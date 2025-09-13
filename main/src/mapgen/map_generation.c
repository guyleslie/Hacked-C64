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
    init_progress("\n\nPlacing stairs");

    if (room_count < 2) return; // Need at least 2 rooms for stairs
    
    unsigned char start_room = 0;
    unsigned char end_room = room_count - 1;
    // Adaptive minimum distance: smaller maps need shorter distances
    unsigned char min_stair_distance = (room_count <= 6) ? 20 : 30;
    
    // Find highest priority room for up stairs
    unsigned char highest_priority = 0;
    for (unsigned char i = 0; i < room_count; i++) {
        if (i % 4 == 0) show_progress(); // Progress indicator every 4th room
        if (rooms[i].priority > highest_priority) {
            highest_priority = rooms[i].priority;
            start_room = i;
        }
    }
    
    // Find second highest priority room for down stairs with distance check
    unsigned char second_highest = 0;
    for (unsigned char i = 0; i < room_count; i++) {
        if (i % 4 == 0) show_progress(); // Progress indicator every 4th room
        if (i != start_room && rooms[i].priority > second_highest) {
            unsigned char distance = calculate_room_distance(start_room, i);
            if (distance >= min_stair_distance) { // Check minimum distance
                second_highest = rooms[i].priority;
                end_room = i;
            }
        }
    }
    
    // Place up stairs in starting room
    unsigned char up_x, up_y;
    get_room_center(start_room, &up_x, &up_y);
    if (coords_in_bounds(up_x, up_y)) {
        set_tile_raw(up_x, up_y, TILE_UP);
    }
    
    // Place down stairs in ending room
    unsigned char down_x, down_y;
    get_room_center(end_room, &down_x, &down_y);
    if (coords_in_bounds(down_x, down_y)) {
        set_tile_raw(down_x, down_y, TILE_DOWN);
    }
}

// =============================================================================
// PHASE 4:  WALL PLACEMENT
// =============================================================================

void add_walls(void) {
    unsigned char x, y; // Oscar64 register allocation
    unsigned char tile;

    init_progress("\n\nPlacing walls");
    
    for (y = 0; y < MAP_H; y++) {
        // Loop unrolling
        #pragma unroll(2)
        for (x = 0; x < MAP_W; x++) {
            tile = get_tile_raw(x, y);
            
            // Only place walls around walkable tiles
            if (is_walkable_tile(tile)) {
                // Cardinal directions - use mapgen_utils helper functions
                if (tile_is_empty(x, y-1)) {
                    set_tile_raw(x, y-1, TILE_WALL);
                }
                if (tile_is_empty(x, y+1)) {
                    set_tile_raw(x, y+1, TILE_WALL);
                }
                if (tile_is_empty(x-1, y)) {
                    set_tile_raw(x-1, y, TILE_WALL);
                }
                if (tile_is_empty(x+1, y)) {
                    set_tile_raw(x+1, y, TILE_WALL);
                }
                
                // Diagonal walls - use mapgen_utils helper functions
                if (tile_is_empty(x-1, y-1)) {
                    set_tile_raw(x-1, y-1, TILE_WALL);
                }
                if (tile_is_empty(x+1, y-1)) {
                    set_tile_raw(x+1, y-1, TILE_WALL);
                }
                if (tile_is_empty(x-1, y+1)) {
                    set_tile_raw(x-1, y+1, TILE_WALL);
                }
                if (tile_is_empty(x+1, y+1)) {
                    set_tile_raw(x+1, y+1, TILE_WALL);
                }
            }
        }
        if ((y & 7) == 0) show_progress();
    }
}

// =============================================================================
// MAIN MAP GENERATION PIPELINE
// =============================================================================

// Level generation pipeline
unsigned char generate_level(void) {
    // Initialize progress system
    init_generation_progress();
    
    // Phase 1: Create rooms using grid-based placement
    create_rooms();
    // Early exit if no rooms were created
    if (room_count == 0) {
        return 0; // Generation failed
    }
    
    // Phase 2: Room Connection System
    init_connection_system();
    connect_rooms();
    
    // Phase 2.5: Mark secret rooms and convert doors
    mark_secret_rooms(SECRET_ROOM_PERCENTAGE);
    
    // Phase 3: Place stairs for level navigation
    add_stairs();
    
    // Phase 4: Add walls around all floor areas
    add_walls();
    
    // Phase 5: Initialize camera for new map
    initialize_camera();
    
    return 1; // Generation successful
}