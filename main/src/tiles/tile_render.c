// =============================================================================
// 3x3 Tile Renderer
// =============================================================================
// See tile_render.h and docs/tile-rendering.md.

#include <c64/vic.h>
#include <string.h>

#include "../mapgen/mapgen_types.h"
#include "../mapgen/mapgen_utils.h"
#include "../mapgen/mapgen_config.h"
#include "../mapgen/tmea_core.h"
#include "tileset_data.h"
#include "tile_render.h"

extern MapParameters current_params;

// =============================================================================
// GRAPHICS MEMORY
// =============================================================================

// VIC bank 3. The character set and screen sit in plain RAM below the I/O
// area, so neither needs the $01 bank switching that $D000 or $E000 would.
// tileviewer.c shrinks the code and data region to end at 0xC000 to keep the
// linker out of here.
unsigned char * const tile_charset = (unsigned char *)0xC000;
unsigned char * const tile_screen0 = (unsigned char *)0xC800;
unsigned char * const tile_screen1 = (unsigned char *)0xCC00;
unsigned char * const tile_color = (unsigned char *)0xD800;

// A full re-expand of the visible area costs about 19,300 cycles against a
// 19,656 cycle PAL frame, and only nine of the twenty five rows fit in the
// vertical blank. Doing it in one go therefore cannot avoid tearing, so the
// screen is double buffered: the next character position is expanded into the
// back buffer a few rows per frame, and the flip is a single $d018 write.
//
// Colour RAM cannot be double buffered, so it is shadowed in ordinary RAM and
// copied across at the flip. That copy is about 5,000 cycles and fits in the
// blank alongside the flip.
static unsigned char * screen_front;
static unsigned char * screen_back;
static unsigned char color_shadow[TILE_SCREEN_COLS * TILE_SCREEN_ROWS];

// Tile cache for the visible area, holding TILESET_ENTRY values so the expander
// can use them directly as an index into the cell-major tables.
#pragma align(tile_cache, 16)
static unsigned char tile_cache[TILE_CACHE_H][TILE_CACHE_W];

// Map coordinate of tile_cache[0][0].
static unsigned char cache_x = 0;
static unsigned char cache_y = 0;

// =============================================================================
// DISPLAY
// =============================================================================

void tiles_init(void) {
    memcpy(tile_charset, tileset_charset, TILESET_CHAR_COUNT * 8);

    screen_front = tile_screen0;
    screen_back = tile_screen1;

    // Sets the VIC bank, $d018 and the mode bits in one go.
    vic_setmode(VICM_TEXT_MC, (const char *)screen_front,
                (const char *)tile_charset);

    vic.color_back = TILESET_COLOR_BG0;
    vic.color_back1 = TILESET_COLOR_BG1;
    vic.color_back2 = TILESET_COLOR_BG2;
    vic.color_border = 0;

    // vic_setmode leaves 40 column and 25 row mode with fine scroll 3. Drop to
    // 38 columns and 24 rows so the partially scrolled edge hides behind the
    // border, and start at offset zero.
    tiles_fine_scroll(0, 0);
}

void tiles_shutdown(void) {
    vic_setmode(VICM_TEXT, (char *)0x0400, (char *)0x1000);
    vic.color_back = 6;
    vic.color_border = 14;
}

void tiles_fine_scroll(unsigned char px, unsigned char py) {
    // Scrolling right means the content moves left, so the register counts
    // down as the camera advances. CSEL and RSEL stay clear for 38x24, which
    // hides the partially scrolled edge behind the border. MCM has to be kept:
    // dropping it would put the whole screen back into hires.
    vic.ctrl2 = VIC_CTRL2_MCM | ((7 - px) & 7);
    vic.ctrl1 = VIC_CTRL1_DEN | ((7 - py) & 7);
}

void tiles_flip(void) {
    unsigned char * swap = screen_front;
    screen_front = screen_back;
    screen_back = swap;

    // Only the screen base changes; the character set and bank stay put, so
    // this is one register write rather than a full vic_setmode.
    vic.memptr = (unsigned char)((((unsigned int)screen_front >> 6) & 0xF0)
                               | (((unsigned int)tile_charset >> 10) & 0x0E));

    memcpy(tile_color, color_shadow, TILE_SCREEN_COLS * TILE_SCREEN_ROWS);
}

// =============================================================================
// MAP CELL -> TILESET ENTRY
// =============================================================================

// A wall keeps running through doors and gratings, so those count as a
// connection when a neighbouring wall picks its shape.
static unsigned char wall_connects(unsigned char x, unsigned char y) {
    unsigned char tile = get_compact_tile(x, y);
    if (tile == TILE_WALL || tile == TILE_DOOR) return 1;
    // TILE_MARKER carries TMEA metadata over a floor or a door cell. Only a
    // door continues a wall run.
    if (tile == TILE_MARKER) return is_door_secret(x, y);
    return 0;
}

