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
#include "../mapgen/mapgen_utils.h"
#include "../mapgen/tmea_core.h"
#include "../sprites/actor_sprites.h"
#include "../visibility/visibility.h"
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
static TileViewOrigin view_origin;

// Logical player position plus a temporary world-pixel position used only
// during the three-stage visual transition.
static unsigned char player_x;
static unsigned char player_y;
static unsigned char player_facing;
static int player_world_x;
static int player_world_y;
static unsigned char player_transition_active;

// A hardware sprite is 24x21 pixels, so its only artwork-specific adjustment
// inside a 24x24 world tile is the two-pixel vertical centering anchor.
#define PLAYER_TILE_OFFSET_Y    2

// The camera aims to keep the top-left of the player's 24x24 world tile at
// this screen position. The sprite itself is centred inside that tile below.
#define PLAYER_HOME_SCREEN_X  172
#define PLAYER_HOME_SCREEN_Y  147

static const signed char entrance_dx[8] = {
    -1,  0,  1, -1,  1, -1,  0,  1
};
static const signed char entrance_dy[8] = {
    -1, -1, -1,  0,  0,  1,  1,  1
};

// Used only to resolve a diagonal joystick position into one cardinal axis.
static signed char last_dx, last_dy;

// add_stairs() places each stair at a room center, so locating TILE_UP costs at
// most 20 tile reads instead of a complete map scan.
static void player_place_near_up_stairs(void) {
    unsigned char up_x;
    unsigned char up_y;
    unsigned char found = 0;
    unsigned char candidates = 0;

    if (room_count > 0) {
        up_x = room_list[0].center_x;
        up_y = room_list[0].center_y;
    } else {
        up_x = current_params.map_width / 2;
        up_y = current_params.map_height / 2;
    }

    for (unsigned char i = 0; i < room_count; i++) {
        unsigned char x = room_list[i].center_x;
        unsigned char y = room_list[i].center_y;
        if (get_compact_tile(x, y) == TILE_UP) {
            up_x = x;
            up_y = y;
            found = 1;
            break;
        }
    }

    player_x = up_x;
    player_y = up_y;

    if (found) {
        // Reservoir selection gives every walkable neighbour equal probability
        // without a candidate array or a second pass.
        for (unsigned char i = 0; i < 8; i++) {
            int nx = (int)up_x + entrance_dx[i];
            int ny = (int)up_y + entrance_dy[i];

            if (nx < 0 || ny < 0 ||
                nx >= current_params.map_width ||
                ny >= current_params.map_height) continue;

            if (get_compact_tile((unsigned char)nx,
                                 (unsigned char)ny) != TILE_FLOOR) continue;

            candidates++;
            if (rnd(candidates) == 0) {
                player_x = (unsigned char)nx;
                player_y = (unsigned char)ny;
            }
        }
    }

    player_facing = (player_x > up_x)
        ? ACTOR_FACING_LEFT : ACTOR_FACING_RIGHT;
}

static void player_sprite_sync(void) {
    int screen_x;
    int screen_y;

    tiles_project_world(&view_origin, player_world_x, player_world_y,
                        &screen_x, &screen_y);

    actor_sprite_move(ACTOR_SPRITE_SLOT_PLAYER, screen_x,
                      screen_y + PLAYER_TILE_OFFSET_Y);
}

static void camera_rebuild_view_origin(void) {
    tiles_view_origin_set(&view_origin,
                          axis_x.tile, axis_x.sub,
                          axis_y.tile, axis_y.sub,
                          fine_x, fine_y);
}

