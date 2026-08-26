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

// A full re-expand does not fit in the vertical blank. It is used only for a
// full camera reset and is expanded into the hidden screen before a $d018 flip.
// Regular movement uses the in-place raster scroll further below.
//
// Color RAM cannot be banked with the screens. Each screen therefore has an
// ordinary-RAM color shadow. While expanding the back screen we collect only
// cells whose color differs from the visible screen, then update those sparse
// positions at the flip instead of copying all 1000 Color RAM bytes.
static unsigned char * screen_front;
static unsigned char * screen_back;
static unsigned char color_shadow0[TILE_SCREEN_COLS * TILE_SCREEN_ROWS];
static unsigned char color_shadow1[TILE_SCREEN_COLS * TILE_SCREEN_ROWS];
static unsigned char * color_front;
static unsigned char * color_back;
static unsigned char color_dirty_cols[TILE_SCREEN_COLS * TILE_SCREEN_ROWS];
static unsigned char color_dirty_counts[TILE_SCREEN_ROWS];
static unsigned char color_front_valid;

// One newly exposed character row or column. Regular camera movement shifts
// the visible screen in place and only generates this edge from the tile cache.
static unsigned char scroll_chars[TILE_SCREEN_COLS];
static unsigned char scroll_colors[TILE_SCREEN_COLS];

// Moving the screen down has to copy backwards in memory, towards the raster
// beam. Two saved seam rows let that operation follow the three-part schedule
// from OSCAR64's samples/scrolling/cgrid8way.c.
static unsigned char scroll_tmp0[TILE_SCREEN_COLS];
static unsigned char scroll_tmp1[TILE_SCREEN_COLS];
static unsigned char scroll_tmp2[TILE_SCREEN_COLS];
static unsigned char scroll_tmp3[TILE_SCREEN_COLS];

#define TILE_SCROLL_SPLIT1  12
#define TILE_SCROLL_SPLIT2  20

// Tile cache for the visible area, holding TILESET_ENTRY values so the expander
// can use them directly as an index into the cell-major tables.
static unsigned char tile_cache[TILE_CACHE_H][TILE_CACHE_W];
#pragma align(tile_cache, 16)

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
    color_front = color_shadow0;
    color_back = color_shadow1;

    // Establish the same known state in physical Color RAM and both shadows.
    // Value 8 enables multicolor with character-specific color black.
    memset(tile_color, 8, TILE_SCREEN_COLS * TILE_SCREEN_ROWS);
    memset(color_front, 8, TILE_SCREEN_COLS * TILE_SCREEN_ROWS);
    memset(color_back, 8, TILE_SCREEN_COLS * TILE_SCREEN_ROWS);
    memset(color_dirty_counts, 0, TILE_SCREEN_ROWS);
    color_front_valid = 1;

    // Sets the VIC bank, $d018 and the mode bits in one go.
    vic_setmode(VICM_TEXT_MC, (const char *)screen_front,
                (const char *)tile_charset);

    vic.color_back = TILESET_COLOR_BG0;
    vic.color_back1 = TILESET_COLOR_BG1;
    vic.color_back2 = TILESET_COLOR_BG2;
    vic.color_border = 0;

    // Start from the centered offset used by the four-way raster scroll. CSEL
    // and RSEL remain clear, hiding the moving edge behind the border.
    tiles_fine_scroll(4, 4);
}

void tiles_shutdown(void) {
    vic_setmode(VICM_TEXT, (char *)0x0400, (char *)0x1000);
    vic.color_back = 6;
    vic.color_border = 14;
}

void tiles_fine_scroll(unsigned char px, unsigned char py) {
    // Raw VIC offsets. MCM has to be kept in $d016; dropping it would put the
    // whole screen back into hires. CSEL/RSEL stay clear for 38x24 mode.
    vic.ctrl2 = VIC_CTRL2_MCM | (px & 7);
    vic.ctrl1 = VIC_CTRL1_DEN | (py & 7);
}

