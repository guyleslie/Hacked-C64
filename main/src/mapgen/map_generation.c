// =============================================================================
// Map Generation Module for C64 Map Generator
// Contains stair generation, wall placement, and main map generation logic
// =============================================================================

#include "mapgen_types.h"      // For Room, MAX_ROOMS
#include "mapgen_internal.h"   // For add_stairs, add_walls, etc. and global variable declarations
#include "mapgen_utils.h"      // For get_room_center, coords_in_bounds, calculate_room_distance

// =============================================================================
// OPTIMIZED WALL PLACEMENT - OSCAR64 ENHANCED
// Corner detection completely removed - Oscar64 loop unrolling applied
// =============================================================================

// Oscar64 zero page variables for critical data (auto-managed with -Oz flag)
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

void add_walls(void) {
    unsigned char x, y; // Oscar64 register allocation automatic
    unsigned char tile;

    print_text("\n\nPlacing walls");
    
    // SINGLE PHASE ONLY - Phase 2 corner detection completely removed
    for (y = 0; y < MAP_H; y++) {
        // Oscar64 loop unrolling - process inner loop more efficiently
        #pragma unroll(2)
        for (x = 0; x < MAP_W; x++) {
            tile = get_tile_raw(x, y);
            
            // Only place walls around walkable tiles
            if (is_walkable_tile(tile)) {
                // Oscar64 optimizes repeated bounds checking automatically
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
                
                // Diagonal walls for complete enclosure
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
        // Oscar64 strength reduction: bit operations instead of modulo
        if ((y & 7) == 0) print_text(".");
    }
    
    // PHASE 2 COMPLETELY ELIMINATED
}

// =============================================================================
// STAIR PLACEMENT SYSTEM
// =============================================================================

// Place stairs in appropriate rooms based on priority
void add_stairs(void) {

    print_text("\n\nPlacing stairs");

    if (room_count < 2) return; // Need at least 2 rooms for stairs
    
    unsigned char start_room = 0;
    unsigned char end_room = room_count - 1;
      // Find highest priority room for up stairs (usually starting room)
    unsigned char highest_priority = 0;
    for (unsigned char i = 0; i < room_count; i++) {
        if (i % 4 == 0) print_text("."); // Progress indicator every 4th room
        if (rooms[i].priority > highest_priority) {
            highest_priority = rooms[i].priority;
            start_room = i;
        }
    }
    
    // Find second highest priority room for down stairs (usually ending room)
    unsigned char second_highest = 0;
    for (unsigned char i = 0; i < room_count; i++) {
        if (i % 4 == 0) print_text("."); // Progress indicator every 4th room
        if (i != start_room && rooms[i].priority > second_highest) {
            second_highest = rooms[i].priority;
            end_room = i;
        }
    }// Place up stairs in starting room
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
// MAIN MAP GENERATION
// =============================================================================

// Complete level generation pipeline 
unsigned char generate_level(void) {
    // Display map generation progress message
    // Print the map generation message centered horizontally (40 columns)
    print_text("      *** Hacked Map Generator ***\n");
    
    // Phase 1: Create rooms using efficient grid-based placement
    create_rooms();
    // Early exit if no rooms were created
    if (room_count == 0) {
        return 0; // Generation failed
    }
    
    // Phase 2: Room Connection System
    // - Position-based corridor selection ensures near-perfect connectivity
    // - Standard MST with attempted connection filtering (prevents infinite loops)
    // - Dynamic distance limits: 30-80 tiles based on room density for optimal connectivity
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
    // Connect exactly (room_count - 1) rooms for optimal spanning tree
    // OSCAR64 optimized MST main loop
    #pragma optimize(speed)
    while (connections_made < room_count - 1) {
        mst_best_distance = 255;
        unsigned char connection_found = 0;
        
        // STANDARD MST: Find shortest VALID connection between connected and unconnected rooms
        // Enhanced with attempted connection filtering to prevent infinite loops
        // OSCAR64 automatically optimizes nested loops with zero page variables
        for (i = 0; i < room_count; i++) {
            if (!connected[i]) continue; // Only connected rooms as source
            
            for (unsigned char j = 0; j < room_count; j++) {
                // Only unconnected rooms as target
                if (connected[j]) continue; 
                
                // Only allow connections that comply with safety rules
                // Dynamic distance limits: 30-80 tiles based on room count for better connectivity
                if (!can_connect_rooms_safely(i, j)) continue;
                
                // INFINITE LOOP PREVENTION: Skip connections already attempted
                if (is_room_reachable(i, j)) continue;
                
                // OSCAR64 strength reduction optimization with zero page distance
                unsigned char distance = calculate_room_distance(i, j);
                if (distance < mst_best_distance) {
                    mst_best_distance = distance;
                    mst_best_room1 = i;
                    mst_best_room2 = j;
                    connection_found = 1;
                }
            }
        }
        
        // Make the best connection found using zero page optimized variables
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
    
    // Phase 4: Place stairs for level navigation
    add_stairs();

    // Phase 5: Add walls around all floor areas
    add_walls();
    
    return 1; // Generation successful
}