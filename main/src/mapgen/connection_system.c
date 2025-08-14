// =============================================================================
// RULE-BASED ROOM CONNECTION SYSTEM
// Room connection system with distance rules and duplicate prevention
// =============================================================================
// Features:
// 1. Enforces MIN_ROOM_DISTANCE rule between rooms
// 2. Uses connection matrix to track room relationships
// 3. Validates all connections against placement rules
// 4. Prevents duplicate connections through matrix tracking
// 5. Avoids multiple corridors between same room pairs
// 6. Creates new corridors for each connection request
// 7. Z-CORRIDOR DIRECTION: First leg direction based on exit wall type
//    - Horizontal walls (top/bottom): Start with vertical movement
//    - Vertical walls (left/right): Start with horizontal movement
//    This avoids corridors running parallel to room walls
// =============================================================================

#include "mapgen_types.h"      // For Room, MAX_ROOMS 
#include "mapgen_internal.h"   // For connection helpers and door placement functions
#include "mapgen_utils.h"    // For utility functions

// External references
extern Room rooms[MAX_ROOMS];
extern unsigned char room_count;

// Global flag to allow endpoint override for corridor placement
// Set to 1 when placing corridor at a room edge (perimeter) endpoint
unsigned char corridor_endpoint_override = 0;

// Oscar64/C64: Move large arrays to static file scope to avoid stack overflow
static unsigned char visited_global[MAX_ROOMS];
static unsigned char stack_global[MAX_ROOMS];

// Connection tracking
static unsigned char connection_matrix[MAX_ROOMS][MAX_ROOMS];

// Track attempted connections to prevent duplicates
static unsigned char attempted_connections[MAX_ROOMS][MAX_ROOMS];

// =============================================================================
// MEMORY POOL GLOBALS - C64 OPTIMIZED STATIC ALLOCATION
// =============================================================================

// Static memory pools - faster than dynamic allocation on C64
static CorridorPool corridor_pool = {0};
static ConnectionCache connection_cache = {0};

// Quick lookup table for room distances (cache frequently used calculations)
static unsigned char room_distance_cache[MAX_ROOMS][MAX_ROOMS];
static unsigned char distance_cache_valid = 0;

// =============================================================================
// DUPLICATE CONNECTION PREVENTION - REACHABILITY CHECK
// =============================================================================

/**
 * @brief Checks if room2 is reachable from room1 through existing connections
 * @param room1 Starting room index
 * @param room2 Target room index  
 * @return 1 if room2 is reachable from room1, 0 otherwise
 * 
 * Uses Depth-First Search (DFS) with static arrays for C64 compatibility.
 * Prevents creating duplicate connections by detecting indirect paths.
 */
unsigned char is_room_reachable(unsigned char room1, unsigned char room2) {
    // Basic validation
    if (room1 >= room_count || room2 >= room_count || room1 == room2) {
        return 0;
    }
    
    // Direct connection already exists
    if (connection_matrix[room1][room2]) {
        return 1;
    }
    
    // Depth-First Search through existing connections
    // Using static arrays to avoid C64 stack overflow
    unsigned char i;
    unsigned char sp = 0; // Stack pointer
    
    // Initialize visited array
    for (i = 0; i < MAX_ROOMS; i++) {
        visited_global[i] = 0;
    }
    
    // Start DFS from room1
    stack_global[sp++] = room1;
    visited_global[room1] = 1;
    
    // DFS traversal
    while (sp > 0) {
        unsigned char current = stack_global[--sp];
        
        // Check all direct connections from current room
        for (i = 0; i < room_count; i++) {
            if (connection_matrix[current][i] && !visited_global[i]) {
                // Found target room - it's reachable
                if (i == room2) {
                    return 1;
                }
                
                // Continue search from this room
                visited_global[i] = 1;
                if (sp < MAX_ROOMS) {  // Stack overflow protection
                    stack_global[sp++] = i;
                }
            }
        }
    }
    
    return 0; // Not reachable through existing connections
}

// =============================================================================
// OPTIMIZED DISTANCE CALCULATION WITH CACHING
// =============================================================================

