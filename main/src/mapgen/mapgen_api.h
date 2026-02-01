#ifndef MAPGEN_API_H
#define MAPGEN_API_H

#include "mapgen_types.h"
#include "mapgen_config.h"

// Initialization and seed management
void mapgen_init(unsigned int seed);           // Set explicit 16-bit seed
unsigned int mapgen_get_seed(void);            // Query current seed value
void mapgen_reset_seed_flag(void);             // Reset to random seed on next generation
void mapgen_set_parameters(const MapParameters *params);

// Public API for map generation
unsigned char mapgen_generate_dungeon(void);

// Production mode API - direct parameter generation
unsigned char mapgen_generate_with_params(
    unsigned char map_size,      // 0=SMALL, 1=MEDIUM, 2=LARGE
    unsigned char hidden_rooms,  // 0=10%, 1=25%, 2=50%
    unsigned char niches,        // 0=10%, 1=25%, 2=50%
    unsigned char deception      // 0=10%, 1=25%, 2=50%
);

// Query functions
unsigned char mapgen_get_map_size(void);

#endif // MAPGEN_API_H