void tiles_flip(void) {
    unsigned char * swap = screen_front;
    screen_front = screen_back;
    screen_back = swap;

    swap = color_front;
    color_front = color_back;
    color_back = swap;
    color_front_valid = 1;

    // Only the screen base changes; the character set and bank stay put, so
    // this is one register write rather than a full vic_setmode.
    vic.memptr = (unsigned char)((((unsigned int)screen_front >> 6) & 0xF0)
                               | (((unsigned int)tile_charset >> 10) & 0x0E));

    unsigned char * dirty = color_dirty_cols;
    unsigned char * source = color_front;
    unsigned char * dest = tile_color;
    for (unsigned char row = 0; row < TILE_SCREEN_ROWS; row++) {
        unsigned char count = color_dirty_counts[row];
        for (unsigned char i = 0; i < count; i++) {
            unsigned char col = dirty[i];
            dest[col] = source[col];
        }
        dirty += TILE_SCREEN_COLS;
        source += TILE_SCREEN_COLS;
        dest += TILE_SCREEN_COLS;
    }
    memset(color_dirty_counts, 0, TILE_SCREEN_ROWS);
}

// =============================================================================
// MAP CELL -> TILESET ENTRY
// =============================================================================

// TILE_MARKER replaces the compact tile byte whenever TMEA metadata is added.
// Inspect the metadata type so an ordinary, open, locked or trapped door does
// not accidentally turn into floor just because it is not secret.
static unsigned char marker_is_door(unsigned char x, unsigned char y) {
    unsigned char flags;
    if (!get_tile_metadata(x, y, &flags, NULL)) return 0;
    return is_meta_type(flags, TMTYPE_DOOR);
}

// Classify a neighbouring map cell with one packed-map read. A door is both a
// continuation of the wall and an opening in it. An ordinary marker overlays
// walkable floor; a door marker has both properties just like TILE_DOOR.
#define WALL_NEIGHBOUR_CONNECTS  0x01
#define WALL_NEIGHBOUR_WALKABLE 0x02

#define WALL_WALK_U   0x01
#define WALL_WALK_D   0x02
#define WALL_WALK_L   0x04
#define WALL_WALK_R   0x08
#define WALL_WALK_UL  0x10
#define WALL_WALK_UR  0x20
#define WALL_WALK_DL  0x40
#define WALL_WALK_DR  0x80

static unsigned char wall_neighbour_kind(unsigned char x, unsigned char y) {
    unsigned char tile = get_compact_tile(x, y);
    if (tile == TILE_WALL) return WALL_NEIGHBOUR_CONNECTS;
    if (tile == TILE_DOOR) {
        return WALL_NEIGHBOUR_CONNECTS | WALL_NEIGHBOUR_WALKABLE;
    }
    if (tile == TILE_MARKER) {
        return marker_is_door(x, y)
             ? WALL_NEIGHBOUR_CONNECTS | WALL_NEIGHBOUR_WALKABLE
             : WALL_NEIGHBOUR_WALKABLE;
    }
    if (tile == TILE_FLOOR || tile == TILE_UP || tile == TILE_DOWN) {
        return WALL_NEIGHBOUR_WALKABLE;
    }
    return 0;
}

// A wall keeps running through doors and gratings, so those count as a
// connection when a neighbouring door picks its orientation.
static unsigned char wall_connects(unsigned char x, unsigned char y) {
    return wall_neighbour_kind(x, y) & WALL_NEIGHBOUR_CONNECTS;
}

