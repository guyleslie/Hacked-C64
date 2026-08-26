// =============================================================================
// Tile Map Viewer
// =============================================================================
// See tile_viewer.h and docs/tile-rendering.md.
//
// Regular movement shifts screen RAM and Color RAM in place, racing safely
// behind the raster beam. Only the newly exposed row or column is generated
// from the 3x3 tile cache; double buffering is reserved for a full map reset.

#include <c64/vic.h>
#include <c64/joystick.h>
#include <conio.h>

#include "../mapgen/mapgen_types.h"
#include "../mapgen/mapgen_internal.h"
#include "../mapgen/mapgen_config.h"
#include "../mapgen/mapgen_api.h"
#include "tile_render.h"
#include "tile_viewer.h"

extern MapParameters current_params;

// =============================================================================
// CAMERA
// =============================================================================

// The view is always aligned to a character between camera transactions.
// sub selects one of the three character columns/rows inside a map tile.
typedef struct {
    unsigned char sub;
    unsigned char tile;
    unsigned char limit_sub;
    unsigned char limit_tile;
} ScrollAxis;

static ScrollAxis axis_x;
static ScrollAxis axis_y;
static unsigned char fine_x;
static unsigned char fine_y;

// Used only to resolve a diagonal joystick position into one cardinal axis.
static signed char last_dx, last_dy;

// Set the exact last character-aligned camera position. The VIC runs in 38x24
// mode while the backing screen is 40x25, so the positive edge hides the final
// character lane. One out-of-map lane at the end moves the real map edge into
// that last lane; the two final fine-scroll phases below expose its remaining
// four VIC pixels. tiles_select() renders the extra lane as black.
static void axis_set_limit(ScrollAxis * a, unsigned char map_size,
                           unsigned char backing_chars) {
    unsigned char map_chars = map_size * TILESET_TILE_W;
    unsigned char visible_span = backing_chars - 1;
    unsigned char limit_chars = 0;

    if (map_chars > visible_span) limit_chars = map_chars - visible_span;
    a->limit_tile = limit_chars / TILESET_TILE_W;
    a->limit_sub = limit_chars % TILESET_TILE_W;
}

// Advance a character position by one character, clamped to the map. Returns 1
// when it actually moved.
static unsigned char char_step(const ScrollAxis * a, signed char dir,
                               unsigned char * tile, unsigned char * sub) {
    *tile = a->tile;
    *sub = a->sub;

    if (dir > 0) {
        if (*tile > a->limit_tile ||
            (*tile == a->limit_tile && *sub >= a->limit_sub)) return 0;
        if (*sub + 1 < TILESET_TILE_W) {
            (*sub)++;
            return 1;
        }
        *sub = 0;
        (*tile)++;
        return 1;
    }

    if (dir < 0) {
        if (*sub > 0) {
            (*sub)--;
            return 1;
        }
        if (*tile == 0) return 0;
        *sub = TILESET_TILE_W - 1;
        (*tile)--;
        return 1;
    }

    return 0;
}

// Wait for the start of the next lower-border interval. Calling waitTop first
// matters when rendering happened to finish after raster line 255: it prevents
// an immediate late flip whose Color RAM writes could run into the next frame.
static void wait_vblank_start(void) {
    vic_waitTop();
    vic_waitBottom();
}

// Apply an edge-only two-pixel phase without touching screen or Color RAM.
// Keeping both offsets here also preserves one axis when the other one moves.
static void camera_apply_fine(void) {
    wait_vblank_start();
    tiles_fine_scroll(fine_x, fine_y);
    vic_waitTop();
}

static void camera_reset(void) {
    unsigned char cx, cy;

    axis_set_limit(&axis_x, current_params.map_width, TILE_SCREEN_COLS);
    axis_set_limit(&axis_y, current_params.map_height, TILE_SCREEN_ROWS);

    if (room_count > 0) {
        cx = room_list[0].center_x;
        cy = room_list[0].center_y;
    } else {
        cx = current_params.map_width / 2;
        cy = current_params.map_height / 2;
    }

    axis_x.sub = 0;
    axis_x.tile = (cx > 6) ? cx - 6 : 0;
    if (axis_x.tile > axis_x.limit_tile) {
        axis_x.tile = axis_x.limit_tile;
        axis_x.sub = axis_x.limit_sub;
    }

    axis_y.sub = 0;
    axis_y.tile = (cy > 4) ? cy - 4 : 0;
    if (axis_y.tile > axis_y.limit_tile) {
        axis_y.tile = axis_y.limit_tile;
        axis_y.sub = axis_y.limit_sub;
    }

    tiles_cache_fill(axis_x.tile, axis_y.tile);
    fine_x = 4;
    fine_y = 4;
    tiles_fine_scroll(fine_x, fine_y);

    // Draw the same aligned position into both buffers. Only a complete hidden
    // buffer is ever made visible.
    tiles_expand_begin();
    tiles_expand(0, 0, 0, TILE_SCREEN_ROWS);
    wait_vblank_start();
    tiles_flip();
    vic_waitTop();

    tiles_expand_begin();
    tiles_expand(0, 0, 0, TILE_SCREEN_ROWS);
    wait_vblank_start();
    tiles_flip();
    vic_waitTop();

    last_dx = 0;
    last_dy = 0;
}

