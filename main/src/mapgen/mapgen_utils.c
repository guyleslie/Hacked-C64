#include <c64/types.h>
#include <c64/cia.h>
#include <c64/vic.h>
#include <string.h>
#include "mapgen_types.h"

#include "mapgen_utils.h"
#include "mapgen_internal.h"
#include "mapgen_config.h"
#include "mapgen_display.h"  // For reset_viewport_state, reset_display_state (DEBUG only)
#include "tmea_core.h"

extern MapParameters current_params;
unsigned char compact_map[COMPACT_MAP_SIZE];
Room room_list[MAX_ROOMS];
__zeropage unsigned char mst_best_room1;
__zeropage unsigned char mst_best_room2;
__zeropage unsigned char mst_best_distance;
__zeropage unsigned char adjacent_tile_temp;
unsigned char room_count = 0;

// 16-bit RNG for seed-based generation
__zeropage unsigned int rnd_state_16 = 1;
static unsigned char rng_seeded = 0;
static unsigned int rng_seed_16 = 1;

unsigned short y_bit_stride = 0;

void calculate_y_bit_stride(void) {
    y_bit_stride = (unsigned short)current_params.map_width * 3;
}

static inline unsigned short get_y_bit_offset_fast(unsigned char y) {
    return (unsigned short)y * y_bit_stride;
}

unsigned int get_random_seed(void) {
    unsigned int seed = (cia1.ta << 8) | cia1.tb;
    seed ^= vic.raster;
    return seed ? seed : 1;
}

inline unsigned char rnd(unsigned char max) {
    if (max <= 1) return 0;
    rnd_state_16 = rnd_state_16 * 75 + 74;
    return (unsigned char)(rnd_state_16 >> 8) % max;
}

