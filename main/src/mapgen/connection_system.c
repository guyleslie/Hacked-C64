// =============================================================================
// RULE-BASED ROOM CONNECTION SYSTEM
// Room connection system with corridor types and alignment detection
// =============================================================================
// Features:
// 1. Enforces MIN_ROOM_DISTANCE rule between rooms
// 2. Uses connection matrix to track room relationships
// 3. Validates all connections against placement rules
// 4. Prevents duplicate connections through matrix tracking
// 5. Avoids multiple corridors between same room pairs
// 6. Creates new corridors for each connection request
// 7. CORRIDOR TYPES:
//    - STRAIGHT CORRIDORS: When rooms have overlapping projections on X or Y axis
//      * Exit points placed at center of overlapping region, facing each other
//      * Single straight line connection (horizontal or vertical only)
//    - L-SHAPED CORRIDORS: For diagonal connections without axis overlap
//      * Two perpendicular segments connecting room corners
//      * Starting legs extend from each room toward the other's general direction
//      * First segment: extends from room 1 in direction toward room 2
//      * Second segment: reaches room 2 from opposite direction
//      * Exit points placed 1 tile away from room walkable perimeter
//      * For diagonal rooms: corners facing target room
//    - Z-SHAPED CORRIDORS: For complex diagonal connections (longer distances)
//      * Three segments: starting legs + perpendicular connector
//      * Starting legs: Extend from each room toward the other's general direction
//      * First segment: extends from room 1 in direction toward room 2
//      * Middle segment: connects perpendicular to room orientation
//      * Final segment: reaches room 2 from opposite direction
//      * More natural-looking paths for distant room connections
// 8. EXIT POINT PLACEMENT: Always 1 tile away from room walkable perimeter
// 9. DOOR PLACEMENT: Always 1 tile from room walkable perimeter (toward corridor)
// 10. CORRIDOR DECISION LOGIC:
//     - Check axis alignment: If rooms share horizontal or vertical projection
//       → Use STRAIGHT CORRIDOR only (no Z-shaped for aligned rooms)
//     - Check diagonal positioning: If no axis alignment 
//       → Use L-SHAPED or Z-SHAPED based on room distance and obstacles
//       → Short distance (≤4): Prefer L-shaped
//       → Long distance (>8): Prefer Z-shaped  
//       → Medium distance (5-8): Check obstacles, random selection if both viable
//     - Mixed case (diagonal with partial alignment): Random selection for variety
// 11. Z-CORRIDOR DIRECTION: First leg direction based on exit wall type
//     - Horizontal walls (top/bottom): Start with vertical movement
//     - Vertical walls (left/right): Start with horizontal movement
//     This avoids corridors running parallel to room walls
// =============================================================================

#include "mapgen_types.h"      // For Room, MAX_ROOMS 
#include "mapgen_globals.h"    // For global variable declarations
#include "mapgen_internal.h"   // For connection helpers and door placement functions
#include "mapgen_utils.h"      // For utility functions

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
// STATIC MEMORY ALLOCATION
// =============================================================================

// Static memory pools to avoid dynamic allocation overhead
static CorridorPool corridor_pool = {0};
static ConnectionCache connection_cache = {0};

// Cached room distance calculations for performance
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
// DISTANCE CALCULATION WITH CACHING
// =============================================================================

// Cache-aware distance calculation
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

// Check if a corridor path would intersect any rooms other than source/destination
unsigned char path_intersects_other_rooms(unsigned char start_x, unsigned char start_y, 
                                         unsigned char end_x, unsigned char end_y,
                                         unsigned char source_room, unsigned char dest_room) {
    signed char x = start_x;
    signed char y = start_y;
    
    // Check every point along the path
    while (x != end_x || y != end_y) {
        // Move one step towards destination
        if (x < end_x) x++;
        else if (x > end_x) x--;
        
        if (y < end_y) y++;
        else if (y > end_y) y--;
        
        // Check if this point is inside any room other than source/destination
        for (unsigned char i = 0; i < room_count; i++) {
            if (i == source_room || i == dest_room) continue; // Skip source/dest rooms
            
            // Check if point is inside room i (including buffer zone)
            if (x >= rooms[i].x && x < rooms[i].x + rooms[i].w &&
                y >= rooms[i].y && y < rooms[i].y + rooms[i].h) {
                return 1; // Path intersects another room
            }
        }
    }
    
    return 0; // Path is clear
}

