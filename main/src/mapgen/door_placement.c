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

// Place a door at (x, y) (assumes caller ensures correct edge/perimeter placement)
void place_door(unsigned char x, unsigned char y) {
    set_tile_raw(x, y, TILE_DOOR);
}


// Place doors at the first and last walkable tiles of the corridor path between two rooms (on the room edge/perimeter)
void place_door_between_rooms(Room *roomA, Room *roomB, CorridorPath *path) {
    // Place door at the first walkable tile of the corridor
    unsigned char start_x = path->x[0];
    unsigned char start_y = path->y[0];
    place_door(start_x, start_y);

    // Place door at the last walkable tile of the corridor
    unsigned char end_x = path->x[path->length - 1];
    unsigned char end_y = path->y[path->length - 1];
    place_door(end_x, end_y);
}
