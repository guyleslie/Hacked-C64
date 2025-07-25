

// Set C64 to mixed (lowercase/uppercase) character set
#define VIC_BASE 0xD000
#define VIC_MEM  (*(unsigned char *)(VIC_BASE + 0x18))

// Switches the C64 to the mixed (lowercase/uppercase) character set
void set_mixed_charset() {
    // Set bit 1 of $D018 to 1 to select mixed charset
    VIC_MEM |= 0x02;
}

// Main program for Modular Map Generator for C64 - Oscar64 compatible version

#include <conio.h>
#include <c64/kernalio.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <c64/cia.h>
#include <c64/vic.h>
#include "mapgen/mapgen_types.h"      // For Room, MAP_W, MAP_H, MAX_ROOMS
#include "mapgen/mapgen_api.h"        // For mapgen_init, mapgen_generate_dungeon, etc.
#include "mapgen/mapgen_display.h"    // For render_map_viewport, process_navigation_input
#include "oscar64_console.h"          // For oscar_clrscr
#include "mapgen/map_export.h"        // For save_compact_map (map export)



// =============================================================================
// GLOBAL VARIABLES - MAIN PROGRAM STATE
// =============================================================================

// Compact map storage: 3 bits per tile, optimized for C64 memory constraints
// 64x64 map = 4096 tiles = 1536 bytes (62.5% savings vs. 8-bit storage)
unsigned char compact_map[MAP_H * MAP_W * 3 / 8]; // 1536 bytes

// Room and dungeon structure data
Room rooms[MAX_ROOMS];
unsigned char room_count = 0;
unsigned int rng_seed = 1;

// Main function with complete dungeon generation and interactive navigation
int main(void) {
    // Switch to mixed (lowercase/uppercase) character set for C64
    set_mixed_charset();
    unsigned char key;
    
    // Initialize the map generator system
    mapgen_init();
    oscar_clrscr();
    // Generate complete level
    mapgen_generate_dungeon();
    // Refresh point of view
    render_map_viewport(1);
    
    // Interactive loop
    while (1) {
        key = getch();

        if (key == 'Q' || key == 'q') {
            oscar_clrscr();
            break;

        } else if (key == ' ') {
            oscar_clrscr();
            // Generate new level
            mapgen_generate_dungeon();
            // Refresh point of view
            render_map_viewport(1);

        } else if (key == 'M' || key == 'm') {
            // Save the current map to disk
            save_compact_map("MAPDATA.BIN");
        } else {
            // Handle movement input (WASD)
            process_navigation_input(key);
            render_map_viewport(0); // Normal "delta" update
        }
    }
    
    return 0;
}