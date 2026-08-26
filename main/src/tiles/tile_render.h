#ifndef TILE_RENDER_H
#define TILE_RENDER_H

// =============================================================================
// 3x3 Tile Renderer
// =============================================================================
// Draws the generated dungeon with the CharPad tileset in multicolour
// character mode. One map cell is one 3x3 character tile.
//
// The black frame around walkable tiles is not part of the artwork:
// tools/tileset_build.py stamps it into generated character variants, and this
// module only picks which pre-stamped variant to emit. Optional fog support is
// retained but disabled by default.
// See docs/tile-rendering.md.
//
// Regular movement follows OSCAR64's samples/scrolling/cgrid8way.c: VIC fine
// scroll covers the pixels between character positions, while screen RAM and
// Color RAM are shifted in raster-safe sections. Only the newly exposed 25-cell
// column or 40-cell row is generated from the tile cache. Double buffering is
// retained for full redraws such as generating a new dungeon.

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

// -----------------------------------------------------------------------------
// Tileset tile indices - must match main/assets/tileset.ctm
// -----------------------------------------------------------------------------

#define TS_EMPTY        0   // Solid black, outside the dungeon
#define TS_FLOOR        1   // Walkable floor
#define TS_WALL_H       2   // Wall running left-right
#define TS_WALL_V       3   // Wall running up-down
#define TS_WALL_RD      4   // Wall corner opening right and down
#define TS_WALL_LD      5   // Wall corner opening left and down
#define TS_WALL_RU      6   // Wall corner opening right and up
#define TS_WALL_LU      7   // Wall corner opening left and up
#define TS_STAIR_A      8   // Staircase, one direction (walkable)
#define TS_STAIR_B      9   // Staircase, the other direction (walkable)
#define TS_GRATE_V      11  // Closed iron grating in an up-down wall
#define TS_GRATE_H      12  // Closed iron grating in a left-right wall
#define TS_DOOR_OPEN_V  13  // Open, walkable door in an up-down wall
#define TS_DOOR_OPEN_H  14  // Open, walkable door in a left-right wall
#define TS_DOOR_WOOD    17  // Closed wooden door
#define TS_FLOOR_ITEM   18  // Floor carrying a pickup, demo artwork

// An open door still shows the wall's top rim; only the closed leaf is gone.
// A cell with no door has no rim at all, so plain floor is used there.
//
// Tiles 10, 15 and 16 are retained artwork duplicates of tiles 9, 13 and 14.
// They share the same walkability and generated-grid behaviour.

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
 * @brief Show the back buffer and update changed shadow colours in Color RAM
 * Call inside the vertical blank. Only positions recorded as changed while the
 * back buffer was expanded are written.
 */
void tiles_flip(void);

/**
 * @brief Set the raw hardware fine scroll offset
 * @param px Horizontal VIC offset, 0-7
 * @param py Vertical VIC offset, 0-7
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

/**
 * @brief Move the visible screen one character in a cardinal direction
 * Uses a two-pixel raster scroll and shifts screen/Color RAM in place. The tile
 * cache must already describe the target tile origin.
 * @param dx Camera direction: -1, 0 or +1
 * @param dy Camera direction: -1, 0 or +1
 * @param sub_x Target character offset inside the leftmost tile, 0-2
 * @param sub_y Target character offset inside the topmost tile, 0-2
 */
void tiles_scroll(signed char dx, signed char dy,
                  unsigned char sub_x, unsigned char sub_y);

// -----------------------------------------------------------------------------
// Rendering
// -----------------------------------------------------------------------------

/**
 * @brief Start building a fresh back-buffer position
 * Resets the sparse Color RAM update list used by tiles_flip().
 */
void tiles_expand_begin(void);

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
