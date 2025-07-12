#ifndef DOOR_PLACEMENT_H
#define DOOR_PLACEMENT_H

#include "mapgen_types.h"

typedef struct {
    unsigned char x[MAX_PATH_LENGTH];
    unsigned char y[MAX_PATH_LENGTH];
    unsigned char length;
} CorridorPath;

// Place a door at (x, y) if valid (Oscar64/C64)
void place_door(unsigned char x, unsigned char y);
void place_doors_along_corridor(const CorridorPath* path);

#endif // DOOR_PLACEMENT_H
