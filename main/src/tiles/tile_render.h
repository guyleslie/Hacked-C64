#ifndef TILE_RENDER_H
#define TILE_RENDER_H

// =============================================================================
// 3x3 Tile Renderer
// =============================================================================
// Draws the generated dungeon with the CharPad tileset in multicolour
// character mode. One map cell is one 3x3 character tile.
//
// The black frame around walkable tiles and the fog of war checkerboard are
// not part of the artwork: tools/tileset_build.py stamps them into the
// character set, and this module only picks which pre-stamped variant to emit.
// See docs/tile-rendering.md.

#include "tileset_data.h"

// -----------------------------------------------------------------------------
// Screen layout (see docs/game-architecture-plan.md section 3)
// -----------------------------------------------------------------------------

#define TILE_VIEW_TILES_W   10                                  // 30 columns
#define TILE_VIEW_TILES_H   8                                   // 24 rows
#define TILE_VIEW_COLS      (TILE_VIEW_TILES_W * TILESET_TILE_W)
#define TILE_VIEW_ROWS      (TILE_VIEW_TILES_H * TILESET_TILE_H)

// -----------------------------------------------------------------------------
// Tileset tile indices - must match main/assets/tileset.ctm
// -----------------------------------------------------------------------------

#define TS_EMPTY        0   // Solid black, outside the dungeon
#define TS_FLOOR        1   // Walkable floor
#define TS_WALL_H       3   // Wall running left-right
#define TS_WALL_V       4   // Wall running up-down
#define TS_WALL_RD      5   // Wall corner opening right and down
#define TS_WALL_LD      6   // Wall corner opening left and down
#define TS_WALL_RU      7   // Wall corner opening right and up
#define TS_WALL_LU      8   // Wall corner opening left and up
#define TS_STAIR_A      9   // Staircase, one direction
#define TS_STAIR_B      10  // Staircase, the other direction
#define TS_GRATE_V      12  // Iron grating in an up-down wall
#define TS_GRATE_H      13  // Iron grating in a left-right wall
#define TS_WALL_FLOOR_V 14  // Wall edge with floor to its right
#define TS_WALL_FLOOR_H 15  // Wall edge with floor below it
#define TS_DOOR_WOOD    18  // Wooden door
#define TS_FLOOR_ITEM   19  // Floor carrying a pickup, demo artwork

// Tiles 2, 11, 16 and 17 are hand drawn fog copies of tiles 1, 10, 14 and 15.
// The fog variant is generated now, so they are redundant and can be deleted
// from the CTM file.

// -----------------------------------------------------------------------------
// API
// -----------------------------------------------------------------------------

/**
 * @brief Copy the tileset into the VIC character set and set the display mode
 * Selects multicolour character mode and loads the three global colour
 * registers the tileset was authored against.
 */
void tiles_init(void);

/**
 * @brief Draw one tileset tile at a character position
 * @param tile Tileset tile index
 * @param variant TILE_VARIANT_LIT or TILE_VARIANT_FOG
 * @param col Left character column
 * @param row Top character row
 */
void tiles_draw(unsigned char tile, unsigned char variant,
                unsigned char col, unsigned char row);

/**
 * @brief Choose the tileset tile that represents a map cell
 * Resolves wall joining, door orientation and secret doors.
 * @param map_x Map X coordinate
 * @param map_y Map Y coordinate
 * @return Tileset tile index
 */
unsigned char tiles_select(unsigned char map_x, unsigned char map_y);

/**
 * @brief Fog of war hook
 * Replace the body when the visibility system exists; it decides whether a
 * cell is drawn lit or darkened.
 * @param map_x Map X coordinate
 * @param map_y Map Y coordinate
 * @return TILE_VARIANT_LIT or TILE_VARIANT_FOG
 */
unsigned char tiles_variant_at(unsigned char map_x, unsigned char map_y);

/**
 * @brief Door artwork hook
 * Replace the body when door kinds are modelled. Returning TS_DOOR_WOOD picks
 * the wooden door; anything else leaves the iron grating, whose orientation is
 * derived from the wall run.
 * @param map_x Map X coordinate
 * @param map_y Map Y coordinate
 * @return TS_DOOR_WOOD or TS_GRATE_V
 */
unsigned char tiles_door_kind(unsigned char map_x, unsigned char map_y);

/**
 * @brief Draw the whole viewport starting at a map coordinate
 * @param origin_x Map X coordinate of the top-left visible tile
 * @param origin_y Map Y coordinate of the top-left visible tile
 */
void tiles_render_viewport(unsigned char origin_x, unsigned char origin_y);

#endif // TILE_RENDER_H
