// =============================================================================
// ROOM CONNECTION SYSTEM
// MST-based room connectivity with corridor generation
// =============================================================================

#include "mapgen_types.h"      // For Room, MAX_ROOMS 
#include "mapgen_internal.h"   // For connection helpers, door placement functions, and global variable declarations
#include "mapgen_utils.h"      // For utility functions

// Static arrays for C64 compatibility
static unsigned char visited_global[MAX_ROOMS];
static unsigned char stack_global[MAX_ROOMS];

// Connection tracking
static unsigned char connection_matrix[MAX_ROOMS][MAX_ROOMS];

// Track attempted connections to prevent duplicates
static unsigned char attempted_connections[MAX_ROOMS][MAX_ROOMS];

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
    unsigned char i;  // C64 optimization
    unsigned char sp = 0; // Stack pointer - C64 optimization
    
    // Initialize visited array
    for (i = 0; i < room_count; i++) {
        visited_global[i] = 0;
    }
    
    // Start DFS from room1
    stack_global[sp++] = room1;
    visited_global[room1] = 1;
    
    // DFS traversal
    while (sp > 0) {
        unsigned char current = stack_global[--sp];  // C64 optimization
        
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
// BASE RULE CHECKS
// =============================================================================

// BOUNDING BOX PRE-FILTERING
// Eliminates expensive detailed path checking for non-overlapping bounds
#pragma optimize(push)
#pragma optimize(3, speed, inline, constparams) // Maximum optimization for critical function

// Helper function for detailed intersection (when bounding box check passes)
static unsigned char detailed_path_room_intersection(unsigned char start_x, unsigned char start_y,
                                                   unsigned char end_x, unsigned char end_y,
                                                   unsigned char room_index) {
    signed char x = start_x;
    signed char y = start_y;
    
    while (x != end_x || y != end_y) {
        // Move one step towards destination
        if (x < end_x) x++;
        else if (x > end_x) x--;
        
        if (y < end_y) y++;
        else if (y > end_y) y--;
        
        // Check if point intersects room buffer zone with overflow protection
        unsigned char room_min_x = (rooms[room_index].x > 0) ? rooms[room_index].x - 1 : 0;
        unsigned char room_max_x = (rooms[room_index].x < 255 - rooms[room_index].w - 1) ? 
                                   rooms[room_index].x + rooms[room_index].w + 1 : 255;
        unsigned char room_min_y = (rooms[room_index].y > 0) ? rooms[room_index].y - 1 : 0;
        unsigned char room_max_y = (rooms[room_index].y < 255 - rooms[room_index].h - 1) ?
                                   rooms[room_index].y + rooms[room_index].h + 1 : 255;
        
        if (x >= room_min_x && x <= room_max_x &&
            y >= room_min_y && y <= room_max_y) {
            return 1; // Path intersects room's buffer zone
        }
    }
    return 0;
}

// Check if a corridor path would intersect any rooms other than source/destination
unsigned char path_intersects_other_rooms(unsigned char start_x, unsigned char start_y, 
                                         unsigned char end_x, unsigned char end_y,
                                         unsigned char source_room, unsigned char dest_room) {
    // Oscar64 Range Analysis hints for optimal code generation
    __assume(start_x < MAP_W);
    __assume(start_y < MAP_H);
    __assume(end_x < MAP_W);
    __assume(end_y < MAP_H);
    __assume(source_room < room_count);
    __assume(dest_room < room_count);
    
    unsigned char i; // Oscar64 loop register optimization
    
    // Pre-compute path bounding box using local variables (faster than array access on 6502)
    // Oscar64 Strength Reduction optimizes min/max operations
    unsigned char path_min_x = (start_x < end_x) ? start_x : end_x;
    unsigned char path_max_x = (start_x > end_x) ? start_x : end_x;
    unsigned char path_min_y = (start_y < end_y) ? start_y : end_y;
    unsigned char path_max_y = (start_y > end_y) ? start_y : end_y;
    
    // Oscar64 optimizes this loop with register allocation and range analysis  
    for (i = 0; i < room_count; i++) {
        if (i == source_room || i == dest_room) continue;
        
        // Oscar64 Common Subexpression Elimination optimizes repeated room access
        unsigned char room_x = rooms[i].x; // Cache in register
        unsigned char room_y = rooms[i].y;
        unsigned char room_w = rooms[i].w;
        unsigned char room_h = rooms[i].h;
        
        // Compute room buffer bounds with overflow protection - Oscar64 Value Forwarding optimizes
        unsigned char room_min_x = (room_x > 0) ? room_x - 1 : 0;
        unsigned char room_max_x = (room_x < 255 - room_w - 1) ? room_x + room_w + 1 : 255;
        unsigned char room_min_y = (room_y > 0) ? room_y - 1 : 0;
        unsigned char room_max_y = (room_y < 255 - room_h - 1) ? room_y + room_h + 1 : 255;
        
        // Quick bounding box overlap test - Oscar64 Branch Optimization
        if (path_max_x >= room_min_x && path_min_x <= room_max_x &&
            path_max_y >= room_min_y && path_min_y <= room_max_y) {
            
            // Potential intersection - only now do expensive detailed check
            if (detailed_path_room_intersection(start_x, start_y, end_x, end_y, i)) {
                return 1;
            }
        }
        // Else: No bounding box overlap - skip expensive detailed check entirely
    }
    return 0; // Path is clear
}

#pragma optimize(pop)

// Check if L-shaped path between two points avoids room intersections
unsigned char l_path_avoids_rooms(unsigned char sx, unsigned char sy, unsigned char ex, unsigned char ey,
                                 unsigned char source_room, unsigned char dest_room, unsigned char xy_first) {
    signed char pivot_x, pivot_y;  // C64 optimization
    
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

// Safety check for room connections
unsigned char can_connect_rooms_safely(unsigned char room1, unsigned char room2) {
    if (room1 >= room_count || room2 >= room_count || room1 == room2) {
        return 0;
    }
    
    // Dynamic distance check based on room count and map size
    unsigned char max_distance = get_max_connection_distance();
    unsigned char distance = get_cached_room_distance(room1, room2);
    if (distance > max_distance) {
        return 0; // Too far apart for reasonable corridor
    }
    
    return 1; // Safe to connect
}

// Rule check for corridors with basic placement rules
unsigned char can_place_corridor(unsigned char x, unsigned char y) {
    if (!is_within_map_bounds(x, y)) return 0;
    if (!is_outside_any_room(x, y)) return 0;

    return 1; // Safe to build - validation handled by path intersection checks
}

// =============================================================================
// CORRIDOR DRAWING
// =============================================================================

// Static corridor path for C64 compatibility
static CorridorPath corridor_path_static;

// =============================================================================
// STATIC HELPER FUNCTIONS (defined before use to avoid forward declarations)
// =============================================================================

/**
 * @brief Determine which wall side a door position is on relative to a room
 * @param door_x Door X coordinate
 * @param door_y Door Y coordinate  
 * @param room Pointer to the room
 * @return Wall side: 0=left, 1=right, 2=top, 3=bottom
 */
static unsigned char get_wall_side_from_position(unsigned char door_x, unsigned char door_y, Room *room) {
    if (door_x < room->x) return 0; // Left
    else if (door_x >= room->x + room->w) return 1; // Right
    else if (door_y < room->y) return 2; // Top
    else return 3; // Bottom
}

// Helper function to adjust exit coordinates to align with existing doors
static void adjust_exit_to_existing_door(unsigned char room_idx, unsigned char side, 
                                         unsigned char *exit_x, unsigned char *exit_y) {
    unsigned char existing_door_x, existing_door_y;
    if (find_existing_door_on_room_side(room_idx, side, *exit_x, *exit_y, &existing_door_x, &existing_door_y)) {
        switch (side) {
            case 0: *exit_y = existing_door_y; *exit_x = existing_door_x - 1; break;
            case 1: *exit_y = existing_door_y; *exit_x = existing_door_x + 1; break;
            case 2: *exit_x = existing_door_x; *exit_y = existing_door_y - 1; break;
            case 3: *exit_x = existing_door_x; *exit_y = existing_door_y + 1; break;
        }
    }
}

// Draw a corridor in two straight segments: first along X, then along Y (or vice versa)
static void straight_corridor_path(signed char sx, signed char sy, signed char ex, signed char ey, unsigned char xy_first) {
    signed char x = sx;  // C64 optimization: use for loop variables
    signed char y = sy;
    
    if (xy_first) {
        // Move along X first
        while (x != ex) {
            if (x < ex) x++;
            else x--;
            if (can_place_corridor(x, y)) {
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
            if (can_place_corridor(x, y)) {
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
            if (can_place_corridor(x, y)) {
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
            if (can_place_corridor(x, y)) {
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
 * @brief Find optimal door positions for L-shaped corridor between diagonal rooms
 * Returns door coordinates (1 tile from room perimeter) on diagonally opposite sides
 * Geometry-aware door reuse - checks for existing doors only on geometrically correct sides
 * This ensures corridor geometry rules are maintained (L-corridors use perpendicular walls)
 * @param room1 First room index
 * @param room2 Second room index
 * @param exit1_x Pointer to store room1 door X coordinate
 * @param exit1_y Pointer to store room1 door Y coordinate
 * @param exit2_x Pointer to store room2 door X coordinate
 * @param exit2_y Pointer to store room2 door Y coordinate
 * @param room1_wall_side Pointer to store room1 wall side information
 * @param room2_wall_side Pointer to store room2 wall side information
 */
static void find_l_corridor_exits(unsigned char room1, unsigned char room2,
                                 unsigned char *exit1_x, unsigned char *exit1_y,
                                 unsigned char *exit2_x, unsigned char *exit2_y,
                                 unsigned char *room1_wall_side, unsigned char *room2_wall_side) {
    Room *r1 = &rooms[room1];
    Room *r2 = &rooms[room2];
    
    // Calculate room centers to determine relative position
    unsigned char r1_center_x = r1->x + r1->w / 2;
    unsigned char r1_center_y = r1->y + r1->h / 2;
    unsigned char r2_center_x = r2->x + r2->w / 2;
    unsigned char r2_center_y = r2->y + r2->h / 2;
    
    // Determine relative positions and choose opposite sides
    unsigned char room1_exit_side, room2_exit_side;
    
    // Choose complementary sides for L-shaped connection
    if (r2_center_x > r1_center_x && r2_center_y > r1_center_y) {
        // Room2 is bottom-right of Room1
        room1_exit_side = 1; // Room1 exits from right side
        room2_exit_side = 2; // Room2 exits from top side
    } else if (r2_center_x < r1_center_x && r2_center_y > r1_center_y) {
        // Room2 is bottom-left of Room1
        room1_exit_side = 3; // Room1 exits from bottom side
        room2_exit_side = 1; // Room2 exits from right side
    } else if (r2_center_x > r1_center_x && r2_center_y < r1_center_y) {
        // Room2 is top-right of Room1
        room1_exit_side = 2; // Room1 exits from top side
        room2_exit_side = 0; // Room2 exits from left side
    } else {
        // Room2 is top-left of Room1
        room1_exit_side = 0; // Room1 exits from left side
        room2_exit_side = 3; // Room2 exits from bottom side
    }
    
    // Calculate door coordinates (1 tile from room perimeter)
    switch (room1_exit_side) {
        case 0: // Left side - door 1 tile from room
            *exit1_x = r1->x - 1;
            *exit1_y = r1->y + r1->h / 2; // Center of left wall
            break;
        case 1: // Right side - door 1 tile from room
            *exit1_x = r1->x + r1->w;
            *exit1_y = r1->y + r1->h / 2; // Center of right wall
            break;
        case 2: // Top side - door 1 tile from room
            *exit1_x = r1->x + r1->w / 2; // Center of top wall
            *exit1_y = r1->y - 1;
            break;
        case 3: // Bottom side - door 1 tile from room
            *exit1_x = r1->x + r1->w / 2; // Center of bottom wall
            *exit1_y = r1->y + r1->h;
            break;
    }
    
    // Geometry-aware door reuse: check for existing door on room1's geometrically correct side only
    // This prevents creating duplicate doors while maintaining proper L-corridor geometry
    unsigned char existing_door_x, existing_door_y;
    if (find_existing_door_on_room_side(room1, room1_exit_side, *exit1_x, *exit1_y, &existing_door_x, &existing_door_y)) {
        // Use existing door coordinates directly (maintains geometric consistency)
        *exit1_x = existing_door_x;
        *exit1_y = existing_door_y;
    }
    
    switch (room2_exit_side) {
        case 0: // Left side - door 1 tile from room
            *exit2_x = r2->x - 1;
            *exit2_y = r2->y + r2->h / 2; // Center of left wall
            break;
        case 1: // Right side - door 1 tile from room
            *exit2_x = r2->x + r2->w;
            *exit2_y = r2->y + r2->h / 2; // Center of right wall
            break;
        case 2: // Top side - door 1 tile from room
            *exit2_x = r2->x + r2->w / 2; // Center of top wall
            *exit2_y = r2->y - 1;
            break;
        case 3: // Bottom side - door 1 tile from room
            *exit2_x = r2->x + r2->w / 2; // Center of bottom wall
            *exit2_y = r2->y + r2->h;
            break;
    }
    
    // Geometry-aware door reuse: check for existing door on room2's geometrically correct side only
    if (find_existing_door_on_room_side(room2, room2_exit_side, *exit2_x, *exit2_y, &existing_door_x, &existing_door_y)) {
        // Use existing door coordinates directly (maintains geometric consistency)
        *exit2_x = existing_door_x;
        *exit2_y = existing_door_y;
    }
    
    // Return wall_side information to caller
    *room1_wall_side = room1_exit_side;
    *room2_wall_side = room2_exit_side;
}

/**
 * @brief Draw L-shaped corridor where two straight lines meet at intersection
 * L-SHAPED CORRIDOR LOGIC: Two perpendicular segments meeting at intersection
 * - Movement direction based on room layout: facing walls connect naturally
 * - Each room sends straight line toward the other, meeting at optimal intersection
 * 
 * @param exit1_x First exit X coordinate
 * @param exit1_y First exit Y coordinate
 * @param exit2_x Second exit X coordinate
 * @param exit2_y Second exit Y coordinate
 * @param exit1_side Side of room1 where exit1 is located (0=left, 1=right, 2=top, 3=bottom)
 * @param exit2_side Side of room2 where exit2 is located (0=left, 1=right, 2=top, 3=bottom)
 */
static void draw_l_corridor(unsigned char exit1_x, unsigned char exit1_y,
                               unsigned char exit2_x, unsigned char exit2_y,
                               unsigned char exit1_side, unsigned char exit2_side) {
    signed char intersection_x, intersection_y;
    
    // L-SHAPED CORRIDOR LOGIC: Each door must start in its wall's perpendicular direction
    // Calculate intersection point ensuring proper directional flow from both doors
    
    // Calculate intermediate points based on wall directions
    unsigned char corridor1_x = exit1_x, corridor1_y = exit1_y;
    unsigned char corridor2_x = exit2_x, corridor2_y = exit2_y;
    
    // Move from door1 in its wall's perpendicular direction
    switch (exit1_side) {
        case 0: corridor1_x = exit1_x - 1; break; // Left wall -> go left
        case 1: corridor1_x = exit1_x + 1; break; // Right wall -> go right  
        case 2: corridor1_y = exit1_y - 1; break; // Top wall -> go up
        case 3: corridor1_y = exit1_y + 1; break; // Bottom wall -> go down
    }
    
    // Move from door2 in its wall's perpendicular direction
    switch (exit2_side) {
        case 0: corridor2_x = exit2_x - 1; break; // Left wall -> go left
        case 1: corridor2_x = exit2_x + 1; break; // Right wall -> go right
        case 2: corridor2_y = exit2_y - 1; break; // Top wall -> go up  
        case 3: corridor2_y = exit2_y + 1; break; // Bottom wall -> go down
    }
    
    // Calculate intersection point for L-shape
    if ((exit1_side == 0 || exit1_side == 1) && (exit2_side == 2 || exit2_side == 3)) {
        // Room1 vertical exit, Room2 horizontal exit
        intersection_x = corridor2_x;
        intersection_y = corridor1_y;
    } else if ((exit1_side == 2 || exit1_side == 3) && (exit2_side == 0 || exit2_side == 1)) {
        // Room1 horizontal exit, Room2 vertical exit
        intersection_x = corridor1_x;
        intersection_y = corridor2_y;
    } else {
        // Both exits same type - create balanced L-shape
        intersection_x = (corridor1_x + corridor2_x) / 2;
        intersection_y = (corridor1_y + corridor2_y) / 2;
    }
    
    // Draw three segments: door1->corridor1->intersection->corridor2->door2
    straight_corridor_path(exit1_x, exit1_y, corridor1_x, corridor1_y, 
                          (exit1_side == 0 || exit1_side == 1) ? 1 : 0);
    straight_corridor_path(corridor1_x, corridor1_y, intersection_x, intersection_y, 
                          (corridor1_x != intersection_x) ? 1 : 0);
    straight_corridor_path(intersection_x, intersection_y, corridor2_x, corridor2_y,
                          (intersection_x != corridor2_x) ? 1 : 0);
    straight_corridor_path(corridor2_x, corridor2_y, exit2_x, exit2_y,
                          (exit2_side == 0 || exit2_side == 1) ? 1 : 0);
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
 * Places doors on facing walls for direct connection
 */
static void find_straight_corridor_exits(unsigned char room1, unsigned char room2, 
                                       unsigned char horizontal_aligned,
                                       unsigned char *exit1_x, unsigned char *exit1_y,
                                       unsigned char *exit2_x, unsigned char *exit2_y) {
    Room *r1 = &rooms[room1];
    Room *r2 = &rooms[room2];
    
    if (horizontal_aligned) {
        // Horizontally aligned - place doors on facing vertical walls
        unsigned char overlap_start = (r1->y > r2->y) ? r1->y : r2->y;
        unsigned char overlap_end = ((r1->y + r1->h) < (r2->y + r2->h)) ? (r1->y + r1->h) : (r2->y + r2->h);
        unsigned char center_y = overlap_start + (overlap_end - overlap_start) / 2;
        
        if (r1->x + r1->w < r2->x) {
            // Room1 is left, Room2 is right
            *exit1_x = r1->x + r1->w;  // Door at room1 right edge
            *exit1_y = center_y;
            *exit2_x = r2->x - 1;      // Door at room2 left edge  
            *exit2_y = center_y;
        } else {
            // Room2 is left, Room1 is right
            *exit1_x = r1->x - 1;      // Door at room1 left edge
            *exit1_y = center_y;
            *exit2_x = r2->x + r2->w;  // Door at room2 right edge
            *exit2_y = center_y;
        }
    } else {
        // Vertically aligned - place doors on facing horizontal walls
        unsigned char overlap_start = (r1->x > r2->x) ? r1->x : r2->x;
        unsigned char overlap_end = ((r1->x + r1->w) < (r2->x + r2->w)) ? (r1->x + r1->w) : (r2->x + r2->w);
        unsigned char center_x = overlap_start + (overlap_end - overlap_start) / 2;
        
        if (r1->y + r1->h < r2->y) {
            // Room1 is top, Room2 is bottom
            *exit1_x = center_x;
            *exit1_y = r1->y + r1->h;  // Door at room1 bottom edge
            *exit2_x = center_x;
            *exit2_y = r2->y - 1;      // Door at room2 top edge
        } else {
            // Room2 is top, Room1 is bottom
            *exit1_x = center_x;
            *exit1_y = r1->y - 1;      // Door at room1 top edge
            *exit2_x = center_x;
            *exit2_y = r2->y + r2->h;  // Door at room2 bottom edge
        }
    }
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
        if (can_place_corridor(x, y)) {
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
 * Z-SHAPED CORRIDOR LOGIC: Three segments for complex diagonal connections
 * - Starting legs extend from each room in direction that avoids running parallel to room walls
 * - Rule: Horizontal walls (top/bottom) → start with vertical movement
 *         Vertical walls (left/right) → start with horizontal movement
 * - Middle segment connects perpendicular to starting direction
 * 
 * @param exit1_x First exit X coordinate
 * @param exit1_y First exit Y coordinate
 * @param exit2_x Second exit X coordinate
 * @param exit2_y Second exit Y coordinate
 * @param start_with_x 1 to start with X movement, 0 to start with Y movement (based on exit wall type)
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
        // Z-CORRIDOR X-FIRST: horizontal → vertical → horizontal
        // Used when starting from vertical wall (left/right exit)
        unsigned char leg_length = dx / 3 + 1; // First leg length (1/3 of total distance)
        
        // First leg: horizontal movement away from room wall
        if (exit2_x > exit1_x) {
            leg1_end_x = exit1_x + leg_length;
        } else {
            leg1_end_x = exit1_x - leg_length;
        }
        leg1_end_y = exit1_y;
        
        // Second leg end: vertical connector to destination Y level
        leg2_end_x = leg1_end_x;
        leg2_end_y = exit2_y;
        
        // Draw three Z-segments
        straight_corridor_path(exit1_x, exit1_y, leg1_end_x, leg1_end_y, 1); // Horizontal away from wall
        straight_corridor_path(leg1_end_x, leg1_end_y, leg2_end_x, leg2_end_y, 0); // Vertical connector
        straight_corridor_path(leg2_end_x, leg2_end_y, exit2_x, exit2_y, 1); // Horizontal to destination
        
    } else {
        // Z-CORRIDOR Y-FIRST: vertical → horizontal → vertical
        // Used when starting from horizontal wall (top/bottom exit)
        unsigned char leg_length = dy / 3 + 1; // First leg length (1/3 of total distance)
        
        // First leg: vertical movement away from room wall
        if (exit2_y > exit1_y) {
            leg1_end_y = exit1_y + leg_length;
        } else {
            leg1_end_y = exit1_y - leg_length;
        }
        leg1_end_x = exit1_x;
        
        // Second leg end: horizontal connector to destination X level
        leg2_end_x = exit2_x;
        leg2_end_y = leg1_end_y;
        
        // Draw three Z-segments
        straight_corridor_path(exit1_x, exit1_y, leg1_end_x, leg1_end_y, 0); // Vertical away from wall
        straight_corridor_path(leg1_end_x, leg1_end_y, leg2_end_x, leg2_end_y, 1); // Horizontal connector
        straight_corridor_path(leg2_end_x, leg2_end_y, exit2_x, exit2_y, 0); // Vertical to destination
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
    // 2. Check if connection already exists
    if (connection_matrix[room1][room2]) {
        return 1; // Connection already exists
    }
    // 2.1 Check attempted connections to avoid duplicates
    if (attempted_connections[room1][room2]) {
        return 1; // Was attempted - avoid duplicates
    }
    // 2.2 Check if rooms are already reachable through indirect paths
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

// MST algorithm - find closest unconnected room pair
unsigned char find_best_connection(unsigned char *connected, unsigned char *best_room1, unsigned char *best_room2) {
    unsigned char i, j;
    unsigned char min_distance = 255;
    unsigned char found = 0;
    
    // Simple O(n²) search for minimum distance edge
    for (i = 0; i < room_count; i++) {
        if (!connected[i]) continue; // Only connected rooms as sources
        
        for (j = 0; j < room_count; j++) {
            if (connected[j] || i == j) continue; // Skip connected/self
            
            unsigned char distance = get_cached_room_distance(i, j);
            if (distance < min_distance) {
                min_distance = distance;
                *best_room1 = i;
                *best_room2 = j;
                found = 1;
            }
        }
    }
    
    return found;
}

// Initialize connection system and memory pools
void init_connection_system(void) {
    // Zero out all matrices
    for (unsigned char i = 0; i < MAX_ROOMS; i++) {  // C64 optimization
        for (unsigned char j = 0; j < MAX_ROOMS; j++) {  // C64 optimization
            connection_matrix[i][j] = 0;
            attempted_connections[i][j] = 0;
        }
    }
    
    // Initialize room distance cache (defined in mapgen_utils.c)
    init_room_distance_cache();
}

// Checks if two rooms are connected
unsigned char rooms_are_connected(unsigned char room1, unsigned char room2) {
    if (room1 >= room_count || room2 >= room_count) return 0;
    return connection_matrix[room1][room2];
}

// =============================================================================
// DOOR PLACEMENT IMPLEMENTATION  
// =============================================================================

/**
 * @brief Find existing door on a room side that's closest to target coordinates
 * @param room_idx Room index to check
 * @param side Side of room: 0=left, 1=right, 2=top, 3=bottom
 * @param target_x Target X coordinate to find closest door to
 * @param target_y Target Y coordinate to find closest door to
 * @param door_x Pointer to store door X coordinate if found
 * @param door_y Pointer to store door Y coordinate if found
 * @return 1 if door found on specified side, 0 otherwise
 */
unsigned char find_existing_door_on_room_side(unsigned char room_idx, unsigned char side,
                                                  unsigned char target_x, unsigned char target_y,
                                                  unsigned char *door_x, unsigned char *door_y) {
    if (room_idx >= room_count) return 0;
    
    Room *room = &rooms[room_idx];
    unsigned char x, y;
    unsigned char best_door_x = 0, best_door_y = 0;
    unsigned char found_door = 0;
    unsigned char best_distance = 255;
    
    switch (side) {
        case 0: // Left side - check tiles 1 position left of room
            x = room->x - 1;
            for (y = room->y; y < room->y + room->h; y++) {
                if (tile_is_door(x, y)) {
                    unsigned char distance = abs_diff(y, target_y);
                    if (!found_door || distance < best_distance) {
                        best_door_x = x;
                        best_door_y = y;
                        best_distance = distance;
                        found_door = 1;
                    }
                }
            }
            break;
            
        case 1: // Right side - check tiles 1 position right of room
            x = room->x + room->w;
            for (y = room->y; y < room->y + room->h; y++) {
                if (tile_is_door(x, y)) {
                    unsigned char distance = abs_diff(y, target_y);
                    if (!found_door || distance < best_distance) {
                        best_door_x = x;
                        best_door_y = y;
                        best_distance = distance;
                        found_door = 1;
                    }
                }
            }
            break;
            
        case 2: // Top side - check tiles 1 position above room
            y = room->y - 1;
            for (x = room->x; x < room->x + room->w; x++) {
                if (tile_is_door(x, y)) {
                    unsigned char distance = abs_diff(x, target_x);
                    if (!found_door || distance < best_distance) {
                        best_door_x = x;
                        best_door_y = y;
                        best_distance = distance;
                        found_door = 1;
                    }
                }
            }
            break;
            
        case 3: // Bottom side - check tiles 1 position below room
            y = room->y + room->h;
            for (x = room->x; x < room->x + room->w; x++) {
                if (tile_is_door(x, y)) {
                    unsigned char distance = abs_diff(x, target_x);
                    if (!found_door || distance < best_distance) {
                        best_door_x = x;
                        best_door_y = y;
                        best_distance = distance;
                        found_door = 1;
                    }
                }
            }
            break;
    }
    
    if (found_door) {
        *door_x = best_door_x;
        *door_y = best_door_y;
        return 1;
    }
    
    return 0; // No door found on specified side
}

// Place a door at (x, y) if there isn't already one there (assumes caller ensures correct edge/perimeter placement)
void place_door(unsigned char x, unsigned char y) {
    // Only place door if position doesn't already have one
    if (!tile_is_door(x, y)) {
        set_tile_raw(x, y, TILE_DOOR);
    }
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

// =============================================================================
// CORRIDOR DRAWING 
// =============================================================================

/**
 * @brief Corridor drawing with proper exit point calculation
 * 
 * @param room1 First room index
 * @param room2 Second room index
 * @return 1 if corridor was successfully drawn, 0 otherwise
 */
unsigned char draw_corridor(unsigned char room1, unsigned char room2) {
    ExitPoint exit1, exit2;
    unsigned char room1_center_x, room1_center_y;
    unsigned char room2_center_x, room2_center_y;
    
    // Get room center coordinates
    get_room_center(room1, &room1_center_x, &room1_center_y);
    get_room_center(room2, &room2_center_x, &room2_center_y);
    
    // Calculate door positions for corridor connections
    calculate_exit_points(&rooms[room1], room2_center_x, room2_center_y, &exit1);
    calculate_exit_points(&rooms[room2], room1_center_x, room1_center_y, &exit2);
    
    // Reset corridor path for this connection
    corridor_path_static.length = 0;
    
    // Determine corridor type based on room alignment
    unsigned char has_horizontal_overlap, has_vertical_overlap;
    check_room_axis_alignment(room1, room2, &has_horizontal_overlap, &has_vertical_overlap);
    
    // =================================================================
    // CORRIDOR TYPE SELECTION
    // =================================================================
    
    if (has_horizontal_overlap || has_vertical_overlap) {
        // ALIGNED ROOMS: Use straight or Z-shaped corridors only
        // 70% chance of straight corridor, 30% chance of Z-shaped
        // NEVER use L-shaped for aligned rooms
        
        unsigned char use_straight = rnd(100) < 70;
        
        if (use_straight) {
            // Try straight corridor with proper exit points
            unsigned char straight_exit1_x, straight_exit1_y, straight_exit2_x, straight_exit2_y;
            find_straight_corridor_exits(room1, room2, has_horizontal_overlap, 
                                        &straight_exit1_x, &straight_exit1_y, 
                                        &straight_exit2_x, &straight_exit2_y);
            
            if (!path_intersects_other_rooms(straight_exit1_x, straight_exit1_y, 
                                            straight_exit2_x, straight_exit2_y, room1, room2)) {
                
                if (draw_straight_corridor(straight_exit1_x, straight_exit1_y, 
                                         straight_exit2_x, straight_exit2_y)) {
                    
                    place_door(straight_exit1_x, straight_exit1_y);
                    place_door(straight_exit2_x, straight_exit2_y);
                    return 1;
                }
            }
        }
        
        // Try Z-shaped corridor (30% chance initially, or fallback if straight failed)
        unsigned char start_with_x = (exit1.wall_side == 0 || exit1.wall_side == 1) ? 1 : 0;
        
        // Try Z-shaped corridor directly
        if (draw_z_corridor(exit1.x, exit1.y, 
                          exit2.x, exit2.y, start_with_x)) {
            
            place_door(exit1.x, exit1.y);
            place_door(exit2.x, exit2.y);
            return 1;
        }
        
    } else {
        // DIAGONAL ROOMS: Use L-shaped or Z-shaped corridors only
        // 50-50% chance between L-shaped and Z-shaped
        // NEVER use straight corridors for diagonal rooms
        
        unsigned char use_l_shaped = rnd(100) < 50;
        
        if (use_l_shaped) {
            // Try L-shaped corridor using diagonal exit points
            unsigned char l_exit1_x, l_exit1_y, l_exit2_x, l_exit2_y;
            unsigned char wall_side1, wall_side2;
            find_l_corridor_exits(room1, room2, &l_exit1_x, &l_exit1_y, &l_exit2_x, &l_exit2_y, &wall_side1, &wall_side2);
            
            // Check if L-shaped path avoids room intersections
            unsigned char l_path_clear = l_path_avoids_rooms(l_exit1_x, l_exit1_y, 
                                                            l_exit2_x, l_exit2_y, 
                                                            room1, room2, 1) ||
                                        l_path_avoids_rooms(l_exit1_x, l_exit1_y, 
                                                            l_exit2_x, l_exit2_y, 
                                                            room1, room2, 0);
            
            if (l_path_clear) {
                // Draw L-corridor using door coordinates with correct wall sides (updated after door reuse)
                draw_l_corridor(l_exit1_x, l_exit1_y, l_exit2_x, l_exit2_y, wall_side1, wall_side2);
                
                // Place doors at the positions returned by find_l_corridor_exits
                place_door(l_exit1_x, l_exit1_y);
                place_door(l_exit2_x, l_exit2_y);
                return 1;
            }
        }
        
        // Try Z-shaped corridor (50% chance initially, or fallback if L-shaped failed)
        unsigned char start_with_x = (exit1.wall_side == 0 || exit1.wall_side == 1) ? 1 : 0;
        
        // Try Z-shaped corridor directly
        if (draw_z_corridor(exit1.x, exit1.y, 
                          exit2.x, exit2.y, start_with_x)) {
            
            place_door(exit1.x, exit1.y);
            place_door(exit2.x, exit2.y);
            return 1;
        }
    }
    
    return 0; // All corridor types failed
}
