// =============================================================================
// ROOM CONNECTION SYSTEM
// Explicit data storage for room connections, doors, and corridor types
// =============================================================================

#include "mapgen_types.h"
#include "mapgen_internal.h"
#include "mapgen_utils.h"

// =============================================================================
// HELPER FUNCTIONS
// =============================================================================


// place_door function moved to mapgen_utils.c

// Corridor placement check - bounds only (room intersection impossible by geometry)
unsigned char can_place_corridor(unsigned char x, unsigned char y) {
    return (x < MAP_W && y < MAP_H);
}

// Validity check for room connections - essential for array bounds safety
unsigned char can_connect_rooms_safely(unsigned char room1, unsigned char room2) {
    return (room1 != room2 && room1 < room_count && room2 < room_count);
}


// Wrapper functions removed - using direct inline access for OSCAR64 efficiency
// rooms_are_connected() eliminated - use room_has_connection_to() directly

// =============================================================================
// CORRIDOR DRAWING FUNCTIONS
// =============================================================================

// Common direction stepping logic - convert wall side to movement direction
static void step_towards_target(unsigned char *x, unsigned char *y, unsigned char target_x, unsigned char target_y) {
    if (*x < target_x) (*x)++;
    else if (*x > target_x) (*x)--;
    
    if (*y < target_y) (*y)++;
    else if (*y > target_y) (*y)--;
}


// Draw straight corridor connecting two doors with walls
static void draw_straight_path(unsigned char door1_x, unsigned char door1_y, unsigned char door2_x, unsigned char door2_y, unsigned char is_secret) {
    unsigned char x = door1_x, y = door1_y;
    unsigned char tile_type = is_secret ? TILE_SECRET_PATH : TILE_FLOOR;
    
    // Draw corridor from door to door, skipping positions inside rooms
    while (x != door2_x || y != door2_y) {
        // Place corridor tiles, avoiding only room interiors
        if (can_place_corridor(x, y)) {
            set_compact_tile(x, y, tile_type);
            // Place walls around this corridor tile
            place_walls_around_corridor_tile(x, y);
        }
        
        // Use common stepping logic
        step_towards_target(&x, &y, door2_x, door2_y);
    }
}

// Draw L-shaped corridor connecting two doors with perpendicular segments and walls
static void draw_l_path(unsigned char door1_x, unsigned char door1_y, unsigned char door2_x, unsigned char door2_y, unsigned char wall1_side, unsigned char is_secret) {
    unsigned char pivot_x, pivot_y;
    
    // Calculate L-bend point using wall1_side - ALWAYS follow correct direction rule
    if ((wall1_side & 0x02) == 0) {
        // Vertical wall (Left/Right) -> MUST go horizontal first, then vertical
        pivot_x = door2_x;
        pivot_y = door1_y;
    } else {
        // Horizontal wall (Top/Bottom) -> MUST go vertical first, then horizontal
        pivot_x = door1_x;
        pivot_y = door2_y;
    }
    
    // NO ALTERNATIVE DIRECTION - L-corridor must follow wall rules
    // If pivot point is invalid, the corridor selection logic should use Z-shaped instead
    
    // Draw L-path: door1 -> pivot -> door2
    draw_straight_path(door1_x, door1_y, pivot_x, pivot_y, is_secret);
    draw_straight_path(pivot_x, pivot_y, door2_x, door2_y, is_secret);
}

// Draw Z-shaped corridor connecting two doors with three segments and walls
static void draw_z_path(unsigned char door1_x, unsigned char door1_y, unsigned char door2_x, unsigned char door2_y, unsigned char wall_side, unsigned char is_secret) {
    // Calculate Z-corridor segment endpoints
    unsigned char seg1_end_x = door1_x, seg1_end_y = door1_y;
    unsigned char seg2_end_x = door1_x, seg2_end_y = door1_y;
    
    unsigned char dx = abs_diff_inline(door2_x, door1_x);
    unsigned char dy = abs_diff_inline(door2_y, door1_y);
    
    // Z-corridor: 3 segments with 2 direction changes
    // Use bitwise test
    if ((wall_side & 0x02) == 0) { // Vertical walls -> start horizontal
        unsigned char leg_length = dx / 3;
        seg1_end_x = (door2_x > door1_x) ? door1_x + leg_length : door1_x - leg_length;
        seg1_end_y = door1_y;
        seg2_end_x = seg1_end_x;
        seg2_end_y = door2_y;
    } else { // Horizontal walls -> start vertical
        unsigned char leg_length = dy / 3;
        seg1_end_x = door1_x;
        seg1_end_y = (door2_y > door1_y) ? door1_y + leg_length : door1_y - leg_length;
        seg2_end_x = door2_x;
        seg2_end_y = seg1_end_y;
    }
    
    // Draw three Z-segments: door1 -> seg1 -> seg2 -> door2
    draw_straight_path(door1_x, door1_y, seg1_end_x, seg1_end_y, is_secret);
    draw_straight_path(seg1_end_x, seg1_end_y, seg2_end_x, seg2_end_y, is_secret);
    draw_straight_path(seg2_end_x, seg2_end_y, door2_x, door2_y, is_secret);
}