// Fast cache-aware distance calculation - C64 optimized
unsigned char get_cached_room_distance(unsigned char room1, unsigned char room2) {
    if (!distance_cache_valid || room1 >= MAX_ROOMS || room2 >= MAX_ROOMS) {
        return calculate_room_distance(room1, room2);
    }
    
    unsigned char cached_distance = room_distance_cache[room1][room2];
    if (cached_distance != 255) { // Valid cache entry
        return cached_distance;
    }
    
    // Cache miss - calculate and store
    cached_distance = calculate_room_distance(room1, room2);
    room_distance_cache[room1][room2] = cached_distance;
    room_distance_cache[room2][room1] = cached_distance; // Symmetric
    
    return cached_distance;
}

// =============================================================================
// BASE RULE CHECKS
// =============================================================================

// OPTIMIZED: Cache-aware rule check between two rooms
unsigned char can_connect_rooms_safely(unsigned char room1, unsigned char room2) {
    if (room1 >= room_count || room2 >= room_count || room1 == room2) {
        return 0;
    }
    
    // 1. Cached distance check
    unsigned char distance = get_cached_room_distance(room1, room2);
    if (distance > 30) { // Too far apart
        return 0;
    }
    
    // 2. Check that buffer zones do not overlap (uses MIN_ROOM_DISTANCE only)
    unsigned char room1_buffer_x1 = rooms[room1].x - MIN_ROOM_DISTANCE;
    unsigned char room1_buffer_y1 = rooms[room1].y - MIN_ROOM_DISTANCE;
    unsigned char room1_buffer_x2 = rooms[room1].x + rooms[room1].w + MIN_ROOM_DISTANCE;
    unsigned char room1_buffer_y2 = rooms[room1].y + rooms[room1].h + MIN_ROOM_DISTANCE;
    unsigned char room2_buffer_x1 = rooms[room2].x - MIN_ROOM_DISTANCE;
    unsigned char room2_buffer_y1 = rooms[room2].y - MIN_ROOM_DISTANCE;
    unsigned char room2_buffer_x2 = rooms[room2].x + rooms[room2].w + MIN_ROOM_DISTANCE;
    unsigned char room2_buffer_y2 = rooms[room2].y + rooms[room2].h + MIN_ROOM_DISTANCE;
    
    // Check if buffer zones overlap
    if (room1_buffer_x2 > room2_buffer_x1 && room1_buffer_x1 < room2_buffer_x2 &&
        room1_buffer_y2 > room2_buffer_y1 && room1_buffer_y1 < room2_buffer_y2) {
        return 0; // Too close to each other
    }
    
    return 1; // Safe to connect
}

// Fast rule check for corridors with basic adjacency rules
unsigned char can_place_corridor_tile(unsigned char x, unsigned char y) {
    // Endpoint override logic - allow placement at room edges
    if (corridor_endpoint_override) {
        if (!is_within_map_bounds(x, y)) return 0;
        if (!is_outside_any_room(x, y)) return 0;
        if (!is_on_room_edge(x, y)) return 0;
        return 1;
    }
    
    if (!is_within_map_bounds(x, y)) return 0;
    if (!is_outside_any_room(x, y)) return 0;

    // For short corridors, relax adjacency rules
    // Check if this position is part of a direct connection between close rooms
    unsigned char adjacent_room_count = 0;
    if (!is_outside_any_room(x + 1, y)) adjacent_room_count++;
    if (!is_outside_any_room(x - 1, y)) adjacent_room_count++;
    if (!is_outside_any_room(x, y + 1)) adjacent_room_count++;
    if (!is_outside_any_room(x, y - 1)) adjacent_room_count++;

    // Allow corridor tiles adjacent to exactly 1 or 2 rooms (for short connections)
    // Prevent placement if adjacent to 3+ rooms (would create problematic intersections)
    if (adjacent_room_count >= 3) {
        return 0;
    }

    return 1; // Safe to build
}

// =============================================================================
// CORRIDOR DRAWING
// =============================================================================

// Oscar64/C64: Use static struct to avoid stack usage
static CorridorPath corridor_path_static;

/**
 * @brief Determines which side of a room an exit point is on
 * @param room Pointer to the room
 * @param exit_x Exit X coordinate
 * @param exit_y Exit Y coordinate
 * @return 0=left, 1=right, 2=top, 3=bottom
 */
