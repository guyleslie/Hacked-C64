// =============================================================================
// Main Application Entry Point
// Handles program initialization, user input processing, and dungeon generation coordination
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
#include "mapgen/mapgen_utils.h"      // For init_rng and utility functions
#include "mapgen/mapgen_display.h"    // For render_map_viewport, process_navigation_input
#include "mapgen/map_export.h"        // For save_compact_map (map export)

// =============================================================================
// VIC-II HARDWARE CONFIGURATION
// =============================================================================

// VIC-II base address and memory control register definitions
#define VIC_BASE 0xD000
#define VIC_MEM  (*(unsigned char *)(VIC_BASE + 0x18))

/**
 * Function: set_mixed_charset
 * Purpose: Configures VIC-II to display both uppercase and lowercase characters
 * Implementation: Sets bit 1 of VIC-II register $D018 to select character ROM bank 1
 */
void set_mixed_charset() {
    // Configure VIC-II memory control register to use character ROM bank 1
    VIC_MEM |= 0x02;
}

// =============================================================================
// GLOBAL VARIABLES - MAIN PROGRAM STATE
// =============================================================================

/**
 * Variable: compact_map
 * Purpose: Stores compressed map data using bit-packed tile encoding
 * Storage: 64x64 map = 4096 tiles, 3 bits per tile = 1536 bytes total
 * Encoding: Groups of 8 tiles packed into 3 bytes
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
    // Configure VIC-II for mixed character display mode
    set_mixed_charset();
    unsigned char key; 
    // Initialize random number generator
    init_rng();
    // Generate initial dungeon layout
    mapgen_generate_dungeon();
    // Display initial viewport
    render_map_viewport(1);
    
    // Interactive loop
    while (1) {
        key = getch();

        if (key == 'Q' || key == 'q') {
            clrscr();
            break;

        } else if (key == ' ') {
            clrscr();
            // Generate new dungeon layout
            mapgen_generate_dungeon();
            // Update display with new map
            render_map_viewport(1);

        } else if (key == 'M' || key == 'm') {
            // Export current map to disk file
            save_compact_map("MAPDATA.BIN");
        } else {
            // Process directional movement (WASD keys)
            process_navigation_input(key);
            render_map_viewport(0); // Incremental display update
        }
    }
    
    return 0;
}