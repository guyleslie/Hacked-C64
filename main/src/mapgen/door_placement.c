// Oscar64-compatible C64 door placement logic for corridors
// Implements improved, symmetric, and corner-aware door placement
#include "mapgen_types.h"
#include "mapgen_internal.h"
#include "mapgen_utility.h"

// Structure for a path of points (corridor)
typedef struct {
    unsigned char x[MAX_PATH_LENGTH];
    unsigned char y[MAX_PATH_LENGTH];
    unsigned char length;
} CorridorPath;

// Returns 1 if (x, y) is adjacent (cardinal or diagonal) to any room wall
typedef unsigned char (*adjacent_fn)(unsigned char, unsigned char);

static unsigned char is_adjacent_to_room(unsigned char x, unsigned char y) {
    for (unsigned char i = 0; i < room_count; i++) {
        Room *room = &rooms[i];
        // Check 4 cardinal directions
        if ((x > 0 && point_in_room(x-1, y, i)) ||
            (x+1 < MAP_W && point_in_room(x+1, y, i)) ||
            (y > 0 && point_in_room(x, y-1, i)) ||
            (y+1 < MAP_H && point_in_room(x, y+1, i))) {
            return 1;
        }
    }
    return 0;
}

// Returns 1 if (x, y) is adjacent diagonally to any room wall
static unsigned char is_corner(unsigned char x, unsigned char y) {
    for (unsigned char i = 0; i < room_count; i++) {
        Room *room = &rooms[i];
        if ((x > 0 && y > 0 && point_in_room(x-1, y-1, i)) ||
            (x+1 < MAP_W && y > 0 && point_in_room(x+1, y-1, i)) ||
            (x > 0 && y+1 < MAP_H && point_in_room(x-1, y+1, i)) ||
            (x+1 < MAP_W && y+1 < MAP_H && point_in_room(x+1, y+1, i))) {
            return 1;
        }
    }
    return 0;
}

// Place a door at (x, y) if valid
static void place_door(unsigned char x, unsigned char y) {
    if (is_valid_room_wall_for_door(x, y)) {
        set_tile_raw(x, y, TILE_DOOR);
    }
}

// Place doors at both ends of a corridor path, handling corners
void place_doors_along_corridor(const CorridorPath* path) {
    // Start
    unsigned char idx = 0;
    while (idx < path->length && !is_adjacent_to_room(path->x[idx], path->y[idx])) {
        idx++;
    }
    if (idx < path->length) {
        if (is_corner(path->x[idx], path->y[idx]) && idx+1 < path->length) idx++;
        place_door(path->x[idx], path->y[idx]);
    }
    // End
    idx = path->length - 1;
    while (idx < 255 && !is_adjacent_to_room(path->x[idx], path->y[idx])) {
        if (idx == 0) break;
        idx--;
    }
    if (idx < path->length) {
        if (is_corner(path->x[idx], path->y[idx]) && idx > 0) idx--;
        place_door(path->x[idx], path->y[idx]);
    }
}
