#ifndef MAPGEN_INTERNAL_H
#define MAPGEN_INTERNAL_H

#include "mapgen_types.h"
#include "mapgen_config.h"  // For MapParameters type

// =============================================================================
// SIMPLIFIED CONNECTION SYSTEM
// =============================================================================

// Core map generation algorithm functions (internal only)
void create_rooms(void);
void build_room_network(void);
void add_stairs(void);
unsigned char generate_level(void);
void place_room(unsigned char x, unsigned char y, unsigned char w, unsigned char h);

// Room initialization
void init_rooms(void);

// Secret room management
void place_secret_rooms(unsigned char room_count_target);

// Secret treasure management
void place_secret_treasures(unsigned char treasure_count);

// False corridor management
void place_false_corridors(unsigned char corridor_count);

// Hidden corridor management
void place_hidden_corridors(unsigned char corridor_count);

// =============================================================================
// CONSOLIDATED GLOBAL VARIABLE DECLARATIONS
// =============================================================================

// Core map data (defined in mapgen_utils.c)
extern unsigned char compact_map[COMPACT_MAP_SIZE];
extern Room room_list[MAX_ROOMS];
extern unsigned char room_count;
extern unsigned char rnd_state;

// Generation parameters (defined in map_generation.c)
extern MapParameters current_params;

// Runtime feature counters for percentage-based generation (defined in map_generation.c)
extern unsigned char total_connections;         // Total MST corridors created
extern unsigned char total_secret_rooms;        // Secret rooms placed
extern unsigned char total_treasures;           // Treasure chambers placed
extern unsigned char total_false_corridors;     // False corridors placed
extern unsigned char total_hidden_corridors;    // Hidden corridors placed
extern unsigned char available_walls_count;     // Walls without doors (non-secret rooms)

// Corridor tile cache for O(1) tile queries (defined in map_generation.c)
extern CorridorTileCache corridor_cache[MAX_CONNECTIONS];
extern unsigned char corridor_cache_count;

// Zero page variables for MST performance
extern __zeropage unsigned char mst_best_room1;
extern __zeropage unsigned char mst_best_room2; 
extern __zeropage unsigned char mst_best_distance;

// Display and camera system (defined in main.c)
extern unsigned char camera_center_x, camera_center_y;
extern Viewport view;
extern unsigned char screen_buffer[VIEW_H][VIEW_W];
extern unsigned char screen_dirty;
extern unsigned char last_scroll_direction;

// Connection functions (optimized)
unsigned char connect_rooms(unsigned char room1, unsigned char room2, unsigned char is_secret);

// can_connect_rooms_safely() removed - MST algorithm guarantees valid indices

/**
 * @brief Checks if a corridor tile can be placed at the given coordinates.
 * @param x The x coordinate.
 * @param y The y coordinate.
 * @return 1 if placement is allowed, 0 otherwise.
 */
unsigned char can_place_corridor(unsigned char x, unsigned char y, unsigned char check_level);



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