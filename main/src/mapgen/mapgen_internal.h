#ifndef MAPGEN_INTERNAL_H
#define MAPGEN_INTERNAL_H

#include "mapgen_types.h"

// =============================================================================
// SIMPLIFIED CONNECTION SYSTEM
// =============================================================================

// Core map generation algorithm functions (internal only)
void create_rooms(void);
void connect_rooms(void);
void add_stairs(void);
unsigned char generate_level(void);
void place_room(unsigned char x, unsigned char y, unsigned char w, unsigned char h);
void assign_room_priorities(void);

// Room initialization
void init_rooms(void);

// Secret room management
void convert_secret_corridors(void);

// =============================================================================
// CONSOLIDATED GLOBAL VARIABLE DECLARATIONS
// =============================================================================

// Core map data (defined in mapgen_utils.c)
extern unsigned char compact_map[MAP_H * MAP_W * 3 / 8];
extern Room rooms[MAX_ROOMS];
extern unsigned char room_count;
extern unsigned char rnd_state;

// OSCAR64 zero page optimized variables for MST performance
extern __zeropage unsigned char mst_best_room1;
extern __zeropage unsigned char mst_best_room2; 
extern __zeropage unsigned char mst_best_distance;

// Display and camera system (defined in main.c)
extern unsigned char camera_center_x, camera_center_y;
extern Viewport view;
extern unsigned char screen_buffer[VIEW_H][VIEW_W];
extern unsigned char screen_dirty;
extern unsigned char last_scroll_direction;

// Connection functions (wrappers removed for OSCAR64 efficiency)
unsigned char connect_rooms_directly(unsigned char room1, unsigned char room2, unsigned char is_secret);
unsigned char rooms_are_connected(unsigned char room1, unsigned char room2);

/**
 * @brief Checks if two rooms can be safely connected according to simplified rules.
 * @param room1 The first room index.
 * @param room2 The second room index.
 * @return 1 if connection is allowed, 0 otherwise.
 * 
 * Simplified validation with dynamic distance limits:
 * - For sparse layouts (≤8 rooms): max 80 tiles apart
 * - For normal layouts (>8 rooms): max 30 tiles apart
 * This ensures connectivity on large maps with few rooms while maintaining C64 performance.
 */
unsigned char can_connect_rooms_safely(unsigned char room1, unsigned char room2);

/**
 * @brief Checks if a corridor tile can be placed at the given coordinates.
 * @param x The x coordinate.
 * @param y The y coordinate.
 * @return 1 if placement is allowed, 0 otherwise.
 */
unsigned char can_place_corridor(unsigned char x, unsigned char y);



// =============================================================================
// ROOM CONNECTION FUNCTIONS
// =============================================================================


// =============================================================================
// DOOR PLACEMENT FUNCTIONS
// =============================================================================

/**
 * @brief Place a door at (x, y) on the room edge (perimeter) if valid (Oscar64/C64)
 * @param x The x coordinate.
 * @param y The y coordinate.
 */
void place_door(unsigned char x, unsigned char y);

/**
 * @brief Find existing door on specified wall side within tolerance
 * @param room_idx The room index
 * @param wall_side The wall side (0=left, 1=right, 2=top, 3=bottom)
 * @param target_x Target X coordinate
 * @param target_y Target Y coordinate
 * @param found_x Pointer to store found door X coordinate
 * @param found_y Pointer to store found door Y coordinate
 * @return 1 if door found, 0 otherwise
 */
unsigned char find_existing_door_on_wall(unsigned char room_idx, unsigned char wall_side, 
                                        unsigned char target_x, unsigned char target_y,
                                        unsigned char *found_x, unsigned char *found_y);

/**
 * @brief Atomic connection management - adds connection and door metadata in single operation
 * @param room_idx The room index
 * @param connected_room Index of connected room
 * @param door_x Door X coordinate
 * @param door_y Door Y coordinate
 * @param wall_side Wall side where door is placed
 * @param corridor_type Type of corridor (0=straight, 1=L-shaped, 2=Z-shaped)
 * @return 1 if successful, 0 if room is full or invalid
 */
unsigned char add_connection_to_room(unsigned char room_idx, unsigned char connected_room,
                                    unsigned char door_x, unsigned char door_y, 
                                    unsigned char wall_side, unsigned char corridor_type);

/**
 * @brief Centralized connection validation - checks if rooms are already connected
 * @param room_idx The room index
 * @param target_room The target room to check connection to
 * @return 1 if connection exists, 0 otherwise
 */
unsigned char room_has_connection_to(unsigned char room_idx, unsigned char target_room);

/**
 * @brief Get connection info for specific connected room
 * @param room_idx The room index
 * @param target_room The connected room to get info for
 * @param door_x Pointer to store door X coordinate
 * @param door_y Pointer to store door Y coordinate
 * @param wall_side Pointer to store wall side
 * @param corridor_type Pointer to store corridor type
 * @return 1 if connection found, 0 otherwise
 */
unsigned char get_connection_info(unsigned char room_idx, unsigned char target_room,
                                 unsigned char *door_x, unsigned char *door_y, 
                                 unsigned char *wall_side, unsigned char *corridor_type);

/**
 * @brief Atomic rollback - removes last connection from room safely
 * @param room_idx The room index
 * @return 1 if successful, 0 if no connections to remove or invalid room
 */
unsigned char remove_last_connection_from_room(unsigned char room_idx);

// Clean implementation - all metadata management through atomic operations only

#endif // MAPGEN_INTERNAL_H