// Draw corridor using stored corridor type
static void draw_corridor_from_door(unsigned char exit1_x, unsigned char exit1_y, 
                                   unsigned char wall1_side, unsigned char exit2_x, unsigned char exit2_y,
                                   unsigned char corridor_type, unsigned char is_secret) {
    switch (corridor_type) {
        case 0: // Straight corridor
            draw_straight_path(exit1_x, exit1_y, exit2_x, exit2_y, is_secret);
            break;
            
        case 1: // L-shaped corridor
            draw_l_path(exit1_x, exit1_y, exit2_x, exit2_y, wall1_side, is_secret);
            break;
            
        case 2: // Z-shaped corridor  
            draw_z_path(exit1_x, exit1_y, exit2_x, exit2_y, wall1_side, is_secret);
            break;
    }
}


// =============================================================================
// ROOM CONNECTION IMPLEMENTATION
// =============================================================================

// Calculate door positions for straight corridors - simple logic
static void calculate_straight_exits(unsigned char room1, unsigned char room2,
                                    unsigned char *exit1_x, unsigned char *exit1_y,
                                    unsigned char *exit2_x, unsigned char *exit2_y) {
    Room *r1 = &room_list[room1];
    Room *r2 = &room_list[room2];
    
    unsigned char r1_cx, r1_cy, r2_cx, r2_cy;
    get_room_center_ptr(r1, &r1_cx, &r1_cy);
    get_room_center_ptr(r2, &r2_cx, &r2_cy);
    
    if (r1_cx == r2_cx) {
        // Vertical alignment - use top/bottom walls
        *exit1_x = r1_cx; *exit2_x = r2_cx;
        if (r1_cy < r2_cy) {
            *exit1_y = r1->y + r1->h; *exit2_y = r2->y - 1; // r1 bottom, r2 top
        } else {
            *exit1_y = r1->y - 1; *exit2_y = r2->y + r2->h; // r1 top, r2 bottom
        }
    } else {
        // Horizontal alignment - use left/right walls
        *exit1_y = r1_cy; *exit2_y = r2_cy;
        if (r1_cx < r2_cx) {
            *exit1_x = r1->x + r1->w; *exit2_x = r2->x - 1; // r1 right, r2 left
        } else {
            *exit1_x = r1->x - 1; *exit2_x = r2->x + r2->w; // r1 left, r2 right
        }
    }
}

// Calculate door position on room wall facing target
static void calculate_exit_from_target(unsigned char room_idx, unsigned char target_x, unsigned char target_y,
                                     unsigned char *door_x, unsigned char *door_y) {
    Room *room = &room_list[room_idx];
    unsigned char room_center_x, room_center_y;
    get_room_center_ptr(room, &room_center_x, &room_center_y);
    
    unsigned char dx = abs_diff_inline(target_x, room_center_x);
    unsigned char dy = abs_diff_inline(target_y, room_center_y);
    
    // Position door on room wall closest to target
    if (dx > dy) {
        // Horizontal movement preferred
        if (target_x > room_center_x) {
            *door_x = room->x + room->w; // Right wall
            *door_y = room_center_y;
        } else {
            *door_x = room->x - 1; // Left wall
            *door_y = room_center_y;
        }
    } else {
        // Vertical movement preferred
        if (target_y > room_center_y) {
            *door_x = room_center_x;
            *door_y = room->y + room->h; // Bottom wall
        } else {
            *door_x = room_center_x;
            *door_y = room->y - 1; // Top wall
        }
    }
}



// Get wall side from door position
static unsigned char get_wall_side_from_exit(unsigned char room_idx, unsigned char exit_x, unsigned char exit_y) {
    Room *room = &room_list[room_idx];
    
    // Reduce branches with early returns
    if (exit_x < room->x) return 0; // Left
    if (exit_x >= room->x + room->w) return 1; // Right  
    if (exit_y < room->y) return 2; // Top
    return 3; // Bottom (default case)
}

