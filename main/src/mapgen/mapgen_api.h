#ifndef MAPGEN_API_H
#define MAPGEN_API_H

#include "mapgen_types.h"

// Initialization and configuration
void mapgen_init(unsigned int seed);

// Public API for map generation and query
unsigned char mapgen_generate_dungeon(void);
unsigned char mapgen_get_room_info(unsigned char room_index, unsigned char *x, unsigned char *y, 
                                  unsigned char *w, unsigned char *h, unsigned char *priority);
unsigned char mapgen_find_room_at_position(unsigned char x, unsigned char y);
unsigned char mapgen_get_room_center(unsigned char room_index, unsigned char *center_x, unsigned char *center_y);

#endif // MAPGEN_API_H
