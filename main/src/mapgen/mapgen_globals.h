#ifndef MAPGEN_GLOBALS_H
#define MAPGEN_GLOBALS_H

#include "mapgen_types.h"

// Global variable declarations (defined in main.c)
extern unsigned char compact_map[MAP_H * MAP_W * 3 / 8];
extern Room rooms[MAX_ROOMS];
extern unsigned char room_count;
extern unsigned int rng_seed;

#endif // MAPGEN_GLOBALS_H