// Check for valid straight corridor: centers aligned AND walls face each other
static unsigned char can_use_straight_corridor(unsigned char room1, unsigned char room2) {
    Room *r1 = &room_list[room1];
    Room *r2 = &room_list[room2];
    
    unsigned char r1_cx, r1_cy, r2_cx, r2_cy;
    get_room_center_ptr(r1, &r1_cx, &r1_cy);
    get_room_center_ptr(r2, &r2_cx, &r2_cy);
    
    // Check alignment and facing direction in one step
    if (r1_cx == r2_cx) {
        // Vertical alignment - rooms must face each other (not overlap)
        return (r1_cy < r2_cy) ? (r1->y + r1->h <= r2->y) : (r2->y + r2->h <= r1->y);
    }
    if (r1_cy == r2_cy) {
        // Horizontal alignment - rooms must face each other (not overlap)
        return (r1_cx < r2_cx) ? (r1->x + r1->w <= r2->x) : (r2->x + r2->w <= r1->x);
    }
    return 0; // Not aligned or overlapping
}



// Calculate door positions for diagonal rooms using L-shaped corridors
// Uses same logic as draw_l_path() to ensure consistency
static void calculate_l_exits(unsigned char room1, unsigned char room2,
                            unsigned char *exit1_x, unsigned char *exit1_y,
                            unsigned char *exit2_x, unsigned char *exit2_y) {
    Room *r1 = &room_list[room1];
    Room *r2 = &room_list[room2];
    
    unsigned char r1_center_x, r1_center_y, r2_center_x, r2_center_y;
    get_room_center_ptr(r1, &r1_center_x, &r1_center_y);
    get_room_center_ptr(r2, &r2_center_x, &r2_center_y);
    
    // Determine which wall of room1 should be used based on room2 direction
    unsigned char dx = abs_diff_inline(r2_center_x, r1_center_x);
    unsigned char dy = abs_diff_inline(r2_center_y, r1_center_y);
    
    if (dx > dy) {
        // Horizontal distance is greater - use vertical walls (left/right)
        if (r2_center_x > r1_center_x) {
            // Room2 is to the right - use Room1 right wall
            *exit1_x = r1->x + r1->w; *exit1_y = r1_center_y; // Right wall
        } else {
            // Room2 is to the left - use Room1 left wall  
            *exit1_x = r1->x - 1; *exit1_y = r1_center_y; // Left wall
        }
        // For vertical walls: horizontal first, then vertical to room2
        if (r2_center_y > r1_center_y) {
            *exit2_x = r2_center_x; *exit2_y = r2->y - 1; // Room2 top wall
        } else {
            *exit2_x = r2_center_x; *exit2_y = r2->y + r2->h; // Room2 bottom wall
        }
    } else {
        // Vertical distance is greater - use horizontal walls (top/bottom)
        if (r2_center_y > r1_center_y) {
            // Room2 is below - use Room1 bottom wall
            *exit1_x = r1_center_x; *exit1_y = r1->y + r1->h; // Bottom wall
        } else {
            // Room2 is above - use Room1 top wall
            *exit1_x = r1_center_x; *exit1_y = r1->y - 1; // Top wall
        }
        // For horizontal walls: vertical first, then horizontal to room2
        if (r2_center_x > r1_center_x) {
            *exit2_x = r2->x - 1; *exit2_y = r2_center_y; // Room2 left wall
        } else {
            *exit2_x = r2->x + r2->w; *exit2_y = r2_center_y; // Room2 right wall
        }
    }
}

// Try to calculate L-corridor with gap validation - returns 1 if successful, 0 if not viable
static unsigned char try_calculate_l_corridor(unsigned char room1, unsigned char room2,
                                            unsigned char *exit1_x, unsigned char *exit1_y,
                                            unsigned char *exit2_x, unsigned char *exit2_y) {
    Room *r1 = &room_list[room1];
    Room *r2 = &room_list[room2];
    
    // Calculate horizontal and vertical gaps between room boundaries
    short horizontal_gap, vertical_gap;
    
    if (r1->x + r1->w <= r2->x) {
        // Room1 is to the left of room2
        horizontal_gap = r2->x - (r1->x + r1->w);
    } else if (r2->x + r2->w <= r1->x) {
        // Room2 is to the left of room1
        horizontal_gap = r1->x - (r2->x + r2->w);
    } else {
        // Rooms overlap horizontally
        horizontal_gap = -1;
    }
    
    if (r1->y + r1->h <= r2->y) {
        // Room1 is above room2
        vertical_gap = r2->y - (r1->y + r1->h);
    } else if (r2->y + r2->h <= r1->y) {
        // Room2 is above room1
        vertical_gap = r1->y - (r2->y + r2->h);
    } else {
        // Rooms overlap vertically
        vertical_gap = -1;
    }
    
    // If either gap is <= 0, L-corridor is not viable
    if (horizontal_gap <= 0 || vertical_gap <= 0) {
        return 0;
    }
    
    // Calculate L-exits using existing logic
    calculate_l_exits(room1, room2, exit1_x, exit1_y, exit2_x, exit2_y);
    return 1;
}


