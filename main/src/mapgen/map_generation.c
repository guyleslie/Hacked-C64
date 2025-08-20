// =============================================================================
// Map Generation Module for C64 Map Generator
// Contains wall placement, stair generation, and main map generation logic
// =============================================================================

#include "mapgen_types.h"      // For Room, MAX_ROOMS
#include "mapgen_internal.h"   // For add_walls, add_stairs, etc. and global variable declarations
#include "mapgen_utils.h"      // For get_room_center, coords_in_bounds, calculate_room_distance

// =============================================================================
// WALL PLACEMENT SYSTEM - TWO PHASE APPROACH
// =============================================================================
// PHASE 1: Place walls around walkable areas
// PHASE 2: Place corners at true spatial corner locations

// Helper function: Check if position is valid and what type of tile it is
unsigned char get_tile_safe(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return TILE_EMPTY;
    return get_tile_raw(x, y);
}

// Helper function: Check if tile is walkable (floor or door)
unsigned char is_walkable_tile(unsigned char tile) {
    return (tile == TILE_FLOOR || tile == TILE_DOOR);
}

// Helper function: Check if position forms a NetHack-style corner
unsigned char is_true_corner(unsigned char x, unsigned char y) {
    // Must be a wall to be considered for corner placement
    if (get_tile_raw(x, y) != TILE_WALL) return 0;
    
    // Get cardinal direction walls and doors (treat doors as walls for corner logic)
    unsigned char n = get_tile_safe(x, y-1);     // North
    unsigned char s = get_tile_safe(x, y+1);     // South  
    unsigned char w = get_tile_safe(x-1, y);     // West
    unsigned char e = get_tile_safe(x+1, y);     // East
    
    unsigned char wall_north = (n == TILE_WALL || n == TILE_CORNER || n == TILE_DOOR);
    unsigned char wall_south = (s == TILE_WALL || s == TILE_CORNER || s == TILE_DOOR);
    unsigned char wall_west = (w == TILE_WALL || w == TILE_CORNER || w == TILE_DOOR);
    unsigned char wall_east = (e == TILE_WALL || e == TILE_CORNER || e == TILE_DOOR);
    
    unsigned char wall_count = wall_north + wall_south + wall_west + wall_east;
    
    // NetHack-style corner detection: L-shaped wall patterns only
    
    // L-shaped corners - exactly 2 walls in perpendicular directions
    if (wall_count == 2) {
        // Check for perpendicular wall patterns (90-degree turns)
        if ((wall_north && wall_east) ||   // North-East L-corner
            (wall_north && wall_west) ||   // North-West L-corner
            (wall_south && wall_east) ||   // South-East L-corner
            (wall_south && wall_west)) {   // South-West L-corner
            return 1;
        }
    }
    
    // T-junction corners - wall branches in 3 directions
    if (wall_count == 3) {
        return 1;
    }
    
    // Door adjacent corners - any wall directly touching a door
    // Important for visual consistency around doorways
    if (n == TILE_DOOR || s == TILE_DOOR || w == TILE_DOOR || e == TILE_DOOR) {
        return 1;
    }
    
    return 0; // Not a corner in NetHack style
}

// Helper function: Check if position is part of straight wall run
unsigned char is_straight_wall_run(unsigned char x, unsigned char y) {
    if (get_tile_raw(x, y) != TILE_WALL) return 0;
    
    unsigned char n = get_tile_safe(x, y-1);
    unsigned char s = get_tile_safe(x, y+1);  
    unsigned char w = get_tile_safe(x-1, y);
    unsigned char e = get_tile_safe(x+1, y);
    
    // Horizontal wall run (walls or corners to west and east)
    if ((w == TILE_WALL || w == TILE_CORNER) && 
        (e == TILE_WALL || e == TILE_CORNER) && 
        n != TILE_WALL && s != TILE_WALL) {
        return 1;
    }
    
    // Vertical wall run (walls or corners to north and south)  
    if ((n == TILE_WALL || n == TILE_CORNER) && 
        (s == TILE_WALL || s == TILE_CORNER) && 
        w != TILE_WALL && e != TILE_WALL) {
        return 1;
    }
    
    return 0;
}