// tiles_scroll() owns the four raster-timed intermediate states. This observer
// advances the same world-pixel camera origin and moves every active actor by
// the inverse screen delta, keeping all visual layers on one transform.
static void camera_scroll_phase(signed char camera_dx,
                                signed char camera_dy) {
    tiles_view_origin_move(&view_origin, camera_dx, camera_dy);

    // During a player action the actor advances through world space by the
    // same amount as the following camera. Their screen deltas cancel, so the
    // player remains stable while the map scrolls underneath it.
    if (player_transition_active) {
        actor_sprites_shift_except(-camera_dx, -camera_dy,
                                   ACTOR_SPRITE_SLOT_PLAYER);
        player_world_x += camera_dx;
        player_world_y += camera_dy;
    } else {
        actor_sprites_shift(-camera_dx, -camera_dy);
    }
}

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
    int old_world_x = view_origin.world_x;
    int old_world_y = view_origin.world_y;
    signed char camera_dx;
    signed char camera_dy;

    wait_vblank_start();
    tiles_fine_scroll(fine_x, fine_y);
    camera_rebuild_view_origin();

    camera_dx = (signed char)(view_origin.world_x - old_world_x);
    camera_dy = (signed char)(view_origin.world_y - old_world_y);
    if (player_transition_active) {
        actor_sprites_shift_except(-camera_dx, -camera_dy,
                                   ACTOR_SPRITE_SLOT_PLAYER);
        player_world_x += camera_dx;
        player_world_y += camera_dy;
    } else {
        actor_sprites_shift(-camera_dx, -camera_dy);
        player_sprite_sync();
    }
    vic_waitTop();
}

static int camera_min_x(void) {
    return -6;
}

static int camera_min_y(void) {
    return -3;
}

static int camera_max_x(void) {
    return ((int)axis_x.limit_tile * TILESET_TILE_W + axis_x.limit_sub) * 8;
}

static int camera_max_y(void) {
    return ((int)axis_y.limit_tile * TILESET_TILE_H + axis_y.limit_sub) * 8 + 3;
}

static int camera_target_x(unsigned char tile_x) {
    int target = (int)tile_x * TILE_WORLD_PIXELS
               - (PLAYER_HOME_SCREEN_X - 24);

    if (target < camera_min_x()) return camera_min_x();
    if (target > camera_max_x()) return camera_max_x();
    return target;
}

static int camera_target_y(unsigned char tile_y) {
    int target = (int)tile_y * TILE_WORLD_PIXELS
               - (PLAYER_HOME_SCREEN_Y - 50);

    if (target < camera_min_y()) return camera_min_y();
    if (target > camera_max_y()) return camera_max_y();
    return target;
}

static void camera_reset(void) {
    unsigned char cx, cy;

    axis_set_limit(&axis_x, current_params.map_width, TILE_SCREEN_COLS);
    axis_set_limit(&axis_y, current_params.map_height, TILE_SCREEN_ROWS);

    player_place_near_up_stairs();
    cx = player_x;
    cy = player_y;
    visibility_reset(player_x, player_y);

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

    fine_x = 4;
    fine_y = 4;

    // Exact clamped endpoints. At the negative edge a fine offset of 6
    // exposes the first pixels hidden by 38x24 mode; at the positive edge 0
    // exposes the last pixels. Everywhere else the centred value uses 4.
    if (camera_target_x(cx) == camera_min_x()) {
        axis_x.tile = 0;
        axis_x.sub = 0;
        fine_x = 6;
    } else if (camera_target_x(cx) == camera_max_x()) {
        axis_x.tile = axis_x.limit_tile;
        axis_x.sub = axis_x.limit_sub;
        fine_x = 0;
    }
    if (camera_target_y(cy) == camera_min_y()) {
        axis_y.tile = 0;
        axis_y.sub = 0;
        fine_y = 6;
    } else if (camera_target_y(cy) == camera_max_y()) {
        axis_y.tile = axis_y.limit_tile;
        axis_y.sub = axis_y.limit_sub;
        fine_y = 0;
    }

    tiles_cache_fill(axis_x.tile, axis_y.tile);
    tiles_fine_scroll(fine_x, fine_y);
    camera_rebuild_view_origin();
    player_world_x = (int)player_x * TILE_WORLD_PIXELS;
    player_world_y = (int)player_y * TILE_WORLD_PIXELS;
    player_transition_active = 0;
    actor_sprite_set(ACTOR_SPRITE_SLOT_PLAYER, ACTOR_APPEAR_HERO,
                     player_facing);

    // Draw the same aligned position into both buffers. Only a complete hidden
    // buffer is ever made visible.
    tiles_expand_begin();
    tiles_expand(0, 0, 0, TILE_SCREEN_ROWS);
    wait_vblank_start();
    tiles_flip();
    player_sprite_sync();
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
    camera_rebuild_view_origin();
    player_sprite_sync();
    return 1;
}