// =============================================================================
// ROOM CONNECTION LOGIC
// =============================================================================

// Connect two rooms with corridor and store connection metadata
unsigned char connect_rooms_directly(unsigned char room1, unsigned char room2, unsigned char is_secret) {
    // Check if already connected - direct call for OSCAR64 efficiency
    if (room_has_connection_to(room1, room2)) {
        return 1;
    }
    
    // Safety distance check
    if (!can_connect_rooms_safely(room1, room2)) {
        return 0;
    }
    
    Room *r1 = &room_list[room1];
    Room *r2 = &room_list[room2];
    
    // Calculate room centers for door positioning
    unsigned char r1_center_x, r1_center_y, r2_center_x, r2_center_y;
    get_room_center_ptr(r1, &r1_center_x, &r1_center_y);
    get_room_center_ptr(r2, &r2_center_x, &r2_center_y);
    
    // Corridor type selection: overlap-based room connection logic
    unsigned char corridor_type = 2; // Default to Z-shaped
    unsigned char exit1_x, exit1_y, exit2_x, exit2_y;
    
    // Corridor type priority: Straight > Z-shaped > L-shaped
    if (can_use_straight_corridor(room1, room2)) {
        // Straight corridor - rooms are aligned and face each other
        corridor_type = 0;
        calculate_straight_exits(room1, room2, &exit1_x, &exit1_y, &exit2_x, &exit2_y);
    } else {
        // Try L-shaped corridor with simplified gap validation
        if (try_calculate_l_corridor(room1, room2, &exit1_x, &exit1_y, &exit2_x, &exit2_y)) {
            // Use L-shaped corridor
            corridor_type = 1;
        } else {
            // Fallback to Z-shaped
            corridor_type = 2;
            calculate_exit_from_target(room1, r2_center_x, r2_center_y, &exit1_x, &exit1_y);
            calculate_exit_from_target(room2, r1_center_x, r1_center_y, &exit2_x, &exit2_y);
        }
    }
    
    // Secret flag is now passed as parameter
    
    // Draw corridor and store connection data
    unsigned char wall1 = get_wall_side_from_exit(room1, exit1_x, exit1_y);
    unsigned char wall2 = get_wall_side_from_exit(room2, exit2_x, exit2_y);
    
    draw_corridor_from_door(exit1_x, exit1_y, wall1, exit2_x, exit2_y, corridor_type, is_secret);
    
    // Place doors at calculated positions (secret passages use TILE_SECRET_PATH)
    if (is_secret) {
        set_compact_tile(exit1_x, exit1_y, TILE_SECRET_PATH);
        set_compact_tile(exit2_x, exit2_y, TILE_SECRET_PATH);
    } else {
        place_door(exit1_x, exit1_y);
        place_door(exit2_x, exit2_y);
    }
    
    // Mark secret rooms in their state
    if (is_secret) {
        room_list[room1].state |= ROOM_SECRET;
        room_list[room2].state |= ROOM_SECRET;
    }
    
    // Store connection data atomically using optimized metadata management
    // Add bidirectional connection with atomic operations
    if (!add_connection_to_room(room1, room2, exit1_x, exit1_y, wall1, corridor_type)) {
        return 0; // Failed to add connection to room1
    }
    
    if (!add_connection_to_room(room2, room1, exit2_x, exit2_y, wall2, corridor_type)) {
        // Atomic rollback room1 connection if room2 addition fails
        remove_last_connection_from_room(room1);
        return 0; // Failed to add connection to room2
    }
    
    // Calculate and store breakpoints for both rooms
    calculate_and_store_breakpoints(room1, room_list[room1].connections - 1);
    calculate_and_store_breakpoints(room2, room_list[room2].connections - 1);
    
    return 1;
}

// init_connection_system() removed - initialization handled by init_rooms() to avoid duplication

