// Main Module for C64 Map Generator
// Contains: VIC-II mixed character setup, main program loop, and user input handling

// System headers
#include <conio.h>
#include <c64/kernalio.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <c64/cia.h>
#include <c64/vic.h>
// Project headers
#include "mapgen/mapgen_api.h"        // For mapgen_generate_dungeon
#include "mapgen/mapgen_display.h"    // For move_camera_direction
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


// Main function with complete dungeon generation and interactive navigation
int main(void) {
    unsigned char key;
    
    clrscr();
    
    // Switch to mixed (lowercase/uppercase) character set for C64
    set_mixed_charset();
    
    // Generate complete level (includes all necessary resets)
    mapgen_generate_dungeon();
    
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

        } else if (key == 'M' || key == 'm') {
            // Save the current map to disk
            save_compact_map("MAPDATA.BIN");
        } else {
            // Handle movement input (WASD)
            if (key == 'w' || key == 'W') {
                move_camera_direction(MOVE_UP);
            } else if (key == 's' || key == 'S') {
                move_camera_direction(MOVE_DOWN);
            } else if (key == 'a' || key == 'A') {
                move_camera_direction(MOVE_LEFT);
            } else if (key == 'd' || key == 'D') {
                move_camera_direction(MOVE_RIGHT);
            }
        }
    }
    
    return 0;
}