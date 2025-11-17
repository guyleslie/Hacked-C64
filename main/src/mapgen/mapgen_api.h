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

// Corridor tile cache queries (O(1) corridor tile access)
unsigned char mapgen_get_corridor_tile_count(unsigned char room1, unsigned char room2);
unsigned char mapgen_get_corridor_tiles(unsigned char room1, unsigned char room2,
                                        unsigned char **tiles_x, unsigned char **tiles_y);
unsigned char mapgen_get_random_corridor_tile(unsigned char room1, unsigned char room2,
                                              unsigned char *x, unsigned char *y);

#endif // MAPGEN_API_H
