// =============================================================================
// Map Generation Module for C64 Map Generator
// Structure following the generation pipeline
// =============================================================================

#include "mapgen_types.h"      // For Room, MAX_ROOMS
#include "mapgen_internal.h"   // For add_stairs, add_walls, etc. and global variable declarations
#include "mapgen_utils.h"      // For get_room_center, coords_in_bounds, calculate_room_distance
#include "mapgen_display.h"    // For initialize_camera
#include "mapgen_config.h"     // For MapParameters

// =============================================================================
// DYNAMIC GENERATION PARAMETERS
// =============================================================================

// Current generation parameters (set via mapgen_set_parameters)
// Non-static so other modules can access via extern declaration
MapParameters current_params = {
    72,  // map_width (default MEDIUM)
    72,  // map_height
    20,  // max_rooms
    4,   // min_room_size
    8,   // max_room_size
    4,   // secret_room_count (20% of 20)
    5,   // false_corridor_count
    4    // treasure_count
};

// =============================================================================
// PHASE 1: ROOM CREATION
// =============================================================================
// Note: create_rooms() function is implemented in room_management.c
// This phase creates rooms using grid-based placement

// =============================================================================
// PHASE 2: ROOM CONNECTION SYSTEM
// =============================================================================
// Note: Connection system is implemented in connection_system.c
// Creates corridors between rooms using MST algorithm with fallback

// =============================================================================
// PHASE 3: STAIR PLACEMENT SYSTEM
// =============================================================================

// Place stairs in rooms with maximum distance for optimal separation
void add_stairs(void) {
    if (room_count < 2) return; // Need at least 2 rooms for stairs

    // Phase 5: Stair placement progress - starting
    update_progress_step(5, 0, 2);

    // Find room pair with maximum distance (brute-force optimal)
    unsigned char start_room = 0;
    unsigned char end_room = 1;
    unsigned char max_distance = calculate_room_distance(0, 1);

    for (unsigned char i = 0; i < room_count; i++) {
        __assume(room_count <= MAX_ROOMS);
        for (unsigned char j = i + 1; j < room_count; j++) {
            __assume(i < MAX_ROOMS);
            __assume(j < MAX_ROOMS);
            unsigned char dist = calculate_room_distance(i, j);
            if (dist > max_distance) {
                max_distance = dist;
                start_room = i;
                end_room = j;
            }
        }
    }

    // Place up stairs in starting room center
    unsigned char up_x, up_y;
    get_room_center(start_room, &up_x, &up_y);
    if (coords_in_bounds(up_x, up_y)) {
        set_compact_tile(up_x, up_y, TILE_UP);
    }

    update_progress_step(5, 1, 2);

    // Place down stairs in ending room center
    unsigned char down_x, down_y;
    get_room_center(end_room, &down_x, &down_y);
    if (coords_in_bounds(down_x, down_y)) {
        set_compact_tile(down_x, down_y, TILE_DOWN);
    }

    // Phase 5: Stair placement complete
    update_progress_step(5, 2, 2);
}


// =============================================================================
// MAIN MAP GENERATION PIPELINE
// =============================================================================

// Level generation pipeline with incremental wall building
unsigned char generate_level(void) {
    // Initialize progress bar system
    init_generation_progress();
    init_progress_weights();  // Pre-calculate dynamic phase boundaries

    // Phase 1: Create rooms with walls using grid-based placement
    show_phase(0); // "Building Rooms"
    create_rooms();
    // Early exit if no rooms were created
    if (room_count == 0) {
        finish_progress_bar_simple();
        return 0; // Generation failed
    }

    // Phase 2: Room Connection System with corridor walls
    show_phase(1); // "Connecting Rooms"
    build_room_network();

    // Phase 2.5: Convert single-connection rooms to secret rooms
    show_phase(2); // "Secret Areas"
    convert_secret_rooms_doors();

    // Phase 2.6: Place secret treasures
    show_phase(3); // "Secret Treasures"
    place_secret_treasures(current_params.treasure_count);

    // Phase 2.7: Place false corridors
    show_phase(4); // "False Corridors"
    place_false_corridors(current_params.false_corridor_count);

    // Phase 3: Place stairs for level navigation
    show_phase(5); // "Placing Stairs"
    add_stairs();

    // Phase 6: Initialize camera for new map
    show_phase(6); // "Finalizing"
    update_progress_step(6, 0, 1);
    initialize_camera();
    update_progress_step(6, 1, 1);

    // Finish progress bar and show completion message
    finish_progress_bar_simple();
    show_phase(7); // "Complete"
    
    // VIC-II raster-based delay (more reliable on C64)
    // Wait for multiple frame cycles for visible delay
    for (unsigned char frames = 0; frames < 150; frames++) {  // ~3 seconds at 50Hz PAL
        // Wait for raster line 0 (top of screen)
        while (*(volatile unsigned char*)0xD012 != 0) {
            // Wait for raster to reach top
        }
        // Wait for raster to leave line 0
        while (*(volatile unsigned char*)0xD012 == 0) {
            // Wait for next frame to start
        }
    }
    
    // Now render the map after progress bar is complete
    render_map_viewport(1);
    
    return 1; // Generation successful
}

// =============================================================================
// PUBLIC API FUNCTIONS
// =============================================================================

// Set generation parameters from configuration
void mapgen_set_parameters(const MapParameters *params) {
    if (params) {
        current_params = *params;
    }
}

// Get current generation parameters (for testing/debugging)
void mapgen_get_parameters(MapParameters *params) {
    if (params) {
        *params = current_params;
    }
}

// Get current map size (width == height)
unsigned char mapgen_get_map_size(void) {
    return current_params.map_width;
}