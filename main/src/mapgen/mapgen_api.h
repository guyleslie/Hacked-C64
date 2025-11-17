#ifndef MAPGEN_API_H
#define MAPGEN_API_H

#include "mapgen_types.h"
#include "mapgen_config.h"

// Initialization and configuration
void mapgen_init(unsigned int seed);
void mapgen_set_parameters(const MapParameters *params);

// Public API for map generation
unsigned char mapgen_generate_dungeon(void);

// Query functions
unsigned char mapgen_get_map_size(void);

#endif // MAPGEN_API_H
