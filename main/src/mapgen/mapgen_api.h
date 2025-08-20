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
unsigned char mapgen_get_start_room(void);
unsigned char mapgen_get_end_room(void);
unsigned char mapgen_get_room_center(unsigned char room_index, unsigned char *center_x, unsigned char *center_y);
unsigned int mapgen_count_tiles(unsigned char tile_type);
void mapgen_get_statistics(unsigned int *floor_tiles, unsigned int *wall_tiles, 
                          unsigned int *door_tiles, unsigned char *total_rooms);
unsigned char mapgen_find_tiles(unsigned char tile_type, unsigned char *x_positions, 
                               unsigned char *y_positions, unsigned char max_results);
unsigned char mapgen_validate_map(void);
void mapgen_clear_area(unsigned char x, unsigned char y, unsigned char w, unsigned char h);
void mapgen_fill_area(unsigned char x, unsigned char y, unsigned char w, unsigned char h, unsigned char tile);
void mapgen_get_dimensions(unsigned char *width, unsigned char *height);

#endif // MAPGEN_API_H
