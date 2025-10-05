// =============================================================================
// Map Generation Module for C64 Map Generator
// Structure following the generation pipeline
// =============================================================================

#include "mapgen_types.h"      // For Room, MAX_ROOMS
#include "mapgen_internal.h"   // For add_stairs, add_walls, etc. and global variable declarations
#include "mapgen_utils.h"      // For get_room_center, coords_in_bounds, calculate_room_distance
#include "mapgen_display.h"    // For initialize_camera

// =============================================================================
// HELPER FUNCTIONS & UTILITIES
// =============================================================================



// Helper function: Check if tile is walkable (floor or door)
unsigned char is_walkable_tile(unsigned char tile) {
    return (tile == TILE_FLOOR || tile == TILE_DOOR || tile == TILE_SECRET_PATH);
}

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

// Place stairs in appropriate rooms based on priority
void add_stairs(void) {
    if (room_count < 2) return; // Need at least 2 rooms for stairs
    
    unsigned char start_room = 0;
    unsigned char end_room = room_count - 1;
    // Adaptive minimum distance: smaller maps need shorter distances
    unsigned char min_stair_distance = (room_count <= 6) ? 20 : 30;
    
    // Find highest priority room for up stairs
    unsigned char highest_priority = 0;
    for (unsigned char i = 0; i < room_count; i++) {
        __assume(room_count <= MAX_ROOMS);
        if (room_list[i].priority > highest_priority) {
            highest_priority = room_list[i].priority;
            start_room = i;
        }
    }
    // Phase 3: Stair placement progress
    update_progress_step(3, 1, 1);
    
    // Find second highest priority room for down stairs with distance check
    unsigned char second_highest = 0;
    for (unsigned char i = 0; i < room_count; i++) {
        __assume(room_count <= MAX_ROOMS);
        if (i != start_room && room_list[i].priority > second_highest) {
            unsigned char distance = calculate_room_distance(start_room, i);
            if (distance >= min_stair_distance) { // Check minimum distance
                second_highest = room_list[i].priority;
                end_room = i;
            }
        }
    }
    // End room found - no extra step needed
    
    // Place up stairs in starting room
    unsigned char up_x, up_y;
    get_room_center(start_room, &up_x, &up_y);
    if (coords_in_bounds(up_x, up_y)) {
        set_compact_tile(up_x, up_y, TILE_UP);
    }
    
    // Place down stairs in ending room
    unsigned char down_x, down_y;
    get_room_center(end_room, &down_x, &down_y);
    if (coords_in_bounds(down_x, down_y)) {
        set_compact_tile(down_x, down_y, TILE_DOWN);
    }
    // Stairs placed - no extra step needed
}


// =============================================================================
// MAIN MAP GENERATION PIPELINE
// =============================================================================

// Level generation pipeline with incremental wall building
unsigned char generate_level(void) {
    // Initialize progress bar system
    init_generation_progress();
    
    // Phase 1: Create rooms with walls using grid-based placement
    show_phase_name("Building Rooms");
    create_rooms();
    // Early exit if no rooms were created
    if (room_count == 0) {
        finish_progress_bar_simple();
        return 0; // Generation failed
    }
    
    // Phase 2: Room Connection System with corridor walls
    show_phase_name("Connecting Rooms");
    build_room_network();
    
    // Phase 2.5: Convert single-connection rooms to secret rooms
    show_phase_name("Creating Secret Areas");
    convert_secret_rooms_doors();
    
    // Phase 2.6: Place secret treasures
    show_phase_name("Placing Secret Treasures");
    place_secret_treasures(3); // Place 3 secret treasures
    
    // Phase 2.7: Place false corridors
    show_phase_name("Placing False Corridors");
    place_false_corridors(5); // Place 5 false corridors per map
    
    // Phase 3: Place stairs for level navigation
    show_phase_name("Placing Stairs");
    add_stairs();
    
    // Phase 4: Initialize camera for new map
    show_phase_name("Finalizing");
    initialize_camera();
    
    // Finish progress bar and show completion message
    finish_progress_bar_simple();
    show_phase_name("Generation Success !");
    
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