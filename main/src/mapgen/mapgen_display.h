#ifndef MAPGEN_DISPLAY_H
#define MAPGEN_DISPLAY_H

#include "mapgen_types.h"

// Camera movement directions
#define MOVE_UP    1
#define MOVE_DOWN  2
#define MOVE_LEFT  3
#define MOVE_RIGHT 4

// Display, camera, and input functions
void initialize_camera(void);
void update_camera(void);
void move_camera(unsigned char new_x, unsigned char new_y);
void move_camera_direction(unsigned char direction);
void render_map_viewport(unsigned char force_refresh);
void update_screen_with_scroll(unsigned char scroll_dir);
void update_full_screen(void);

#endif // MAPGEN_DISPLAY_H