// =============================================================================
// MAPGEN INTERNAL HEADER
// =============================================================================
#ifndef MAPGEN_INTERNAL_H
#define MAPGEN_INTERNAL_H

#include "mapgen_types.h"

// Internal map generation and utility functions (not part of public API)
void init_rng(void);
void clear_map(void);
void reset_all_generation_data(void);
void create_rooms(void);
void connect_rooms(void);
void add_walls(void);
void add_stairs(void);
unsigned char generate_level(void);
void place_room(unsigned char x, unsigned char y, unsigned char w, unsigned char h);
unsigned char rnd(unsigned char max);
unsigned int get_hardware_entropy(void);
void shuffle_room_indices(unsigned char *indices, unsigned char count);
void create_random_room_order(unsigned char *order);
unsigned char can_place_room(unsigned char x, unsigned char y, unsigned char w, unsigned char h);
unsigned char is_inside_room(unsigned char x, unsigned char y);
unsigned char is_outside_any_room(unsigned char x, unsigned char y);
unsigned char is_outside_room(unsigned char x, unsigned char y, unsigned char room_id);
unsigned char is_at_room_corner(unsigned char x, unsigned char y);
unsigned char has_door_nearby(unsigned char x, unsigned char y, unsigned char min_distance);
void find_room_exit(Room *room, unsigned char target_x, unsigned char target_y, 
                   unsigned char *exit_x, unsigned char *exit_y);
unsigned char choose_optimal_connection_pattern(void);
void connect_rooms_grid_optimized(unsigned char *connected, unsigned char *connections_made);
void connect_rooms_backbone_tree(unsigned char *connected, unsigned char *connections_made);
void connect_rooms_zone_clusters(unsigned char *connected, unsigned char *connections_made);
void connect_rooms_adaptive_network(unsigned char *connected, unsigned char *connections_made);
void connect_rooms_spatial_spanning(unsigned char *connected, unsigned char *connections_made);
unsigned char analyze_room_distribution(void);
unsigned char calculate_map_density(void);
unsigned char find_central_rooms(unsigned char *central_rooms);
void create_minimum_spanning_tree(unsigned char *connected, unsigned char *connections_made);
void add_strategic_loops(unsigned char connections_made);
unsigned char check_tile_adjacency(unsigned char x, unsigned char y, unsigned char include_diagonals, unsigned char tile_types);
void assign_room_priorities(void);
void get_grid_position(unsigned char grid_index, unsigned char *x, unsigned char *y);
unsigned char try_place_room_at_grid(unsigned char grid_index, unsigned char w, unsigned char h, 
                                    unsigned char *result_x, unsigned char *result_y);
unsigned char get_compact_tile_fast(unsigned char x, unsigned char y);
void set_compact_tile_fast(unsigned char x, unsigned char y, unsigned char tile);
unsigned char get_tile_raw(unsigned char x, unsigned char y);
void set_tile_raw(unsigned char x, unsigned char y, unsigned char tile);
unsigned char tile_is_floor(unsigned char x, unsigned char y);
unsigned char tile_is_wall(unsigned char x, unsigned char y);
unsigned char tile_is_door(unsigned char x, unsigned char y);
unsigned char tile_is_empty(unsigned char x, unsigned char y);


/**
 * @brief Checks if two rooms can be safely connected according to the base rules.
 * @param room1 The first room index.
 * @param room2 The second room index.
 * @return 1 if connection is allowed, 0 otherwise.
 */
unsigned char can_connect_rooms_safely(unsigned char room1, unsigned char room2);

/**
 * @brief Checks if a corridor tile can be placed at the given coordinates.
 * @param x The x coordinate.
 * @param y The y coordinate.
 * @return 1 if placement is allowed, 0 otherwise.
 */
unsigned char can_place_corridor_tile(unsigned char x, unsigned char y);

/**
 * @brief Draws a simple rule-based corridor between two rooms.
 * @param room1 The first room index.
 * @param room2 The second room index.
 * @return 1 if drawing was successful, 0 otherwise.
 */
unsigned char draw_rule_based_corridor(unsigned char room1, unsigned char room2);

/**
 * @brief Checks if an existing path can be reused between two rooms.
 * @param room1 The first room index.
 * @param room2 The second room index.
 * @return 1 if path can be reused, 0 otherwise.
 */
unsigned char can_reuse_existing_path(unsigned char room1, unsigned char room2);

/**
 * @brief Connects two rooms via existing corridors if possible.
 * @param room1 The first room index.
 * @param room2 The second room index.
 * @return 1 if connection was made, 0 otherwise.
 */
unsigned char connect_via_existing_corridors(unsigned char room1, unsigned char room2);

/**
 * @brief Main logic for connecting rooms using rule-based system.
 * @param room1 The first room index.
 * @param room2 The second room index.
 * @return 1 if connection was made, 0 otherwise.
 */
unsigned char rule_based_connect_rooms(unsigned char room1, unsigned char room2);

/**
 * @brief Initializes the rule-based connection system.
 */
void init_rule_based_connection_system(void);

/**
 * @brief Checks if two rooms are already connected.
 * @param room1 The first room index.
 * @param room2 The second room index.
 * @return 1 if rooms are connected, 0 otherwise.
 */
unsigned char rooms_are_connected(unsigned char room1, unsigned char room2);

#endif // MAPGEN_INTERNAL_H
