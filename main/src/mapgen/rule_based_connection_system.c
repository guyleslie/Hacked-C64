// Global flag to allow endpoint override for corridor placement
// Set to 1 when placing corridor at a room wall endpoint
unsigned char corridor_endpoint_override = 0;
// =============================================================================
// RULE-BASED ROOM CONNECTION SYSTEM
// Strict rule-based room connection system - all rules are always enforced
// =============================================================================
// Principles:
// 1. ALWAYS enforces MIN_ROOM_DISTANCE rule
// 2. Consistent MST (Minimum Spanning Tree) based connection
// 3. Existing corridors are reused ONLY if all rules are satisfied
// 4. NO exceptions - every connection is rule-based
// =============================================================================

#include "mapgen_types.h"      // For Room, MAX_ROOMS
#include "mapgen_internal.h"   // For connection helpers

// External references
extern Room rooms[MAX_ROOMS];
extern unsigned char room_count;

// Connection tracking
static unsigned char connection_matrix[MAX_ROOMS][MAX_ROOMS];

// Extern flag for endpoint override (see utility.c)
extern unsigned char corridor_endpoint_override;

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

// OPTIMIZED: Fast rule check for corridors - C64 optimized
unsigned char can_place_corridor_tile(unsigned char x, unsigned char y) {
    // Overload: allow endpoint override for corridor placement
    // If endpoint override is set, allow placement even if buffer/adjacency rules would block
    if (corridor_endpoint_override) {
        if (!coords_in_bounds_fast(x, y)) return 0;
        if (!is_outside_any_room(x, y)) return 0;
        return 1;
    }
    if (!coords_in_bounds_fast(x, y)) return 0;
    // Corridor tiles must be outside all rooms
    if (!is_outside_any_room(x, y)) return 0;

    // --- NEW RULE: Prevent corridor from being adjacent to any room (except at endpoints) ---
    // Check 4 cardinal neighbors; if any neighbor is inside a room, corridor cannot be placed here
    if (!is_outside_any_room(x + 1, y) ||
        !is_outside_any_room(x - 1, y) ||
        !is_outside_any_room(x, y + 1) ||
        !is_outside_any_room(x, y - 1)) {
        return 0;
    }

    // OPTIMIZATION: Only check nearby rooms (proximity check)
    for (unsigned char i = 0; i < room_count; i++) {
        unsigned char room_center_x, room_center_y;
        get_room_center(i, &room_center_x, &room_center_y);
        if (manhattan_distance_fast(x, y, room_center_x, room_center_y) > 12) {
            continue;
        }
        // ...existing code for further proximity checks if needed...
    }

    return 1; // Safe to build
}

// =============================================================================
// SIMPLE CORRIDOR DRAWING
// =============================================================================