static unsigned char get_exit_side(Room *room, unsigned char exit_x, unsigned char exit_y) {
    // Left side - vertical wall
    if (exit_x == room->x - 2) {
        return 0; // Left side
    }
    // Right side - vertical wall  
    if (exit_x == room->x + room->w + 1) {
        return 1; // Right side
    }
    // Top side - horizontal wall
    if (exit_y == room->y - 2) {
        return 2; // Top side
    }
    // Bottom side - horizontal wall
    if (exit_y == room->y + room->h + 1) {
        return 3; // Bottom side
    }
    
    // Fallback - should not happen with proper exit placement
    return 0;
}

/**
 * @brief Determines optimal first direction for Z-corridor based on exit sides
 * @param exit1_side Side of room1 where exit1 is located (0=left, 1=right, 2=top, 3=bottom)
 * @param exit2_side Side of room2 where exit2 is located (0=left, 1=right, 2=top, 3=bottom)
 * @return 1 if should start with X-axis movement, 0 if should start with Y-axis movement
 */
static unsigned char get_optimal_corridor_direction(unsigned char exit1_side, unsigned char exit2_side) {
    // Rule: If starting from horizontal wall (top/bottom), start with vertical movement (Y-axis)
    //       If starting from vertical wall (left/right), start with horizontal movement (X-axis)
    
    if (exit1_side == 2 || exit1_side == 3) {
        // Starting from top or bottom wall (horizontal wall) - start with Y movement
        return 0; // Y-axis first
    } else {
        // Starting from left or right wall (vertical wall) - start with X movement  
        return 1; // X-axis first
    }
}

// Draw a corridor in two straight segments: first along X, then along Y (or vice versa)
static void straight_corridor_path(signed char sx, signed char sy, signed char ex, signed char ey, unsigned char xy_first) {
    signed char x = sx;
    signed char y = sy;
    
    if (xy_first) {
        // Move along X first
        while (x != ex) {
            if (x < ex) x++;
            else x--;
            if (can_place_corridor_tile(x, y)) {
                set_tile_raw(x, y, TILE_FLOOR);
                if (corridor_path_static.length < MAX_PATH_LENGTH) {
                    corridor_path_static.x[corridor_path_static.length] = x;
                    corridor_path_static.y[corridor_path_static.length] = y;
                    corridor_path_static.length++;
                }
            }
        }
        // Then along Y
        while (y != ey) {
            if (y < ey) y++;
            else y--;
            if (can_place_corridor_tile(x, y)) {
                set_tile_raw(x, y, TILE_FLOOR);
                if (corridor_path_static.length < MAX_PATH_LENGTH) {
                    corridor_path_static.x[corridor_path_static.length] = x;
                    corridor_path_static.y[corridor_path_static.length] = y;
                    corridor_path_static.length++;
                }
            }
        }
    } else {
        // Move along Y first
        while (y != ey) {
            if (y < ey) y++;
            else y--;
            if (can_place_corridor_tile(x, y)) {
                set_tile_raw(x, y, TILE_FLOOR);
                if (corridor_path_static.length < MAX_PATH_LENGTH) {
                    corridor_path_static.x[corridor_path_static.length] = x;
                    corridor_path_static.y[corridor_path_static.length] = y;
                    corridor_path_static.length++;
                }
            }
        }
        // Then along X
        while (x != ex) {
            if (x < ex) x++;
            else x--;
            if (can_place_corridor_tile(x, y)) {
                set_tile_raw(x, y, TILE_FLOOR);
                if (corridor_path_static.length < MAX_PATH_LENGTH) {
                    corridor_path_static.x[corridor_path_static.length] = x;
                    corridor_path_static.y[corridor_path_static.length] = y;
                    corridor_path_static.length++;
                }
            }
        }
    }
}

