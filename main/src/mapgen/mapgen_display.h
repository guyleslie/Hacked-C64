#ifndef MAPGEN_DISPLAY_H
#define MAPGEN_DISPLAY_H

#include "mapgen_types.h"

// Display, camera, and input functions
void update_camera(void);
void move_camera(unsigned char new_x, unsigned char new_y);
void render_map_viewport(unsigned char force_refresh);
void update_screen_with_perfect_scroll(unsigned char scroll_dir);
void update_full_screen(void);
void process_navigation_input(unsigned char key);
void print_text(const char* text);

#endif // MAPGEN_DISPLAY_H