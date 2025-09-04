#include <c64/vic.h>
#include <c64/cia.h>
#include <stdio.h>
#include <conio.h>
#include <string.h>
#include <stdlib.h>
#include "mapgen_types.h"
#include "mapgen_api.h"
#include "mapgen_utils.h"
#include "mapgen_internal.h"
#include "mapgen_display.h"
unsigned char compact_map[MAP_H * MAP_W * 3 / 8];
Room rooms[MAX_ROOMS];
__zeropage unsigned char mst_best_room1;
__zeropage unsigned char mst_best_room2;
__zeropage unsigned char mst_best_distance;
__zeropage unsigned char adjacent_tile_temp;
unsigned char room_count = 0;
unsigned char rnd_state = 1;

extern unsigned char camera_center_x, camera_center_y;
extern Viewport view;
extern unsigned char screen_buffer[VIEW_H][VIEW_W];
extern unsigned char screen_dirty;
extern unsigned char last_scroll_direction;

static unsigned char room_center_cache[MAX_ROOMS][2];
static unsigned char room_center_cache_valid = 0;

void init_rnd(void) {
    rnd_state = (unsigned char)(cia1.ta ^ vic.raster);
    if (rnd_state == 0) rnd_state = 1;
}
unsigned char rnd(unsigned char max) {
    if (max <= 1) return 0;
    rnd_state = rnd_state * 97 + 71;
    return rnd_state % max;
}

unsigned char get_compact_tile(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return TILE_EMPTY;
    
    unsigned short bit_offset = ((unsigned short)y << 7) + ((unsigned short)y << 6) + x + x + x;
    unsigned char *byte_ptr = &compact_map[bit_offset >> 3];
    unsigned char bit_pos = bit_offset & 7;
    
    if (bit_pos <= 5) {
        return (*byte_ptr >> bit_pos) & TILE_MASK;
    } else {
        unsigned char low_bits = 8 - bit_pos;
        unsigned char first_part = *byte_ptr >> bit_pos;
        unsigned char second_part = (*(byte_ptr + 1) & ((1 << (3 - low_bits)) - 1)) << low_bits;
        return (first_part | second_part) & TILE_MASK;
    }
}

void set_compact_tile(unsigned char x, unsigned char y, unsigned char tile) {
    if (x >= MAP_W || y >= MAP_H) return;
    
    unsigned short bit_offset = ((unsigned short)y << 7) + ((unsigned short)y << 6) + x + x + x;
    unsigned char *byte_ptr = &compact_map[bit_offset >> 3];
    unsigned char bit_pos = bit_offset & 7;
    
    tile &= TILE_MASK;
    
    if (bit_pos <= 5) {
        unsigned char mask = TILE_MASK << bit_pos;
        *byte_ptr = (*byte_ptr & ~mask) | (tile << bit_pos);
    } else {
        unsigned char low_bits = 8 - bit_pos;
        unsigned char high_bits = 3 - low_bits;
        unsigned char mask1 = ((1 << low_bits) - 1) << bit_pos;
        *byte_ptr = (*byte_ptr & ~mask1) | ((tile & ((1 << low_bits) - 1)) << bit_pos);
        unsigned char mask2 = (1 << high_bits) - 1;
        *(byte_ptr + 1) = (*(byte_ptr + 1) & ~mask2) | (tile >> low_bits);
    }
}


unsigned char get_map_tile(unsigned char map_x, unsigned char map_y) {
    if (map_x >= MAP_W || map_y >= MAP_H) return EMPTY;
    
    unsigned char raw_tile = get_compact_tile(map_x, map_y);
    
    switch(raw_tile) {
        case TILE_EMPTY:      return EMPTY;
        case TILE_WALL:       return WALL;
        case TILE_FLOOR:      return FLOOR;
        case TILE_DOOR:       return DOOR;
        case TILE_SECRET_PATH: return SECRET_PATH;
        case TILE_UP:         return UP;
        case TILE_DOWN:       return DOWN;
        default:              return EMPTY;
    }
}

inline unsigned char get_tile_raw(unsigned char x, unsigned char y) {
    return get_compact_tile(x, y);
}

inline void set_tile_raw(unsigned char x, unsigned char y, unsigned char tile) {
    set_compact_tile(x, y, tile);
}