unsigned char draw_corridor(unsigned char room1, unsigned char room2) {
    unsigned char exit1_x, exit1_y, exit2_x, exit2_y;
    unsigned char room1_center_x, room1_center_y, room2_center_x, room2_center_y;
    signed char pivot_x, pivot_y;
    
    get_room_center(room1, &room1_center_x, &room1_center_y);
    get_room_center(room2, &room2_center_x, &room2_center_y);
    find_room_exit(&rooms[room1], room2_center_x, room2_center_y, &exit1_x, &exit1_y);
    find_room_exit(&rooms[room2], room1_center_x, room1_center_y, &exit2_x, &exit2_y);

    // Use static struct for path
    corridor_path_static.length = 0;

    // Calculate distance between exits to determine corridor type
    unsigned char dx = (exit1_x > exit2_x) ? (exit1_x - exit2_x) : (exit2_x - exit1_x);
    unsigned char dy = (exit1_y > exit2_y) ? (exit1_y - exit2_y) : (exit2_y - exit1_y);
    unsigned char total_distance = dx + dy;

    // Determine exit sides for optimal corridor direction
    unsigned char exit1_side = get_exit_side(&rooms[room1], exit1_x, exit1_y);
    unsigned char exit2_side = get_exit_side(&rooms[room2], exit2_x, exit2_y);
    unsigned char start_with_x = get_optimal_corridor_direction(exit1_side, exit2_side);

    // Place corridor tile at the exit tile (room edge) to visually connect corridor to the room
    corridor_endpoint_override = 1;
    set_tile_raw(exit1_x, exit1_y, TILE_FLOOR);
    if (corridor_path_static.length < MAX_PATH_LENGTH) {
        corridor_path_static.x[corridor_path_static.length] = exit1_x;
        corridor_path_static.y[corridor_path_static.length] = exit1_y;
        corridor_path_static.length++;
    }
    corridor_endpoint_override = 0;

    // Short corridor logic: direct path for very close rooms
    if (total_distance <= 4) {
        // Direct L-shaped path for short distances - use optimal direction
        straight_corridor_path(exit1_x, exit1_y, exit2_x, exit2_y, start_with_x);
    } else {
        // Choose a pivot point for Z-shape: midpoint between exits
        pivot_x = (exit1_x + exit2_x) / 2;
        pivot_y = (exit1_y + exit2_y) / 2;

        // First leg: from exit1 to pivot - use optimal direction based on exit side
        straight_corridor_path(exit1_x, exit1_y, pivot_x, pivot_y, start_with_x);
        // Second leg: from pivot to exit2 - use opposite direction for Z-shape
        straight_corridor_path(pivot_x, pivot_y, exit2_x, exit2_y, !start_with_x);
    }

    // Place doors 1 tile closer to the room than the corridor endpoint
    unsigned char door1_x = exit1_x;
    unsigned char door1_y = exit1_y;
    unsigned char door2_x = exit2_x;
    unsigned char door2_y = exit2_y;

    // Determine direction for door1 (room1)
    if (exit1_x == rooms[room1].x - 2) {
        door1_x = rooms[room1].x - 1;
    } else if (exit1_x == rooms[room1].x + rooms[room1].w + 1) {
        door1_x = rooms[room1].x + rooms[room1].w;
    } else if (exit1_y == rooms[room1].y - 2) {
        door1_y = rooms[room1].y - 1;
    } else if (exit1_y == rooms[room1].y + rooms[room1].h + 1) {
        door1_y = rooms[room1].y + rooms[room1].h;
    }

    // Determine direction for door2 (room2)
    if (exit2_x == rooms[room2].x - 2) {
        door2_x = rooms[room2].x - 1;
    } else if (exit2_x == rooms[room2].x + rooms[room2].w + 1) {
        door2_x = rooms[room2].x + rooms[room2].w;
    } else if (exit2_y == rooms[room2].y - 2) {
        door2_y = rooms[room2].y - 1;
    } else if (exit2_y == rooms[room2].y + rooms[room2].h + 1) {
        door2_y = rooms[room2].y + rooms[room2].h;
    }

    place_door(door1_x, door1_y);
    place_door(door2_x, door2_y);

    return 1; // Success
}

// =============================================================================
// ROOM CONNECTION LOGIC WITH DUPLICATE PREVENTION
// =============================================================================

