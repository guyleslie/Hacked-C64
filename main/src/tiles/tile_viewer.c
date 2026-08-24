// =============================================================================
// Tile Map Viewer
// =============================================================================
// See tile_viewer.h and docs/tile-rendering.md.
//
// The camera moves a pixel at a time. Seven of every eight pixels cost nothing
// but a VIC register write; the eighth crosses a character boundary, and by
// then the back buffer already holds that position because it has been expanded
// a few rows per frame in the meantime.

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

// Pixels per frame. The fine scroll makes every one of them a real step, so
// this is the scroll speed rather than a step size. At two pixels a character
// boundary arrives every fourth frame, which leaves the back buffer three
// frames of expanding plus the frame of the flip.
#define SCROLL_SPEED    2

// =============================================================================
// CAMERA
// =============================================================================

// One scrolling axis, split the way the hardware wants it: a pixel offset the
// VIC applies for free, a character offset inside the tile, and the tile.
typedef struct {
    unsigned char fine;     // 0-7, goes straight into the VIC
    unsigned char sub;      // 0-2, character column or row inside the tile
    unsigned char tile;     // map coordinate of the first visible tile
    unsigned char limit;    // largest tile value that still fills the view
} ScrollAxis;

static ScrollAxis axis_x;
static ScrollAxis axis_y;

// The character position the back buffer is being built for, and how much of
// it is done. Tracked separately from the axes because it runs one character
// ahead of what is on screen.
static unsigned char target_sub_x, target_sub_y;
static unsigned char target_tile_x, target_tile_y;
static unsigned char built_rows;

// Direction the current target was derived from, so a change of direction can
// be noticed and the target rebuilt.
static signed char target_dx, target_dy;

// Pixels advanced inside the current character, counted along the direction of
// travel and shared by both axes. Sharing it is what keeps a diagonal from
// letting one axis reach the character boundary before the other, which would
// make the flip advance an axis that was not ready. A direction change resets
// it, so the axes are always in step while a direction is held.
static unsigned char phase;

// Largest first-visible tile that still fills the screen.
static unsigned char axis_limit(unsigned char map_size, unsigned char chars) {
    unsigned char tiles = (chars + TILESET_TILE_W - 1) / TILESET_TILE_W;
    if (map_size <= tiles) return 0;
    return map_size - tiles;
}