// Wall shape selection, derived from the reference map drawn in CharPad and
// verified by tools/tileset_build.py against every wall placement in it.
//
// The tileset has straight runs and four corners but no T or cross piece, so a
// junction keeps one vertical and one horizontal direction. Down wins over up
// and right wins over left, which is what the hand drawn map does.
static unsigned char select_wall_tile(unsigned char x, unsigned char y) {
    unsigned char up = wall_connects(x, y - 1);
    unsigned char down = wall_connects(x, y + 1);
    unsigned char left = wall_connects(x - 1, y);
    unsigned char right = wall_connects(x + 1, y);

    if (down) {
        if (right) return TS_WALL_RD;
        if (left) return TS_WALL_LD;
        return TS_WALL_V;
    }
    if (up) {
        if (right) return TS_WALL_RU;
        if (left) return TS_WALL_LU;
        return TS_WALL_V;
    }
    return TS_WALL_H;
}

// Which artwork a closed door uses is game data, not geometry. Replace the
// body when door kinds are modelled.
unsigned char tiles_door_is_wooden(unsigned char map_x, unsigned char map_y) {
    (void)map_x;
    (void)map_y;
    return 0;
}

// A door inherits the orientation of the wall run it sits in. Opening it takes
// away the leaf but not the wall's top rim, which is why an open door has its
// own artwork rather than becoming plain floor.
static unsigned char select_door_tile(unsigned char x, unsigned char y) {
    unsigned char vertical = wall_connects(x, y - 1) || wall_connects(x, y + 1);

    if (is_door_open(x, y)) {
        return vertical ? TS_DOOR_OPEN_V : TS_DOOR_OPEN_H;
    }
    if (tiles_door_is_wooden(x, y)) return TS_DOOR_WOOD;
    return vertical ? TS_GRATE_V : TS_GRATE_H;
}

// Integration point. The visibility system does not exist yet, so everything
// is drawn lit. Returning TILE_VARIANT_FOG for an explored but currently
// unseen cell is all that is needed to darken it; the darkened characters are
// already in the character set.
unsigned char tiles_variant_at(unsigned char map_x, unsigned char map_y) {
    (void)map_x;
    (void)map_y;
    return TILE_VARIANT_LIT;
}

unsigned char tiles_select(unsigned char map_x, unsigned char map_y) {
    unsigned char tile;

    if (map_x >= current_params.map_width || map_y >= current_params.map_height) {
        return TILESET_ENTRY(TILE_VARIANT_LIT, TS_EMPTY);
    }

    unsigned char raw = get_compact_tile(map_x, map_y);

    // TILE_* are const variables rather than macros, so this is an if chain
    // instead of a switch.
    if (raw == TILE_FLOOR) {
        tile = TS_FLOOR;
    } else if (raw == TILE_WALL) {
        tile = select_wall_tile(map_x, map_y);
    } else if (raw == TILE_DOOR) {
        // A secret door must be indistinguishable from the wall it hides in.
        // Hidden rooms, hidden passages and niches all mark their door with
        // add_secret_door_metadata(), so this one check covers the lot.
        tile = is_door_secret(map_x, map_y)
             ? select_wall_tile(map_x, map_y)
             : select_door_tile(map_x, map_y);
    } else if (raw == TILE_MARKER) {
        // TMEA metadata marker: a door when it carries door metadata,
        // otherwise the floor underneath it.
        tile = is_door_secret(map_x, map_y)
             ? select_wall_tile(map_x, map_y)
             : TS_FLOOR;
    } else if (raw == TILE_UP) {
        tile = TS_STAIR_A;
    } else if (raw == TILE_DOWN) {
        tile = TS_STAIR_B;
    } else {
        tile = TS_EMPTY;
    }

    return TILESET_ENTRY(tiles_variant_at(map_x, map_y), tile);
}

// =============================================================================
// TILE CACHE
// =============================================================================

void tiles_cache_fill(unsigned char tile_x, unsigned char tile_y) {
    cache_x = tile_x;
    cache_y = tile_y;

    for (unsigned char row = 0; row < TILE_CACHE_H; row++) {
        unsigned char my = tile_y + row;
        for (unsigned char col = 0; col < TILE_CACHE_W; col++) {
            tile_cache[row][col] = tiles_select(tile_x + col, my);
        }
    }
}

static void cache_fill_col(unsigned char col) {
    unsigned char mx = cache_x + col;
    for (unsigned char row = 0; row < TILE_CACHE_H; row++) {
        tile_cache[row][col] = tiles_select(mx, cache_y + row);
    }
}