// =============================================================================
// MST CONNECTION ALGORITHM
// =============================================================================

// Connect all rooms using Minimum Spanning Tree algorithm
void connect_rooms(void) {
    static unsigned char connected[MAX_ROOMS];
    
    // Help compiler with range analysis
    __assume(room_count <= MAX_ROOMS);
    
    // Initialize - only first room is connected
    for (unsigned char i = 0; i < room_count; i++) {
        __assume(room_count <= MAX_ROOMS);
        connected[i] = (i == 0) ? 1 : 0;
    }
    
    unsigned char connections_made = 0;
    
    // MST algorithm - connect closest unconnected rooms
    while (connections_made < room_count - 1) {
        unsigned char best_room1 = 255, best_room2 = 255;
        unsigned char min_distance = 255;
        
        // Find closest unconnected room pair
        for (unsigned char i = 0; i < room_count; i++) {
            __assume(room_count <= MAX_ROOMS);
            if (!connected[i]) continue;
            
            for (unsigned char j = 0; j < room_count; j++) {
                __assume(room_count <= MAX_ROOMS);
                if (connected[j] || i == j) continue;
                
                unsigned char distance = calculate_room_distance(i, j);
                if (distance < min_distance) {
                    min_distance = distance;
                    best_room1 = i;
                    best_room2 = j;
                }
            }
        }
        
        // Connect the best pair
        if (best_room1 != 255) {
            if (connect_rooms_directly(best_room1, best_room2, 0)) {
                connected[best_room2] = 1;
                connections_made++;
                // Batch progress updates - only update every 2 connections for performance
                if ((connections_made & 1) == 0 || connections_made == room_count - 1) {
                    update_progress_step(1, connections_made, room_count - 1);
                }
            } else {
                break;
            }
        } else {
            break;
        }
    }
}

// =============================================================================
// SECRET ROOM SYSTEM
// =============================================================================

// Convert doors to secret rooms into secret passages
void convert_secret_rooms_doors(void) {
    // Secret room conversion phase - progress handled by main generation loop
    unsigned char secrets_made = 0;
    
    for (unsigned char i = 0; i < room_count; i++) {
        __assume(room_count <= MAX_ROOMS);
        // Only rooms with exactly one connection can be secret
        if (room_list[i].connections == 1 && rnd(100) < SECRET_ROOM_PERCENTAGE) {
            unsigned char connected_room = room_list[i].conn_data[0].room_id;
            
            // Get the connected room's door position for this connection
            unsigned char connected_door_x, connected_door_y, connected_wall_side, temp_corridor_type;
            if (!get_connection_info(connected_room, i, &connected_door_x, &connected_door_y, &connected_wall_side, &temp_corridor_type)) {
                continue; // Connection not found, skip this room
            }
            
            // Count how many doors are on this specific wall in connected room
            unsigned char doors_on_wall = 0;
            for (unsigned char j = 0; j < room_list[connected_room].connections; j++) {
                if (room_list[connected_room].doors[j].wall_side == connected_wall_side) {
                    doors_on_wall++;
                }
            }
            // If more than 1 door on this wall, skip (would delete existing corridor)
            if (doors_on_wall > 1) continue;
            room_list[i].state |= ROOM_SECRET;
            
            if (room_list[i].connections > 0) {
                Door *secret_door = &room_list[i].doors[0];
                
                // Use the door coordinates we already retrieved above
                unsigned char normal_door_x = connected_door_x;
                unsigned char normal_door_y = connected_door_y;
                
                // Only convert the normal room door to secret passage
                // The corridor and secret room door remain normal
                // This creates a hidden entrance to the secret room
                set_compact_tile(normal_door_x, normal_door_y, TILE_SECRET_PATH);
                
                // Mark the door as secret in metadata - find the door index in connected room
                for (unsigned char door_idx = 0; door_idx < room_list[connected_room].connections; door_idx++) {
                    if (room_list[connected_room].doors[door_idx].x == normal_door_x && 
                        room_list[connected_room].doors[door_idx].y == normal_door_y) {
                        room_list[connected_room].doors[door_idx].is_secret_door = 1;
                        break;
                    }
                }
                
                secrets_made++;
                // Phase 2: Secret room progress
                update_progress_step(2, secrets_made, room_count);
            }
        }
    }
}

// =============================================================================
// SECRET TREASURE PLACEMENT SYSTEM
// =============================================================================

