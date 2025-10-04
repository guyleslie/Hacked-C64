#ifndef MAPGEN_DISPLAY_H
#define MAPGEN_DISPLAY_H

#include "mapgen_types.h"

// Camera movement directions
const unsigned char MOVE_UP = 1;
const unsigned char MOVE_DOWN = 2;
const unsigned char MOVE_LEFT = 3;
const unsigned char MOVE_RIGHT = 4;

// Display, camera, and input functions
void initialize_camera(void);
void update_camera(void);
void move_camera_direction(unsigned char direction);
void render_map_viewport(unsigned char force_refresh);
void update_partial_screen(unsigned char scroll_dir);
void update_full_screen(void);

#endif // MAPGEN_DISPLAY_H