#ifndef MAPGEN_INTERNAL_H
#define MAPGEN_INTERNAL_H

#include "mapgen_types.h"

// Core map generation algorithm functions (internal only)
void create_rooms(void);
void connect_rooms(void);
void add_walls(void);
void add_stairs(void);
unsigned char generate_level(void);
void place_room(unsigned char x, unsigned char y, unsigned char w, unsigned char h);
void assign_room_priorities(void);

// Global mapgen module variables (defined in mapgen_utils.c)
extern unsigned char compact_map[MAP_H * MAP_W * 3 / 8];
extern Room rooms[MAX_ROOMS];
extern unsigned char room_count;
extern unsigned int rng_seed;

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
 * @brief Checks if a corridor path would intersect any rooms other than source/destination.
 * @param start_x Starting X coordinate.
 * @param start_y Starting Y coordinate.
 * @param end_x Ending X coordinate.
 * @param end_y Ending Y coordinate.
 * @param source_room Source room index to exclude from intersection check.
 * @param dest_room Destination room index to exclude from intersection check.
 * @return 1 if path intersects other rooms, 0 if clear.
 */
unsigned char path_intersects_other_rooms(unsigned char start_x, unsigned char start_y, 
                                         unsigned char end_x, unsigned char end_y,
                                         unsigned char source_room, unsigned char dest_room);

/**
 * @brief Checks if an L-shaped path between two points avoids room intersections.
 * @param sx Starting X coordinate.
 * @param sy Starting Y coordinate.
 * @param ex Ending X coordinate.
 * @param ey Ending Y coordinate.
 * @param source_room Source room index to exclude from intersection check.
 * @param dest_room Destination room index to exclude from intersection check.
 * @param xy_first 1 to move X-axis first, 0 to move Y-axis first.
 * @return 1 if path avoids room intersections, 0 if it intersects rooms.
 */
unsigned char l_path_avoids_rooms(unsigned char sx, unsigned char sy, unsigned char ex, unsigned char ey,
                                 unsigned char source_room, unsigned char dest_room, unsigned char xy_first);

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
// ROOM CONNECTION FUNCTIONS
// =============================================================================

/**
 * @brief Check if two rooms have overlapping projections on X or Y axis for straight corridors
 * @param room1 First room index
 * @param room2 Second room index
 * @param has_horizontal_overlap Pointer to store horizontal overlap result
 * @param has_vertical_overlap Pointer to store vertical overlap result
 */
void check_room_axis_alignment(unsigned char room1, unsigned char room2, 
                              unsigned char *has_horizontal_overlap, 
                              unsigned char *has_vertical_overlap);

/**
 * @brief Find optimal exit points for straight corridor between aligned rooms
 * @param room1 First room index
 * @param room2 Second room index
 * @param horizontal_aligned 1 if horizontally aligned, 0 if vertically aligned
 * @param exit1_x Pointer to store room1 exit X coordinate
 * @param exit1_y Pointer to store room1 exit Y coordinate
 * @param exit2_x Pointer to store room2 exit X coordinate
 * @param exit2_y Pointer to store room2 exit Y coordinate
 */
void find_straight_corridor_exits(unsigned char room1, unsigned char room2, 
                                 unsigned char horizontal_aligned,
                                 unsigned char *exit1_x, unsigned char *exit1_y,
                                 unsigned char *exit2_x, unsigned char *exit2_y);

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
 * @brief Find the best existing door on a room side that's closest to target coordinates
 * @param room_idx Room index to check
 * @param side Side of room: 0=left, 1=right, 2=top, 3=bottom
 * @param target_x Target X coordinate to find closest door to
 * @param target_y Target Y coordinate to find closest door to
 * @param door_x Pointer to store door X coordinate if found
 * @param door_y Pointer to store door Y coordinate if found
 * @return 1 if door found on specified side, 0 otherwise
 */
unsigned char find_best_existing_door_on_room_side(unsigned char room_idx, unsigned char side,
                                                  unsigned char target_x, unsigned char target_y,
                                                  unsigned char *door_x, unsigned char *door_y);

#endif // MAPGEN_INTERNAL_H