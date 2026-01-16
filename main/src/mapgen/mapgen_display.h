#ifndef MAPGEN_DISPLAY_H
#define MAPGEN_DISPLAY_H

#include "mapgen_types.h"

#ifdef DEBUG_MAPGEN
// Camera movement directions
const unsigned char MOVE_UP = 1;
const unsigned char MOVE_DOWN = 2;
const unsigned char MOVE_LEFT = 3;
const unsigned char MOVE_RIGHT = 4;

// =============================================================================
// PETSCII TILE CONVERSION
// =============================================================================

/**
 * @brief Convert raw tile type to PETSCII display character
 * @param map_x Map X coordinate
 * @param map_y Map Y coordinate
 * @return PETSCII character code for display
 */
unsigned char get_map_tile(unsigned char map_x, unsigned char map_y);

// =============================================================================
// VIEWPORT STATE MANAGEMENT
// =============================================================================

/**
 * @brief Reset viewport position to map center
 * Called before new map generation to ensure clean state
 */
void reset_viewport_state(void);

/**
 * @brief Reset display buffer and dirty flags
 * Clears screen buffer and marks for full redraw
 */
void reset_display_state(void);

// =============================================================================
// CAMERA AND DISPLAY FUNCTIONS
// =============================================================================

void initialize_camera(void);
void update_camera(void);
void move_camera_direction(unsigned char direction);
void render_map_viewport(unsigned char force_refresh);
void update_partial_screen(unsigned char scroll_dir);
void update_full_screen(void);
#endif // DEBUG_MAPGEN

#endif // MAPGEN_DISPLAY_H