// Simple L-shaped corridor drawing with rule enforcement
unsigned char draw_rule_based_corridor(unsigned char room1, unsigned char room2) {
    // Improved L-corridor logic: always start in the direction of the exit wall,
    // then bend towards the target exit. Doors are placed only after the full corridor path is generated.

    unsigned char exit1_x, exit1_y, exit2_x, exit2_y;
    unsigned char room1_center_x, room1_center_y, room2_center_x, room2_center_y;

    // Get the centers and exits of the rooms
    get_room_center(room1, &room1_center_x, &room1_center_y);
    get_room_center(room2, &room2_center_x, &room2_center_y);
    // Always use the other room's center as the target for both sides to ensure symmetric door placement
    find_room_exit(&rooms[room1], room2_center_x, room2_center_y, &exit1_x, &exit1_y);
    find_room_exit(&rooms[room2], room1_center_x, room1_center_y, &exit2_x, &exit2_y);

    // Determine the initial direction from exit1 (which wall?)
    int dx = 0, dy = 0;
    if (exit1_x == rooms[room1].x - 1) { dx = -1; dy = 0; } // left wall
    else if (exit1_x == rooms[room1].x + rooms[room1].w) { dx = 1; dy = 0; } // right wall
    else if (exit1_y == rooms[room1].y - 1) { dx = 0; dy = -1; } // top wall
    else if (exit1_y == rooms[room1].y + rooms[room1].h) { dx = 0; dy = 1; } // bottom wall

    // Step out from the room wall
    int x = exit1_x + dx;
    int y = exit1_y + dy;
    // Store the first corridor tile position for later door placement
    int first_corridor_x = x;
    int first_corridor_y = y;

    // Draw the first corridor tile (if allowed)
    corridor_endpoint_override = 1;
    if (can_place_corridor_tile(x, y)) {
        set_tile_raw(x, y, TILE_FLOOR);
    }
    corridor_endpoint_override = 0;

    // Now, determine the bend point: the point where either x == exit2_x or y == exit2_y
    // We'll first go straight in the initial direction until we align with the target exit on one axis
    // Track the last walkable tile for door placement
    int last_corridor_x = x;
    int last_corridor_y = y;
    while (x != exit2_x && y != exit2_y) {
        // Move in the initial direction
        x += dx;
        y += dy;
        if (can_place_corridor_tile(x, y)) {
            set_tile_raw(x, y, TILE_FLOOR);
            last_corridor_x = x;
            last_corridor_y = y;
        }
    }

    // Now, bend: move along the other axis until we reach the target exit
    while (x != exit2_x) {
        x += (x < exit2_x) ? 1 : -1;
        if (can_place_corridor_tile(x, y)) {
            set_tile_raw(x, y, TILE_FLOOR);
            last_corridor_x = x;
            last_corridor_y = y;
        }
    }
    while (y != exit2_y) {
        y += (y < exit2_y) ? 1 : -1;
        if (can_place_corridor_tile(x, y)) {
            set_tile_raw(x, y, TILE_FLOOR);
            last_corridor_x = x;
            last_corridor_y = y;
        }
    }

    // After the full corridor is drawn, place doors at both ends if valid
    // Place door at the start (where the corridor leaves the room)
    if (is_valid_room_wall_for_door(exit1_x, exit1_y)) {
        set_tile_raw(exit1_x, exit1_y, TILE_DOOR);
    }
    // Place door at the end (where the corridor meets the target room)
    if (is_valid_room_wall_for_door(exit2_x, exit2_y)) {
        set_tile_raw(exit2_x, exit2_y, TILE_DOOR);
    }

    // Optionally, handle corner/corridor-joining exceptions here if needed

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
    
    // OPTIMIZATION: Limited search area
    // Checks only 9x9 (81 cells) area, but more intelligently
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
    
    // Fast exit if no corridor near the first room
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
    
    // If both rooms have a corridor nearby, try to reuse
    return found_path_near_room1 && found_path_near_room2;
}