// Advance a character position by one character, clamped to the map. Returns 1
// when it actually moved.
static unsigned char char_step(const ScrollAxis * a, signed char dir,
                               unsigned char * tile, unsigned char * sub) {
    *tile = a->tile;
    *sub = a->sub;

    if (dir > 0) {
        if (*sub + 1 < TILESET_TILE_W) {
            (*sub)++;
            return 1;
        }
        if (*tile >= a->limit) return 0;
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

// The VIC offset for an axis. The register counts pixels the camera has
// advanced, so a leftward or upward axis runs the phase backwards.
static unsigned char axis_offset(signed char dir, unsigned char stored) {
    if (dir > 0) return phase;
    if (dir < 0) return 7 - phase;
    return stored;
}

// Point the tile cache and the expansion at a new target character position.
static void target_set(signed char dx, signed char dy) {
    target_dx = dx;
    target_dy = dy;
    phase = 0;

    if (!char_step(&axis_x, dx, &target_tile_x, &target_sub_x)) {
        target_tile_x = axis_x.tile;
        target_sub_x = axis_x.sub;
        target_dx = 0;
    }
    if (!char_step(&axis_y, dy, &target_tile_y, &target_sub_y)) {
        target_tile_y = axis_y.tile;
        target_sub_y = axis_y.sub;
        target_dy = 0;
    }

    // Nothing on screen depends on the cache, only the expansion does, so
    // moving it to the target early is free. Addressing it absolutely means a
    // second direction change before the flip does not shift it twice.
    tiles_cache_move_to(target_tile_x, target_tile_y);
    built_rows = 0;
}

static void build_slice(unsigned char rows) {
    unsigned char to = built_rows + rows;
    if (to > TILE_SCREEN_ROWS) to = TILE_SCREEN_ROWS;
    if (built_rows < to) {
        tiles_expand(target_sub_x, target_sub_y, built_rows, to);
        built_rows = to;
    }
}

static void camera_reset(void) {
    unsigned char cx, cy;

    axis_x.limit = axis_limit(current_params.map_width, TILE_SCREEN_COLS);
    axis_y.limit = axis_limit(current_params.map_height, TILE_SCREEN_ROWS);

    if (room_count > 0) {
        cx = room_list[0].center_x;
        cy = room_list[0].center_y;
    } else {
        cx = current_params.map_width / 2;
        cy = current_params.map_height / 2;
    }

    axis_x.fine = 0;
    axis_x.sub = 0;
    axis_x.tile = (cx > 6) ? cx - 6 : 0;
    if (axis_x.tile > axis_x.limit) axis_x.tile = axis_x.limit;

    axis_y.fine = 0;
    axis_y.sub = 0;
    axis_y.tile = (cy > 4) ? cy - 4 : 0;
    if (axis_y.tile > axis_y.limit) axis_y.tile = axis_y.limit;

    tiles_cache_fill(axis_x.tile, axis_y.tile);
    tiles_fine_scroll(0, 0);

    // Draw the same picture into both buffers so the first flip has something
    // sensible to show.
    tiles_expand(0, 0, 0, TILE_SCREEN_ROWS);
    vic_waitBottom();
    tiles_flip();
    tiles_expand(0, 0, 0, TILE_SCREEN_ROWS);

    target_dx = 0;
    target_dy = 0;
    target_tile_x = axis_x.tile;
    target_tile_y = axis_y.tile;
    target_sub_x = 0;
    target_sub_y = 0;
    built_rows = TILE_SCREEN_ROWS;
    phase = 0;
}

// Move the displayed position onto the target and reset the fine offsets to
// the far side of the character we just left.
static void adopt_target(signed char dx, signed char dy) {
    if (dx != 0) {
        axis_x.tile = target_tile_x;
        axis_x.sub = target_sub_x;
        axis_x.fine = (dx > 0) ? 0 : 7;
    }
    if (dy != 0) {
        axis_y.tile = target_tile_y;
        axis_y.sub = target_sub_y;
        axis_y.fine = (dy > 0) ? 0 : 7;
    }
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

        // A new direction invalidates whatever the back buffer was being built
        // for, so it restarts from the top.
        if (dx != target_dx || dy != target_dy) {
            target_set(dx, dy);
        }

        if (dx != 0 || dy != 0) {
            build_slice(TILE_EXPAND_SLICE);
        }

        // Advance the shared phase. Both axes reach the character boundary at
        // the same moment, so one test covers the diagonal case too.
        unsigned char crossed = 0;
        if (target_dx != 0 || target_dy != 0) {
            phase += SCROLL_SPEED;
            if (phase >= 8) {
                phase = 0;
                crossed = 1;
            }
        }

        if (!crossed) {
            if (target_dx != 0) axis_x.fine = axis_offset(target_dx, axis_x.fine);
            if (target_dy != 0) axis_y.fine = axis_offset(target_dy, axis_y.fine);
        }

        vic_waitBottom();

        if (crossed) {
            // Finish anything the slices did not get to, then show it. Both
            // happen in the vertical blank.
            build_slice(TILE_SCREEN_ROWS);
            tiles_flip();
            adopt_target(target_dx, target_dy);
            tiles_fine_scroll(axis_x.fine, axis_y.fine);
            target_set(dx, dy);   // also clears the phase
        } else {
            tiles_fine_scroll(axis_x.fine, axis_y.fine);
            vic_waitTop();
        }
    }

    tiles_shutdown();
    clrscr();
}
