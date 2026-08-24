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
//
// Scrolling follows the OSCAR64 samples (samples/games/hscrollshmup.c): screen
// memory is never shifted. The visible area is re-expanded from a small tile
// cache, and the VIC fine scroll registers cover the seven pixels between one
// character position and the next. Re-expanding beats a shift here because
// colour RAM has to move too - the tileset uses seven different colour RAM
// values - and it needs no direction-specific code.
//
// A full re-expand is about 19,300 cycles against a 19,656 cycle PAL frame, so
// it cannot be done in one go without tearing. Instead the screen is double
// buffered: the next character position is expanded into the hidden buffer a
// few rows per frame, and crossing the character boundary is just a flip.

#include "tileset_data.h"

// -----------------------------------------------------------------------------
// Screen layout
// -----------------------------------------------------------------------------

#define TILE_SCREEN_COLS    40
#define TILE_SCREEN_ROWS    25

// Tile cache covering the visible area. One extra tile on each axis because the
// view is almost never aligned to a tile boundary.
#define TILE_CACHE_W        ((TILE_SCREEN_COLS / TILESET_TILE_W) + 1)
#define TILE_CACHE_H        ((TILE_SCREEN_ROWS / TILESET_TILE_H) + 1)

// Rows expanded into the back buffer per frame. Four rows is about 3,100
// cycles, so the work stays well inside a frame even at two pixels per frame,
// where a character boundary arrives every fourth frame.
#define TILE_EXPAND_SLICE   4

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
#define TS_DOOR_OPEN_V  14  // Open door in an up-down wall
#define TS_DOOR_OPEN_H  15  // Open door in a left-right wall
#define TS_DOOR_WOOD    18  // Wooden door
#define TS_FLOOR_ITEM   19  // Floor carrying a pickup, demo artwork

// An open door still shows the wall's top rim; only the closed leaf is gone.
// A cell with no door has no rim at all, so plain floor is used there.
//
// Tiles 2, 11, 16 and 17 are hand drawn fog copies of tiles 1, 10, 14 and 15.
// The fog variant is generated now, so they are redundant and can be deleted
// from the CTM file.

// -----------------------------------------------------------------------------
// Display
// -----------------------------------------------------------------------------

/**
 * @brief Install the tileset and switch to multicolour character mode
 * Copies the generated character set into VIC bank 3 and loads the three
 * global colour registers the tileset was authored against.
 */
void tiles_init(void);

/**
 * @brief Restore the kernal display defaults
 * Call before returning to anything that prints text, otherwise the tileset
 * glyphs are still in place and characters come out as map artwork.
 */
void tiles_shutdown(void);

/**
 * @brief Show the back buffer and copy the shadow colours into colour RAM
 * Call inside the vertical blank: the colour copy is about 5,000 cycles of the
 * roughly 7,000 the blank provides.
 */
void tiles_flip(void);

/**
 * @brief Set the hardware fine scroll offset
 * @param px Horizontal offset, 0-7 pixels
 * @param py Vertical offset, 0-7 pixels
 * Keeps 38 column and 24 row mode so the partially scrolled edge stays hidden
 * behind the border.
 */
void tiles_fine_scroll(unsigned char px, unsigned char py);

// -----------------------------------------------------------------------------
// Tile cache
// -----------------------------------------------------------------------------

/**
 * @brief Fill the whole tile cache for a new view position
 * @param tile_x Map X coordinate of the top-left visible tile
 * @param tile_y Map Y coordinate of the top-left visible tile
 * Costs one tile selection per cached tile, so use it on a camera jump, not
 * while scrolling.
 */
void tiles_cache_fill(unsigned char tile_x, unsigned char tile_y);

/**
 * @brief Move the tile cache so its origin is the given tile
 * Shifts by one tile when that is all it takes, refills on a longer jump.
 * Taking an absolute target rather than a delta means calling it twice without
 * anything moving in between is harmless.
 * @param tile_x Map X coordinate the cache should start at
 * @param tile_y Map Y coordinate the cache should start at
 */
void tiles_cache_move_to(unsigned char tile_x, unsigned char tile_y);

/**
 * @brief Shift the tile cache by one tile and fill the newly exposed edge
 * @param dx -1, 0 or +1 tiles
 * @param dy -1, 0 or +1 tiles
 * Only the new row or column is selected, which is what keeps tile selection
 * out of the scrolling path.
 */
void tiles_cache_shift(signed char dx, signed char dy);

// -----------------------------------------------------------------------------
// Rendering
// -----------------------------------------------------------------------------

/**
 * @brief Re-expand a horizontal band of the BACK buffer from the tile cache
 * Writes to the hidden screen and to the colour shadow, so it can be spread
 * over several frames without anything appearing half drawn.
 * @param sub_x Character offset into the leftmost cached tile, 0-2
 * @param sub_y Character offset into the topmost cached tile, 0-2
 * @param row_from First screen row to write
 * @param row_to One past the last screen row to write
 */
void tiles_expand(unsigned char sub_x, unsigned char sub_y,
                  unsigned char row_from, unsigned char row_to);

/**
 * @brief Choose the tileset entry that represents a map cell
 * Resolves wall joining, door orientation, open doors and secret doors, and
 * folds in the fog variant. The result indexes the cell-major tables directly.
 * @param map_x Map X coordinate
 * @param map_y Map Y coordinate
 * @return TILESET_ENTRY(variant, tile)
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
 * @brief Whether a closed door is drawn as a wooden door or an iron grating
 * Replace the body when door kinds are modelled; the orientation is derived
 * from the wall run either way.
 * @param map_x Map X coordinate
 * @param map_y Map Y coordinate
 * @return 1 for a wooden door, 0 for an iron grating
 */
unsigned char tiles_door_is_wooden(unsigned char map_x, unsigned char map_y);

#endif // TILE_RENDER_H