unsigned char get_compact_tile(unsigned char x, unsigned char y) {
    if (x >= current_params.map_width || y >= current_params.map_height) return TILE_EMPTY;
    __assume(x < 80);
    __assume(y < 80);

    unsigned short bit_offset = get_y_bit_offset_fast(y) + x + x + x;
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
    if (x >= current_params.map_width || y >= current_params.map_height) return;
    __assume(x < 80);
    __assume(y < 80);
    __assume(tile <= 7);

    unsigned short bit_offset = get_y_bit_offset_fast(y) + x + x + x;
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

void clear_map(void) {
    unsigned short tile_bits = (unsigned short)current_params.map_width *
                               current_params.map_height * 3;
    unsigned short total_bytes = (tile_bits + 7) >> 3;

    unsigned char *ptr = compact_map;
    unsigned char full_chunks = total_bytes >> 8;
    unsigned char remainder = total_bytes & 0xFF;

    for (unsigned char chunk = 0; chunk < full_chunks; chunk++) {
        for (unsigned char i = 0; i < 255; i++) *ptr++ = 0;
        *ptr++ = 0;
    }
    for (unsigned char i = 0; i < remainder; i++) *ptr++ = 0;
}

inline unsigned char coords_in_bounds(unsigned char x, unsigned char y) {
    return (x < current_params.map_width && y < current_params.map_height);
}

unsigned char point_in_room(unsigned char x, unsigned char y, unsigned char room_id) {
    if (room_id >= room_count) return 0;
    Room *room = &room_list[room_id];
    return (x >= room->x && x < room->x + room->w &&
            y >= room->y && y < room->y + room->h);
}

unsigned char is_inside_any_room(unsigned char x, unsigned char y) {
    for (unsigned char i = 0; i < room_count; i++) {
        __assume(room_count <= MAX_ROOMS);
        Room *room = &room_list[i];
        if (x >= room->x && x < room->x + room->w &&
            y >= room->y && y < room->y + room->h) {
            return 1;
        }
    }
    return 0;
}

unsigned char point_in_any_room(unsigned char x, unsigned char y, unsigned char *room_id) {
    for (unsigned char i = 0; i < room_count; i++) {
        __assume(room_count <= MAX_ROOMS);
        unsigned char rx = room_list[i].x;
        unsigned char ry = room_list[i].y;
        unsigned char rw = room_list[i].w;
        unsigned char rh = room_list[i].h;

        if (x >= rx && y >= ry && x < rx + rw && y < ry + rh) {
            if (room_id) *room_id = i;
            return 1;
        }
    }
    return 0;
}

unsigned char is_on_room_edge(unsigned char x, unsigned char y) {
    for (unsigned char i = 0; i < room_count; i++) {
        __assume(room_count <= MAX_ROOMS);
        unsigned char room_x = room_list[i].x;
        unsigned char room_y = room_list[i].y;
        unsigned char room_w = room_list[i].w;
        unsigned char room_h = room_list[i].h;
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

unsigned char calculate_room_distance(unsigned char room1, unsigned char room2) {
    unsigned char x1 = get_room_center_x_inline(room1, room_count, room_list);
    unsigned char y1 = get_room_center_y_inline(room1, room_count, room_list);
    unsigned char x2 = get_room_center_x_inline(room2, room_count, room_list);
    unsigned char y2 = get_room_center_y_inline(room2, room_count, room_list);
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
    if (x >= current_params.map_width || y >= current_params.map_height) return 0;

    if (y > 0) {
        adjacent_tile_temp = get_compact_tile(x, y-1);
        if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
    }
    if (y < current_params.map_height - 1) {
        adjacent_tile_temp = get_compact_tile(x, y+1);
        if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
    }
    if (x < current_params.map_width - 1) {
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
        if (x < current_params.map_width - 1 && y > 0) {
            adjacent_tile_temp = get_compact_tile(x+1, y-1);
            if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
        }
        if (x > 0 && y < current_params.map_height - 1) {
            adjacent_tile_temp = get_compact_tile(x-1, y+1);
            if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
        }
        if (x < current_params.map_width - 1 && y < current_params.map_height - 1) {
            adjacent_tile_temp = get_compact_tile(x+1, y+1);
            if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
        }
    }
    return 0;
}

void reset_all_generation_data(void) {
    if (!rng_seeded) {
        unsigned int s = get_random_seed();
        rnd_state_16 = s;
        rng_seed_16  = s;
        rng_seeded   = 1;
    } else {
        // FIX: Reset RNG to stored seed for reproducible regeneration
        rnd_state_16 = rng_seed_16;
    }

    clear_map();

    for (unsigned char i = 0; i < MAX_ROOMS; i++) {
        room_list[i].x = 0;
        room_list[i].y = 0;
        room_list[i].w = 0;
        room_list[i].h = 0;
        room_list[i].center_x = 0;
        room_list[i].center_y = 0;
        room_list[i].connections = 0;
        room_list[i].state = 0;
        room_list[i].treasure_wall_side = 255;
        room_list[i].false_corridor_wall_side = 255;
        room_list[i].false_corridor_end_x = 255;
        room_list[i].false_corridor_end_y = 255;
    }

    room_count = 0;
    reset_tmea_data();

    total_connections = 0;
    total_secret_rooms = 0;
    total_treasures = 0;
    total_false_corridors = 0;
    total_hidden_corridors = 0;
    available_walls_count = 0;
}

void mapgen_init(unsigned int seed) {
    seed = seed ? seed : 1;
    rnd_state_16 = seed;
    rng_seed_16  = seed;
    rng_seeded   = 1;
    room_count = 0;
    clear_map();
}

unsigned char mapgen_generate_dungeon(void) {
#ifdef DEBUG_MAPGEN
    reset_viewport_state();
    reset_display_state();
#endif
    reset_all_generation_data();
    return generate_level();
}

unsigned char mapgen_generate_with_params(
    unsigned char map_size,
    unsigned char room_count_param,
    unsigned char room_size,
    unsigned char secret_rooms,
    unsigned char false_corridors,
    unsigned char secret_treasures,
    unsigned char hidden_corridors
) {
    MapConfig config;
    MapParameters params;

    if (map_size > 2 || room_count_param > 2 || room_size > 2 ||
        secret_rooms > 2 || false_corridors > 2 ||
        secret_treasures > 2 || hidden_corridors > 2) {
        return 1;
    }

    config.map_size = (PresetLevel)map_size;
    config.room_count = (PresetLevel)room_count_param;
    config.room_size = (PresetLevel)room_size;
    config.secret_rooms = (PresetLevel)secret_rooms;
    config.false_corridors = (PresetLevel)false_corridors;
    config.secret_treasures = (PresetLevel)secret_treasures;
    config.hidden_corridors = (PresetLevel)hidden_corridors;

    validate_and_adjust_config(&config, &params);
    mapgen_set_parameters(&params);

#ifdef DEBUG_MAPGEN
    reset_viewport_state();
    reset_display_state();
#endif
    reset_all_generation_data();

    unsigned char result = generate_level();
    return result ? 0 : 2;
}

/**
 * @brief Place walls around a room perimeter
 * @param x Room top-left X
 * @param y Room top-left Y
 * @param w Room width
 * @param h Room height
 *
 * OPTIMIZATION: No TILE_EMPTY checks needed because:
 * 1. can_place_room() validated buffer area is completely TILE_EMPTY
 * 2. Room floor placed BEFORE walls, wall positions still TILE_EMPTY
 * 3. MIN_ROOM_DISTANCE (4 tiles) guarantees no room overlap
 */
void place_walls_around_room(unsigned char x, unsigned char y, unsigned char w, unsigned char h) {
    // Top and bottom walls (including corners)
    for (unsigned char ix = x - 1; ix <= x + w; ix++) {
        set_compact_tile(ix, y - 1, TILE_WALL);  // Top wall
        set_compact_tile(ix, y + h, TILE_WALL);  // Bottom wall
    }
    // Left and right walls (excluding corners - already done)
    for (unsigned char iy = y; iy < y + h; iy++) {
        set_compact_tile(x - 1, iy, TILE_WALL);  // Left wall
        set_compact_tile(x + w, iy, TILE_WALL);  // Right wall
    }
}

void place_walls_around_corridor_tile(unsigned char x, unsigned char y) {
    for (signed char dy = -1; dy <= 1; dy++) {
        for (signed char dx = -1; dx <= 1; dx++) {
            if (dx == 0 && dy == 0) continue;
            unsigned char wall_x = x + dx;
            unsigned char wall_y = y + dy;
            if (get_compact_tile(wall_x, wall_y) == TILE_EMPTY) {
                set_compact_tile(wall_x, wall_y, TILE_WALL);
            }
        }
    }
}

/**
 * @brief Wall a straight corridor segment (horizontal or vertical)
 * @param x1, y1 Segment start
 * @param x2, y2 Segment end
 * @note Only walls TILE_EMPTY to preserve existing structures
 */
void place_wall_straight_corridor(unsigned char x1, unsigned char y1,
                                  unsigned char x2, unsigned char y2) {
    if (y1 == y2) {
        // Horizontal segment
        unsigned char start_x = (x1 < x2) ? x1 : x2;
        unsigned char end_x = (x1 < x2) ? x2 : x1;

        for (unsigned char x = start_x; x <= end_x; x++) {
            // Wall above
            if (get_compact_tile(x, y1 - 1) == TILE_EMPTY)
                set_compact_tile(x, y1 - 1, TILE_WALL);
            // Wall below
            if (get_compact_tile(x, y1 + 1) == TILE_EMPTY)
                set_compact_tile(x, y1 + 1, TILE_WALL);
        }
        // End caps
        if (get_compact_tile(start_x - 1, y1) == TILE_EMPTY)
            set_compact_tile(start_x - 1, y1, TILE_WALL);
        if (get_compact_tile(end_x + 1, y1) == TILE_EMPTY)
            set_compact_tile(end_x + 1, y1, TILE_WALL);
    } else {
        // Vertical segment
        unsigned char start_y = (y1 < y2) ? y1 : y2;
        unsigned char end_y = (y1 < y2) ? y2 : y1;

        for (unsigned char y = start_y; y <= end_y; y++) {
            // Wall left
            if (get_compact_tile(x1 - 1, y) == TILE_EMPTY)
                set_compact_tile(x1 - 1, y, TILE_WALL);
            // Wall right
            if (get_compact_tile(x1 + 1, y) == TILE_EMPTY)
                set_compact_tile(x1 + 1, y, TILE_WALL);
        }
        // End caps
        if (get_compact_tile(x1, start_y - 1) == TILE_EMPTY)
            set_compact_tile(x1, start_y - 1, TILE_WALL);
        if (get_compact_tile(x1, end_y + 1) == TILE_EMPTY)
            set_compact_tile(x1, end_y + 1, TILE_WALL);
    }
}

/**
 * @brief Wall around a corridor junction (L-corner or Z-bend breakpoints)
 * @param jx, jy Junction center coordinates
 * @note Fills diagonal corners not covered by place_wall_straight_corridor()
 */
void place_wall_corridor_junction(unsigned char jx, unsigned char jy) {
    for (signed char dy = -1; dy <= 1; dy++) {
        for (signed char dx = -1; dx <= 1; dx++) {
            unsigned char wx = jx + dx;
            unsigned char wy = jy + dy;
            if (get_compact_tile(wx, wy) == TILE_EMPTY) {
                set_compact_tile(wx, wy, TILE_WALL);
            }
        }
    }
}

void place_door(unsigned char x, unsigned char y) {
    if (get_compact_tile(x, y) != TILE_DOOR) {
        set_compact_tile(x, y, TILE_DOOR);
    }
}

unsigned char get_wall_side_from_exit(unsigned char room_idx, unsigned char exit_x, unsigned char exit_y) {
    Room *room = &room_list[room_idx];
    if (exit_x < room->x) return 0;
    if (exit_x >= room->x + room->w) return 1;
    if (exit_y < room->y) return 2;
    return 3;
}

unsigned char calculate_percentage_count(unsigned char total, unsigned char percentage) {
    return (total * percentage + 99) / 100;
}

unsigned char count_non_branching_from_flags(void) {
    unsigned char count = 0;
    for (unsigned char i = 0; i < room_count; i++) {
        Room *room = &room_list[i];
        for (unsigned char c = 0; c < room->connections; c++) {
            if (room->conn_data[c].is_non_branching == 1) {
                count++;
            }
        }
    }
    return count / 2;
}

unsigned int mapgen_get_seed(void) {
    return rng_seed_16;
}

void mapgen_reset_seed_flag(void) {
    rng_seeded = 0;
}
