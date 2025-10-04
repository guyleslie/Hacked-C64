#include <conio.h>      // For clrscr(), gotoxy()
#include <string.h>     // For memset()
#include "mapgen_types.h"
#include "mapgen_utils.h"
#include "mapgen_internal.h"
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

// Room center cache removed - simple calculation is faster

// Pre-calculated Y bit offsets lookup table
// Replaces expensive 16-bit multiplication: y * 216 = y * (72 * 3)
// Each Y coordinate maps to bit offset: y * MAP_W * 3 = y * 216
static const unsigned short y_bit_offsets[72] = {
    0, 216, 432, 648, 864, 1080, 1296, 1512, 1728, 1944, 2160, 2376, 2592, 2808, 3024, 3240,
    3456, 3672, 3888, 4104, 4320, 4536, 4752, 4968, 5184, 5400, 5616, 5832, 6048, 6264, 6480, 6696,
    6912, 7128, 7344, 7560, 7776, 7992, 8208, 8424, 8640, 8856, 9072, 9288, 9504, 9720, 9936, 10152,
    10368, 10584, 10800, 11016, 11232, 11448, 11664, 11880, 12096, 12312, 12528, 12744, 12960, 13176, 13392, 13608,
    13824, 14040, 14256, 14472, 14688, 14904, 15120, 15336
};

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
    // Compiler hints for 8-bit range analysis
    __assume(x < MAP_W);
    __assume(y < MAP_H);
    
    if (x >= MAP_W || y >= MAP_H) return TILE_EMPTY;
    
    // Use lookup table instead of 16-bit multiplication
    // Old: ((unsigned short)y << 7) + ((unsigned short)y << 6) + x + x + x
    // New: y_bit_offsets[y] + x * 3
    unsigned short bit_offset = y_bit_offsets[y] + x + x + x;
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
    // Compiler hints for 8-bit range analysis
    __assume(x < MAP_W);
    __assume(y < MAP_H);
    __assume(tile <= TILE_MASK);  // tile < 8
    
    if (x >= MAP_W || y >= MAP_H) return;
    
    // Use lookup table instead of 16-bit multiplication
    unsigned short bit_offset = y_bit_offsets[y] + x + x + x;
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

// Inline wrappers removed for size optimization - use direct calls:
// get_tile_raw() -> get_compact_tile()
// set_compact_tile() -> set_compact_tile()
// tile_is_*() -> get_compact_tile() == TILE_*

void clear_map(void) {
    // OSCAR64 Optimized: Use 8-bit operations instead of 16-bit loop
    // Total bytes: (72*72*3+7)/8 = 3888 bytes = 15 chunks of 256 + 48 remainder
    unsigned char *ptr = compact_map;
    unsigned char chunks = 15;  // 3888 / 256 = 15 (+ 48 remainder)
    
    // Clear in 256-byte chunks for optimal 8-bit performance
    for (unsigned char chunk = 0; chunk < chunks; chunk++) {
        for (unsigned char i = 0; i < 255; i++) {
            *ptr++ = 0;
        }
        // Handle the 256th byte separately to avoid 8-bit overflow
        *ptr++ = 0;
    }
    
    // Clear remainder bytes: 3888 - (15 * 256) = 48 bytes
    for (unsigned char i = 0; i < 48; i++) {
        *ptr++ = 0;
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
    // Inline bounds check to avoid wrapper overhead
    for (unsigned char i = 0; i < room_count; i++) {
        __assume(room_count <= MAX_ROOMS);
        Room *room = &rooms[i];
        if (x >= room->x && x < room->x + room->w &&
            y >= room->y && y < room->y + room->h) {
            return 1;
        }
    }
    return 0;
}

unsigned char point_in_any_room(unsigned char x, unsigned char y, unsigned char *room_id) {
    unsigned char i;
    
    for (i = 0; i < room_count; i++) {
        __assume(room_count <= MAX_ROOMS);
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
            if (get_compact_tile(ix, iy) == TILE_DOOR) {
                return 1;
            }
        }
    }
    
    return 0;
}