/**
 * @brief Connects two rooms with a corridor while preventing duplicate connections
 * @param room1 First room index
 * @param room2 Second room index
 * @return 1 if connection was made or already exists, 0 if failed
 * 
 * Creates new corridors between rooms. Checks for existing connections and
 * reachability to avoid creating redundant paths between the same room pairs.
 */
unsigned char connect_rooms_directly(unsigned char room1, unsigned char room2) {
    // 1. Validate room distance and positioning rules
    if (!can_connect_rooms_safely(room1, room2)) {
        return 0;
    }
    // 2. Check if connection already exists or was previously attempted
    if (connection_matrix[room1][room2] || attempted_connections[room1][room2]) {
        return 1; // Connection exists or was attempted - avoid duplicates
    }
    // 2.1 Check if rooms are already reachable through indirect paths
    if (is_room_reachable(room1, room2)) {
        // Mark as connected since they are reachable through other rooms
        connection_matrix[room1][room2] = 1;
        connection_matrix[room2][room1] = 1;
        attempted_connections[room1][room2] = 1;
        attempted_connections[room2][room1] = 1;
        return 1; // Rooms are already connected indirectly
    }
    // 3. Reserve connection slots in matrices before corridor creation
    connection_matrix[room1][room2] = 1;
    connection_matrix[room2][room1] = 1;
    attempted_connections[room1][room2] = 1;
    attempted_connections[room2][room1] = 1;
    // 4. Create physical corridor between the rooms
    if (draw_corridor(room1, room2)) {
        return 1; // Corridor successfully created
    }
    // 5. Corridor creation failed - clear connection matrix reservation
    connection_matrix[room1][room2] = 0;
    connection_matrix[room2][room1] = 0;
    // Keep attempted_connections marked to prevent future retry attempts
    
    return 0; // Connection failed
}

// Initializes the rule-based connection system + memory pools
void init_connection_system(void) {
    // Zero out all matrices
    for (unsigned char i = 0; i < MAX_ROOMS; i++) {
        for (unsigned char j = 0; j < MAX_ROOMS; j++) {
            connection_matrix[i][j] = 0;
            attempted_connections[i][j] = 0;
            room_distance_cache[i][j] = 255;
        }
    }
    
    // Initialize memory pools
    corridor_pool.active_count = 0;
    corridor_pool.next_free_index = 0;
    connection_cache.count = 0;
    distance_cache_valid = 0;
    
    // Pre-calculate room distances (cache warming)
    for (unsigned char i = 0; i < room_count && i < MAX_ROOMS; i++) {
        for (unsigned char j = i + 1; j < room_count && j < MAX_ROOMS; j++) {
            room_distance_cache[i][j] = calculate_room_distance(i, j);
            room_distance_cache[j][i] = room_distance_cache[i][j];
        }
    }
    distance_cache_valid = 1;
}

// Checks if two rooms are connected
unsigned char rooms_are_connected(unsigned char room1, unsigned char room2) {
    if (room1 >= room_count || room2 >= room_count) return 0;
    return connection_matrix[room1][room2];
}

// =============================================================================
// DOOR PLACEMENT IMPLEMENTATION
// =============================================================================

// Place a door at (x, y) (assumes caller ensures correct edge/perimeter placement)
void place_door(unsigned char x, unsigned char y) {
    set_tile_raw(x, y, TILE_DOOR);
}

// Place doors at the first and last walkable tiles of the corridor path between two rooms (on the room edge/perimeter)
void place_door_between_rooms(Room *roomA, Room *roomB, CorridorPath *path) {
    // Place door at the first walkable tile of the corridor
    unsigned char start_x = path->x[0];
    unsigned char start_y = path->y[0];
    place_door(start_x, start_y);

    // Place door at the last walkable tile of the corridor
    unsigned char end_x = path->x[path->length - 1];
    unsigned char end_y = path->y[path->length - 1];
    place_door(end_x, end_y);
}

// Place doors along a corridor path (placeholder implementation)
void place_doors_along_corridor(const CorridorPath* path) {
    // This function can be extended if needed for more complex door placement logic
    if (path == 0 || path->length == 0) return;
    
    // For now, just place doors at start and end
    place_door(path->x[0], path->y[0]);
    if (path->length > 1) {
        place_door(path->x[path->length - 1], path->y[path->length - 1]);
    }
}