static void cache_fill_row(unsigned char row) {
    unsigned char my = cache_y + row;
    for (unsigned char col = 0; col < TILE_CACHE_W; col++) {
        tile_cache[row][col] = tiles_select(cache_x + col, my);
    }
}

void tiles_cache_move_to(unsigned char tile_x, unsigned char tile_y) {
    signed char dx = (signed char)(tile_x - cache_x);
    signed char dy = (signed char)(tile_y - cache_y);

    if (dx == 0 && dy == 0) return;

    // Anything further than one tile is a jump, not a scroll step, so refilling
    // is both simpler and cheaper than repeated shifting.
    if (dx < -1 || dx > 1 || dy < -1 || dy > 1) {
        tiles_cache_fill(tile_x, tile_y);
        return;
    }
    tiles_cache_shift(dx, dy);
}

void tiles_cache_shift(signed char dx, signed char dy) {
    if (dy > 0) {
        cache_y++;
        for (unsigned char row = 0; row < TILE_CACHE_H - 1; row++) {
            memcpy(tile_cache[row], tile_cache[row + 1], TILE_CACHE_W);
        }
        cache_fill_row(TILE_CACHE_H - 1);
    } else if (dy < 0) {
        cache_y--;
        for (unsigned char row = TILE_CACHE_H - 1; row > 0; row--) {
            memcpy(tile_cache[row], tile_cache[row - 1], TILE_CACHE_W);
        }
        cache_fill_row(0);
    }

    if (dx > 0) {
        cache_x++;
        for (unsigned char row = 0; row < TILE_CACHE_H; row++) {
            memmove(&tile_cache[row][0], &tile_cache[row][1], TILE_CACHE_W - 1);
        }
        cache_fill_col(TILE_CACHE_W - 1);
    } else if (dx < 0) {
        cache_x--;
        for (unsigned char row = 0; row < TILE_CACHE_H; row++) {
            memmove(&tile_cache[row][1], &tile_cache[row][0], TILE_CACHE_W - 1);
        }
        cache_fill_col(0);
    }
}

// =============================================================================
// EXPAND
// =============================================================================

void tiles_expand(unsigned char sub_x, unsigned char sub_y,
                  unsigned char row_from, unsigned char row_to) {
    // Which cached tile row, and which character row inside it, the first
    // screen row comes from.
    unsigned char cell_y = sub_y + row_from;
    unsigned char cache_row = 0;
    while (cell_y >= TILESET_TILE_H) {
        cell_y -= TILESET_TILE_H;
        cache_row++;
    }

    for (unsigned char row = row_from; row < row_to; row++) {
        const unsigned char * cache = tile_cache[cache_row];

        // The three character columns of a tile at this character row.
        // Hoisting them turns every lookup below into a single indexed load
        // with the tile entry as the index.
        unsigned char cell = cell_y * TILESET_TILE_W;
        const unsigned char * ch0 = tileset_cell_char[cell];
        const unsigned char * ch1 = tileset_cell_char[cell + 1];
        const unsigned char * ch2 = tileset_cell_char[cell + 2];
        const unsigned char * co0 = tileset_cell_color[cell];
        const unsigned char * co1 = tileset_cell_color[cell + 1];
        const unsigned char * co2 = tileset_cell_color[cell + 2];

        unsigned int offset = (unsigned int)row * TILE_SCREEN_COLS;
        unsigned char * sp = screen_back + offset;
        unsigned char * cp = color_shadow + offset;

        unsigned char col = 0;
        unsigned char index = 0;
        unsigned char entry = cache[0];

        // Leading partial tile, when the view is not aligned to a tile.
        if (sub_x == 1) {
            sp[0] = ch1[entry]; cp[0] = co1[entry];
            sp[1] = ch2[entry]; cp[1] = co2[entry];
            col = 2;
            index = 1;
        } else if (sub_x == 2) {
            sp[0] = ch2[entry]; cp[0] = co2[entry];
            col = 1;
            index = 1;
        }

        // Whole tiles. Three cells per iteration, one entry load each.
        while (col + TILESET_TILE_W <= TILE_SCREEN_COLS) {
            entry = cache[index];
            sp[col] = ch0[entry];      cp[col] = co0[entry];
            sp[col + 1] = ch1[entry];  cp[col + 1] = co1[entry];
            sp[col + 2] = ch2[entry];  cp[col + 2] = co2[entry];
            col += TILESET_TILE_W;
            index++;
        }

        // Trailing partial tile.
        if (col < TILE_SCREEN_COLS) {
            entry = cache[index];
            sp[col] = ch0[entry];
            cp[col] = co0[entry];
            col++;
            if (col < TILE_SCREEN_COLS) {
                sp[col] = ch1[entry];
                cp[col] = co1[entry];
            }
        }

        cell_y++;
        if (cell_y == TILESET_TILE_H) {
            cell_y = 0;
            cache_row++;
        }
    }
}