inline unsigned char tile_is_floor(unsigned char x, unsigned char y) {
    return get_compact_tile(x, y) == TILE_FLOOR;
}

inline unsigned char tile_is_wall(unsigned char x, unsigned char y) {
    return get_compact_tile(x, y) == TILE_WALL;
}

inline unsigned char tile_is_door(unsigned char x, unsigned char y) {
    return get_compact_tile(x, y) == TILE_DOOR;
}

inline unsigned char tile_is_secret_path(unsigned char x, unsigned char y) {
    return get_compact_tile(x, y) == TILE_SECRET_PATH;
}

inline unsigned char tile_is_any_door(unsigned char x, unsigned char y) {
    unsigned char tile = get_compact_tile(x, y);
    return (tile == TILE_DOOR || tile == TILE_SECRET_PATH);
}

inline unsigned char tile_is_empty(unsigned char x, unsigned char y) {
    return get_compact_tile(x, y) == TILE_EMPTY;
}

void clear_map(void) {
    unsigned short total_bytes = (MAP_H * MAP_W * 3 + 7) / 8;
    unsigned short i;
    
    for (i = 0; i < total_bytes; i++) {
        compact_map[i] = 0;
    }
}

inline unsigned char coords_in_bounds(unsigned char x, unsigned char y) {
    return (x < MAP_W && y < MAP_H && x != UNDERFLOW_CHECK_VALUE && y != UNDERFLOW_CHECK_VALUE);
}


void clamp_to_bounds(unsigned char *x, unsigned char *y) {
    if (*x >= MAP_W) *x = MAP_W - 1;
    if (*y >= MAP_H) *y = MAP_H - 1;
    if (*x == UNDERFLOW_CHECK_VALUE) *x = 0;
    if (*y == UNDERFLOW_CHECK_VALUE) *y = 0;
}

unsigned char point_in_room(unsigned char x, unsigned char y, unsigned char room_id) {
    if (room_id >= room_count) return 0;
    
    Room *room = &rooms[room_id];
    return (x >= room->x && x < room->x + room->w &&
            y >= room->y && y < room->y + room->h);
}

unsigned char is_inside_any_room(unsigned char x, unsigned char y) {
    for (unsigned char i = 0; i < room_count; i++) {
        if (point_in_room(x, y, i)) {
            return 1;
        }
    }
    return 0;
}

unsigned char point_in_any_room(unsigned char x, unsigned char y, unsigned char *room_id) {
    unsigned char i;
    
    for (i = 0; i < room_count; i++) {
        unsigned char rx = rooms[i].x;
        unsigned char ry = rooms[i].y;
        unsigned char rw = rooms[i].w;
        unsigned char rh = rooms[i].h;
        
        if (x >= rx && y >= ry && x < rx + rw && y < ry + rh) {
            if (room_id) *room_id = i;
            return 1;
        }
    }
    return 0;
}


static unsigned char calculate_optimal_exit_position(unsigned char room_dim, unsigned char target_coord, unsigned char room_coord) {
    unsigned char relative_pos;
    if (target_coord > room_coord + room_dim / 2) {
        relative_pos = 192;
    } else if (target_coord < room_coord + room_dim / 2) {
        relative_pos = 64;
    } else {
        relative_pos = 128;
    }
    
    unsigned char min_pos = room_dim / 4;
    unsigned char max_pos = room_dim - room_dim / 4;
    
    if (min_pos >= max_pos) {
        return room_dim / 2;
    }
    
    unsigned char safe_range = max_pos - min_pos;
    unsigned char offset = (relative_pos * safe_range) / 256;
    
    return min_pos + offset;
}

void find_room_exit(Room *room, unsigned char target_x, unsigned char target_y, 
                   unsigned char *exit_x, unsigned char *exit_y) {
    unsigned char room_center_x, room_center_y;
    unsigned char room_id = room - rooms;
    get_room_center(room_id, &room_center_x, &room_center_y);
    
    unsigned char dx = abs_diff(target_x, room_center_x);
    unsigned char dy = abs_diff(target_y, room_center_y);
    
    if (dx > dy) {
        if (target_x > room_center_x) {
            *exit_x = room->x + room->w + 1;
            *exit_y = room->y + calculate_optimal_exit_position(room->h, target_y, room->y);
        } else {
            *exit_x = room->x - 2;
            *exit_y = room->y + calculate_optimal_exit_position(room->h, target_y, room->y);
        }
    } else {
        if (target_y > room_center_y) {
            *exit_y = room->y + room->h + 1;
            *exit_x = room->x + calculate_optimal_exit_position(room->w, target_x, room->x);
        } else {
            *exit_y = room->y - 2;
            *exit_x = room->x + calculate_optimal_exit_position(room->w, target_x, room->x);
        }
    }
}

