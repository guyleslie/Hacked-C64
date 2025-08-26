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

// Oscar64 zero page variables for data
__zeropage unsigned char wall_loop_counter;
__zeropage unsigned char wall_tile_cache;

// Helper function: Check if position is valid and what type of tile it is
unsigned char get_tile_safe(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return TILE_EMPTY;
    return get_tile_raw(x, y);
}

// Helper function: Check if tile is walkable (floor or door)
unsigned char is_walkable_tile(unsigned char tile) {
    return (tile == TILE_FLOOR || tile == TILE_DOOR);
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
    print_text("\n\nPlacing stairs");

    if (room_count < 2) return; // Need at least 2 rooms for stairs
    
    unsigned char start_room = 0;
    unsigned char end_room = room_count - 1;
    
    // Find highest priority room for up stairs
    unsigned char highest_priority = 0;
    for (unsigned char i = 0; i < room_count; i++) {
        if (i % 4 == 0) print_text("."); // Progress indicator every 4th room
        if (rooms[i].priority > highest_priority) {
            highest_priority = rooms[i].priority;
            start_room = i;
        }
    }
    
    // Find second highest priority room for down stairs
    unsigned char second_highest = 0;
    for (unsigned char i = 0; i < room_count; i++) {
        if (i % 4 == 0) print_text("."); // Progress indicator every 4th room
        if (i != start_room && rooms[i].priority > second_highest) {
            second_highest = rooms[i].priority;
            end_room = i;
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

    print_text("\n\nPlacing walls");
    
    for (y = 0; y < MAP_H; y++) {
        // Loop unrolling
        #pragma unroll(2)
        for (x = 0; x < MAP_W; x++) {
            tile = get_tile_raw(x, y);
            
            // Only place walls around walkable tiles
            if (is_walkable_tile(tile)) {
                // Cardinal directions
                if (y > 0 && get_tile_raw(x, y-1) == TILE_EMPTY) {
                    set_tile_raw(x, y-1, TILE_WALL);
                }
                if (y < MAP_H-1 && get_tile_raw(x, y+1) == TILE_EMPTY) {
                    set_tile_raw(x, y+1, TILE_WALL);
                }
                if (x > 0 && get_tile_raw(x-1, y) == TILE_EMPTY) {
                    set_tile_raw(x-1, y, TILE_WALL);
                }
                if (x < MAP_W-1 && get_tile_raw(x+1, y) == TILE_EMPTY) {
                    set_tile_raw(x+1, y, TILE_WALL);
                }
                
                // Diagonal walls
                if (x > 0 && y > 0 && get_tile_raw(x-1, y-1) == TILE_EMPTY) {
                    set_tile_raw(x-1, y-1, TILE_WALL);
                }
                if (x < MAP_W-1 && y > 0 && get_tile_raw(x+1, y-1) == TILE_EMPTY) {
                    set_tile_raw(x+1, y-1, TILE_WALL);
                }
                if (x > 0 && y < MAP_H-1 && get_tile_raw(x-1, y+1) == TILE_EMPTY) {
                    set_tile_raw(x-1, y+1, TILE_WALL);
                }
                if (x < MAP_W-1 && y < MAP_H-1 && get_tile_raw(x+1, y+1) == TILE_EMPTY) {
                    set_tile_raw(x+1, y+1, TILE_WALL);
                }
            }
        }
        if ((y & 7) == 0) print_text(".");
    }
}

// =============================================================================
// MAIN MAP GENERATION PIPELINE
// =============================================================================

// Level generation pipeline
unsigned char generate_level(void) {
    // Display map generation progress message
    // Print the map generation message centered horizontally (40 columns)
    print_text("      *** Hacked Map Generator ***\n");
    
    // Phase 1: Create rooms using grid-based placement
    create_rooms();
    // Early exit if no rooms were created
    if (room_count == 0) {
        return 0; // Generation failed
    }
    
    // Phase 2: Room Connection System (see connection_system.c)
    // Connect rooms using MST algorithm with corridor creation
    print_text("\n\nCreating corridors...");
    unsigned char connected[MAX_ROOMS];
    unsigned char connections_made = 0;
    unsigned char i;
    // Initialize connection system
    init_connection_system();
    
    // Initialize connection tracking
    for (i = 0; i < MAX_ROOMS; i++) {
        connected[i] = 0;
    }
    // Start with room 0 as connected
    connected[0] = 1;
    // Connect exactly (room_count - 1) rooms for spanning tree
    // MST main loop
    #pragma optimize(speed)
    while (connections_made < room_count - 1) {
        mst_best_distance = 255;
        unsigned char connection_found = 0;
        
        // MST: Try optimized connection finding first  
        connection_found = find_best_connection(connected, &mst_best_room1, &mst_best_room2);
        
        if (!connection_found) {
            // Fallback to traditional MST algorithm if cache missed
            // Connection filtering to prevent infinite loops
            for (i = 0; i < room_count; i++) {
                if (!connected[i]) continue; // Only connected rooms as source
                
                for (unsigned char j = 0; j < room_count; j++) {
                    // Only unconnected rooms as target
                    if (connected[j]) continue; 
                    
                    // Only allow connections that comply with safety rules
                    // Dynamic distance limits: 30-80 tiles based on room count
                    if (!can_connect_rooms_safely(i, j)) continue;
                    
                    // Skip connections already attempted
                    if (is_room_reachable(i, j)) continue;
                    
                    // Use traditional distance cache
                    unsigned char distance = get_cached_room_distance(i, j);
                    if (distance < mst_best_distance) {
                        mst_best_distance = distance;
                        mst_best_room1 = i;
                        mst_best_room2 = j;
                        connection_found = 1;
                    }
                }
            }
        }
        
        // Make the best connection found using zero page variables
        if (connection_found && connect_rooms_directly(mst_best_room1, mst_best_room2)) {
            // Connection succeeded - connect_rooms_directly handles matrix management
            connected[mst_best_room2] = 1; // Mark new room as connected
            connections_made++;
            print_text("."); // Progress every connection
        } else {
            // No valid connections found - MST complete
            break;
        }
    }
    
    // Phase 3: Place stairs for level navigation
    add_stairs();
    
    // Phase 4: Add walls around all floor areas
    add_walls();
    
    // Phase 5: Initialize camera for new map
    initialize_camera();
    
    return 1; // Generation successful
}