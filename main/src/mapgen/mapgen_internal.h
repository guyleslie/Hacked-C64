#ifndef MAPGEN_INTERNAL_H
#define MAPGEN_INTERNAL_H

#include "mapgen_types.h"

// =============================================================================
// SIMPLIFIED CONNECTION SYSTEM
// =============================================================================

// Core map generation algorithm functions (internal only)
void create_rooms(void);
void connect_rooms(void);
void add_walls(void);
void add_stairs(void);
unsigned char generate_level(void);
void place_room(unsigned char x, unsigned char y, unsigned char w, unsigned char h);
void assign_room_priorities(void);

// Room initialization
void init_rooms(void);

// Secret room management
void mark_secret_rooms(unsigned char secret_percentage);

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

// Connection functions
unsigned char connect_rooms_directly(unsigned char room1, unsigned char room2);
void init_connection_system(void);
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

// Door functions moved to connection_system.c

#endif // MAPGEN_INTERNAL_H