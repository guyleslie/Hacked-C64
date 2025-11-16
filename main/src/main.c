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
#include "mapgen/mapgen_config.h"     // For configuration management

// Include C files for OSCAR64 linking
#include "mapgen/tmea_core.c"         // TMEA system (must be first)
#include "mapgen/mapgen_config.c"
#include "mapgen/mapgen_utils.c"
#include "mapgen/map_generation.c"
#include "mapgen/room_management.c"
#include "mapgen/connection_system.c"
#include "mapgen/mapgen_display.c"
#include "mapgen/map_export.c"

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
    MapConfig config;
    MapParameters params;

    clrscr();

    // Switch to mixed (lowercase/uppercase) character set for C64
    set_mixed_charset();

    // Initialize TMEA system (must be called once at startup)
    init_tmea_system();

    // Initialize default configuration
    init_default_config(&config);

    // Show configuration menu
    show_config_menu(&config);

    // Validate and compute parameters
    validate_and_adjust_config(&config, &params);

    // Set generation parameters
    mapgen_set_parameters(&params);

    // Clear screen before generation
    clrscr();

    // Generate complete level (includes all necessary resets)
    mapgen_generate_dungeon();

    // Interactive loop using joystick 2
    while (1) {
        // Check for keyboard commands
        key = getchx();
        if (key == 'Q' || key == 'q') {
            clrscr();
            break;
        } else if (key == 'M' || key == 'm') {
            save_compact_map("mapbin");
        }

        // Read joystick 2 from CIA1 Port A ($DC00)
        unsigned char joy2 = cia1.pra;

        // Joystick 2 bit mapping (active low):
        // Bit 0 = UP
        // Bit 1 = DOWN
        // Bit 2 = LEFT
        // Bit 3 = RIGHT
        // Bit 4 = FIRE

        // Check FIRE button for configuration menu
        if (!(joy2 & 0x10)) {
            clrscr();
            show_config_menu(&config);
            validate_and_adjust_config(&config, &params);
            mapgen_set_parameters(&params);
            clrscr();
            mapgen_generate_dungeon();
            // Wait for fire release
            while (!(cia1.pra & 0x10)) {}
        }

        // Check joystick directions (supports diagonal)
        if (!(joy2 & 0x01)) {  // UP
            move_camera_direction(MOVE_UP);
        }
        if (!(joy2 & 0x02)) {  // DOWN
            move_camera_direction(MOVE_DOWN);
        }
        if (!(joy2 & 0x04)) {  // LEFT
            move_camera_direction(MOVE_LEFT);
        }
        if (!(joy2 & 0x08)) {  // RIGHT
            move_camera_direction(MOVE_RIGHT);
        }
    }
    
    return 0;
}