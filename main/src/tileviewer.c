// =============================================================================
// Tile Viewer Entry Point
// =============================================================================
// Builds a standalone PRG that generates a dungeon and lets it be scrolled on
// screen with the 3x3 tile renderer, instead of the one-character-per-cell
// PETSCII preview.
//
// Doors draw as the iron grating. Secret doors, and the doors the deception
// system hides, draw as plain wall - tiles_select() asks TMEA and treats them
// as part of the wall run, so nothing about them is visible.
//
// Controls: joystick 2 scrolls, FIRE generates a new dungeon, Q quits.

#include <conio.h>

#include "mapgen/mapgen_api.h"
#include "mapgen/mapgen_config.h"
#include "tiles/tile_viewer.h"

// =============================================================================
// OSCAR64 Module Includes (single-file compilation model)
// =============================================================================

#include "mapgen/tmea_core.c"         // TMEA metadata system (must be first)
#include "mapgen/tmea_data.c"         // TMEA lookup tables (items, monsters)
#include "mapgen/mapgen_config.c"     // Configuration and parameter management
#include "mapgen/mapgen_utils.c"      // Utility functions and tile operations
#include "mapgen/map_generation.c"    // Generation pipeline controller
#include "mapgen/room_management.c"   // Room placement algorithms
#include "mapgen/connection_system.c" // Corridor and feature generation

#include "tiles/tileset_data.c"       // Generated character set and tile tables
#include "tiles/tile_render.c"        // VIC setup, tile blit, tile selection
#include "tiles/tile_viewer.c"        // Camera and input loop

int main(void) {
    init_tmea_system();

    clrscr();

    mapgen_generate_with_params(
        1,  // MEDIUM map (64x64, 16 rooms)
        1,  // 25% hidden rooms
        1,  // 25% niches
        1   // 25% deception (decoys + hidden passages)
    );

    tile_viewer_run();
    return 0;
}