unsigned char has_door_nearby(unsigned char x, unsigned char y, unsigned char min_distance) {
    unsigned char start_x = (x >= min_distance) ? x - min_distance : 0;
    unsigned char start_y = (y >= min_distance) ? y - min_distance : 0;
    unsigned char end_x = x + min_distance;
    unsigned char end_y = y + min_distance;
    
    if (end_x >= MAP_W) end_x = MAP_W - 1;
    if (end_y >= MAP_H) end_y = MAP_H - 1;
    
    for (unsigned char iy = start_y; iy <= end_y; iy++) {
        for (unsigned char ix = start_x; ix <= end_x; ix++) {
            if (tile_is_door(ix, iy)) {
                return 1;
            }
        }
    }
    
    return 0;
}

unsigned char is_on_room_edge(unsigned char x, unsigned char y) {
    unsigned char i;
    for (i = 0; i < room_count; i++) {
        unsigned char room_x = rooms[i].x;
        unsigned char room_y = rooms[i].y;
        unsigned char room_w = rooms[i].w;
        unsigned char room_h = rooms[i].h;
        unsigned char right_edge = room_x + room_w - 1;
        unsigned char bottom_edge = room_y + room_h - 1;
        
        if (x < room_x || x > right_edge || y < room_y || y > bottom_edge) continue;
        
        if (y == room_y && x >= room_x && x <= right_edge) return 1;
        if (y == bottom_edge && x >= room_x && x <= right_edge) return 1;
        if (x == room_x && y >= room_y && y <= bottom_edge) return 1;
        if (x == right_edge && y >= room_y && y <= bottom_edge) return 1;
    }
    return 0;
}

inline unsigned char abs_diff(unsigned char a, unsigned char b) {
    return (a > b) ? a - b : b - a;
}
inline unsigned char manhattan_distance(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2) {
    return abs_diff(x1, x2) + abs_diff(y1, y2);
}


void get_room_bounds(unsigned char room_id, unsigned char *x1, unsigned char *y1, unsigned char *x2, unsigned char *y2) {
    if (room_id >= room_count) {
        *x1 = *y1 = *x2 = *y2 = 0;
        return;
    }
    *x1 = rooms[room_id].x;
    *y1 = rooms[room_id].y;
    *x2 = rooms[room_id].x + rooms[room_id].w - 1;
    *y2 = rooms[room_id].y + rooms[room_id].h - 1;
}

unsigned char calculate_direction(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2) {
    unsigned char dx = abs_diff(x1, x2);
    unsigned char dy = abs_diff(y1, y2);
    
    if (dx > dy) {
        return (x2 > x1) ? 0 : 4;
    } else if (dy > dx) {
        return (y2 > y1) ? 6 : 2;
    } else {
        if (x2 > x1) {
            return (y2 > y1) ? 7 : 1;
        } else {
            return (y2 > y1) ? 5 : 3;
        }
    }
}

inline void get_room_center(unsigned char room_id, unsigned char *center_x, unsigned char *center_y) {
    if (!room_center_cache_valid || room_id >= MAX_ROOMS) {
        if (room_id >= room_count) {
            *center_x = *center_y = 0;
            return;
        }
        *center_x = rooms[room_id].x + (rooms[room_id].w - 1) / 2;
        *center_y = rooms[room_id].y + (rooms[room_id].h - 1) / 2;
        if (room_id < MAX_ROOMS) {
            room_center_cache[room_id][0] = *center_x;
            room_center_cache[room_id][1] = *center_y;
        }
        return;
    }
    *center_x = room_center_cache[room_id][0];
    *center_y = room_center_cache[room_id][1];
}

void init_room_center_cache(void) {
    unsigned char i;
    
    for (i = 0; i < room_count && i < MAX_ROOMS; i++) {
        room_center_cache[i][0] = rooms[i].x + (rooms[i].w - 1) / 2;
        room_center_cache[i][1] = rooms[i].y + (rooms[i].h - 1) / 2;
    }
    room_center_cache_valid = 1;
}

