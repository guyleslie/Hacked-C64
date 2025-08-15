// =============================================================================
// Main Module for C64 Map Generator
// Contains: main program loop, VIC-II setup, global variables, and user input handling
// =============================================================================

#include <conio.h>
#include <c64/kernalio.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <c64/cia.h>
#include <c64/vic.h>
#include "mapgen/mapgen_types.h"      // For Room, MAP_W, MAP_H, MAX_ROOMS
#include "mapgen/mapgen_api.h"        // For mapgen_generate_dungeon, etc.
#include "mapgen/mapgen_utils.h"      // For init_rng
#include "mapgen/mapgen_display.h"    // For render_map_viewport, process_navigation_input
#include "mapgen/mapgen_utils.h"      // For utility functions
#include "mapgen/map_export.h"        // For save_compact_map (map export)

// =============================================================================
// VIC-II HARDWARE CONFIGURATION
// =============================================================================

// VIC-II base address and memory control register definitions
#define VIC_BASE 0xD000
#define VIC_MEM  (*(unsigned char *)(VIC_BASE + 0x18))

/**
 * Function: set_mixed_charset
 * Purpose: Enables the C64's mixed character set (lowercase/uppercase mode)
 * Details: Sets bit 1 of VIC-II register $D018 to enable character ROM bank 1
 *          which contains both uppercase and lowercase characters
 */
void set_mixed_charset() {
    // Set bit 1 of $D018 to 1 to select mixed charset (character ROM bank 1)
    VIC_MEM |= 0x02;
}

// =============================================================================
// GLOBAL VARIABLES - MAIN PROGRAM STATE
// =============================================================================

/**
 * Variable: compact_map
 * Purpose: Compressed map data storage using 3 bits per tile
 * Size: 64x64 map = 4096 tiles × 3 bits = 12288 bits = 1536 bytes
 * Format: Packed tile IDs (0-7) stored in groups of 8 tiles per 3 bytes
 */
unsigned char compact_map[MAP_H * MAP_W * 3 / 8]; // 1536 bytes

/**
 * Variable: rooms
 * Purpose: Array storing room structure data for dungeon generation
 * Contains: Room coordinates, dimensions, connections, and type information
 */
Room rooms[MAX_ROOMS];

/**
 * Variable: room_count
 * Purpose: Tracks the current number of rooms generated in the dungeon
 * Range: 0 to MAX_ROOMS
 */
unsigned char room_count = 0;

/**
 * Variable: rng_seed
 * Purpose: Seed value for random number generation
 * Usage: Controls dungeon layout randomization and ensures reproducible results
 */
unsigned int rng_seed = 1;

// Main function with complete dungeon generation and interactive navigation
int main(void) {
    clrscr();
    // Switch to mixed (lowercase/uppercase) character set for C64
    set_mixed_charset();
    unsigned char key;
    // Initialize RNG (random number generator) for map generation
    init_rng();
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
            render_map_viewport(0); // Normal "delta" update
        }
    }
    
    return 0;
}