#ifndef MAPGEN_UTILITY_H
#define MAPGEN_UTILITY_H

#include "mapgen_types.h"
#include "mapgen_internal.h"  // For ExitPoint structure

// Calculate and cache the Y bit stride for current map dimensions
void calculate_y_bit_stride(void);
// External reference to cached Y bit stride
extern unsigned short y_bit_stride;

// RNG functions - 16-bit seed-based generation
unsigned int get_random_seed(void);       // Generate random seed from hardware
unsigned char rnd(unsigned char max);     // 16-bit LCG random number generator

// Seed-based generation API
unsigned int mapgen_get_seed(void);       // Get current seed value
void mapgen_reset_seed_flag(void);        // Reset to random seed on next generation

// Tile access and manipulation (optimized for C64 performance)
unsigned char get_compact_tile(unsigned char x, unsigned char y);
void set_compact_tile(unsigned char x, unsigned char y, unsigned char tile);
// Inline wrappers removed - use direct calls:
// get_tile_raw() -> get_compact_tile()
// set_tile_raw() -> set_compact_tile()
// tile_is_*() -> get_compact_tile() == TILE_*
void clear_map(void);

// Coordinate and bounds checking
unsigned char coords_in_bounds(unsigned char x, unsigned char y);

// Room containment functions - available for all modules
unsigned char point_in_room(unsigned char x, unsigned char y, unsigned char room_id);
unsigned char is_inside_any_room(unsigned char x, unsigned char y);
unsigned char point_in_any_room(unsigned char x, unsigned char y, unsigned char *room_id);

// Room edge validation
unsigned char is_on_room_edge(unsigned char x, unsigned char y);

// Mathematical and computational utilities
unsigned char abs_diff(unsigned char a, unsigned char b);
unsigned char manhattan_distance(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2);

// Room center management - use direct access: room_list[room_id].center_x/center_y
unsigned char calculate_room_distance(unsigned char room1, unsigned char room2);
unsigned char get_max_connection_distance(void);
// get_room_center_ptr_inline() is static inline below for OSCAR64 optimization

// Tile validation and adjacency checking
unsigned char check_tile_has_types(unsigned char x, unsigned char y, unsigned char type_flags);
unsigned char check_adjacent_tile_types(unsigned char x, unsigned char y, unsigned char type_flags, unsigned char include_diagonals);

// Reset and state management
void reset_all_generation_data(void);

// Wall and door validation utilities
unsigned char get_wall_side_from_exit(unsigned char room_idx, unsigned char exit_x, unsigned char exit_y);

// Percentage-based generation utilities
unsigned char calculate_percentage_count(unsigned char total, unsigned char percentage);
unsigned char count_non_branching_from_flags(void);

// Incremental wall placement functions
void place_walls_around_room(unsigned char x, unsigned char y, unsigned char w, unsigned char h);
void place_walls_around_corridor_tile(unsigned char x, unsigned char y);

// Segment-based corridor walling (more efficient than per-tile)
void place_wall_straight_corridor(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2);
void place_wall_corridor_junction(unsigned char jx, unsigned char jy);

// Door placement functions
void place_door(unsigned char x, unsigned char y);

// ===================================================================
// INLINE OPTIMIZED HELPERS - C64 Performance Critical
// ===================================================================

// Mathematical helpers
static inline unsigned char abs_diff_inline(unsigned char a, unsigned char b) {
    return (a > b) ? a - b : b - a;
}

// Grid calculation helpers - OSCAR64 inline optimization for room placement
static inline unsigned char get_grid_x(unsigned char grid_index) {
    return grid_index % GRID_SIZE;
}

static inline unsigned char get_grid_y(unsigned char grid_index) {
    return grid_index / GRID_SIZE;
}

static inline unsigned char get_grid_cell_width(unsigned char map_width) {
    return (map_width - 8) / GRID_SIZE;
}

static inline unsigned char get_grid_cell_height(unsigned char map_height) {
    return (map_height - 8) / GRID_SIZE;
}

// Bounds clamping helper - generic utility for boundary management
static inline unsigned char clamp_max(unsigned char value, unsigned char max_value) {
    return (value >= max_value) ? (max_value - 1) : value;
}

// Note: is_within_map_bounds_inline() removed - use coords_in_bounds() instead
// (requires runtime access to current_params, not suitable for inline header functions)

static inline unsigned char get_room_center_x_inline(unsigned char room_id, unsigned char room_count, const Room *room_list) {
    if (room_id >= room_count) return 0;
    return room_list[room_id].center_x;
}

static inline unsigned char get_room_center_y_inline(unsigned char room_id, unsigned char room_count, const Room *room_list) {
    if (room_id >= room_count) return 0;
    return room_list[room_id].center_y;
}

// Optimized Room pointer center access - static inline for best code generation
static inline void get_room_center_ptr_inline(Room *room, unsigned char *center_x, unsigned char *center_y) {
    *center_x = room->center_x;
    *center_y = room->center_y;
}

#endif // MAPGEN_UTILITY_H
