#include <conio.h>      // For clrscr(), gotoxy()
#include <string.h>     // For memset()
#include "mapgen_types.h"
#include "mapgen_utils.h"
#include "mapgen_internal.h"
#include "mapgen_config.h"  // For MapParameters

// External reference to current generation parameters
extern MapParameters current_params;
unsigned char compact_map[COMPACT_MAP_SIZE];
Room room_list[MAX_ROOMS];
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

// Calculate Y bit offset dynamically based on current map width
// Formula: y * current_params.map_width * 3
// This ensures correct offset calculation for all map sizes (48/64/80)
static inline unsigned short calculate_y_bit_offset(unsigned char y) {
    // Optimized multiplication: y * map_width * 3
    // Using shifts and adds for 8-bit efficiency
    unsigned short y_times_width = (unsigned short)y * current_params.map_width;
    return y_times_width + y_times_width + y_times_width; // × 3
}

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
    // Single bounds check - callers trust this function
    if (x >= current_params.map_width || y >= current_params.map_height) return TILE_EMPTY;

    // OSCAR64 compiler hints for better code generation after bounds check
    __assume(x < 80);  // Max map size
    __assume(y < 80);

    // Calculate bit offset dynamically using actual map width
    unsigned short bit_offset = calculate_y_bit_offset(y) + x + x + x;
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
    // Single bounds check - callers trust this function
    if (x >= current_params.map_width || y >= current_params.map_height) return;

    // OSCAR64 compiler hints for better code generation after bounds check
    __assume(x < 80);  // Max map size
    __assume(y < 80);
    __assume(tile <= 7);  // 3-bit tile encoding

    // Calculate bit offset dynamically using actual map width
    unsigned short bit_offset = calculate_y_bit_offset(y) + x + x + x;
    unsigned char *byte_ptr = &compact_map[bit_offset >> 3];
    unsigned char bit_pos = bit_offset & 7;

    // Runtime tile masking
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
    // No bounds check - get_compact_tile() already validates
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
    // Calculate actual bytes based on current map size
    unsigned short tile_bits = (unsigned short)current_params.map_width *
                               current_params.map_height * 3;
    unsigned short total_bytes = (tile_bits + 7) >> 3;

    unsigned char *ptr = compact_map;
    unsigned char full_chunks = total_bytes >> 8;
    unsigned char remainder = total_bytes & 0xFF;

    // Clear full 256-byte chunks
    for (unsigned char chunk = 0; chunk < full_chunks; chunk++) {
        for (unsigned char i = 0; i < 255; i++) *ptr++ = 0;
        *ptr++ = 0; // 256th byte
    }

    // Clear remainder
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
    // Inline bounds check to avoid wrapper overhead
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
    unsigned char i;
    
    for (i = 0; i < room_count; i++) {
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


unsigned char is_on_room_edge(unsigned char x, unsigned char y) {
    unsigned char i;
    for (i = 0; i < room_count; i++) {
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

inline void get_room_center(unsigned char room_id, unsigned char *center_x, unsigned char *center_y) {
    // Use cached center to avoid repeated division
    if (room_id >= room_count) {
        *center_x = *center_y = 0;
        return;
    }
    *center_x = room_list[room_id].center_x;
    *center_y = room_list[room_id].center_y;
}

// Room center values are cached per room for fast lookup during generation
// get_room_center_ptr_inline() moved to header as static inline for best optimization

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


void reset_viewport_state(void) {
    camera_center_x = current_params.map_width / 2;
    camera_center_y = current_params.map_height / 2;
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
        room_list[i].x = 0;
        room_list[i].y = 0;
        room_list[i].w = 0;
        room_list[i].h = 0;
        room_list[i].center_x = 0;
        room_list[i].center_y = 0;
        room_list[i].connections = 0;
        room_list[i].state = 0;
        room_list[i].treasure_wall_x = 255;
        room_list[i].treasure_wall_y = 255;
        room_list[i].false_corridor_door_x = 255; // Mark as no false corridor
        room_list[i].false_corridor_door_y = 255;
        room_list[i].false_corridor_end_x = 255;
        room_list[i].false_corridor_end_y = 255;
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

// Dynamic phase boundaries - calculated from current_params at generation start
static unsigned char phase_boundaries[8];   // Phase start positions (0-80 scale)
static unsigned char phase_total_weight = 0; // Total weight cache for fast calculation

// External reference to current generation parameters
extern MapParameters current_params;

// Initialize dynamic progress weights based on current_params
void init_progress_weights(void) {
    // Calculate weights from current generation parameters
    unsigned char weights[8];
    weights[0] = current_params.max_rooms;                    // Rooms
    weights[1] = current_params.max_rooms - 1;                // Connections (MST: n-1 edges)
    weights[2] = current_params.secret_room_count;            // Secrets
    weights[3] = current_params.treasure_count;               // Treasures
    weights[4] = current_params.false_corridor_count;         // False corridors
    weights[5] = 2;                                           // Stairs (fixed: 2 stairs)
    weights[6] = 1;                                           // Finalize (fixed: camera init)
    weights[7] = 1;                                           // Complete (fixed: display)

    // Calculate total weight
    phase_total_weight = 0;
    for (unsigned char i = 0; i < 8; i++) {
        phase_total_weight += weights[i];
    }

    // Pre-calculate phase boundaries on 0-80 scale
    unsigned char accumulated = 0;
    for (unsigned char i = 0; i < 8; i++) {
        // Boundary = (accumulated * 80) / total_weight
        phase_boundaries[i] = ((unsigned short)accumulated * 80) / phase_total_weight;
        accumulated += weights[i];
    }
}

// Initialize progress bar with C64-optimized display
void init_progress_bar_simple(const char* title) {
    progress_steps = 0;

    // Clear screen and show title using OSCAR64 compatible functions
    clrscr();
    gotoxy(13, 10); // Center generation status: (40-14)/2 = 13
    print_text(title);

    // Progress bar will be drawn by update_progress_step() calls
}

// Dynamic phase progress update - calculated from pre-computed boundaries
void update_progress_step(unsigned char phase, unsigned char current, unsigned char total) {
    // Compiler hints for range analysis (no redundant runtime checks)
    __assume(phase < 8);
    __assume(current <= total);
    __assume(total > 0);

    if (total == 0) return; // Only essential runtime check

    // Get phase start and end from pre-calculated boundaries (fast lookup!)
    unsigned char phase_start = phase_boundaries[phase];
    unsigned char phase_end = (phase < 7) ? phase_boundaries[phase + 1] : 80;
    unsigned char phase_range = phase_end - phase_start;

    // Calculate progress within this phase
    unsigned char phase_progress = 0;
    if (current >= total) {
        // Phase complete
        phase_progress = phase_range;
    } else if (phase_range > 0) {
        // Proportional progress: (current * range) / total
        // 8-bit safe: max current=20, max range=80 → 1600 < 65535
        phase_progress = ((unsigned short)current * phase_range) / total;
    }

    // Set absolute progress position
    progress_steps = phase_start + phase_progress;
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

// Compact phase name storage - saves ~100 bytes vs individual strings
// Strings packed sequentially to save pointer overhead
static const char phase_strings[] =
    "Building Rooms\0"
    "Connecting Rooms\0"
    "Secret Areas\0"
    "Secret Treasures\0"
    "False Corridors\0"
    "Placing Stairs\0"
    "Finalizing\0"
    "Generation Complete!";

// Offsets into packed string (much smaller than 8 pointers)
static const unsigned char phase_offsets[8] = {0, 15, 32, 45, 62, 78, 93, 104};

// Show phase by index - optimized for size
void show_phase(unsigned char phase_id) {
    if (phase_id >= 8) return;

    const char* text = phase_strings + phase_offsets[phase_id];
    unsigned char text_len = 0;
    const char* p = text;
    while (*p++) text_len++;

    unsigned char phase_x = (40 - text_len) / 2;

    gotoxy(0, progress_y + 2);
    for (unsigned char i = 0; i < 40; i++) putchar(' ');
    gotoxy(phase_x, progress_y + 2);
    print_text(text);
}

// Legacy wrapper for compatibility
void show_phase_name(const char* phase_name) {
    unsigned char text_len = 0;
    const char* p = phase_name;
    while (*p++) text_len++;

    unsigned char phase_x = (40 - text_len) / 2;

    gotoxy(0, progress_y + 2);
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
    // Caller (can_place_room) guarantees room is validly placed within map bounds
    // get_compact_tile() and set_compact_tile() already handle bounds checking

    // Top and bottom walls (including corners)
    for (unsigned char ix = x - 1; ix <= x + w; ix++) {
        if (get_compact_tile(ix, y - 1) == TILE_EMPTY) {
            set_compact_tile(ix, y - 1, TILE_WALL); // Top wall
        }
        if (get_compact_tile(ix, y + h) == TILE_EMPTY) {
            set_compact_tile(ix, y + h, TILE_WALL); // Bottom wall
        }
    }

    // Left and right walls (excluding corners already done)
    for (unsigned char iy = y; iy < y + h; iy++) {
        if (get_compact_tile(x - 1, iy) == TILE_EMPTY) {
            set_compact_tile(x - 1, iy, TILE_WALL); // Left wall
        }
        if (get_compact_tile(x + w, iy) == TILE_EMPTY) {
            set_compact_tile(x + w, iy, TILE_WALL); // Right wall
        }
    }
}

// Place walls around a single corridor tile during corridor creation
void place_walls_around_corridor_tile(unsigned char x, unsigned char y) {
    // get_compact_tile() and set_compact_tile() already handle bounds checking
    // 8-directional wall placement around corridor tile
    for (signed char dy = -1; dy <= 1; dy++) {
        for (signed char dx = -1; dx <= 1; dx++) {
            if (dx == 0 && dy == 0) continue; // Skip center tile

            unsigned char wall_x = x + dx;
            unsigned char wall_y = y + dy;

            if (get_compact_tile(wall_x, wall_y) == TILE_EMPTY) {
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
    // get_compact_tile() already handles bounds checking
    // Only place door if position is not already a door
    if (get_compact_tile(x, y) != TILE_DOOR) {
        set_compact_tile(x, y, TILE_DOOR);
    }
}

// =============================================================================
// WALL AND DOOR VALIDATION UTILITIES
// =============================================================================
// (Unused 400-byte room_distance_cache removed - never called, wastes RAM)

// Get wall side from door position - room geometry utility
unsigned char get_wall_side_from_exit(unsigned char room_idx, unsigned char exit_x, unsigned char exit_y) {
    Room *room = &room_list[room_idx];

    if (exit_x < room->x) return 0; // Left
    if (exit_x >= room->x + room->w) return 1; // Right
    if (exit_y < room->y) return 2; // Top
    return 3; // Bottom
}

// Check if a wall side has any doors (normal or cached false corridors)
unsigned char wall_has_doors(unsigned char room_idx, unsigned char wall_side) {
    Room *room = &room_list[room_idx];

    for (unsigned char i = 0; i < room->connections; i++) {
        if (room->doors[i].wall_side == wall_side) {
            return 1;
        }
    }

    // State flag guarantees coordinates are valid - no sentinel check needed
    if (room->state & ROOM_HAS_FALSE_CORRIDOR) {
        unsigned char recorded_wall = get_wall_side_from_exit(room_idx,
                                                              room->false_corridor_door_x,
                                                              room->false_corridor_door_y);
        if (recorded_wall == wall_side) {
            return 1;
        }
    }

    return 0;
}


