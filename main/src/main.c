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
#include "oscar64_console.h"   // For oscar_clrscr



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
    unsigned char key;
    
    // Initialize the map generator system
    mapgen_init();
    oscar_clrscr();
    // Generate complete level
    mapgen_generate_dungeon();
    // Save the generated map to a binary file for C64/Oscar64 using Oscar64 KERNAL routines
    krnio_setnam("MAPDATA.BIN"); // Set the filename
    // Save the compact_map array to device 8 (disk/SD2IEC)
    if (!krnio_save(8, (const char*)compact_map, (const char*)(compact_map + sizeof(compact_map)))) {
        // Print error if file could not be saved
        puts("File save error!");
    }
    // Refresh point of view
    render_map_viewport(1);
    
    // Interactive loop
    while (1) {
        key = getch();
        
        if (key == 'Q') {
            oscar_clrscr();
            break;

        } else if (key == ' ') {
            oscar_clrscr();
            // Generate new level
            mapgen_generate_dungeon();
            // Save the generated map to a binary file for C64/Oscar64 using Oscar64 KERNAL routines
            krnio_setnam("MAPDATA.BIN"); // Set the filename
            if (!krnio_save(8, (const char*)compact_map, (const char*)(compact_map + sizeof(compact_map)))) {
                // Print error if file could not be saved
                puts("File save error!");
            }
            // Refresh point of view
            render_map_viewport(1);

        } else {
            // Handle movement input (WASD)
            process_navigation_input(key);
            render_map_viewport(0); // Normal "delta" update
        }
    }
    
    return 0;
}