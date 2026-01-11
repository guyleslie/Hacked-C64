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
#include "mapgen/mapgen_api.h"        // For mapgen_generate_with_params
#include "mapgen/mapgen_config.h"     // For configuration management

#ifdef DEBUG_MAPGEN
#include "mapgen/mapgen_debug.h"      // For mapgen_run_debug_mode (DEBUG mode wrapper)
#endif

// Include C files for OSCAR64 linking
#include "mapgen/tmea_core.c"         // TMEA system (must be first)
#include "mapgen/mapgen_config.c"
#include "mapgen/mapgen_utils.c"
#include "mapgen/map_generation.c"
#include "mapgen/room_management.c"
#include "mapgen/connection_system.c"

#ifdef DEBUG_MAPGEN
#include "mapgen/mapgen_display.c"
#include "mapgen/map_export.c"
#include "mapgen/mapgen_debug.c"      // DEBUG mode implementation
#endif

// VIC-II base address and memory control register definitions
#define VIC_BASE 0xD000
#define VIC_MEM  (*(unsigned char *)(VIC_BASE + 0x18))

// Function: set_mixed_charset
// Purpose: Enables the C64's mixed character set (lowercase/uppercase mode)
void set_mixed_charset(void) {
    // Set bit 1 of $D018 to 1 to select mixed charset (character ROM bank 1)
    VIC_MEM |= 0x02;
}


// Main function - Entry point for both DEBUG and PRODUCTION modes
int main(void) {
    clrscr();

    // Switch to mixed (lowercase/uppercase) character set for C64
    set_mixed_charset();

    // Initialize TMEA system (must be called once at startup)
    init_tmea_system();

#ifdef DEBUG_MAPGEN
    // DEBUG MODE: Interactive menu + generation + preview/navigation
    // All DEBUG functionality is encapsulated in mapgen_debug.c
    mapgen_run_debug_mode();

#else
    // PRODUCTION MODE: Direct parameter generation
    unsigned char result = mapgen_generate_with_params(
        1, // MEDIUM map size (64x64)
        1, // MEDIUM room count (12-16)
        1, // MEDIUM room size (4-7)
        1, // MEDIUM secret rooms (25%)
        1, // MEDIUM false corridors (25%)
        1, // MEDIUM secret treasures (25%)
        1  // MEDIUM hidden corridors (25%)
    );

    // Map data is now in compact_map[], room_list[], TMEA pools
    // Game engine can immediately use the generated map
    // Result: 0=success, 1=invalid params, 2=generation failed
#endif

    return 0;
}
