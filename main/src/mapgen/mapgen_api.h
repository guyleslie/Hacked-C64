#ifndef MAPGEN_API_H
#define MAPGEN_API_H

#include "mapgen_types.h"
#include "mapgen_config.h"

// Initialization and configuration
void mapgen_init(unsigned int seed);
void mapgen_set_parameters(const MapParameters *params);

// Public API for map generation
unsigned char mapgen_generate_dungeon(void);

// Production mode API - direct parameter generation
unsigned char mapgen_generate_with_params(
    unsigned char map_size,        // 0=SMALL(48x48), 1=MEDIUM(64x64), 2=LARGE(80x80)
    unsigned char room_count,      // 0=SMALL(8-12), 1=MEDIUM(12-16), 2=LARGE(16-20)
    unsigned char room_size,       // Currently unused (fixed 4-8), reserved for future
    unsigned char secret_rooms,    // 0=10%, 1=25%, 2=50%
    unsigned char false_corridors, // 0=10%, 1=25%, 2=50%
    unsigned char secret_treasures,// 0=10%, 1=25%, 2=50%
    unsigned char hidden_corridors // 0=10%, 1=25%, 2=50%
);

// Query functions
unsigned char mapgen_get_map_size(void);

#endif // MAPGEN_API_H
