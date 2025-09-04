#ifndef MAPGEN_UTILITY_H
#define MAPGEN_UTILITY_H

#include "mapgen_types.h"
#include "mapgen_internal.h"  // For ExitPoint structure

// RNG functions
void init_rnd(void);
unsigned char rnd(unsigned char max);

// Console functions for Oscar64
void print_text(const char* text);

// Tile access and manipulation (optimized for C64 performance)
unsigned char get_compact_tile(unsigned char x, unsigned char y);
void set_compact_tile(unsigned char x, unsigned char y, unsigned char tile);
unsigned char get_tile_raw(unsigned char x, unsigned char y);
void set_tile_raw(unsigned char x, unsigned char y, unsigned char tile);
unsigned char tile_is_floor(unsigned char x, unsigned char y);
unsigned char tile_is_wall(unsigned char x, unsigned char y);
unsigned char tile_is_door(unsigned char x, unsigned char y);
unsigned char tile_is_secret_path(unsigned char x, unsigned char y);
unsigned char tile_is_any_door(unsigned char x, unsigned char y);
unsigned char tile_is_empty(unsigned char x, unsigned char y);
void clear_map(void);

// Centralized PETSCII conversion for all display modules
unsigned char get_map_tile(unsigned char map_x, unsigned char map_y);

// Coordinate and bounds checking
unsigned char coords_in_bounds(unsigned char x, unsigned char y);
unsigned char is_within_map_bounds(unsigned char x, unsigned char y);
void clamp_to_bounds(unsigned char *x, unsigned char *y);

// Room containment functions - available for all modules
unsigned char point_in_room(unsigned char x, unsigned char y, unsigned char room_id);
unsigned char is_inside_any_room(unsigned char x, unsigned char y);
unsigned char point_in_any_room(unsigned char x, unsigned char y, unsigned char *room_id);
unsigned char is_outside_any_room(unsigned char x, unsigned char y);
unsigned char is_outside_room(unsigned char x, unsigned char y, unsigned char room_id);

// Room exit and validation utilities
void find_room_exit(Room *room, unsigned char target_x, unsigned char target_y, 
                   unsigned char *exit_x, unsigned char *exit_y);

// Room exit utilities - simplified
void find_room_exit_simple(unsigned char room_idx, unsigned char target_x, unsigned char target_y, 
                           unsigned char *exit_x, unsigned char *exit_y, unsigned char *wall_side);

unsigned char has_door_nearby(unsigned char x, unsigned char y, unsigned char min_distance);

// Room edge validation
unsigned char is_on_room_edge(unsigned char x, unsigned char y);

// Mathematical and computational utilities
unsigned char abs_diff(unsigned char a, unsigned char b);
unsigned char manhattan_distance(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2);
unsigned char calculate_direction(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2);

// Room boundary calculation utilities (commonly used patterns)
unsigned char get_room_right_edge(unsigned char room_id);
unsigned char get_room_bottom_edge(unsigned char room_id);
unsigned char get_room_center_x(unsigned char room_id);
unsigned char get_room_center_y(unsigned char room_id);
void get_room_bounds(unsigned char room_id, unsigned char *x1, unsigned char *y1, unsigned char *x2, unsigned char *y2);

// Viewport calculation utilities (commonly used viewport patterns)
unsigned char get_viewport_half_width(void);
unsigned char get_viewport_half_height(void);
unsigned char get_viewport_max_x(void);
unsigned char get_viewport_max_y(void);

// Room center cache management
void get_room_center(unsigned char room_id, unsigned char *center_x, unsigned char *center_y);
void init_room_center_cache(void);
void clear_room_center_cache(void);
unsigned char calculate_room_distance(unsigned char room1, unsigned char room2);
unsigned char get_max_connection_distance(void);

// Tile validation and adjacency checking
unsigned char check_tile_has_types(unsigned char x, unsigned char y, unsigned char type_flags);
unsigned char check_adjacent_tile_types(unsigned char x, unsigned char y, unsigned char type_flags, unsigned char include_diagonals);
unsigned char check_tile_adjacency(unsigned char x, unsigned char y, unsigned char include_diagonals, unsigned char tile_types);

// Reset and state management
void reset_viewport_state(void);
void reset_display_state(void);
void reset_all_generation_data(void);

// Connection system utilities (moved from connection_system.c)
unsigned char get_cached_room_distance(unsigned char room1, unsigned char room2);

// Traditional room distance cache
void init_room_distance_cache(void);
void clear_room_distance_cache(void);

#endif // MAPGEN_UTILITY_H
