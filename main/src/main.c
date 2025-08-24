// Main Module for C64 Map Generator
// Contains: main program loop, VIC-II setup, global variables, and user input handling

// System headers
#include <conio.h>
#include <c64/kernalio.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <c64/cia.h>
#include <c64/vic.h>
// Project headers
#include "mapgen/mapgen_types.h"      // For Room, MAP_W, MAP_H, MAX_ROOMS
#include "mapgen/mapgen_api.h"        // For mapgen_generate_dungeon, etc.
#include "mapgen/mapgen_utils.h"      // For init_rng
#include "mapgen/mapgen_display.h"    // For render_map_viewport, process_navigation_input
#include "mapgen/map_export.h"        // For save_compact_map

// VIC-II base address and memory control register definitions
#define VIC_BASE 0xD000
#define VIC_MEM  (*(unsigned char *)(VIC_BASE + 0x18))

// Function: set_mixed_charset
// Purpose: Enables the C64's mixed character set (lowercase/uppercase mode)
void set_mixed_charset(void) {
    // Set bit 1 of $D018 to 1 to select mixed charset (character ROM bank 1)
    VIC_MEM |= 0x02;
}

// Global variables - Map data

// Global variables - Camera and viewport

// Camera position in map space
unsigned char camera_center_x = 32;
unsigned char camera_center_y = 32;

// Current viewport position (top-left corner)
Viewport view = {0, 0};

// Global variables - Display

// Cache of previous screen contents for delta updates
unsigned char screen_buffer[VIEW_H][VIEW_W];

// Flag indicating screen needs refresh
unsigned char screen_dirty = 1;

// Tracks last scroll direction for optimization
// Values: 0=none, 1=up, 2=down, 3=left, 4=right
unsigned char last_scroll_direction = 0;

// Main function with complete dungeon generation and interactive navigation
int main(void) {
    unsigned char key;
    
    clrscr();
    
    // Switch to mixed (lowercase/uppercase) character set for C64
    set_mixed_charset();
    
    // Initialize RNG (random number generator) for map generation
    init_rng();
    
    // Initialize map generation system with seed
    mapgen_init(1);
    
    // Generate complete level (includes all necessary resets)
    mapgen_generate_dungeon();
    
    // Refresh point of view
    render_map_viewport(1);
    
    // Interactive loop
    while (1) {
        key = getch();

        if (key == 'Q' || key == 'q') {
            clrscr();
            break;

        } else if (key == ' ') {
            clrscr();
            // Generate new level (includes all necessary resets)
            mapgen_generate_dungeon();
            // Refresh point of view
            render_map_viewport(1);

        } else if (key == 'M' || key == 'm') {
            // Save the current map to disk
            save_compact_map("MAPDATA.BIN");
        } else {
            // Handle movement input (WASD)
            process_navigation_input(key);
            render_map_viewport(0); // Normal update
        }
    }
    
    return 0;
}