// Helper function to calculate door position for false corridor on given wall
static void calculate_false_corridor_door(unsigned char room_idx, unsigned char wall_side, 
                                         unsigned char *door_x, unsigned char *door_y) {
    Room *room = &room_list[room_idx];
    
    // Generate direction vector based on wall side
    signed char dx = 0, dy = 0;
    switch (wall_side) {
        case 0: dx = -1; dy = 0; break; // Left wall
        case 1: dx = 1; dy = 0; break;  // Right wall
        case 2: dx = 0; dy = -1; break; // Top wall
        case 3: dx = 0; dy = 1; break;  // Bottom wall
        default: *door_x = 255; *door_y = 255; return;
    }
    
    // Calculate target point far in the chosen direction
    unsigned char room_center_x, room_center_y;
    get_room_center_ptr(room, &room_center_x, &room_center_y);
    unsigned char target_x = room_center_x + dx * 10; // Fixed distance for door calculation
    unsigned char target_y = room_center_y + dy * 10;
    
    // Calculate door position using existing helper
    calculate_exit_from_target(room_idx, target_x, target_y, door_x, door_y);
}

// Check if a wall side has any doors (normal doors + false corridor doors)
unsigned char wall_has_doors(unsigned char room_idx, unsigned char wall_side) {
    Room *room = &room_list[room_idx];
    
    // Check normal doors on this wall side
    for (unsigned char i = 0; i < room->connections; i++) {
        if (room->doors[i].wall_side == wall_side) {
            return 1; // Found normal door on this wall
        }
    }
    
    // Check false corridor door on this wall side
    if (room->state & ROOM_HAS_FALSE_CORRIDOR) {
        unsigned char expected_door_x, expected_door_y;
        calculate_false_corridor_door(room_idx, wall_side, &expected_door_x, &expected_door_y);
        
        if (room->false_corridor_door_x == expected_door_x && 
            room->false_corridor_door_y == expected_door_y) {
            return 1; // Found false corridor door on this wall
        }
    }
    
    return 0; // No doors found on this wall
}

// =============================================================================
// FALSE CORRIDOR SYSTEM
// =============================================================================

// Create a simple false corridor (dead-end) from room wall
static unsigned char create_simple_false_corridor(unsigned char room_idx, unsigned char wall_side) {
    Room *room = &room_list[room_idx];
    
    // Skip secret rooms
    if (room->state & ROOM_SECRET) return 0;
    
    // Skip walls that have doors
    if (wall_has_doors(room_idx, wall_side)) return 0;
    
    // Calculate door position using shared helper
    unsigned char door_x, door_y;
    calculate_false_corridor_door(room_idx, wall_side, &door_x, &door_y);
    
    // Generate direction vector for target calculation
    signed char dx = 0, dy = 0;
    unsigned char corridor_length = 5 + rnd(8); // 5-12 tiles
    
    switch (wall_side) {
        case 0: dx = -1; dy = 0; break; // Left wall
        case 1: dx = 1; dy = 0; break;  // Right wall
        case 2: dx = 0; dy = -1; break; // Top wall
        case 3: dx = 0; dy = 1; break;  // Bottom wall
        default: return 0;
    }
    
    // Calculate actual target based on door position
    unsigned char target_x = door_x + dx * corridor_length;
    unsigned char target_y = door_y + dy * corridor_length;
    
    // Check bounds with 2-tile margin from map edges
    if (target_x < 2 || target_x >= MAP_W-2 || target_y < 2 || target_y >= MAP_H-2) {
        return 0;
    }
    
    // Check room collision using existing helper
    unsigned char collision_room;
    if (point_in_any_room(target_x, target_y, &collision_room)) {
        return 0; // Too close to room
    }
    
    // Optional L-shaped or Z-shaped deviation - simple approach
    unsigned char final_x = target_x, final_y = target_y;
    unsigned char corridor_type = 0; // Default to straight
    
    if (rnd(100) < 50) {
        unsigned char offset = 2 + rnd(4); // 2-5 tiles
        unsigned char shape_choice = rnd(100); // Random choice between L and Z
        
        // Add perpendicular offset and check if still valid
        unsigned char test_x = target_x, test_y = target_y;
        if (wall_side <= 1) { // Horizontal corridors - add vertical offset
            test_y = target_y + (rnd(2) ? offset : -offset);
        } else { // Vertical corridors - add horizontal offset
            test_x = target_x + (rnd(2) ? offset : -offset);
        }
        
        // Quick validation with 2-tile margin from edges
        if (coords_in_bounds(test_x, test_y) && test_x >= 2 && test_x < MAP_W-2 && test_y >= 2 && test_y < MAP_H-2) {
            unsigned char collision_room;
            if (!point_in_any_room(test_x, test_y, &collision_room)) {
                final_x = test_x;
                final_y = test_y;
                corridor_type = (shape_choice < 70) ? 1 : 2; // 70% L-shaped, 30% Z-shaped
            }
        }
    }
    
    // Draw corridor using existing corridor drawing function
    draw_corridor_from_door(door_x, door_y, wall_side, final_x, final_y, corridor_type, 0);
    
    // Place door at entrance
    place_door(door_x, door_y);
    
    // Store false corridor metadata
    room->state |= ROOM_HAS_FALSE_CORRIDOR;
    room->false_corridor_door_x = door_x;
    room->false_corridor_door_y = door_y;
    room->false_corridor_end_x = final_x;
    room->false_corridor_end_y = final_y;
    
    return 1; // Success
}