// Move one character in a cardinal direction. The renderer prepares just the
// entering edge and performs the four raster-timed two-pixel phases.
static unsigned char camera_step(signed char dx, signed char dy) {
    unsigned char next_tile_x = axis_x.tile;
    unsigned char next_tile_y = axis_y.tile;
    unsigned char next_sub_x = axis_x.sub;
    unsigned char next_sub_y = axis_y.sub;
    unsigned char moved = 0;

    if (dx != 0) {
        if (dx > 0) {
            // Leave the negative edge smoothly before advancing a character.
            if (fine_x > 4) {
                fine_x -= 2;
                camera_apply_fine();
                last_dx = dx;
                last_dy = 0;
                return 1;
            }

            // At the positive limit, offset 4 still leaves half of the last
            // multicolour character behind the 38-column border. Finish with
            // the same 4->2->0 phases as a regular left-moving screen scroll.
            if (axis_x.tile == axis_x.limit_tile &&
                axis_x.sub == axis_x.limit_sub && fine_x > 0) {
                fine_x -= 2;
                camera_apply_fine();
                last_dx = dx;
                last_dy = 0;
                return 1;
            }
        } else {
            // Leave the positive edge smoothly before moving back.
            if (fine_x < 4) {
                fine_x += 2;
                camera_apply_fine();
                last_dx = dx;
                last_dy = 0;
                return 1;
            }

            // CSEL still covers two pixels of the first map column at x=0.
            if (axis_x.tile == 0 && axis_x.sub == 0 && fine_x < 6) {
                fine_x += 2;
                camera_apply_fine();
                last_dx = dx;
                last_dy = 0;
                return 1;
            }
        }
        moved = char_step(&axis_x, dx, &next_tile_x, &next_sub_x);
    } else if (dy != 0) {
        if (dy > 0) {
            if (fine_y > 4) {
                fine_y -= 2;
                camera_apply_fine();
                last_dx = 0;
                last_dy = dy;
                return 1;
            }
            if (axis_y.tile == axis_y.limit_tile &&
                axis_y.sub == axis_y.limit_sub && fine_y > 0) {
                fine_y -= 2;
                camera_apply_fine();
                last_dx = 0;
                last_dy = dy;
                return 1;
            }
        } else {
            if (fine_y < 4) {
                fine_y += 2;
                camera_apply_fine();
                last_dx = 0;
                last_dy = dy;
                return 1;
            }

            // RSEL hides the first two raster rows at y=0. Offset 6 exposes
            // them without shifting screen RAM or adding a virtual map row.
            if (axis_y.tile == 0 && axis_y.sub == 0 && fine_y < 6) {
                fine_y += 2;
                camera_apply_fine();
                last_dx = 0;
                last_dy = dy;
                return 1;
            }
        }
        moved = char_step(&axis_y, dy, &next_tile_y, &next_sub_y);
    }
    if (!moved) return 0;

    tiles_cache_move_to(next_tile_x, next_tile_y);
    tiles_scroll(dx, dy, next_sub_x, next_sub_y);

    axis_x.tile = next_tile_x;
    axis_x.sub = next_sub_x;
    axis_y.tile = next_tile_y;
    axis_y.sub = next_sub_y;
    last_dx = dx;
    last_dy = dy;
    return 1;
}

// =============================================================================
// VIEWER
// =============================================================================

static void wait_for_fire_release(void) {
    do {
        joy_poll(0);
    } while (joyb[0]);
}

void tile_viewer_run(void) {
    tiles_init();
    camera_reset();
    wait_for_fire_release();

    while (1) {
        char key = getchx();
        if (key == 'Q' || key == 'q') break;

        joy_poll(0);

        if (joyb[0]) {
            wait_for_fire_release();
            mapgen_reset_seed_flag();
            mapgen_generate_dungeon();
            camera_reset();
            wait_for_fire_release();
            continue;
        }

        signed char dx = joyx[0];
        signed char dy = joyy[0];

        // Four-way camera: a diagonal keeps the most recently used axis.
        if (dx != 0 && dy != 0) {
            if (last_dx != 0) {
                dy = 0;
            } else if (last_dy != 0) {
                dx = 0;
            } else {
                dy = 0;
            }
        }

        if (!camera_step(dx, dy)) {
            camera_apply_fine();
        }
    }

    tiles_shutdown();
    clrscr();
}
