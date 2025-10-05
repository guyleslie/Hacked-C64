#ifndef MAPGEN_API_H
#define MAPGEN_API_H

#include "mapgen_types.h"

// Initialization and configuration
void mapgen_init(unsigned int seed);

// Public API for map generation
unsigned char mapgen_generate_dungeon(void);

#endif // MAPGEN_API_H
