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
unsigned char has_door_nearby(unsigned char x, unsigned char y, unsigned char min_distance);
void find_room_exit(Room *room, unsigned char target_x, unsigned char target_y, 
                   unsigned char *exit_x, unsigned char *exit_y);
unsigned char check_tile_adjacency(unsigned char x, unsigned char y, unsigned char include_diagonals, unsigned char tile_types);
void assign_room_priorities(void);
void get_grid_position(unsigned char grid_index, unsigned char *x, unsigned char *y);
unsigned char try_place_room_at_grid(unsigned char grid_index, unsigned char w, unsigned char h, 
                                    unsigned char *result_x, unsigned char *result_y);
unsigned char get_compact_tile(unsigned char x, unsigned char y);
void set_compact_tile(unsigned char x, unsigned char y, unsigned char tile);
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
unsigned char draw_corridor(unsigned char room1, unsigned char room2);

/**
 * @brief Main logic for connecting rooms using rule-based system.
 * @param room1 The first room index.
 * @param room2 The second room index.
 * @return 1 if connection was made, 0 otherwise.
 */
unsigned char connect_rooms_directly(unsigned char room1, unsigned char room2);

/**
 * @brief Initializes the rule-based connection system.
 */
void init_connection_system(void);

/**
 * @brief Checks if two rooms are already connected.
 * @param room1 The first room index.
 * @param room2 The second room index.
 * @return 1 if rooms are connected, 0 otherwise.
 */
unsigned char rooms_are_connected(unsigned char room1, unsigned char room2);

/**
 * @brief Checks if room2 is reachable from room1 through existing connections.
 * @param room1 Starting room index.
 * @param room2 Target room index.
 * @return 1 if room2 is reachable from room1, 0 otherwise.
 * 
 * Uses Depth-First Search to prevent duplicate connections by detecting
 * indirect paths between rooms through other connections.
 */
unsigned char is_room_reachable(unsigned char room1, unsigned char room2);

// =============================================================================
// DOOR PLACEMENT FUNCTIONS
// =============================================================================

// Structure for a path of points (corridor)
typedef struct {
    unsigned char x[MAX_PATH_LENGTH];
    unsigned char y[MAX_PATH_LENGTH];
    unsigned char length;
} CorridorPath;

/**
 * @brief Place a door at (x, y) on the room edge (perimeter) if valid (Oscar64/C64)
 * @param x The x coordinate.
 * @param y The y coordinate.
 */
void place_door(unsigned char x, unsigned char y);

/**
 * @brief Place doors at the first and last walkable tiles of the corridor path between two rooms
 * @param roomA Pointer to the first room.
 * @param roomB Pointer to the second room.
 * @param path Pointer to the corridor path.
 */
void place_door_between_rooms(Room *roomA, Room *roomB, CorridorPath *path);

/**
 * @brief Place doors along a corridor path
 * @param path Pointer to the corridor path.
 */
void place_doors_along_corridor(const CorridorPath* path);

#endif // MAPGEN_INTERNAL_H