// Place false corridors across the map - keep trying until target reached
void place_false_corridors(unsigned char corridor_count) {
    if (room_count == 0 || corridor_count == 0) return;
    
    unsigned char corridors_placed = 0;
    unsigned char attempts = 0;
    unsigned char max_attempts = room_count * 20; // More attempts to reach target
    
    // Keep trying random positions until we reach target or max attempts
    while (corridors_placed < corridor_count && attempts < max_attempts) {
        unsigned char room_idx = rnd(room_count);
        unsigned char wall_side = rnd(4);
        
        if (create_simple_false_corridor(room_idx, wall_side)) {
            corridors_placed++;
        }
        attempts++;
    }
}

// Place a single secret treasure for a room
unsigned char place_treasure_for_room(unsigned char room_idx) {
    Room *room = &room_list[room_idx];
    
    // Skip rooms that already have treasure or are secret rooms
    if (room->state & (ROOM_HAS_TREASURE | ROOM_SECRET)) {
        return 0; // Room already has treasure or is a secret room
    }
    
    // Try each wall side to find walls without doors
    for (unsigned char wall_side = 0; wall_side < 4; wall_side++) {
        // Skip walls that have doors (checks both normal doors and false corridor doors)
        if (wall_has_doors(room_idx, wall_side)) {
            continue; // This wall has doors, skip it
        }
        
        // Calculate wall boundaries excluding only corners
        unsigned char start_pos, end_pos;
        unsigned char wall_x, wall_y, treasure_x, treasure_y;
        
        if (wall_side == 0) { // Left wall (consistent with get_wall_side_from_exit)
            start_pos = room->y + 1;
            end_pos = room->y + room->h - 1;
            if (start_pos >= end_pos) continue; // Wall too small
            
            unsigned char selected_y = start_pos + rnd(end_pos - start_pos);
            wall_x = room->x - 1; wall_y = selected_y;
            treasure_x = wall_x - 1; treasure_y = wall_y;
        } else if (wall_side == 1) { // Right wall
            start_pos = room->y + 1;
            end_pos = room->y + room->h - 1;
            if (start_pos >= end_pos) continue; // Wall too small
            
            unsigned char selected_y = start_pos + rnd(end_pos - start_pos);
            wall_x = room->x + room->w; wall_y = selected_y;
            treasure_x = wall_x + 1; treasure_y = wall_y;
        } else if (wall_side == 2) { // Top wall
            start_pos = room->x + 1;
            end_pos = room->x + room->w - 1;
            if (start_pos >= end_pos) continue; // Wall too small
            
            unsigned char selected_x = start_pos + rnd(end_pos - start_pos);
            wall_x = selected_x; wall_y = room->y - 1;
            treasure_x = wall_x; treasure_y = wall_y - 1;
        } else { // Bottom wall (wall_side == 3)
            start_pos = room->x + 1;
            end_pos = room->x + room->w - 1;
            if (start_pos >= end_pos) continue; // Wall too small
            
            unsigned char selected_x = start_pos + rnd(end_pos - start_pos);
            wall_x = selected_x; wall_y = room->y + room->h;
            treasure_x = wall_x; treasure_y = wall_y + 1;
        }
        
        // Validate bounds before placement
        if (coords_in_bounds(wall_x, wall_y) && coords_in_bounds(treasure_x, treasure_y)) {
            // Create secret path in wall only, normal floor in treasure chamber
            set_compact_tile(wall_x, wall_y, TILE_SECRET_PATH);
            set_compact_tile(treasure_x, treasure_y, TILE_FLOOR);
            
            // Place walls around treasure chamber
            place_walls_around_corridor_tile(treasure_x, treasure_y);
            
            // Mark room as having treasure and store wall position
            room->state |= ROOM_HAS_TREASURE;
            room->treasure_wall_x = wall_x;
            room->treasure_wall_y = wall_y;
            
            return 1; // Successfully placed treasure
        }
    }
    
    return 0; // Failed to place treasure for this room
}

