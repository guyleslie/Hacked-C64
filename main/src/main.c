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

// Include C files for OSCAR64 linking
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
    
    clrscr();
    
    // Switch to mixed (lowercase/uppercase) character set for C64
    set_mixed_charset();
    
    // Generate complete level (includes all necessary resets)
    mapgen_generate_dungeon();
    
    // Interactive loop with continuous input using CIA keyboard matrix
    while (1) {
        // Check for non-movement keys using standard input
        if (kbhit()) {
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
            }
        }
        
        // Continuous movement using CIA keyboard matrix direct access
        // Save current CIA state
        unsigned char old_porta = cia1.pra;
        
        // Scan row 1 (contains W, A, S keys) - set row 1 to 0, others to 1
        cia1.pra = 0xFD; // 11111101 - scan row 1
        
        // Read column states from port B
        unsigned char row1_keys = cia1.prb;
        
        // Check W key (row 1, column 1) - bit 1
        if (!(row1_keys & 0x02)) {
            move_camera_direction(MOVE_UP);
        }
        // Check A key (row 1, column 2) - bit 2  
        if (!(row1_keys & 0x04)) {
            move_camera_direction(MOVE_LEFT);
        }
        // Check S key (row 1, column 5) - bit 5
        if (!(row1_keys & 0x20)) {
            move_camera_direction(MOVE_DOWN);
        }
        
        // Scan row 2 (contains D key) - set row 2 to 0, others to 1
        cia1.pra = 0xFB; // 11111011 - scan row 2
        
        unsigned char row2_keys = cia1.prb;
        
        // Check D key (row 2, column 2) - bit 2
        if (!(row2_keys & 0x04)) {
            move_camera_direction(MOVE_RIGHT);
        }
        
        // Restore CIA port A
        cia1.pra = old_porta;
        
        // Small delay for smooth scrolling - prevents too fast movement
        for (unsigned char i = 0; i < 100; i++) {
            // Timing loop - adjust for desired scroll speed
        }
    }
    
    return 0;
}