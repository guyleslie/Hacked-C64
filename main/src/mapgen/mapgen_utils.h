#ifndef MAPGEN_UTILITY_H
#define MAPGEN_UTILITY_H

#include "mapgen_types.h"
#include "mapgen_internal.h"  // For ExitPoint structure

// RNG functions
void init_rnd(void);
unsigned char rnd(unsigned char max);

// Console functions for Oscar64
void print_text(const char* text);
// PETSCII Progress bar system - direct functions, no wrappers
void init_progress_weights(void);  // Initialize dynamic phase boundaries from current_params
void init_progress_bar_simple(const char* title);
void update_progress_step(unsigned char phase, unsigned char current, unsigned char total);
void finish_progress_bar_simple(void);
void show_phase(unsigned char phase_id);  // Optimized indexed phase display
void show_phase_name(const char* phase_name);  // Legacy string version
void init_generation_progress(void);

// Tile access and manipulation (optimized for C64 performance)
unsigned char get_compact_tile(unsigned char x, unsigned char y);
void set_compact_tile(unsigned char x, unsigned char y, unsigned char tile);
// Inline wrappers removed - use direct calls:
// get_tile_raw() -> get_compact_tile()
// set_tile_raw() -> set_compact_tile() 
// tile_is_*() -> get_compact_tile() == TILE_*
void clear_map(void);

// Centralized PETSCII conversion for all display modules
unsigned char get_map_tile(unsigned char map_x, unsigned char map_y);

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

// Room center cache management
void get_room_center(unsigned char room_id, unsigned char *center_x, unsigned char *center_y);
void get_room_center_ptr(Room *room, unsigned char *center_x, unsigned char *center_y);
unsigned char calculate_room_distance(unsigned char room1, unsigned char room2);
unsigned char get_max_connection_distance(void);

// Tile validation and adjacency checking
unsigned char check_tile_has_types(unsigned char x, unsigned char y, unsigned char type_flags);
unsigned char check_adjacent_tile_types(unsigned char x, unsigned char y, unsigned char type_flags, unsigned char include_diagonals);

// Reset and state management
void reset_viewport_state(void);
void reset_display_state(void);
void reset_all_generation_data(void);

// Room distance cache management
void init_room_distance_cache(void);
void clear_room_distance_cache(void);

// Wall and door validation utilities
unsigned char get_wall_side_from_exit(unsigned char room_idx, unsigned char exit_x, unsigned char exit_y);
unsigned char wall_has_doors(unsigned char room_idx, unsigned char wall_side);

// Incremental wall placement functions
void place_walls_around_room(unsigned char x, unsigned char y, unsigned char w, unsigned char h);
void place_walls_around_corridor_tile(unsigned char x, unsigned char y);

// Door placement functions
void place_door(unsigned char x, unsigned char y);

// ===================================================================
// INLINE OPTIMIZED HELPERS - C64 Performance Critical
// ===================================================================

static inline unsigned char abs_diff_inline(unsigned char a, unsigned char b) {
    return (a > b) ? a - b : b - a;
}

static inline unsigned char is_within_map_bounds_inline(unsigned char x, unsigned char y) {
    return (x < MAP_W) && (y < MAP_H);
}

static inline unsigned char get_room_center_x_inline(unsigned char room_id) {
    if (room_id >= room_count) return 0;
    return room_list[room_id].center_x;
}

static inline unsigned char get_room_center_y_inline(unsigned char room_id) {
    if (room_id >= room_count) return 0;
    return room_list[room_id].center_y;
}

#endif // MAPGEN_UTILITY_H
