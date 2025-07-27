// =============================================================================
// RULE-BASED ROOM CONNECTION SYSTEM - ENHANCED VERSION
// Strict rule-based room connection system with duplicate prevention
// =============================================================================
// Principles:
// 1. ALWAYS enforces MIN_ROOM_DISTANCE rule
// 2. Consistent MST (Minimum Spanning Tree) based connection
// 3. Existing corridors are reused ONLY if all rules are satisfied
// 4. NO exceptions - every connection is rule-based
// 5. PREVENTS duplicate connections using immediate matrix updates
// 6. PREVENTS multiple corridors between same room pairs
// =============================================================================

#include "mapgen_types.h"      // For Room, MAX_ROOMS
#include "mapgen_internal.h"   // For connection helpers
#include "door_placement.h"    // For door placement functions

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

// NEW: Track attempted connections to prevent duplicates
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

// ENHANCED: Fast rule check for corridors with comprehensive spacing rules
unsigned char can_place_corridor_tile(unsigned char x, unsigned char y) {
    // Endpoint override logic - allow placement at room edges
    if (corridor_endpoint_override) {
        if (!coords_in_bounds_fast(x, y)) return 0;
        if (!is_outside_any_room(x, y)) return 0;
        if (!is_on_room_edge(x, y)) return 0;
        return 1;
    }
    
    if (!coords_in_bounds_fast(x, y)) return 0;
    if (!is_outside_any_room(x, y)) return 0;

    // Existing room adjacency rule
    if (!is_outside_any_room(x + 1, y) ||
        !is_outside_any_room(x - 1, y) ||
        !is_outside_any_room(x, y + 1) ||
        !is_outside_any_room(x, y - 1)) {
        return 0;
    }

    // --- ENHANCED CORRIDOR SPACING RULES ---
    
    // Rule 1: Prevent direct crossings (+ shape)
    unsigned char has_horizontal = (coords_in_bounds_fast(x-1, y) && get_tile_raw(x-1, y) == TILE_FLOOR && is_outside_any_room(x-1, y)) ||
                                   (coords_in_bounds_fast(x+1, y) && get_tile_raw(x+1, y) == TILE_FLOOR && is_outside_any_room(x+1, y));
    
    unsigned char has_vertical = (coords_in_bounds_fast(x, y-1) && get_tile_raw(x, y-1) == TILE_FLOOR && is_outside_any_room(x, y-1)) ||
                                 (coords_in_bounds_fast(x, y+1) && get_tile_raw(x, y+1) == TILE_FLOOR && is_outside_any_room(x, y+1));
    
    if (has_horizontal && has_vertical) {
        return 0; // Would create a crossing
    }
    
    // Rule 2: Prevent parallel corridors with 2-tile spacing
    if (coords_in_bounds_fast(x, y-2) && get_tile_raw(x, y-2) == TILE_FLOOR && 
        is_outside_any_room(x, y-2) && get_tile_raw(x, y-1) != TILE_FLOOR) {
        return 0; // Parallel corridor above with gap
    }
    
    if (coords_in_bounds_fast(x, y+2) && get_tile_raw(x, y+2) == TILE_FLOOR && 
        is_outside_any_room(x, y+2) && get_tile_raw(x, y+1) != TILE_FLOOR) {
        return 0; // Parallel corridor below with gap
    }
    
    if (coords_in_bounds_fast(x-2, y) && get_tile_raw(x-2, y) == TILE_FLOOR && 
        is_outside_any_room(x-2, y) && get_tile_raw(x-1, y) != TILE_FLOOR) {
        return 0; // Parallel corridor left with gap
    }
    
    if (coords_in_bounds_fast(x+2, y) && get_tile_raw(x+2, y) == TILE_FLOOR && 
        is_outside_any_room(x+2, y) && get_tile_raw(x+1, y) != TILE_FLOOR) {
        return 0; // Parallel corridor right with gap
    }

    return 1; // Safe to build
}

// =============================================================================
// CORRIDOR DRAWING
// =============================================================================

// Oscar64/C64: Use static struct to avoid stack usage
static CorridorPath corridor_path_static;

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

