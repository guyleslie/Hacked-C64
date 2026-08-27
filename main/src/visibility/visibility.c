// =============================================================================
// Player Visibility and Exploration Memory
// =============================================================================
// One persistent bit per possible 80x80 map cell (800 bytes). Current line of
// sight is calculated from the player's position, so it needs no second map.

#include <string.h>

#include "../mapgen/mapgen_types.h"
#include "../mapgen/mapgen_config.h"
#include "../mapgen/mapgen_internal.h"
#include "../mapgen/mapgen_utils.h"
#include "../mapgen/tmea_core.h"
#include "visibility.h"

#define VISIBILITY_MEMORY_BYTES  ((MAX_MAP_SIZE * MAX_MAP_SIZE) / 8)
#define VISIBILITY_ROOM_RADIUS   5
#define VISIBILITY_CORRIDOR_RADIUS 3
#define VISIBILITY_WINDOW_SIZE   (VISIBILITY_ROOM_RADIUS * 2 + 1)
#define VISIBILITY_WINDOW_BYTES  \
    ((VISIBILITY_WINDOW_SIZE * VISIBILITY_WINDOW_SIZE + 7) / 8)

// The tile viewer no longer uses the KERNAL's default $0400 text screen after
// tiles_init(). This dedicated uninitialised section reuses 800 bytes of that
// otherwise idle RAM; visibility_reset() explicitly clears it before use.
#pragma section(visibility_memory, 0, , , bss)
#pragma region(visibility_memory, 0x0400, 0x0720, , , {visibility_memory})
#pragma bss(visibility_memory)
static unsigned char explored_cells[VISIBILITY_MEMORY_BYTES];
#pragma bss(bss)

// Transient 11x11 current LOS: 121 bits rounded to 16 bytes. Bresenham rays
// are calculated once per turn; renderer queries then become constant-time.
static unsigned char visible_cells[VISIBILITY_WINDOW_BYTES];
static unsigned char visibility_player_x;
static unsigned char visibility_player_y;
static unsigned char visibility_radius;

static unsigned int visibility_bit_index(unsigned char x, unsigned char y) {
    return (unsigned int)y * MAX_MAP_SIZE + x;
}

static unsigned char visibility_was_explored(unsigned char x,
                                             unsigned char y) {
    unsigned int bit = visibility_bit_index(x, y);
    return explored_cells[bit >> 3] & (1 << (bit & 7));
}

static void visibility_remember(unsigned char x, unsigned char y) {
    unsigned int bit = visibility_bit_index(x, y);
    explored_cells[bit >> 3] |= 1 << (bit & 7);
}

static unsigned char visibility_window_index(unsigned char x,
                                             unsigned char y) {
    unsigned char relative_x = x - visibility_player_x
                             + VISIBILITY_ROOM_RADIUS;
    unsigned char relative_y = y - visibility_player_y
                             + VISIBILITY_ROOM_RADIUS;
    return relative_y * VISIBILITY_WINDOW_SIZE + relative_x;
}

static void visibility_mark_current(unsigned char x, unsigned char y) {
    unsigned char bit = visibility_window_index(x, y);
    visible_cells[bit >> 3] |= 1 << (bit & 7);
}

static unsigned char visibility_is_current(unsigned char x, unsigned char y) {
    unsigned char bit = visibility_window_index(x, y);
    return visible_cells[bit >> 3] & (1 << (bit & 7));
}

// Walls and closed doors stop the ray after their own cell, so their surface
// remains visible. An ordinary TMEA marker overlays floor and is transparent.
static unsigned char visibility_is_opaque(unsigned char x, unsigned char y) {
    unsigned char raw;

    if (x >= current_params.map_width || y >= current_params.map_height) {
        return 1;
    }

    raw = get_compact_tile(x, y);
    if (raw == TILE_EMPTY || raw == TILE_WALL) return 1;
    if (raw == TILE_DOOR) return !is_door_open(x, y);

    if (raw == TILE_MARKER) {
        unsigned char flags;
        if (get_tile_metadata(x, y, &flags, NULL) &&
            is_meta_type(flags, TMTYPE_DOOR)) {
            return !is_door_open(x, y);
        }
    }

    return 0;
}

// Integer Bresenham line stepping, following the OSCAR64 missile sample's
// error-term pattern. The endpoint is accepted before its opacity is tested.
static unsigned char visibility_has_line(unsigned char target_x,
                                         unsigned char target_y) {
    int x = visibility_player_x;
    int y = visibility_player_y;
    int dx = (target_x > visibility_player_x)
        ? target_x - visibility_player_x
        : visibility_player_x - target_x;
    int dy = (target_y > visibility_player_y)
        ? target_y - visibility_player_y
        : visibility_player_y - target_y;
    int step_x = (visibility_player_x < target_x) ? 1 : -1;
    int step_y = (visibility_player_y < target_y) ? 1 : -1;
    int error = dx - dy;

    while (x != target_x || y != target_y) {
        int twice_error = error * 2;
        if (twice_error > -dy) {
            error -= dy;
            x += step_x;
        }
        if (twice_error < dx) {
            error += dx;
            y += step_y;
        }

        if (x == target_x && y == target_y) return 1;
        if (visibility_is_opaque((unsigned char)x, (unsigned char)y)) return 0;
    }

    return 1;
}

static unsigned char visibility_in_current_range(unsigned char map_x,
                                                 unsigned char map_y) {
    return abs_diff(map_x, visibility_player_x) <= visibility_radius &&
           abs_diff(map_y, visibility_player_y) <= visibility_radius;
}

void visibility_update(unsigned char player_x, unsigned char player_y) {
    int min_x;
    int max_x;
    int min_y;
    int max_y;

    visibility_player_x = player_x;
    visibility_player_y = player_y;
    visibility_radius = is_inside_any_room(player_x, player_y)
        ? VISIBILITY_ROOM_RADIUS : VISIBILITY_CORRIDOR_RADIUS;
    memset(visible_cells, 0, VISIBILITY_WINDOW_BYTES);

    min_x = (int)player_x - visibility_radius;
    max_x = (int)player_x + visibility_radius;
    min_y = (int)player_y - visibility_radius;
    max_y = (int)player_y + visibility_radius;

    if (min_x < 0) min_x = 0;
    if (min_y < 0) min_y = 0;
    if (max_x >= current_params.map_width) max_x = current_params.map_width - 1;
    if (max_y >= current_params.map_height) max_y = current_params.map_height - 1;

    for (int y = min_y; y <= max_y; y++) {
        for (int x = min_x; x <= max_x; x++) {
            if (visibility_has_line((unsigned char)x, (unsigned char)y)) {
                visibility_mark_current((unsigned char)x, (unsigned char)y);
                visibility_remember((unsigned char)x, (unsigned char)y);
            }
        }
    }
}

void visibility_reset(unsigned char player_x, unsigned char player_y) {
    memset(explored_cells, 0, VISIBILITY_MEMORY_BYTES);
    visibility_update(player_x, player_y);
}

unsigned char visibility_state_at(unsigned char map_x, unsigned char map_y) {
    if (map_x >= current_params.map_width || map_y >= current_params.map_height) {
        return VISIBILITY_HIDDEN;
    }

    if (visibility_in_current_range(map_x, map_y) &&
        visibility_is_current(map_x, map_y)) {
        return VISIBILITY_VISIBLE;
    }

    return visibility_was_explored(map_x, map_y)
        ? VISIBILITY_REMEMBERED : VISIBILITY_HIDDEN;
}
