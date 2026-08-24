// =============================================================================
// Tile Map Viewer
// =============================================================================
// See tile_viewer.h and docs/tile-rendering.md.

#include <c64/vic.h>
#include <c64/cia.h>
#include <conio.h>

#include "../mapgen/mapgen_types.h"
#include "../mapgen/mapgen_internal.h"
#include "../mapgen/mapgen_config.h"
#include "../mapgen/mapgen_api.h"
#include "tile_render.h"
#include "tile_viewer.h"

extern MapParameters current_params;

// Camera position in map space, the top-left visible tile.
static unsigned char camera_x = 0;
static unsigned char camera_y = 0;

// =============================================================================
// CAMERA
// =============================================================================

// Largest origin that still fills the viewport. Maps smaller than the viewport
// clamp to zero and simply show empty tiles on the far side.
static unsigned char camera_limit(unsigned char map_size, unsigned char view_size) {
    if (map_size <= view_size) return 0;
    return map_size - view_size;
}

static void center_camera_on(unsigned char map_x, unsigned char map_y) {
    unsigned char limit_x = camera_limit(current_params.map_width, TILE_VIEW_TILES_W);
    unsigned char limit_y = camera_limit(current_params.map_height, TILE_VIEW_TILES_H);

    camera_x = (map_x > TILE_VIEW_TILES_W / 2) ? map_x - TILE_VIEW_TILES_W / 2 : 0;
    camera_y = (map_y > TILE_VIEW_TILES_H / 2) ? map_y - TILE_VIEW_TILES_H / 2 : 0;

    if (camera_x > limit_x) camera_x = limit_x;
    if (camera_y > limit_y) camera_y = limit_y;
}

static void reset_camera(void) {
    if (room_count > 0) {
        center_camera_on(room_list[0].center_x, room_list[0].center_y);
    } else {
        center_camera_on(current_params.map_width / 2,
                         current_params.map_height / 2);
    }
}

// Returns 1 when the camera actually moved, so the caller only redraws then.
static unsigned char move_camera_by(signed char dx, signed char dy) {
    unsigned char limit_x = camera_limit(current_params.map_width, TILE_VIEW_TILES_W);
    unsigned char limit_y = camera_limit(current_params.map_height, TILE_VIEW_TILES_H);
    unsigned char old_x = camera_x;
    unsigned char old_y = camera_y;

    if (dx < 0) {
        if (camera_x > 0) camera_x--;
    } else if (dx > 0) {
        if (camera_x < limit_x) camera_x++;
    }

    if (dy < 0) {
        if (camera_y > 0) camera_y--;
    } else if (dy > 0) {
        if (camera_y < limit_y) camera_y++;
    }

    return (camera_x != old_x || camera_y != old_y);
}

// =============================================================================
// INPUT
// =============================================================================

static void wait_for_fire_release(void) {
    while (!(cia1.pra & 0x10)) {}
}

// =============================================================================
// VIEWER
// =============================================================================

void tile_viewer_run(void) {
    unsigned char movement_frame = 0;

    tiles_init();
    reset_camera();
    tiles_render_viewport(camera_x, camera_y);
    wait_for_fire_release();

    while (1) {
        // Sample once per frame. Together with the toggle below this gives one
        // map step every two frames while a fresh press still reacts at once,
        // matching the PETSCII preview's feel.
        vic_waitFrame();

        char key = getchx();
        if (key == 'Q' || key == 'q') break;

        unsigned char joy2 = cia1.pra;

        // FIRE regenerates. The seed flag is reset first so each press gives a
        // different dungeon.
        if (!(joy2 & 0x10)) {
            wait_for_fire_release();
            mapgen_reset_seed_flag();
            mapgen_generate_dungeon();
            reset_camera();
            tiles_render_viewport(camera_x, camera_y);
            wait_for_fire_release();
            continue;
        }

        // Joystick 2 on CIA1 port A, active low:
        // bit 0 UP, bit 1 DOWN, bit 2 LEFT, bit 3 RIGHT, bit 4 FIRE.
        // Opposite directions cancel; a diagonal moves both axes but redraws
        // only once.
        signed char dx = 0;
        signed char dy = 0;

        if (!(joy2 & 0x01) && (joy2 & 0x02)) dy = -1;
        else if (!(joy2 & 0x02) && (joy2 & 0x01)) dy = 1;

        if (!(joy2 & 0x04) && (joy2 & 0x08)) dx = -1;
        else if (!(joy2 & 0x08) && (joy2 & 0x04)) dx = 1;

        if (dx != 0 || dy != 0) {
            if (movement_frame == 0) {
                if (move_camera_by(dx, dy)) {
                    tiles_render_viewport(camera_x, camera_y);
                }
            }
            movement_frame ^= 1;
        } else {
            // Do not delay the first step of the next press.
            movement_frame = 0;
        }
    }

    tiles_shutdown();
    clrscr();
}