// Wall shape selection. A raw connection mask alone is insufficient: walls of
// nearby rooms and one-tile corridors can touch without belonging to the same
// visible run.
//
// The final newest5 reference resolves T and cross contacts by the walkable
// space around the junction. A branch is a real corner only when a walkable
// diagonal beside that branch confirms it; otherwise the through axis remains
// straight. This prevents walls of adjacent rooms/corridors from producing a
// row of false white-dotted corners.
static unsigned char select_wall_tile(unsigned char x, unsigned char y) {
    unsigned char up_kind = wall_neighbour_kind(x, y - 1);
    unsigned char down_kind = wall_neighbour_kind(x, y + 1);
    unsigned char left_kind = wall_neighbour_kind(x - 1, y);
    unsigned char right_kind = wall_neighbour_kind(x + 1, y);

    unsigned char up = up_kind & WALL_NEIGHBOUR_CONNECTS;
    unsigned char down = down_kind & WALL_NEIGHBOUR_CONNECTS;
    unsigned char left = left_kind & WALL_NEIGHBOUR_CONNECTS;
    unsigned char right = right_kind & WALL_NEIGHBOUR_CONNECTS;

    // Only junctions need diagonal map reads. Straight runs and ordinary
    // corners stay on the four-read fast path.
    if ((up && down && (left || right)) ||
        (left && right && (up || down))) {
        unsigned char walk = 0;
        if (up_kind & WALL_NEIGHBOUR_WALKABLE) walk |= WALL_WALK_U;
        if (down_kind & WALL_NEIGHBOUR_WALKABLE) walk |= WALL_WALK_D;
        if (left_kind & WALL_NEIGHBOUR_WALKABLE) walk |= WALL_WALK_L;
        if (right_kind & WALL_NEIGHBOUR_WALKABLE) walk |= WALL_WALK_R;
        if (wall_neighbour_kind(x - 1, y - 1) & WALL_NEIGHBOUR_WALKABLE)
            walk |= WALL_WALK_UL;
        if (wall_neighbour_kind(x + 1, y - 1) & WALL_NEIGHBOUR_WALKABLE)
            walk |= WALL_WALK_UR;
        if (wall_neighbour_kind(x - 1, y + 1) & WALL_NEIGHBOUR_WALKABLE)
            walk |= WALL_WALK_DL;
        if (wall_neighbour_kind(x + 1, y + 1) & WALL_NEIGHBOUR_WALKABLE)
            walk |= WALL_WALK_DR;

        // Vertical through with a right branch: right-side diagonals prove
        // the turn; otherwise the right contact is incidental.
        if (up && down && right && !left) {
            return (walk & (WALL_WALK_UR | WALL_WALK_DR))
                 ? TS_WALL_RD : TS_WALL_V;
        }

        // Vertical through with a left branch. Most confirmed turns use LD;
        // an isolated upper-left opening uses LU. Three door-overlap patterns
        // in newest5 need the continuation just outside the 3x3 neighbourhood
        // to decide which adjacent cell owns the corner.
        if (up && down && left && !right) {
            if (!(walk & (WALL_WALK_UL | WALL_WALK_DL))) return TS_WALL_V;
            if (walk == WALL_WALK_UL) return TS_WALL_LU;
            if (walk == (WALL_WALK_U | WALL_WALK_R |
                         WALL_WALK_UL | WALL_WALK_UR)) return TS_WALL_V;
            if (walk == (WALL_WALK_U | WALL_WALK_R | WALL_WALK_UL |
                         WALL_WALK_UR | WALL_WALK_DR)) {
                return (wall_neighbour_kind(x - 2, y) & WALL_NEIGHBOUR_WALKABLE)
                     ? TS_WALL_LD : TS_WALL_V;
            }
            if (walk == (WALL_WALK_D | WALL_WALK_R |
                         WALL_WALK_DL | WALL_WALK_DR)) {
                return wall_connects(x - 2, y - 2)
                     ? TS_WALL_LD : TS_WALL_V;
            }
            return TS_WALL_LD;
        }

        // Horizontal through with an upper branch.
        if (left && right && up && !down) {
            if (!(walk & (WALL_WALK_UL | WALL_WALK_UR))) return TS_WALL_H;
            return (walk == WALL_WALK_UL) ? TS_WALL_LU : TS_WALL_RU;
        }

        // Horizontal through with a lower branch.
        if (left && right && down && !up) {
            if (!(walk & (WALL_WALK_DL | WALL_WALK_DR))) return TS_WALL_H;
            if ((walk & WALL_WALK_DL) && !(walk & WALL_WALK_DR) &&
                !(walk & WALL_WALK_L)) return TS_WALL_LD;
            return TS_WALL_RD;
        }

        // Cross: follow the confirmed walkable diagonal, preferring the lower
        // right perspective used by the authored tileset.
        if (walk & WALL_WALK_DR) return TS_WALL_RD;
        if (walk & WALL_WALK_UR) return TS_WALL_RU;
        if (walk & WALL_WALK_DL) return TS_WALL_LD;
        if (walk & WALL_WALK_UL) return TS_WALL_LU;
        return TS_WALL_RD;
    }

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
        if (marker_is_door(map_x, map_y)) {
            tile = is_door_secret(map_x, map_y)
                 ? select_wall_tile(map_x, map_y)
                 : select_door_tile(map_x, map_y);
        } else {
            tile = TS_FLOOR;
        }
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
// IN-PLACE CHARACTER SCROLL
// =============================================================================

// Generate one screen column for the target camera position. The pointer walks
// the 14-byte cache rows explicitly; OSCAR64 previously miscompiled a computed
// tile_cache[row] expression for this non-power-of-two stride.
static void prepare_scroll_column(unsigned char sub_x, unsigned char sub_y,
                                  unsigned char screen_col) {
    unsigned char cell_x = sub_x + screen_col;
    unsigned char cache_col = 0;
    while (cell_x >= TILESET_TILE_W) {
        cell_x -= TILESET_TILE_W;
        cache_col++;
    }

    unsigned char cell_y = sub_y;
    const unsigned char * cache = tile_cache[0] + cache_col;

    for (unsigned char row = 0; row < TILE_SCREEN_ROWS; row++) {
        unsigned char cell = cell_y * TILESET_TILE_W + cell_x;
        unsigned char entry = cache[0];
        scroll_chars[row] = tileset_cell_char[cell][entry];
        scroll_colors[row] = tileset_cell_color[cell][entry];

        cell_y++;
        if (cell_y == TILESET_TILE_H) {
            cell_y = 0;
            cache += TILE_CACHE_W;
        }
    }
}

// Generate one screen row for the target camera position.
static void prepare_scroll_row(unsigned char sub_x, unsigned char sub_y,
                               unsigned char screen_row) {
    unsigned char cell_y = sub_y + screen_row;
    const unsigned char * cache = tile_cache[0];
    while (cell_y >= TILESET_TILE_H) {
        cell_y -= TILESET_TILE_H;
        cache += TILE_CACHE_W;
    }

    unsigned char cell_x = sub_x;
    for (unsigned char col = 0; col < TILE_SCREEN_COLS; col++) {
        unsigned char cell = cell_y * TILESET_TILE_W + cell_x;
        unsigned char entry = cache[0];
        scroll_chars[col] = tileset_cell_char[cell][entry];
        scroll_colors[col] = tileset_cell_color[cell][entry];

        cell_x++;
        if (cell_x == TILESET_TILE_W) {
            cell_x = 0;
            cache++;
        }
    }
}

// Content moves left: the camera advances right. The copy is split above and
// below the raster beam, exactly like OSCAR64's cgrid8way reference.
static void scroll_content_left(void) {
    unsigned char * const sp = (unsigned char *)0xC800;

    __asm {
        php
        sei
    }

    vic_waitTop();
    vic_waitBottom();
    vic.ctrl2 = VIC_CTRL2_MCM | 2;
    vic_waitTop();
    vic_waitBottom();
    vic.ctrl2 = VIC_CTRL2_MCM | 0;

    vic_waitLine(50 + 8 * TILE_SCROLL_SPLIT1);

    for (unsigned char x = 0; x < TILE_SCREEN_COLS - 1; x++) {
#assign ty 0
#repeat
        sp[TILE_SCREEN_COLS * ty + x] =
            sp[TILE_SCREEN_COLS * ty + x + 1];
        tile_color[TILE_SCREEN_COLS * ty + x] =
            tile_color[TILE_SCREEN_COLS * ty + x + 1];
#assign ty ty + 1
#until ty == TILE_SCROLL_SPLIT1
    }

#assign ty 0
#repeat
    sp[TILE_SCREEN_COLS * ty + TILE_SCREEN_COLS - 1] = scroll_chars[ty];
    tile_color[TILE_SCREEN_COLS * ty + TILE_SCREEN_COLS - 1] =
        scroll_colors[ty];
#assign ty ty + 1
#until ty == TILE_SCROLL_SPLIT1

    vic_waitBottom();
    vic.ctrl2 = VIC_CTRL2_MCM | 6;

    for (unsigned char x = 0; x < TILE_SCREEN_COLS - 1; x++) {
#assign ty TILE_SCROLL_SPLIT1
#repeat
        sp[TILE_SCREEN_COLS * ty + x] =
            sp[TILE_SCREEN_COLS * ty + x + 1];
        tile_color[TILE_SCREEN_COLS * ty + x] =
            tile_color[TILE_SCREEN_COLS * ty + x + 1];
#assign ty ty + 1
#until ty == TILE_SCREEN_ROWS
    }

#assign ty TILE_SCROLL_SPLIT1
#repeat
    sp[TILE_SCREEN_COLS * ty + TILE_SCREEN_COLS - 1] = scroll_chars[ty];
    tile_color[TILE_SCREEN_COLS * ty + TILE_SCREEN_COLS - 1] =
        scroll_colors[ty];
#assign ty ty + 1
#until ty == TILE_SCREEN_ROWS

    vic_waitBottom();
    vic.ctrl2 = VIC_CTRL2_MCM | 4;

    __asm {
        plp
    }
}

// Content moves right: the camera advances left.
static void scroll_content_right(void) {
    unsigned char * const sp = (unsigned char *)0xC800;

    __asm {
        php
        sei
    }

    vic_waitTop();
    vic_waitBottom();
    vic.ctrl2 = VIC_CTRL2_MCM | 6;
    vic_waitLine(50 + 8 * TILE_SCROLL_SPLIT1);

    for (unsigned char x = TILE_SCREEN_COLS - 1; x > 0; x--) {
#assign ty 0
#repeat
        sp[TILE_SCREEN_COLS * ty + x] =
            sp[TILE_SCREEN_COLS * ty + x - 1];
        tile_color[TILE_SCREEN_COLS * ty + x] =
            tile_color[TILE_SCREEN_COLS * ty + x - 1];
#assign ty ty + 1
#until ty == TILE_SCROLL_SPLIT1
    }

#assign ty 0
#repeat
    sp[TILE_SCREEN_COLS * ty] = scroll_chars[ty];
    tile_color[TILE_SCREEN_COLS * ty] = scroll_colors[ty];
#assign ty ty + 1
#until ty == TILE_SCROLL_SPLIT1

    vic_waitBottom();
    vic.ctrl2 = VIC_CTRL2_MCM | 0;

    for (unsigned char x = TILE_SCREEN_COLS - 1; x > 0; x--) {
#assign ty TILE_SCROLL_SPLIT1
#repeat
        sp[TILE_SCREEN_COLS * ty + x] =
            sp[TILE_SCREEN_COLS * ty + x - 1];
        tile_color[TILE_SCREEN_COLS * ty + x] =
            tile_color[TILE_SCREEN_COLS * ty + x - 1];
#assign ty ty + 1
#until ty == TILE_SCREEN_ROWS
    }

#assign ty TILE_SCROLL_SPLIT1
#repeat
    sp[TILE_SCREEN_COLS * ty] = scroll_chars[ty];
    tile_color[TILE_SCREEN_COLS * ty] = scroll_colors[ty];
#assign ty ty + 1
#until ty == TILE_SCREEN_ROWS

    vic_waitBottom();
    vic.ctrl2 = VIC_CTRL2_MCM | 2;
    vic_waitTop();
    vic_waitBottom();
    vic.ctrl2 = VIC_CTRL2_MCM | 4;

    __asm {
        plp
    }
}

// Content moves up: the camera advances down.
static void scroll_content_up(void) {
    unsigned char * const sp = (unsigned char *)0xC800;

    __asm {
        php
        sei
    }

    vic_waitTop();
    vic_waitBottom();
    vic.ctrl1 = VIC_CTRL1_DEN | 2;
    vic_waitTop();
    vic_waitBottom();
    vic.ctrl1 = VIC_CTRL1_DEN | 0;
    vic_waitLine(50 + 8 * TILE_SCROLL_SPLIT1);

    for (unsigned char x = 0; x < TILE_SCREEN_COLS; x++) {
#assign ty 0
#repeat
        sp[TILE_SCREEN_COLS * ty + x] =
            sp[TILE_SCREEN_COLS * (ty + 1) + x];
        tile_color[TILE_SCREEN_COLS * ty + x] =
            tile_color[TILE_SCREEN_COLS * (ty + 1) + x];
#assign ty ty + 1
#until ty == TILE_SCROLL_SPLIT1
    }

    vic_waitBottom();
    vic.ctrl1 = VIC_CTRL1_DEN | 6;

    for (unsigned char x = 0; x < TILE_SCREEN_COLS; x++) {
#assign ty TILE_SCROLL_SPLIT1
#repeat
        sp[TILE_SCREEN_COLS * ty + x] =
            sp[TILE_SCREEN_COLS * (ty + 1) + x];
        tile_color[TILE_SCREEN_COLS * ty + x] =
            tile_color[TILE_SCREEN_COLS * (ty + 1) + x];
#assign ty ty + 1
#until ty == TILE_SCREEN_ROWS - 1
        sp[TILE_SCREEN_COLS * ty + x] = scroll_chars[x];
        tile_color[TILE_SCREEN_COLS * ty + x] = scroll_colors[x];
    }

    vic_waitBottom();
    vic.ctrl1 = VIC_CTRL1_DEN | 4;

    __asm {
        plp
    }
}

// Content moves down: the camera advances up. Copying backwards would race
// towards the beam, so two seam rows are saved and the screen is moved in three
// independent sections.
static void scroll_content_down(void) {
    unsigned char * const sp = (unsigned char *)0xC800;

    __asm {
        php
        sei
    }

    vic_waitTop();
    vic_waitBottom();

    for (unsigned char x = 0; x < TILE_SCREEN_COLS; x++) {
        scroll_tmp0[x] = sp[TILE_SCREEN_COLS * TILE_SCROLL_SPLIT1 + x];
        scroll_tmp1[x] = tile_color[TILE_SCREEN_COLS * TILE_SCROLL_SPLIT1 + x];
        scroll_tmp2[x] = sp[TILE_SCREEN_COLS * TILE_SCROLL_SPLIT2 + x];
        scroll_tmp3[x] = tile_color[TILE_SCREEN_COLS * TILE_SCROLL_SPLIT2 + x];
    }

    vic.ctrl1 = VIC_CTRL1_DEN | 6;
    vic_waitLine(58 + 8 * TILE_SCROLL_SPLIT1);

    for (unsigned char x = 0; x < TILE_SCREEN_COLS; x++) {
#assign ty TILE_SCROLL_SPLIT1
#repeat
        sp[TILE_SCREEN_COLS * ty + x] =
            sp[TILE_SCREEN_COLS * (ty - 1) + x];
        tile_color[TILE_SCREEN_COLS * ty + x] =
            tile_color[TILE_SCREEN_COLS * (ty - 1) + x];
#assign ty ty - 1
#until ty == 0
        sp[x] = scroll_chars[x];
        tile_color[x] = scroll_colors[x];
    }

    vic.ctrl1 = VIC_CTRL1_DEN | 0;

    for (unsigned char x = 0; x < TILE_SCREEN_COLS; x++) {
#assign ty TILE_SCROLL_SPLIT2
#repeat
        sp[TILE_SCREEN_COLS * ty + x] =
            sp[TILE_SCREEN_COLS * (ty - 1) + x];
        tile_color[TILE_SCREEN_COLS * ty + x] =
            tile_color[TILE_SCREEN_COLS * (ty - 1) + x];
#assign ty ty - 1
#until ty == TILE_SCROLL_SPLIT1 + 1
        sp[TILE_SCREEN_COLS * ty + x] = scroll_tmp0[x];
        tile_color[TILE_SCREEN_COLS * ty + x] = scroll_tmp1[x];
    }

    for (unsigned char x = 0; x < TILE_SCREEN_COLS; x++) {
#assign ty TILE_SCREEN_ROWS - 1
#repeat
        sp[TILE_SCREEN_COLS * ty + x] =
            sp[TILE_SCREEN_COLS * (ty - 1) + x];
        tile_color[TILE_SCREEN_COLS * ty + x] =
            tile_color[TILE_SCREEN_COLS * (ty - 1) + x];
#assign ty ty - 1
#until ty == TILE_SCROLL_SPLIT2 + 1
        sp[TILE_SCREEN_COLS * ty + x] = scroll_tmp2[x];
        tile_color[TILE_SCREEN_COLS * ty + x] = scroll_tmp3[x];
    }

    vic_waitBottom();
    vic.ctrl1 = VIC_CTRL1_DEN | 2;
    vic_waitTop();
    vic_waitBottom();
    vic.ctrl1 = VIC_CTRL1_DEN | 4;

    __asm {
        plp
    }
}

void tiles_scroll(signed char dx, signed char dy,
                  unsigned char sub_x, unsigned char sub_y) {
    if (dx > 0) {
        prepare_scroll_column(sub_x, sub_y, TILE_SCREEN_COLS - 1);
        scroll_content_left();
    } else if (dx < 0) {
        prepare_scroll_column(sub_x, sub_y, 0);
        scroll_content_right();
    } else if (dy > 0) {
        prepare_scroll_row(sub_x, sub_y, TILE_SCREEN_ROWS - 1);
        scroll_content_up();
    } else if (dy < 0) {
        prepare_scroll_row(sub_x, sub_y, 0);
        scroll_content_down();
    } else {
        return;
    }

    // Physical Color RAM now matches the in-place screen. Its ordinary-RAM
    // shadow is resynchronised only if a later full double-buffered redraw is
    // requested (for example after FIRE generates a new map).
    color_front_valid = 0;
}

// =============================================================================
// EXPAND
// =============================================================================

void tiles_expand_begin(void) {
    if (!color_front_valid) {
        memcpy(color_front, tile_color,
               TILE_SCREEN_COLS * TILE_SCREEN_ROWS);
        color_front_valid = 1;
    }
    memset(color_dirty_counts, 0, TILE_SCREEN_ROWS);
}

void tiles_expand(unsigned char sub_x, unsigned char sub_y,
                  unsigned char row_from, unsigned char row_to) {
    // Which cached tile row, and which character row inside it, the first
    // screen row comes from. Advance the source pointer explicitly instead of
    // rebuilding tile_cache[cache_row] inside the loop. This follows the
    // OSCAR64 scrolling samples and avoids a bad 14-byte row-pointer
    // calculation produced by the compiler for this hot loop.
    unsigned char cell_y = sub_y + row_from;
    const unsigned char * cache = tile_cache[0];
    while (cell_y >= TILESET_TILE_H) {
        cell_y -= TILESET_TILE_H;
        cache += TILE_CACHE_W;
    }

    for (unsigned char row = row_from; row < row_to; row++) {
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
        unsigned char * cp = color_back + offset;

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

        // Record the positions which will really need a Color RAM write. This
        // scan is distributed over the normal render slices, outside the
        // raster-critical screen flip.
        const unsigned char * fp = color_front + offset;
        unsigned char * dirty = color_dirty_cols + offset;
        unsigned char dirty_count = 0;
        for (unsigned char i = 0; i < TILE_SCREEN_COLS; i++) {
            if (cp[i] != fp[i]) {
                dirty[dirty_count++] = i;
            }
        }
        color_dirty_counts[row] = dirty_count;

        cell_y++;
        if (cell_y == TILESET_TILE_H) {
            cell_y = 0;
            cache += TILE_CACHE_W;
        }
    }
}
