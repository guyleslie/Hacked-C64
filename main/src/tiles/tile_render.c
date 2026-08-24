// =============================================================================
// 3x3 Tile Renderer
// =============================================================================
// See tile_render.h and docs/tile-rendering.md.

#include "../mapgen/mapgen_types.h"
#include "../mapgen/mapgen_utils.h"
#include "../mapgen/mapgen_config.h"
#include "../mapgen/tmea_core.h"
#include "tileset_data.h"
#include "tile_render.h"

extern MapParameters current_params;

// =============================================================================
// VIC-II
// =============================================================================

// Character set base. Must be a 2 KB aligned address inside the current VIC
// bank; 0x3000 sits below the default screen at 0x0400 in bank 0.
#define TILE_CHARSET_BASE   0x3000

#define VIC_CTRL1           (*(unsigned char *)0xD011)
#define VIC_CTRL2           (*(unsigned char *)0xD016)
#define VIC_MEMORY          (*(unsigned char *)0xD018)
#define VIC_BG0             (*(unsigned char *)0xD021)
#define VIC_BG1             (*(unsigned char *)0xD022)
#define VIC_BG2             (*(unsigned char *)0xD023)

unsigned char * const tile_screen = (unsigned char *)SCREEN_MEMORY_BASE;
unsigned char * const tile_color = (unsigned char *)0xD800;
unsigned char * const tile_charset = (unsigned char *)TILE_CHARSET_BASE;

void tiles_init(void) {
    // The generated character bitmaps live in the const section; the VIC can
    // only read from its own bank, so they are copied into place once.
    unsigned int count = TILESET_CHAR_COUNT * 8;
    for (unsigned int i = 0; i < count; i++) {
        tile_charset[i] = tileset_charset[i];
    }

    // Screen at 0x0400, character set at 0x3000.
    VIC_MEMORY = ((SCREEN_MEMORY_BASE >> 6) & 0xF0) | ((TILE_CHARSET_BASE >> 10) & 0x0E);

    // Multicolour character mode.
    VIC_CTRL2 |= 0x10;

    VIC_BG0 = TILESET_COLOR_BG0;
    VIC_BG1 = TILESET_COLOR_BG1;
    VIC_BG2 = TILESET_COLOR_BG2;
}

// =============================================================================
// TILE BLIT
// =============================================================================

void tiles_draw(unsigned char tile, unsigned char variant,
                unsigned char col, unsigned char row) {
    const unsigned char *cells = tileset_tile_chars[variant][tile];
    unsigned int offset = (unsigned int)row * VIEW_W + col;

    for (unsigned char ty = 0; ty < TILESET_TILE_H; ty++) {
        for (unsigned char tx = 0; tx < TILESET_TILE_W; tx++) {
            unsigned char ch = cells[tx];
            tile_screen[offset + tx] = ch;
            tile_color[offset + tx] = tileset_char_color[ch];
        }
        cells += TILESET_TILE_W;
        offset += VIEW_W;
    }
}

// =============================================================================
// MAP CELL -> TILESET TILE
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

unsigned char tiles_select(unsigned char map_x, unsigned char map_y) {
    unsigned char tile = get_compact_tile(map_x, map_y);

    // TILE_* are const variables rather than macros, so this is an if chain
    // instead of a switch.
    if (tile == TILE_FLOOR) return TS_FLOOR;
    if (tile == TILE_WALL) return select_wall_tile(map_x, map_y);

    if (tile == TILE_DOOR) {
        // A secret door must be indistinguishable from the wall it hides in.
        if (is_door_secret(map_x, map_y)) return select_wall_tile(map_x, map_y);
        return select_door_tile(map_x, map_y);
    }

    if (tile == TILE_MARKER) {
        // TMEA metadata marker: a door when it carries door metadata,
        // otherwise the floor underneath it.
        if (is_door_secret(map_x, map_y)) return select_wall_tile(map_x, map_y);
        return TS_FLOOR;
    }

    if (tile == TILE_UP) return TS_STAIR_A;
    if (tile == TILE_DOWN) return TS_STAIR_B;
    return TS_EMPTY;
}

// =============================================================================
// FOG OF WAR
// =============================================================================

// Integration point. The visibility system does not exist yet, so everything
// is drawn lit. Returning TILE_VARIANT_FOG for an explored but currently
// unseen cell is all that is needed to darken it; the darkened characters are
// already in the character set.
unsigned char tiles_variant_at(unsigned char map_x, unsigned char map_y) {
    (void)map_x;
    (void)map_y;
    return TILE_VARIANT_LIT;
}

// =============================================================================
// VIEWPORT
// =============================================================================

void tiles_render_viewport(unsigned char origin_x, unsigned char origin_y) {
    for (unsigned char ty = 0; ty < TILE_VIEW_TILES_H; ty++) {
        unsigned char map_y = origin_y + ty;
        for (unsigned char tx = 0; tx < TILE_VIEW_TILES_W; tx++) {
            unsigned char map_x = origin_x + tx;
            unsigned char tile;
            unsigned char variant;

            if (map_x >= current_params.map_width ||
                map_y >= current_params.map_height) {
                tile = TS_EMPTY;
                variant = TILE_VARIANT_LIT;
            } else {
                tile = tiles_select(map_x, map_y);
                variant = tiles_variant_at(map_x, map_y);
            }

            tiles_draw(tile, variant, tx * TILESET_TILE_W, ty * TILESET_TILE_H);
        }
    }
}