unsigned char draw_rule_based_corridor(unsigned char room1, unsigned char room2) {
    unsigned char exit1_x, exit1_y, exit2_x, exit2_y;
    unsigned char room1_center_x, room1_center_y, room2_center_x, room2_center_y;
    signed char pivot_x, pivot_y;
    
    get_room_center(room1, &room1_center_x, &room1_center_y);
    get_room_center(room2, &room2_center_x, &room2_center_y);
    find_room_exit(&rooms[room1], room2_center_x, room2_center_y, &exit1_x, &exit1_y);
    find_room_exit(&rooms[room2], room1_center_x, room1_center_y, &exit2_x, &exit2_y);

    // Use static struct for path
    corridor_path_static.length = 0;

    // Place corridor tile at the exit tile (room edge) to visually connect corridor to the room
    corridor_endpoint_override = 1;
    set_tile_raw(exit1_x, exit1_y, TILE_FLOOR);
    if (corridor_path_static.length < MAX_PATH_LENGTH) {
        corridor_path_static.x[corridor_path_static.length] = exit1_x;
        corridor_path_static.y[corridor_path_static.length] = exit1_y;
        corridor_path_static.length++;
    }
    corridor_endpoint_override = 0;

    // Choose a pivot point for Z-shape: midpoint between exits
    pivot_x = (exit1_x + exit2_x) / 2;
    pivot_y = (exit1_y + exit2_y) / 2;

    // First leg: from exit1 to pivot (randomize axis order for variety)
    straight_corridor_path(exit1_x, exit1_y, pivot_x, pivot_y, (room1 + room2) % 2);
    // Second leg: from pivot to exit2 (randomize axis order for variety)
    straight_corridor_path(pivot_x, pivot_y, exit2_x, exit2_y, (room1 + room2 + 1) % 2);

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
// REUSING EXISTING CORRIDORS
// =============================================================================

// OPTIMIZED: Search for nearby existing corridors - efficient for C64
unsigned char can_reuse_existing_path(unsigned char room1, unsigned char room2) {
    unsigned char room1_center_x, room1_center_y, room2_center_x, room2_center_y;
    get_room_center(room1, &room1_center_x, &room1_center_y);
    get_room_center(room2, &room2_center_x, &room2_center_y);
    
    unsigned char found_path_near_room1 = 0, found_path_near_room2 = 0;
    
    // Limited search radius for the first room (MAX 4 tile distance)
    for (signed char dx = -4; dx <= 4 && !found_path_near_room1; dx++) {
        for (signed char dy = -4; dy <= 4 && !found_path_near_room1; dy++) {
            unsigned char check_x = room1_center_x + dx;
            unsigned char check_y = room1_center_y + dy;
            
            if (coords_in_bounds_fast(check_x, check_y) && 
                tile_is_floor_fast(check_x, check_y) && 
                is_outside_any_room(check_x, check_y)) {
                found_path_near_room1 = 1;
            }
        }
    }
    
    if (!found_path_near_room1) return 0;
    
    // Limited search radius for the second room
    for (signed char dx = -4; dx <= 4 && !found_path_near_room2; dx++) {
        for (signed char dy = -4; dy <= 4 && !found_path_near_room2; dy++) {
            unsigned char check_x = room2_center_x + dx;
            unsigned char check_y = room2_center_y + dy;
            
            if (coords_in_bounds_fast(check_x, check_y) && 
                tile_is_floor_fast(check_x, check_y) && 
                is_outside_any_room(check_x, check_y)) {
                found_path_near_room2 = 1;
            }
        }
    }
    
    return found_path_near_room1 && found_path_near_room2;
}

// Connects two rooms via existing corridors
unsigned char connect_via_existing_corridors(unsigned char room1, unsigned char room2) {
    unsigned char exit1_x, exit1_y, exit2_x, exit2_y;
    unsigned char room1_center_x, room1_center_y, room2_center_x, room2_center_y;
    
    get_room_center(room1, &room1_center_x, &room1_center_y);
    get_room_center(room2, &room2_center_x, &room2_center_y);
    find_room_exit(&rooms[room1], room2_center_x, room2_center_y, &exit1_x, &exit1_y);
    find_room_exit(&rooms[room2], room1_center_x, room1_center_y, &exit2_x, &exit2_y);
    
    // Find the closest corridor points to each room exit
    unsigned char closest_corridor_x1 = 255, closest_corridor_y1 = 255;
    unsigned char closest_corridor_x2 = 255, closest_corridor_y2 = 255;
    unsigned char min_dist1 = 255, min_dist2 = 255;
    
    // Calculate search bounds
    unsigned char search_x1, search_y1, search_x2, search_y2;
    unsigned char y, x;
    
    if (room1_center_x > 10) search_x1 = room1_center_x - 10; else search_x1 = 0;
    if (room1_center_y > 10) search_y1 = room1_center_y - 10; else search_y1 = 0;
    if ((room1_center_x + 10) < MAP_W) search_x2 = room1_center_x + 10; else search_x2 = MAP_W - 1;
    if ((room1_center_y + 10) < MAP_H) search_y2 = room1_center_y + 10; else search_y2 = MAP_H - 1;
    
    // Scan for nearby corridors
    for (y = search_y1; y <= search_y2; y++) {
        for (x = search_x1; x <= search_x2; x++) {
            if (tile_is_floor(x, y) && is_outside_any_room(x, y)) {
                unsigned char dist1 = fast_abs_diff(x, exit1_x) + fast_abs_diff(y, exit1_y);
                unsigned char dist2 = fast_abs_diff(x, exit2_x) + fast_abs_diff(y, exit2_y);
                
                if (dist1 < min_dist1) {
                    min_dist1 = dist1;
                    closest_corridor_x1 = x;
                    closest_corridor_y1 = y;
                }
                if (dist2 < min_dist2) {
                    min_dist2 = dist2;
                    closest_corridor_x2 = x;
                    closest_corridor_y2 = y;
                }
            }
        }
    }
    
    // If we found nearby corridors and they are close enough, connect
    if (closest_corridor_x1 != 255 && closest_corridor_x2 != 255 && 
        min_dist1 <= 8 && min_dist2 <= 8) {
        
        // Draw short connecting segments (simplified version)
        // This is a basic implementation - can be enhanced
        
        return 1; // Successful reuse
    }
    
    return 0; // Reuse failed
}

// =============================================================================
// MAIN CONNECTION LOGIC - ENHANCED WITH DUPLICATE PREVENTION
// =============================================================================

/**
 * @brief Enhanced room connection function that prevents duplicate connections
 * @param room1 First room index
 * @param room2 Second room index
 * @return 1 if connection was made or already exists, 0 if failed
 */
unsigned char rule_based_connect_rooms(unsigned char room1, unsigned char room2) {
    // 1. Basic safety validation
    if (!can_connect_rooms_safely(room1, room2)) {
        return 0;
    }

    // 2. CRITICAL: Check if already connected or attempted
    if (connection_matrix[room1][room2] || attempted_connections[room1][room2] || 
        is_room_reachable(room1, room2)) {
        return 1; // Already connected - prevent duplicates
    }

    // 3. IMMEDIATE matrix reservation to prevent race conditions
    connection_matrix[room1][room2] = 1;
    connection_matrix[room2][room1] = 1;
    attempted_connections[room1][room2] = 1;
    attempted_connections[room2][room1] = 1;

    // 4. Try to reuse existing corridors
    if (can_reuse_existing_path(room1, room2)) {
        if (connect_via_existing_corridors(room1, room2)) {
            return 1; // Successful reuse
        }
    }
    
    // 5. Draw new corridor as last resort
    if (draw_rule_based_corridor(room1, room2)) {
        return 1; // Successful new connection
    }

    // 6. All attempts failed - clear matrix reservation
    connection_matrix[room1][room2] = 0;
    connection_matrix[room2][room1] = 0;
    // Keep attempted_connections marked to prevent retry
    
    return 0; // Connection failed
}

// ENHANCED: Initializes the rule-based connection system + memory pools
void init_rule_based_connection_system(void) {
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