// =============================================================================
// Main Module for C64 Map Generator
// =============================================================================
// DEBUG mode: Interactive menu, generation preview, map navigation
// RELEASE mode: Pure API - generates map data for other modules to use

// Project headers (API and configuration)
#include "mapgen/mapgen_api.h"
#include "mapgen/mapgen_config.h"

#ifdef DEBUG_MAPGEN
// DEBUG mode additional headers
#include <conio.h>
#include <c64/cia.h>
#include "mapgen/mapgen_debug.h"
#endif

// =============================================================================
// OSCAR64 Module Includes (single-file compilation model)
// =============================================================================

// Core modules - included in both DEBUG and RELEASE
#include "mapgen/tmea_core.c"         // TMEA metadata system (must be first)
#include "mapgen/mapgen_config.c"     // Configuration and parameter management
#include "mapgen/mapgen_utils.c"      // Utility functions and tile operations
#include "mapgen/map_generation.c"    // Generation pipeline controller
#include "mapgen/room_management.c"   // Room placement algorithms
#include "mapgen/connection_system.c" // Corridor and feature generation

#ifdef DEBUG_MAPGEN
// DEBUG mode modules - display, export, progress bar, interactive menu
#include "mapgen/mapgen_progress.c"   // Progress bar system
#include "mapgen/mapgen_display.c"    // Viewport rendering
#include "mapgen/map_export.c"        // File I/O
#include "mapgen/mapgen_debug.c"      // Interactive debug mode
#endif

// =============================================================================
// DEBUG Mode Support Functions
// =============================================================================

#ifdef DEBUG_MAPGEN
#define VIC_MEM  (*(unsigned char *)(0xD018))

static void set_mixed_charset(void) {
    VIC_MEM |= 0x02;  // Enable lowercase/uppercase charset
}
#endif

// Main function - Entry point for both DEBUG and PRODUCTION modes
int main(void) {
    // Initialize TMEA system (must be called once at startup)
    init_tmea_system();

#ifdef DEBUG_MAPGEN
    // DEBUG MODE: Interactive menu + generation + preview/navigation
    clrscr();
    set_mixed_charset();
    mapgen_run_debug_mode();
#else
    // RELEASE MODE: Generate a default map to verify API works
    // This also ensures the mapgen code is not optimized away
    mapgen_init(12345);
    mapgen_generate_with_params(
        1,  // MEDIUM map (64x64)
        1,  // MEDIUM rooms (12-16)
        1,  // MEDIUM room size
        1,  // 25% secret rooms
        1,  // 25% false corridors
        1,  // 25% treasures
        1   // 25% hidden corridors
    );
    // After generation, data is available in memory:
    // - compact_map[] : 3-bit packed tile data
    // - room_list[]   : Room structures with metadata
    // - room_count    : Number of rooms generated
#endif

    return 0;
}