// Check if L-shaped path between two points avoids room intersections
unsigned char l_path_avoids_rooms(unsigned char sx, unsigned char sy, unsigned char ex, unsigned char ey,
                                 unsigned char source_room, unsigned char dest_room, unsigned char xy_first) {
    signed char pivot_x, pivot_y;
    
    if (xy_first) {
        // X-first path: (sx,sy) -> (ex,sy) -> (ex,ey)
        pivot_x = ex;
        pivot_y = sy;
    } else {
        // Y-first path: (sx,sy) -> (sx,ey) -> (ex,ey)
        pivot_x = sx;
        pivot_y = ey;
    }
    
    // Check first leg
    if (path_intersects_other_rooms(sx, sy, pivot_x, pivot_y, source_room, dest_room)) {
        return 0;
    }
    
    // Check second leg
    if (path_intersects_other_rooms(pivot_x, pivot_y, ex, ey, source_room, dest_room)) {
        return 0;
    }
    
    return 1; // Both legs are clear
}

// Cache-aware rule check between two rooms
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

// Forward declarations for static helper functions
static void straight_corridor_path(signed char sx, signed char sy, signed char ex, signed char ey, unsigned char xy_first);
static unsigned char get_exit_side(Room *room, unsigned char exit_x, unsigned char exit_y);

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
 * @brief Check if two rooms have overlapping projections on X or Y axis for straight corridors
 * @param room1 First room index
 * @param room2 Second room index
 * @param has_horizontal_overlap Pointer to store horizontal overlap result
 * @param has_vertical_overlap Pointer to store vertical overlap result
 */
static void check_room_axis_alignment(unsigned char room1, unsigned char room2, 
                                    unsigned char *has_horizontal_overlap, 
                                    unsigned char *has_vertical_overlap) {
    Room *r1 = &rooms[room1];
    Room *r2 = &rooms[room2];
    
    // Check horizontal (X-axis) overlap - rooms share same Y range
    *has_horizontal_overlap = !(r1->y + r1->h <= r2->y || r2->y + r2->h <= r1->y);
    
    // Check vertical (Y-axis) overlap - rooms share same X range  
    *has_vertical_overlap = !(r1->x + r1->w <= r2->x || r2->x + r2->w <= r1->x);
}

/**
 * @brief Find optimal exit points for straight corridor between aligned rooms
 * @param room1 First room index
 * @param room2 Second room index
 * @param horizontal_aligned 1 if horizontally aligned, 0 if vertically aligned
 * @param exit1_x Pointer to store room1 exit X coordinate
 * @param exit1_y Pointer to store room1 exit Y coordinate
 * @param exit2_x Pointer to store room2 exit X coordinate
 * @param exit2_y Pointer to store room2 exit Y coordinate
 */