void clear_room_center_cache(void) {
    room_center_cache_valid = 0;
}

unsigned char calculate_room_distance(unsigned char room1, unsigned char room2) {
    unsigned char x1, y1, x2, y2;
    get_room_center(room1, &x1, &y1);
    get_room_center(room2, &x2, &y2);
    return manhattan_distance(x1, y1, x2, y2);
}

unsigned char get_max_connection_distance(void) {
    if (room_count <= CONNECTION_DISTANCE_THRESHOLD) {
        return MAX_CONNECTION_DISTANCE_EXTENDED;
    }
    return MAX_CONNECTION_DISTANCE_BASE;
}

static const unsigned char tile_type_masks[8] = {
    0x01, 0x02, 0x04, 0x08, 0x00, 0x00, 0x00, 0x00
};
inline unsigned char check_tile_has_types(unsigned char x, unsigned char y, unsigned char type_flags) {
    unsigned char tile = get_compact_tile(x, y);
    return (tile <= 3) ? (tile_type_masks[tile] & type_flags) != 0 : 0;
}

unsigned char check_adjacent_tile_types(unsigned char x, unsigned char y, 
                                       unsigned char type_flags, unsigned char include_diagonals) {
    if (x >= MAP_W || y >= MAP_H) return 0;
    
    if (y > 0) {
        adjacent_tile_temp = get_compact_tile(x, y-1);
        if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
    }
    
    if (y < MAP_H-1) {
        adjacent_tile_temp = get_compact_tile(x, y+1);
        if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
    }
    
    if (x < MAP_W-1) {
        adjacent_tile_temp = get_compact_tile(x+1, y);
        if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
    }
    
    if (x > 0) {
        adjacent_tile_temp = get_compact_tile(x-1, y);
        if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
    }
    
    if (include_diagonals) {
        if (x > 0 && y > 0) {
            adjacent_tile_temp = get_compact_tile(x-1, y-1);
            if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
        }
        if (x < MAP_W-1 && y > 0) {
            adjacent_tile_temp = get_compact_tile(x+1, y-1);
            if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
        }
        if (x > 0 && y < MAP_H-1) {
            adjacent_tile_temp = get_compact_tile(x-1, y+1);
            if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
        }
        if (x < MAP_W-1 && y < MAP_H-1) {
            adjacent_tile_temp = get_compact_tile(x+1, y+1);
            if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
        }
    }
    
    return 0;
}

unsigned char check_tile_adjacency(unsigned char x, unsigned char y, unsigned char include_diagonals, unsigned char tile_types) {
    if (!coords_in_bounds(x, y)) return 0;
    
    unsigned char type_flags = 0;
    if (tile_types & CHECK_DOORS_ONLY) type_flags |= TILE_CHECK_DOOR;
    if (tile_types & CHECK_FLOORS_ONLY) type_flags |= TILE_CHECK_FLOOR;
    
    return check_adjacent_tile_types(x, y, type_flags, include_diagonals);
}


void reset_viewport_state(void) {
    camera_center_x = 32;
    camera_center_y = 32;
    view.x = 0;
    view.y = 0;
}

void reset_display_state(void) {
    memset(screen_buffer, 32, VIEW_H * VIEW_W);
    screen_dirty = 1;
    last_scroll_direction = 0;
}

void reset_all_generation_data(void) {
    init_rnd();
    clear_map();
    
    for (unsigned char i = 0; i < MAX_ROOMS; i++) {
        rooms[i].connections = 0;
        rooms[i].state = 0;
    }
    
    room_count = 0;
    clear_room_center_cache();
    init_connection_system();
}

void mapgen_init(unsigned int seed) {
    rnd_state = (unsigned char)seed;
    if (rnd_state == 0) rnd_state = 1;
    room_count = 0;
    clear_map();
    clear_room_center_cache();
    init_connection_system();
}

unsigned char mapgen_generate_dungeon(void) {
    reset_viewport_state();
    reset_display_state();
    reset_all_generation_data();
    return generate_level();
}

void print_text(const char* text) {
    while (*text) {
        unsigned char c = (*text == '\n') ? 13 : *text;
        __asm {
            lda c
            jsr $ffd2
        }
        text++;
    }
}