unsigned char is_on_room_edge(unsigned char x, unsigned char y) {
    unsigned char i;
    for (i = 0; i < room_count; i++) {
        __assume(room_count <= MAX_ROOMS);
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


// get_room_bounds() removed - dead code (never used)

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
    // Simple calculation without cache overhead
    if (room_id >= room_count) {
        *center_x = *center_y = 0;
        return;
    }
    *center_x = rooms[room_id].x + rooms[room_id].w / 2;
    *center_y = rooms[room_id].y + rooms[room_id].h / 2;
}

// Helper for Room pointer - used in connection_system.c
inline void get_room_center_ptr(Room *room, unsigned char *center_x, unsigned char *center_y) {
    *center_x = room->x + room->w / 2;
    *center_y = room->y + room->h / 2;
}

// Room center cache functions removed - direct calculation is more efficient for OSCAR64

unsigned char calculate_room_distance(unsigned char room1, unsigned char room2) {
    unsigned char x1 = get_room_center_x_inline(room1);
    unsigned char y1 = get_room_center_y_inline(room1);
    unsigned char x2 = get_room_center_x_inline(room2);
    unsigned char y2 = get_room_center_y_inline(room2);
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
    camera_center_x = 36;  // 72/2 = 36 (map center for 72x72)
    camera_center_y = 36;  // 72/2 = 36 (map center for 72x72)
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
    // Cache functions removed for OSCAR64 efficiency
}

void mapgen_init(unsigned int seed) {
    rnd_state = (unsigned char)seed;
    if (rnd_state == 0) rnd_state = 1;
    room_count = 0;
    clear_map();
    // Cache functions removed for OSCAR64 efficiency
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

// =============================================================================
// PETSCII PROGRESS BAR SYSTEM
// =============================================================================

// Screen code characters for progress bar - CharPad mixedcases basis ROM values
static const unsigned char PROGRESS_QUARTER = 0x65;  // 101 = 0x65 left quarter block
static const unsigned char PROGRESS_HALF = 0x61;     // 97 = 0x61 left half block (corrected value)
static const unsigned char PROGRESS_THREE_Q = 0xE7;  // 231 = 0xE7 left three-quarter block  
static const unsigned char PROGRESS_FULL = 0xA0;     // 160 = 0xA0 full block (inverse space)

// Progress bar state
static unsigned char progress_steps = 0;    // Current step (0-80: 20 positions × 4 phases)
static const unsigned char progress_x = 9;  // X position (centered: (40-22)/2 = 9)
static const unsigned char progress_y = 12; // Y position (screen center)

// C64-optimized phase boundaries (80 total steps divided by phases)
static const unsigned char phase_starts[5] = {0, 20, 50, 65, 75};  // Phase start positions
static const unsigned char phase_lengths[5] = {20, 30, 15, 10, 5}; // Steps per phase

// Initialize progress bar with C64-optimized display
void init_progress_bar_simple(const char* title) {
    progress_steps = 0;
    
    // Clear screen and show title using OSCAR64 compatible functions
    clrscr();
    gotoxy(13, 10); // Center generation status: (40-14)/2 = 13
    print_text(title);
    
    // Progress bar will be drawn by update_progress_step() calls
}

// C64-optimized phase progress update - pure 8-bit math
void update_progress_step(unsigned char phase, unsigned char current, unsigned char total) {
    // Validate ranges for compiler analysis
    __assume(phase < 5);
    __assume(current <= total);
    
    // Calculate phase progress using 8-bit math only
    unsigned char phase_progress = 0;
    if (total > 0) {
        // Avoid division: use bit shifts for common cases
        if (total <= 4) {
            phase_progress = (current << 2) < phase_lengths[phase] ? (current << 2) : phase_lengths[phase];
        } else if (total <= 8) {
            phase_progress = (current << 1) < phase_lengths[phase] ? (current << 1) : phase_lengths[phase];
        } else {
            // For larger totals, use simple proportion approximation
            phase_progress = current < total ? current : phase_lengths[phase];
        }
    }
    
    // Set absolute progress position
    progress_steps = phase_starts[phase] + phase_progress;
    if (progress_steps > 80) progress_steps = 80;
    
    // Calculate display position using bit operations
    unsigned char pos = progress_steps >> 2;        // Divide by 4
    unsigned char phase_char = progress_steps & 3;  // Modulo 4
    
    // OSCAR64 range hints
    __assume(pos < 21);
    __assume(phase_char < 4);
    
    // Direct screen memory access
    volatile unsigned char * const screen_mem = (volatile unsigned char *)SCREEN_MEMORY_BASE;
    unsigned short base_pos = progress_y * 40 + (progress_x + 1);
    
    // Fill completed positions
    for (unsigned char i = 0; i < pos && i < 20; i++) {
        screen_mem[base_pos + i] = PROGRESS_FULL;
    }
    
    // Show current position character
    if (pos < 20) {
        unsigned char progress_char = PROGRESS_QUARTER;
        if (phase_char == 1) progress_char = PROGRESS_HALF;
        else if (phase_char == 2) progress_char = PROGRESS_THREE_Q;
        else if (phase_char == 3) progress_char = PROGRESS_FULL;
        
        screen_mem[base_pos + pos] = progress_char;
    }
}

// Finish progress bar - OSCAR64 simplified completion
void finish_progress_bar_simple(void) {
    // Simply set to maximum and display final state
    progress_steps = 80;
    
    // Direct screen memory access for final progress bar
    volatile unsigned char * const screen_mem = (volatile unsigned char *)SCREEN_MEMORY_BASE;
    unsigned short base_pos = progress_y * 40 + (progress_x + 1);
    
    // Draw all 20 positions filled with full blocks using direct screen codes
    for (unsigned char i = 0; i < 20; i++) {
        screen_mem[base_pos + i] = PROGRESS_FULL;  // Direct screen code write
    }
}

// Show current phase name below progress bar - centered
void show_phase_name(const char* phase_name) {
    // Calculate center position for phase name based on text length
    unsigned char text_len = 0;
    const char* p = phase_name;
    while (*p) { // Simple string length calculation - fixed
        text_len++;
        p++;
    }
    
    unsigned char phase_x = (40 - text_len) / 2; // Center horizontally
    
    // Clear previous phase name line
    gotoxy(0, progress_y + 2);
    // Clear full line (40 chars) - using single character for size optimization
    for (unsigned char i = 0; i < 40; i++) putchar(' ');
    gotoxy(phase_x, progress_y + 2);
    print_text(phase_name);
}

// Simplified progress system - direct calls, no unnecessary wrappers
void init_generation_progress(void) {
    init_progress_bar_simple("MAP GENERATION");
}

// =============================================================================
// INCREMENTAL WALL PLACEMENT FUNCTIONS
// =============================================================================

// Place walls around a room during room creation
void place_walls_around_room(unsigned char x, unsigned char y, unsigned char w, unsigned char h) {
    // Top and bottom walls (including corners)
    for (unsigned char ix = x - 1; ix <= x + w; ix++) {
        if (coords_in_bounds(ix, y - 1) && get_compact_tile(ix, y - 1) == TILE_EMPTY) {
            set_compact_tile(ix, y - 1, TILE_WALL); // Top wall
        }
        if (coords_in_bounds(ix, y + h) && get_compact_tile(ix, y + h) == TILE_EMPTY) {
            set_compact_tile(ix, y + h, TILE_WALL); // Bottom wall
        }
    }
    
    // Left and right walls (excluding corners already done)
    for (unsigned char iy = y; iy < y + h; iy++) {
        if (coords_in_bounds(x - 1, iy) && get_compact_tile(x - 1, iy) == TILE_EMPTY) {
            set_compact_tile(x - 1, iy, TILE_WALL); // Left wall
        }
        if (coords_in_bounds(x + w, iy) && get_compact_tile(x + w, iy) == TILE_EMPTY) {
            set_compact_tile(x + w, iy, TILE_WALL); // Right wall
        }
    }
}

// Place walls around a single corridor tile during corridor creation
void place_walls_around_corridor_tile(unsigned char x, unsigned char y) {
    // 8-directional wall placement around corridor tile
    for (signed char dy = -1; dy <= 1; dy++) {
        for (signed char dx = -1; dx <= 1; dx++) {
            if (dx == 0 && dy == 0) continue; // Skip center tile
            
            unsigned char wall_x = x + dx;
            unsigned char wall_y = y + dy;
            
            if (coords_in_bounds(wall_x, wall_y) && get_compact_tile(wall_x, wall_y) == TILE_EMPTY) {
                set_compact_tile(wall_x, wall_y, TILE_WALL);
            }
        }
    }
}

// =============================================================================
// DOOR PLACEMENT FUNCTIONS  
// =============================================================================

// Simple door placement function with duplicate prevention
void place_door(unsigned char x, unsigned char y) {
    // Only place door if position is not already a door
    if (coords_in_bounds(x, y) && get_compact_tile(x, y) != TILE_DOOR) {
        set_compact_tile(x, y, TILE_DOOR);
    }
}

// =============================================================================
// CONNECTION SYSTEM UTILITIES (moved from connection_system.c)
// =============================================================================

static unsigned char room_distance_cache[MAX_ROOMS][MAX_ROOMS];
static unsigned char distance_cache_valid = 0;

unsigned char get_cached_room_distance(unsigned char room1, unsigned char room2) {
    if (!distance_cache_valid) {
        init_room_distance_cache();
    }
    return room_distance_cache[room1][room2];
}

void init_room_distance_cache(void) {
    // Initialize cache with Manhattan distances between room centers
    for (unsigned char i = 0; i < room_count; i++) {
        for (unsigned char j = 0; j < room_count; j++) {
            if (i == j) {
                room_distance_cache[i][j] = 0;
            } else {
                unsigned char x1 = get_room_center_x_inline(i);
                unsigned char y1 = get_room_center_y_inline(i);
                unsigned char x2 = get_room_center_x_inline(j);
                unsigned char y2 = get_room_center_y_inline(j);
                room_distance_cache[i][j] = manhattan_distance(x1, y1, x2, y2);
            }
        }
    }
    distance_cache_valid = 1;
}

void clear_room_distance_cache(void) {
    distance_cache_valid = 0;
}