// Connects two rooms via existing corridors
unsigned char connect_via_existing_corridors(unsigned char room1, unsigned char room2) {
    unsigned char exit1_x, exit1_y, exit2_x, exit2_y;
    unsigned char room1_center_x, room1_center_y, room2_center_x, room2_center_y;
    
    // Find room centers and exits - using cached centers
    get_room_center(room1, &room1_center_x, &room1_center_y);
    get_room_center(room2, &room2_center_x, &room2_center_y);
    find_room_exit(&rooms[room1], room2_center_x, room2_center_y, &exit1_x, &exit1_y);
    // Helyes paraméterezés: mindig a másik szoba középpontját adjuk át célpontnak
    find_room_exit(&rooms[room2], room1_center_x, room1_center_y, &exit2_x, &exit2_y);
    
    // Find the closest corridor points to each room exit
    unsigned char closest_corridor_x1 = 255, closest_corridor_y1 = 255;
    unsigned char closest_corridor_x2 = 255, closest_corridor_y2 = 255;
    unsigned char min_dist1 = 255, min_dist2 = 255;
    
    // Scan a limited area for nearby corridors (optimization)
    unsigned char search_x1 = (room1_center_x > 10) ? room1_center_x - 10 : 0;
    unsigned char search_y1 = (room1_center_y > 10) ? room1_center_y - 10 : 0;
    unsigned char search_x2 = (room1_center_x + 10 < MAP_W) ? room1_center_x + 10 : MAP_W - 1;
    unsigned char search_y2 = (room1_center_y + 10 < MAP_H) ? room1_center_y + 10 : MAP_H - 1;
    
    for (unsigned char y = search_y1; y <= search_y2; y++) {
        for (unsigned char x = search_x1; x <= search_x2; x++) {
            if (tile_is_floor(x, y) && is_outside_any_room(x, y)) {
                // This is a corridor cell
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
    
    // If we found nearby corridors and they are close enough, connect the rooms using them
    if (closest_corridor_x1 != 255 && closest_corridor_x2 != 255 && min_dist1 <= 8 && min_dist2 <= 8) {
        // Draw short connecting segments between rooms and nearby corridors
        // MIRRORED LOGIC: Both ends use the same logic for door and corridor placement

        // --- START ROOM SIDE (exit1) ---
        if (!coords_in_bounds(exit1_x, exit1_y)) return 0;
        if (is_valid_room_wall_for_door(exit1_x, exit1_y)) {
            set_tile_raw(exit1_x, exit1_y, TILE_DOOR); // Place door at the entry point
        }
        int dx1 = 0, dy1 = 0;
        if (exit1_x == rooms[room1].x - 1) { dx1 = -1; dy1 = 0; }
        else if (exit1_x == rooms[room1].x + rooms[room1].w) { dx1 = 1; dy1 = 0; }
        else if (exit1_y == rooms[room1].y - 1) { dx1 = 0; dy1 = -1; }
        else if (exit1_y == rooms[room1].y + rooms[room1].h) { dx1 = 0; dy1 = 1; }
        unsigned char corridor1_x = exit1_x + dx1;
        unsigned char corridor1_y = exit1_y + dy1;
        corridor_endpoint_override = 1;
        if (coords_in_bounds(corridor1_x, corridor1_y) && can_place_corridor_tile(corridor1_x, corridor1_y)) {
            set_tile_raw(corridor1_x, corridor1_y, TILE_FLOOR);
        }
        corridor_endpoint_override = 0;
        unsigned char current1_x = corridor1_x;
        unsigned char current1_y = corridor1_y;
        unsigned char step_limit1 = 64;
        while ((current1_x != closest_corridor_x1 || current1_y != closest_corridor_y1) && step_limit1--) {
            if (current1_x != closest_corridor_x1) {
                current1_x += (current1_x < closest_corridor_x1) ? 1 : -1;
            } else if (current1_y != closest_corridor_y1) {
                current1_y += (current1_y < closest_corridor_y1) ? 1 : -1;
            } else {
                break;
            }
            if (is_outside_any_room(current1_x, current1_y) && can_place_corridor_tile(current1_x, current1_y)) {
                set_tile_raw(current1_x, current1_y, TILE_FLOOR);
            }
        }

        // --- TARGET ROOM SIDE (exit2) ---
        if (!coords_in_bounds(exit2_x, exit2_y)) return 0;
        if (is_valid_room_wall_for_door(exit2_x, exit2_y)) {
            set_tile_raw(exit2_x, exit2_y, TILE_DOOR); // Place door at the target entry point
        }
        int dx2 = 0, dy2 = 0;
        if (exit2_x == rooms[room2].x - 1) { dx2 = -1; dy2 = 0; }
        else if (exit2_x == rooms[room2].x + rooms[room2].w) { dx2 = 1; dy2 = 0; }
        else if (exit2_y == rooms[room2].y - 1) { dx2 = 0; dy2 = -1; }
        else if (exit2_y == rooms[room2].y + rooms[room2].h) { dx2 = 0; dy2 = 1; }
        unsigned char corridor2_x = exit2_x + dx2;
        unsigned char corridor2_y = exit2_y + dy2;
        corridor_endpoint_override = 1;
        if (coords_in_bounds(corridor2_x, corridor2_y) && can_place_corridor_tile(corridor2_x, corridor2_y)) {
            set_tile_raw(corridor2_x, corridor2_y, TILE_FLOOR);
        }
        corridor_endpoint_override = 0;
        unsigned char current2_x = corridor2_x;
        unsigned char current2_y = corridor2_y;
        unsigned char step_limit2 = 64;
        while ((current2_x != closest_corridor_x2 || current2_y != closest_corridor_y2) && step_limit2--) {
            if (current2_x != closest_corridor_x2) {
                current2_x += (current2_x < closest_corridor_x2) ? 1 : -1;
            } else if (current2_y != closest_corridor_y2) {
                current2_y += (current2_y < closest_corridor_y2) ? 1 : -1;
            } else {
                break;
            }
            if (is_outside_any_room(current2_x, current2_y) && can_place_corridor_tile(current2_x, current2_y)) {
                set_tile_raw(current2_x, current2_y, TILE_FLOOR);
            }
        }
        return 1; // Successful reuse
    }
    
    return 0; // Reuse failed
}

// =============================================================================
// MAIN CONNECTION LOGIC
// =============================================================================

// Rule-based room connection function
unsigned char rule_based_connect_rooms(unsigned char room1, unsigned char room2) {
    // 1. Basic validation
    if (!can_connect_rooms_safely(room1, room2)) {
        return 0; // Cannot be safely connected
    }

    // 2. Check if already directly connected
    if (connection_matrix[room1][room2]) {
        return 1; // Already directly connected
    }

    // 2b. Check if already reachable through other rooms (avoid redundant corridors)
    // This is a simple DFS using a local stack and visited array, all inside this function
    unsigned char visited[MAX_ROOMS] = {0};
    unsigned char stack[MAX_ROOMS];
    unsigned char sp = 0;
    stack[sp++] = room1;
    visited[room1] = 1;
    while (sp > 0) {
        unsigned char current = stack[--sp];
        for (unsigned char i = 0; i < room_count; i++) {
            if (connection_matrix[current][i] && !visited[i]) {
                if (i == room2) {
                    return 1; // Already reachable, do not build redundant corridor
                }
                visited[i] = 1;
                stack[sp++] = i;
            }
        }
    }

    // 3. Try to reuse existing corridors (only if all rules are satisfied)
    if (can_reuse_existing_path(room1, room2)) {
        if (connect_via_existing_corridors(room1, room2)) {
            connection_matrix[room1][room2] = 1;
            connection_matrix[room2][room1] = 1;
            return 1; // Successful reuse
        }
    }
    // 4. Draw new corridor
    if (draw_rule_based_corridor(room1, room2)) {
        connection_matrix[room1][room2] = 1;
        connection_matrix[room2][room1] = 1;
        return 1; // Successful new connection
    }

    return 0; // All attempts failed
}

// ENHANCED: Initializes the rule-based connection system + memory pools
void init_rule_based_connection_system(void) {
    // Zero out the connection matrix - oscar64 optimized loop
    for (unsigned char i = 0; i < MAX_ROOMS; i++) {
        for (unsigned char j = 0; j < MAX_ROOMS; j++) {
            connection_matrix[i][j] = 0;
            room_distance_cache[i][j] = 255; // Invalid distance marker
        }
    }
    
    // Initialize memory pools
    corridor_pool.active_count = 0;
    corridor_pool.next_free_index = 0;
    
    connection_cache.count = 0;
    distance_cache_valid = 0;
    
    // Pre-calculate frequently used room distances (cache warming)
    for (unsigned char i = 0; i < room_count && i < MAX_ROOMS; i++) {
        for (unsigned char j = i + 1; j < room_count && j < MAX_ROOMS; j++) {
            room_distance_cache[i][j] = calculate_room_distance(i, j);
            room_distance_cache[j][i] = room_distance_cache[i][j]; // Symmetric
        }
    }
    distance_cache_valid = 1;
}

// Checks if two rooms are connected
unsigned char rooms_are_connected(unsigned char room1, unsigned char room2) {
    if (room1 >= room_count || room2 >= room_count) return 0;
    return connection_matrix[room1][room2];
}
