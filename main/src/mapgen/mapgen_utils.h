#ifndef MAPGEN_UTILITY_H
#define MAPGEN_UTILITY_H

#include "mapgen_types.h"

// =============================================================================
// UTILITY FUNCTIONS HEADER - Unified utilities for mapgen system
// Contains all internal utility functions previously split between files
// =============================================================================

// Hardware and RNG functions
unsigned int get_hardware_entropy(void);
void init_rng(void);
unsigned char rnd(unsigned char max);

// Console functions for Oscar64
void print_text(const char* text);

// Tile access and manipulation
unsigned char get_compact_tile(unsigned char x, unsigned char y);
void set_compact_tile(unsigned char x, unsigned char y, unsigned char tile);
unsigned char get_tile_raw(unsigned char x, unsigned char y);
void set_tile_raw(unsigned char x, unsigned char y, unsigned char tile);
unsigned char tile_is_floor(unsigned char x, unsigned char y);
unsigned char tile_is_wall(unsigned char x, unsigned char y);
unsigned char tile_is_door(unsigned char x, unsigned char y);
unsigned char tile_is_empty(unsigned char x, unsigned char y);
void clear_map(void);

// Coordinate and bounds checking
unsigned char coords_in_bounds(unsigned char x, unsigned char y);
unsigned char is_within_map_bounds(unsigned char x, unsigned char y);
void clamp_to_bounds(unsigned char *x, unsigned char *y);
unsigned char point_in_room(unsigned char x, unsigned char y, unsigned char room_id);

// Room edge validation
unsigned char is_on_room_edge(unsigned char x, unsigned char y);

// Mathematical and computational utilities
unsigned char abs_diff(unsigned char a, unsigned char b);
unsigned char manhattan_distance(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2);
unsigned char calculate_direction(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2);

// Room center cache management
void get_room_center(unsigned char room_id, unsigned char *center_x, unsigned char *center_y);
void init_room_center_cache(void);
void clear_room_center_cache(void);
unsigned char calculate_room_distance(unsigned char room1, unsigned char room2);

// Grid and placement utilities
void get_grid_position(unsigned char grid_index, unsigned char *x, unsigned char *y);

// Randomization utilities
void shuffle_room_indices(unsigned char *indices, unsigned char count);
void create_random_room_order(unsigned char *order);

// Tile validation and adjacency checking
unsigned char check_tile_has_types(unsigned char x, unsigned char y, unsigned char type_flags);
unsigned char check_adjacent_tile_types(unsigned char x, unsigned char y, unsigned char type_flags, unsigned char include_diagonals);
unsigned char check_tile_adjacency(unsigned char x, unsigned char y, unsigned char include_diagonals, unsigned char tile_types);

// Reset and state management
void reset_viewport_state(void);
void reset_display_state(void);
void reset_all_generation_data(void);

#endif // MAPGEN_UTILITY_H