static void find_straight_corridor_exits(unsigned char room1, unsigned char room2, 
                                       unsigned char horizontal_aligned,
                                       unsigned char *exit1_x, unsigned char *exit1_y,
                                       unsigned char *exit2_x, unsigned char *exit2_y) {
    Room *r1 = &rooms[room1];
    Room *r2 = &rooms[room2];
    
    if (horizontal_aligned) {
        // Horizontally aligned - find overlapping Y range and place exits facing each other
        unsigned char overlap_start = (r1->y > r2->y) ? r1->y : r2->y;
        unsigned char overlap_end = ((r1->y + r1->h) < (r2->y + r2->h)) ? (r1->y + r1->h) : (r2->y + r2->h);
        unsigned char center_y = overlap_start + (overlap_end - overlap_start) / 2;
        
        // Determine which room is left/right
        if (r1->x + r1->w < r2->x) {
            // Room1 is left, Room2 is right
            *exit1_x = r1->x + r1->w + 1;  // 2 tiles from room1 right edge
            *exit1_y = center_y;
            *exit2_x = r2->x - 2;          // 2 tiles from room2 left edge
            *exit2_y = center_y;
        } else {
            // Room2 is left, Room1 is right
            *exit1_x = r1->x - 2;          // 2 tiles from room1 left edge
            *exit1_y = center_y;
            *exit2_x = r2->x + r2->w + 1;  // 2 tiles from room2 right edge
            *exit2_y = center_y;
        }
    } else {
        // Vertically aligned - find overlapping X range and place exits facing each other
        unsigned char overlap_start = (r1->x > r2->x) ? r1->x : r2->x;
        unsigned char overlap_end = ((r1->x + r1->w) < (r2->x + r2->w)) ? (r1->x + r1->w) : (r2->x + r2->w);
        unsigned char center_x = overlap_start + (overlap_end - overlap_start) / 2;
        
        // Determine which room is top/bottom
        if (r1->y + r1->h < r2->y) {
            // Room1 is top, Room2 is bottom
            *exit1_x = center_x;
            *exit1_y = r1->y + r1->h + 1;  // 2 tiles from room1 bottom edge
            *exit2_x = center_x;
            *exit2_y = r2->y - 2;          // 2 tiles from room2 top edge
        } else {
            // Room2 is top, Room1 is bottom
            *exit1_x = center_x;
            *exit1_y = r1->y - 2;          // 2 tiles from room1 top edge
            *exit2_x = center_x;
            *exit2_y = r2->y + r2->h + 1;  // 2 tiles from room2 bottom edge
        }
    }
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

/**
 * @brief Place doors for straight corridor connections (1 tile from room perimeter)
 * @param room1 First room index
 * @param room2 Second room index
 * @param exit1_x First exit X coordinate
 * @param exit1_y First exit Y coordinate
 * @param exit2_x Second exit X coordinate
 * @param exit2_y Second exit Y coordinate
 */
static void place_doors_for_straight_corridor(unsigned char room1, unsigned char room2,
                                            unsigned char exit1_x, unsigned char exit1_y,
                                            unsigned char exit2_x, unsigned char exit2_y) {
    Room *r1 = &rooms[room1];
    Room *r2 = &rooms[room2];
    
    // For straight corridors, doors are placed 1 tile from room perimeter
    // toward the corridor direction
    
    // Door for room1
    unsigned char door1_x = exit1_x;
    unsigned char door1_y = exit1_y;
    
    // Determine door1 position based on exit location relative to room1
    if (exit1_x == r1->x + r1->w + 1) {
        // Exit is 2 tiles right of room, door is 1 tile right
        door1_x = r1->x + r1->w;
    } else if (exit1_x == r1->x - 2) {
        // Exit is 2 tiles left of room, door is 1 tile left
        door1_x = r1->x - 1;
    } else if (exit1_y == r1->y + r1->h + 1) {
        // Exit is 2 tiles below room, door is 1 tile below
        door1_y = r1->y + r1->h;
    } else if (exit1_y == r1->y - 2) {
        // Exit is 2 tiles above room, door is 1 tile above
        door1_y = r1->y - 1;
    }
    
    // Door for room2
    unsigned char door2_x = exit2_x;
    unsigned char door2_y = exit2_y;
    
    // Determine door2 position based on exit location relative to room2
    if (exit2_x == r2->x + r2->w + 1) {
        // Exit is 2 tiles right of room, door is 1 tile right
        door2_x = r2->x + r2->w;
    } else if (exit2_x == r2->x - 2) {
        // Exit is 2 tiles left of room, door is 1 tile left
        door2_x = r2->x - 1;
    } else if (exit2_y == r2->y + r2->h + 1) {
        // Exit is 2 tiles below room, door is 1 tile below
        door2_y = r2->y + r2->h;
    } else if (exit2_y == r2->y - 2) {
        // Exit is 2 tiles above room, door is 1 tile above
        door2_y = r2->y - 1;
    }
    
    place_door(door1_x, door1_y);
    place_door(door2_x, door2_y);
}

/**
 * @brief Place doors for diagonal corridor connections (1 tile from room perimeter)
 * @param room1 First room index
 * @param room2 Second room index
 * @param exit1_x First exit X coordinate
 * @param exit1_y First exit Y coordinate
 * @param exit2_x Second exit X coordinate
 * @param exit2_y Second exit Y coordinate
 */
static void place_doors_for_diagonal_corridor(unsigned char room1, unsigned char room2,
                                            unsigned char exit1_x, unsigned char exit1_y,
                                            unsigned char exit2_x, unsigned char exit2_y) {
    // Same logic as straight corridors - doors are always 1 tile from room perimeter
    place_doors_for_straight_corridor(room1, room2, exit1_x, exit1_y, exit2_x, exit2_y);
}

/**
 * @brief Draw a straight corridor between two exit points (horizontal or vertical only)
 * @param exit1_x First exit X coordinate
 * @param exit1_y First exit Y coordinate
 * @param exit2_x Second exit X coordinate
 * @param exit2_y Second exit Y coordinate
 * @return 1 if corridor was drawn successfully, 0 otherwise
 */
static unsigned char draw_straight_corridor(unsigned char exit1_x, unsigned char exit1_y,
                                          unsigned char exit2_x, unsigned char exit2_y) {
    signed char x = exit1_x;
    signed char y = exit1_y;
    
    // Validate that this is actually a straight line (horizontal or vertical)
    if (exit1_x != exit2_x && exit1_y != exit2_y) {
        return 0; // Not a straight line
    }
    
    // Draw the straight line
    while (x != exit2_x || y != exit2_y) {
        // Place corridor tile if position is valid
        if (can_place_corridor_tile(x, y)) {
            set_tile_raw(x, y, TILE_FLOOR);
            if (corridor_path_static.length < MAX_PATH_LENGTH) {
                corridor_path_static.x[corridor_path_static.length] = x;
                corridor_path_static.y[corridor_path_static.length] = y;
                corridor_path_static.length++;
            }
        }
        
        // Move one step towards destination
        if (x < exit2_x) x++;
        else if (x > exit2_x) x--;
        
        if (y < exit2_y) y++;
        else if (y > exit2_y) y--;
    }
    
    return 1; // Success
}

/**
 * @brief Create a Z-shaped corridor with three segments
 * @param exit1_x First exit X coordinate
 * @param exit1_y First exit Y coordinate
 * @param exit2_x Second exit X coordinate
 * @param exit2_y Second exit Y coordinate
 * @param start_with_x 1 to start with X movement, 0 to start with Y movement
 * @return 1 if corridor was drawn successfully, 0 otherwise
 */
static unsigned char draw_z_corridor(unsigned char exit1_x, unsigned char exit1_y,
                                   unsigned char exit2_x, unsigned char exit2_y,
                                   unsigned char start_with_x) {
    signed char leg1_end_x, leg1_end_y;
    signed char leg2_end_x, leg2_end_y;
    
    // Calculate Z-corridor segments
    unsigned char dx = (exit1_x > exit2_x) ? (exit1_x - exit2_x) : (exit2_x - exit1_x);
    unsigned char dy = (exit1_y > exit2_y) ? (exit1_y - exit2_y) : (exit2_y - exit1_y);
    
    if (start_with_x) {
        // X-first Z-corridor: horizontal -> vertical -> horizontal
        unsigned char leg_length = dx / 3 + 1; // First leg length
        
        if (exit2_x > exit1_x) {
            leg1_end_x = exit1_x + leg_length;
        } else {
            leg1_end_x = exit1_x - leg_length;
        }
        leg1_end_y = exit1_y;
        
        // Second leg end (vertical connector)
        leg2_end_x = leg1_end_x;
        leg2_end_y = exit2_y;
        
        // Draw three segments
        straight_corridor_path(exit1_x, exit1_y, leg1_end_x, leg1_end_y, 1); // Horizontal
        straight_corridor_path(leg1_end_x, leg1_end_y, leg2_end_x, leg2_end_y, 0); // Vertical
        straight_corridor_path(leg2_end_x, leg2_end_y, exit2_x, exit2_y, 1); // Horizontal
    } else {
        // Y-first Z-corridor: vertical -> horizontal -> vertical
        unsigned char leg_length = dy / 3 + 1; // First leg length
        
        if (exit2_y > exit1_y) {
            leg1_end_y = exit1_y + leg_length;
        } else {
            leg1_end_y = exit1_y - leg_length;
        }
        leg1_end_x = exit1_x;
        
        // Second leg end (horizontal connector)
        leg2_end_x = exit2_x;
        leg2_end_y = leg1_end_y;
        
        // Draw three segments
        straight_corridor_path(exit1_x, exit1_y, leg1_end_x, leg1_end_y, 0); // Vertical
        straight_corridor_path(leg1_end_x, leg1_end_y, leg2_end_x, leg2_end_y, 1); // Horizontal  
        straight_corridor_path(leg2_end_x, leg2_end_y, exit2_x, exit2_y, 0); // Vertical
    }
    
    return 1; // Success
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
    unsigned char has_horizontal_overlap, has_vertical_overlap;
    unsigned char corridor_type = 0; // 0=L-shaped, 1=straight, 2=Z-shaped
    
    // Reset corridor path
    corridor_path_static.length = 0;
    
    // Check axis alignment between rooms for straight corridor possibility
    check_room_axis_alignment(room1, room2, &has_horizontal_overlap, &has_vertical_overlap);
    
    // Decision logic for corridor type
    if (has_horizontal_overlap || has_vertical_overlap) {
        // Rooms are aligned - use only straight corridors (no Z-shaped for aligned rooms)
        corridor_type = 1; // Always use straight corridor for aligned rooms
        
        if (has_horizontal_overlap) {
            // Horizontally aligned rooms
            find_straight_corridor_exits(room1, room2, 1, &exit1_x, &exit1_y, &exit2_x, &exit2_y);
        } else {
            // Vertically aligned rooms
            find_straight_corridor_exits(room1, room2, 0, &exit1_x, &exit1_y, &exit2_x, &exit2_y);
        }
        
        // Check if straight corridor path is clear
        if (!path_intersects_other_rooms(exit1_x, exit1_y, exit2_x, exit2_y, room1, room2)) {
            // Place corridor tiles at exit points first
            corridor_endpoint_override = 1;
            set_tile_raw(exit1_x, exit1_y, TILE_FLOOR);
            if (corridor_path_static.length < MAX_PATH_LENGTH) {
                corridor_path_static.x[corridor_path_static.length] = exit1_x;
                corridor_path_static.y[corridor_path_static.length] = exit1_y;
                corridor_path_static.length++;
            }
            set_tile_raw(exit2_x, exit2_y, TILE_FLOOR);
            if (corridor_path_static.length < MAX_PATH_LENGTH) {
                corridor_path_static.x[corridor_path_static.length] = exit2_x;
                corridor_path_static.y[corridor_path_static.length] = exit2_y;
                corridor_path_static.length++;
            }
            corridor_endpoint_override = 0;
            
            // Draw straight corridor
            if (draw_straight_corridor(exit1_x, exit1_y, exit2_x, exit2_y)) {
                // Place doors 1 tile closer to rooms
                place_doors_for_straight_corridor(room1, room2, exit1_x, exit1_y, exit2_x, exit2_y);
                return 1;
            }
        }
        
        // If straight corridor failed for aligned rooms, fall through to diagonal logic
        corridor_type = 0;
    }
    
    // No axis alignment or aligned corridor failed - use diagonal corridors (L-shaped or Z-shaped)
    if (corridor_type == 0) {
        // Use existing room center-based exit finding for diagonal connections
        unsigned char room1_center_x, room1_center_y, room2_center_x, room2_center_y;
        
        get_room_center(room1, &room1_center_x, &room1_center_y);
        get_room_center(room2, &room2_center_x, &room2_center_y);
        find_room_exit(&rooms[room1], room2_center_x, room2_center_y, &exit1_x, &exit1_y);
        find_room_exit(&rooms[room2], room1_center_x, room1_center_y, &exit2_x, &exit2_y);
        
        // Calculate distance to determine L-shaped vs Z-shaped preference
        unsigned char dx = (exit1_x > exit2_x) ? (exit1_x - exit2_x) : (exit2_x - exit1_x);
        unsigned char dy = (exit1_y > exit2_y) ? (exit1_y - exit2_y) : (exit2_y - exit1_y);
        unsigned char total_distance = dx + dy;
        
        // Determine exit sides for optimal corridor direction
        unsigned char exit1_side = get_exit_side(&rooms[room1], exit1_x, exit1_y);
        unsigned char exit2_side = get_exit_side(&rooms[room2], exit2_x, exit2_y);
        unsigned char start_with_x = get_optimal_corridor_direction(exit1_side, exit2_side);
        
        // Check path viability for L-shaped corridor - try both directions
        unsigned char l_path_clear = 0;
        unsigned char l_use_x_first = start_with_x;
        
        if (l_path_avoids_rooms(exit1_x, exit1_y, exit2_x, exit2_y, room1, room2, start_with_x)) {
            l_path_clear = 1;
            l_use_x_first = start_with_x;
        } else if (l_path_avoids_rooms(exit1_x, exit1_y, exit2_x, exit2_y, room1, room2, !start_with_x)) {
            l_path_clear = 1;
            l_use_x_first = !start_with_x;
        }
        
        // Decision logic for corridor type based on distance and obstacles
        unsigned char use_z_corridor = 0;
        
        if (total_distance > 8) {
            // Long distance - prefer Z-shaped corridor for more natural paths
            use_z_corridor = 1;
        } else if (total_distance <= 4) {
            // Short distance - prefer L-shaped corridor  
            use_z_corridor = 0;
        } else {
            // Medium distance (5-8) - check for obstacles
            if (!l_path_clear) {
                // L-shaped path blocked - try Z-shaped
                use_z_corridor = 1;
            } else {
                // Both possible - randomly choose for variety
                use_z_corridor = rnd(2); // 0 or 1
            }
        }
        
        // Try chosen corridor type first
        if (use_z_corridor) {
            // Try Z-shaped corridor first
            corridor_endpoint_override = 1;
            set_tile_raw(exit1_x, exit1_y, TILE_FLOOR);
            if (corridor_path_static.length < MAX_PATH_LENGTH) {
                corridor_path_static.x[corridor_path_static.length] = exit1_x;
                corridor_path_static.y[corridor_path_static.length] = exit1_y;
                corridor_path_static.length++;
            }
            corridor_endpoint_override = 0;
            
            if (draw_z_corridor(exit1_x, exit1_y, exit2_x, exit2_y, l_use_x_first)) {
                place_doors_for_diagonal_corridor(room1, room2, exit1_x, exit1_y, exit2_x, exit2_y);
                return 1;
            }
            
            // Z-shaped failed, try L-shaped if path is clear
            if (l_path_clear) {
                corridor_path_static.length = 0; // Reset path
                corridor_endpoint_override = 1;
                set_tile_raw(exit1_x, exit1_y, TILE_FLOOR);
                if (corridor_path_static.length < MAX_PATH_LENGTH) {
                    corridor_path_static.x[corridor_path_static.length] = exit1_x;
                    corridor_path_static.y[corridor_path_static.length] = exit1_y;
                    corridor_path_static.length++;
                }
                corridor_endpoint_override = 0;
                
                straight_corridor_path(exit1_x, exit1_y, exit2_x, exit2_y, l_use_x_first);
                place_doors_for_diagonal_corridor(room1, room2, exit1_x, exit1_y, exit2_x, exit2_y);
                return 1;
            }
        } else {
            // Try L-shaped corridor first
            if (!l_path_clear) {
                return 0; // Cannot create L-shaped corridor without intersecting other rooms
            }
            
            corridor_endpoint_override = 1;
            set_tile_raw(exit1_x, exit1_y, TILE_FLOOR);
            if (corridor_path_static.length < MAX_PATH_LENGTH) {
                corridor_path_static.x[corridor_path_static.length] = exit1_x;
                corridor_path_static.y[corridor_path_static.length] = exit1_y;
                corridor_path_static.length++;
            }
            corridor_endpoint_override = 0;
            
            straight_corridor_path(exit1_x, exit1_y, exit2_x, exit2_y, l_use_x_first);
            place_doors_for_diagonal_corridor(room1, room2, exit1_x, exit1_y, exit2_x, exit2_y);
            return 1;
        }
        
        return 0; // All corridor types failed
    }
    
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

// Initialize connection system and memory pools
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