// Two-phase wall and corner placement system
void add_walls(void) {
    unsigned char x, y;

    // =================================================================
    // PHASE 1: PLACE WALLS AROUND WALKABLE AREAS
    // =================================================================
    print_text("\n\nPlacing walls");
    
    for (y = 0; y < MAP_H; y++) {
        for (x = 0; x < MAP_W; x++) {
            unsigned char tile = get_tile_raw(x, y);
            // Only process floor and door tiles
            if (is_walkable_tile(tile)) {
                // Place walls in all 4 cardinal directions if empty
                // North
                if (y > 0 && get_tile_raw(x, y-1) == TILE_EMPTY) {
                    set_tile_raw(x, y-1, TILE_WALL);
                }
                // South
                if (y < MAP_H-1 && get_tile_raw(x, y+1) == TILE_EMPTY) {
                    set_tile_raw(x, y+1, TILE_WALL);
                }
                // West
                if (x > 0 && get_tile_raw(x-1, y) == TILE_EMPTY) {
                    set_tile_raw(x-1, y, TILE_WALL);
                }
                // East
                if (x < MAP_W-1 && get_tile_raw(x+1, y) == TILE_EMPTY) {
                    set_tile_raw(x+1, y, TILE_WALL);
                }
                
                // DIAGONAL WALLS: Place walls at corner positions for complete enclosure
                // Northwest diagonal
                if (x > 0 && y > 0 && get_tile_raw(x-1, y-1) == TILE_EMPTY) {
                    set_tile_raw(x-1, y-1, TILE_WALL);
                }
                // Northeast diagonal  
                if (x < MAP_W-1 && y > 0 && get_tile_raw(x+1, y-1) == TILE_EMPTY) {
                    set_tile_raw(x+1, y-1, TILE_WALL);
                }
                // Southwest diagonal
                if (x > 0 && y < MAP_H-1 && get_tile_raw(x-1, y+1) == TILE_EMPTY) {
                    set_tile_raw(x-1, y+1, TILE_WALL);
                }
                // Southeast diagonal
                if (x < MAP_W-1 && y < MAP_H-1 && get_tile_raw(x+1, y+1) == TILE_EMPTY) {
                    set_tile_raw(x+1, y+1, TILE_WALL);
                }
            }
        }
        if (y % 8 == 0) print_text("."); // Progress indicator
    }

    // =================================================================
    // PHASE 2: PLACE CORNERS AT L-SHAPED WALL TURNS (NETHACK STYLE)
    // =================================================================
    print_text("\n\nPlacing corners");
    
    for (y = 1; y < MAP_H-1; y++) {
        for (x = 1; x < MAP_W-1; x++) {
            // Skip if not a wall or already processed
            if (get_tile_raw(x, y) != TILE_WALL) continue;
            
            // Skip walls that are part of straight runs - these don't need corners
            if (is_straight_wall_run(x, y)) continue;
            
            // Check if this position forms a NetHack-style corner
            if (is_true_corner(x, y)) {
                set_tile_raw(x, y, TILE_CORNER);
            }
        }
        if (y % 8 == 0) print_text("."); // Progress indicator
    }
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
    
    // Phase 2: Connect rooms with MST logic (prevents duplicate connections)
    print_text("\n\nCreating corridors");
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
    while (connections_made < room_count - 1) {
        unsigned char best_room1 = 255, best_room2 = 255;
        unsigned char best_distance = 255;
        unsigned char connection_found = 0;
        
        // Find shortest VALID connection between connected and unconnected rooms
        for (i = 0; i < room_count; i++) {
            if (!connected[i]) continue; // Only connected rooms as source
            
            for (unsigned char j = 0; j < room_count; j++) {
                // Only unconnected rooms as target
                if (connected[j]) continue; 
                
                // Only allow connections that comply with rules
                if (!can_connect_rooms_safely(i, j)) continue;
                
                unsigned char distance = calculate_room_distance(i, j);
                if (distance < best_distance) {
                    best_distance = distance;
                    best_room1 = i;
                    best_room2 = j;
                    connection_found = 1;
                }
            }
        }
        
        // Make the best connection found
        if (connection_found && connect_rooms_directly(best_room1, best_room2)) {
            connected[best_room2] = 1; // Mark new room as connected
            connections_made++;
            
            // Verify connection_matrix consistency
            // Ensure both MST tracking and connection_matrix are synchronized
            if (!rooms_are_connected(best_room1, best_room2)) {
                // Connection failed in reality - rollback MST state
                connected[best_room2] = 0;
                connections_made--;
                print_text("F"); // Indicate sync failure
                continue;
            }
            
            if (connections_made % 1 == 0) print_text("."); // Progress every connection
        } else {
            // No valid connections found - exit to prevent infinite loop
            print_text("X"); // Indicate connection failure
            break;
        }
    }
    
    // Phase 4: Add walls around all floor areas
    add_walls();

    // Phase 5: Place stairs for level navigation
    add_stairs();
    
    return 1; // Generation successful
}