// A metadata marker normally overlays floor. Door markers are only passable
// once their door is open; ordinary TILE_DOOR cells have the same rule.
static unsigned char player_can_enter(unsigned char x, unsigned char y) {
    unsigned char raw;

    if (x >= current_params.map_width || y >= current_params.map_height) {
        return 0;
    }

    raw = get_compact_tile(x, y);
    if (raw == TILE_FLOOR || raw == TILE_UP || raw == TILE_DOWN) return 1;
    if (raw == TILE_DOOR) return is_door_open(x, y);

    if (raw == TILE_MARKER) {
        unsigned char flags;
        if (get_tile_metadata(x, y, &flags, NULL) &&
            is_meta_type(flags, TMTYPE_DOOR)) {
            return is_door_open(x, y);
        }
        return 1;
    }

    return 0;
}

static void player_visual_residual(signed char dx, signed char dy) {
    if (dx == 0 && dy == 0) return;

    wait_vblank_start();
    player_world_x += dx;
    player_world_y += dy;
    player_sprite_sync();
    vic_waitTop();
}

// One gameplay action crosses exactly one 3x3-character map tile. The visual
// move is split into the tile's three natural eight-pixel character stages.
// A following camera consumes a stage; at a clamped edge the player consumes
// the pixels that the camera cannot, so both paths use the same transition.
static unsigned char player_step(signed char dx, signed char dy) {
    unsigned char target_x;
    unsigned char target_y;
    int target_camera;

    if (dx == 0 && dy == 0) return 0;

    target_x = (unsigned char)((int)player_x + dx);
    target_y = (unsigned char)((int)player_y + dy);
    if (!player_can_enter(target_x, target_y)) return 0;

    if (dx < 0) player_facing = ACTOR_FACING_LEFT;
    if (dx > 0) player_facing = ACTOR_FACING_RIGHT;
    actor_sprite_set(ACTOR_SPRITE_SLOT_PLAYER, ACTOR_APPEAR_HERO,
                     player_facing);

    target_camera = (dx != 0)
        ? camera_target_x(target_x) : camera_target_y(target_y);
    visibility_update(target_x, target_y);
    player_transition_active = 1;

    for (unsigned char stage = 0; stage < TILESET_TILE_W; stage++) {
        int old_camera = (dx != 0)
            ? view_origin.world_x : view_origin.world_y;
        signed char camera_pixels = 0;
        signed char residual_x = dx * 8;
        signed char residual_y = dy * 8;

        if ((dx > 0 && old_camera < target_camera) ||
            (dx < 0 && old_camera > target_camera) ||
            (dy > 0 && old_camera < target_camera) ||
            (dy < 0 && old_camera > target_camera)) {
            camera_step(dx, dy);
            camera_pixels = (signed char)(((dx != 0)
                ? view_origin.world_x : view_origin.world_y) - old_camera);
        }

        if (dx != 0) residual_x -= camera_pixels;
        else residual_y -= camera_pixels;
        player_visual_residual(residual_x, residual_y);
    }

    player_transition_active = 0;
    player_x = target_x;
    player_y = target_y;
    player_world_x = (int)player_x * TILE_WORLD_PIXELS;
    player_world_y = (int)player_y * TILE_WORLD_PIXELS;
    player_sprite_sync();

    if (tiles_refresh_visibility_prepare()) {
        unsigned char more;
        do {
            wait_vblank_start();
            more = tiles_refresh_visibility_draw(axis_x.sub, axis_y.sub);
            vic_waitTop();
        } while (more);
    }
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
    actor_sprites_init();
    tiles_set_scroll_phase_hook(camera_scroll_phase);
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

        // Four-way movement: a diagonal keeps the most recently used axis.
        if (dx != 0 && dy != 0) {
            if (last_dx != 0) {
                dy = 0;
            } else if (last_dy != 0) {
                dx = 0;
            } else {
                dy = 0;
            }
        }

        player_step(dx, dy);
    }

    tiles_set_scroll_phase_hook(NULL);
    actor_sprites_shutdown();
    tiles_shutdown();
    clrscr();
}