// Main secret treasure placement function
void place_secret_treasures(unsigned char treasure_count) {
    if (room_count == 0 || treasure_count == 0) return;
    
    unsigned char treasures_placed = 0;
    unsigned char attempts = 0;
    unsigned char max_attempts = room_count * 2; // Reasonable attempt limit
    
    while (treasures_placed < treasure_count && attempts < max_attempts) {
        unsigned char room_idx = rnd(room_count);
        
        if (place_treasure_for_room(room_idx)) {
            treasures_placed++;
        }
        attempts++;
    }
}

// =============================================================================
// CORRIDOR BREAKPOINT CALCULATION SYSTEM
// =============================================================================

// Calculate and store corridor breakpoints based on corridor type and door positions
void calculate_and_store_breakpoints(unsigned char room_idx, unsigned char connection_idx) {
    Room *room = &room_list[room_idx];
    
    // Validate indices
    if (room_idx >= room_count || connection_idx >= room->connections) {
        return; // Invalid parameters
    }
    
    // Get connection metadata
    unsigned char connected_room = room->conn_data[connection_idx].room_id;
    unsigned char corridor_type = room->conn_data[connection_idx].corridor_type;
    unsigned char door1_x = room->doors[connection_idx].x;
    unsigned char door1_y = room->doors[connection_idx].y;
    unsigned char wall1_side = room->doors[connection_idx].wall_side;
    
    // Get connected room door position
    unsigned char door2_x, door2_y, wall2_side, temp_corridor_type;
    if (!get_connection_info(connected_room, room_idx, &door2_x, &door2_y, &wall2_side, &temp_corridor_type)) {
        return; // Connection not found
    }
    
    // Initialize breakpoints as invalid
    room->breakpoints[connection_idx][0].x = 255;
    room->breakpoints[connection_idx][0].y = 255;
    room->breakpoints[connection_idx][1].x = 255;
    room->breakpoints[connection_idx][1].y = 255;
    
    // Calculate breakpoints based on corridor type
    switch (corridor_type) {
        case 0: // Straight corridor - no breakpoints
            break;
            
        case 1: { // L-shaped corridor - 1 breakpoint (pivot)
            unsigned char pivot_x, pivot_y;
            
            // Calculate L-bend point using same logic as draw_l_path
            if ((wall1_side & 0x02) == 0) {
                // Vertical wall -> go horizontal first
                pivot_x = door2_x; pivot_y = door1_y;
            } else {
                // Horizontal wall -> go vertical first  
                pivot_x = door1_x; pivot_y = door2_y;
            }
            
            room->breakpoints[connection_idx][0].x = pivot_x;
            room->breakpoints[connection_idx][0].y = pivot_y;
            break;
        }
        
        case 2: { // Z-shaped corridor - 2 breakpoints
            unsigned char seg1_end_x = door1_x, seg1_end_y = door1_y;
            unsigned char seg2_end_x = door1_x, seg2_end_y = door1_y;
            
            // Calculate Z-corridor segment endpoints using same logic as draw_z_path
            unsigned char dx = (door2_x > door1_x) ? door2_x - door1_x : door1_x - door2_x;
            unsigned char dy = (door2_y > door1_y) ? door2_y - door1_y : door1_y - door2_y;
            
            if ((wall1_side & 0x02) == 0) { // Vertical walls -> start horizontal
                unsigned char leg_length = dx / 3;
                seg1_end_x = (door2_x > door1_x) ? door1_x + leg_length : door1_x - leg_length;
                seg1_end_y = door1_y;
                seg2_end_x = seg1_end_x;
                seg2_end_y = door2_y;
            } else { // Horizontal walls -> start vertical
                unsigned char leg_length = dy / 3;
                seg1_end_x = door1_x;
                seg1_end_y = (door2_y > door1_y) ? door1_y + leg_length : door1_y - leg_length;
                seg2_end_x = door2_x;
                seg2_end_y = seg1_end_y;
            }
            
            room->breakpoints[connection_idx][0].x = seg1_end_x;
            room->breakpoints[connection_idx][0].y = seg1_end_y;
            room->breakpoints[connection_idx][1].x = seg2_end_x;
            room->breakpoints[connection_idx][1].y = seg2_end_y;
            break;
        }
    }
}


