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

// find_existing_door_on_wall moved to room_management.c

// place_door function moved to mapgen_utils.c

// Corridor placement check - avoid room interiors only
unsigned char can_place_corridor(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return 0;
    
    // OSCAR64 optimization: Help compiler with range analysis
    __assume(room_count <= MAX_ROOMS);
    
    // Check all rooms - avoid only room interiors
    for (unsigned char i = 0; i < room_count; i++) {
        Room *room = &rooms[i];
        if (x >= room->x && x < room->x + room->w && 
            y >= room->y && y < room->y + room->h) {
            return 0;
        }
    }
    
    return 1;
}

// Safety check for room connections - OSCAR64 optimized
unsigned char can_connect_rooms_safely(unsigned char room1, unsigned char room2) {
    // OSCAR64 optimization: Early exit conditions and bit operations
    if (room1 == room2 || room1 >= room_count || room2 >= room_count) return 0;
    
    // Use bitwise comparison: room_count <= 8 means bit 3+ are zero
    unsigned char max_distance = (room_count & 0xF8) ? 30 : 80; // bits 3-7 zero = <= 8
    return calculate_room_distance(room1, room2) <= max_distance;
}


// Wrapper functions removed - using direct inline access for OSCAR64 efficiency
// rooms_are_connected() eliminated - use room_has_connection_to() directly

// =============================================================================
// CORRIDOR DRAWING FUNCTIONS
// =============================================================================

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
        
        // Move towards target door
        if (x < door2_x) x++;
        else if (x > door2_x) x--;
        
        if (y < door2_y) y++;
        else if (y > door2_y) y--;
    }
}

// Draw L-shaped corridor connecting two doors with perpendicular segments and walls
static void draw_l_path(unsigned char door1_x, unsigned char door1_y, unsigned char door2_x, unsigned char door2_y, unsigned char wall1_side, unsigned char wall2_side, unsigned char is_secret) {
    unsigned char pivot_x, pivot_y;
    
    // Calculate L-bend point using BOTH wall orientations for proper perpendicular connection
    // OSCAR64 optimization: Use bitwise test instead of comparison
    // wall_side: 0=Left, 1=Right, 2=Top, 3=Bottom
    if ((wall1_side & 0x02) == 0) {
        // Vertical wall (Left/Right: bit 1 = 0) -> go horizontal first, then vertical
        pivot_x = door2_x;
        pivot_y = door1_y;
    } else {
        // Horizontal wall (Top/Bottom: bit 1 = 1) -> go vertical first, then horizontal
        pivot_x = door1_x;
        pivot_y = door2_y;
    }
    
    // Draw L-path: door1 -> pivot -> door2
    draw_straight_path(door1_x, door1_y, pivot_x, pivot_y, is_secret);
    draw_straight_path(pivot_x, pivot_y, door2_x, door2_y, is_secret);
}

// Draw Z-shaped corridor connecting two doors with three segments and walls
static void draw_z_path(unsigned char door1_x, unsigned char door1_y, unsigned char door2_x, unsigned char door2_y, unsigned char wall_side, unsigned char is_secret) {
    // Calculate Z-corridor segment endpoints
    unsigned char seg1_end_x = door1_x, seg1_end_y = door1_y;
    unsigned char seg2_end_x = door1_x, seg2_end_y = door1_y;
    
    unsigned char dx = abs_diff(door2_x, door1_x);
    unsigned char dy = abs_diff(door2_y, door1_y);
    
    // Z-corridor: 3 segments with 2 direction changes
    // OSCAR64 optimization: Use bitwise test
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
                                   unsigned char wall2_side, unsigned char corridor_type, unsigned char is_secret) {
    switch (corridor_type) {
        case 0: // Straight corridor
            draw_straight_path(exit1_x, exit1_y, exit2_x, exit2_y, is_secret);
            break;
            
        case 1: // L-shaped corridor
            draw_l_path(exit1_x, exit1_y, exit2_x, exit2_y, wall1_side, wall2_side, is_secret);
            break;
            
        case 2: // Z-shaped corridor  
            draw_z_path(exit1_x, exit1_y, exit2_x, exit2_y, wall1_side, is_secret);
            break;
    }
}


// =============================================================================
// ROOM CONNECTION IMPLEMENTATION
// =============================================================================

// Check room alignment for corridor type selection
static void check_room_alignment(unsigned char room1, unsigned char room2, 
                               unsigned char *has_horizontal_overlap, 
                               unsigned char *has_vertical_overlap) {
    Room *r1 = &rooms[room1];
    Room *r2 = &rooms[room2];
    
    // Check horizontal (X-axis) overlap
    *has_horizontal_overlap = !(r1->y + r1->h <= r2->y || r2->y + r2->h <= r1->y);
    
    // Check vertical (Y-axis) overlap  
    *has_vertical_overlap = !(r1->x + r1->w <= r2->x || r2->x + r2->w <= r1->x);
}

// Calculate door position on room wall facing target with door reuse optimization
static void calculate_exit_from_target(unsigned char room_idx, unsigned char target_x, unsigned char target_y,
                                     unsigned char *door_x, unsigned char *door_y) {
    Room *room = &rooms[room_idx];
    unsigned char room_center_x = room->x + room->w / 2;
    unsigned char room_center_y = room->y + room->h / 2;
    
    unsigned char dx = abs_diff(target_x, room_center_x);
    unsigned char dy = abs_diff(target_y, room_center_y);
    
    // Determine target wall and ideal position
    unsigned char target_wall;
    unsigned char ideal_x, ideal_y;
    
    // Position door on room wall (outside walkable area)
    if (dx > dy) {
        // Horizontal movement preferred
        if (target_x > room_center_x) {
            target_wall = 1; // Right wall
            ideal_x = room->x + room->w; // Right wall (outside room)
            ideal_y = room->y + room->h / 2;
        } else {
            target_wall = 0; // Left wall
            ideal_x = room->x - 1; // Left wall (outside room)
            ideal_y = room->y + room->h / 2;
        }
    } else {
        // Vertical movement preferred
        if (target_y > room_center_y) {
            target_wall = 3; // Bottom wall
            ideal_x = room->x + room->w / 2;
            ideal_y = room->y + room->h; // Bottom wall (outside room)
        } else {
            target_wall = 2; // Top wall
            ideal_x = room->x + room->w / 2;
            ideal_y = room->y - 1; // Top wall (outside room)
        }
    }
    
    // DOOR REUSE: Only check if room has existing connections
    if (rooms[room_idx].connections > 0) {
        if (find_existing_door_on_wall(room_idx, target_wall, ideal_x, ideal_y, door_x, door_y)) {
            // Found existing door - reuse it
            return;
        }
    }
    
    // No existing door or no connections - use ideal position
    *door_x = ideal_x;
    *door_y = ideal_y;
}


// Calculate door positions for aligned rooms using straight corridors
static void calculate_straight_exits(unsigned char room1, unsigned char room2, unsigned char horizontal_aligned,
                                   unsigned char *exit1_x, unsigned char *exit1_y,
                                   unsigned char *exit2_x, unsigned char *exit2_y) {
    Room *r1 = &rooms[room1];
    Room *r2 = &rooms[room2];
    
    if (horizontal_aligned) {
        // Horizontally aligned - use vertical walls
        unsigned char overlap_start = (r1->y > r2->y) ? r1->y : r2->y;
        unsigned char overlap_end = ((r1->y + r1->h) < (r2->y + r2->h)) ? r1->y + r1->h : r2->y + r2->h;
        unsigned char center_y = overlap_start + (overlap_end - overlap_start) / 2;
        
        if (r1->x + r1->w < r2->x) {
            // Room1 left, Room2 right
            *exit1_x = r1->x + r1->w;    // Right wall of room1
            *exit1_y = center_y;         // Overlap center
            *exit2_x = r2->x - 1;        // Left wall of room2  
            *exit2_y = center_y;         // Same Y position
        } else {
            // Room2 left, Room1 right
            *exit1_x = r1->x - 1;        // Left wall of room1
            *exit1_y = center_y;         // Overlap center
            *exit2_x = r2->x + r2->w;    // Right wall of room2
            *exit2_y = center_y;         // Same Y position
        }
    } else {
        // Vertically aligned - use horizontal walls
        unsigned char overlap_start = (r1->x > r2->x) ? r1->x : r2->x;
        unsigned char overlap_end = ((r1->x + r1->w) < (r2->x + r2->w)) ? r1->x + r1->w : r2->x + r2->w;
        unsigned char center_x = overlap_start + (overlap_end - overlap_start) / 2;
        
        if (r1->y + r1->h < r2->y) {
            // Room1 top, Room2 bottom
            *exit1_x = center_x;         // Overlap center
            *exit1_y = r1->y + r1->h;    // Bottom wall of room1
            *exit2_x = center_x;         // Same X position
            *exit2_y = r2->y - 1;        // Top wall of room2
        } else {
            // Room2 top, Room1 bottom
            *exit1_x = center_x;         // Overlap center
            *exit1_y = r1->y - 1;        // Top wall of room1
            *exit2_x = center_x;         // Same X position
            *exit2_y = r2->y + r2->h;    // Bottom wall of room2
        }
    }
}

// Get wall side from door position - OSCAR64 optimized
static unsigned char get_wall_side_from_exit(unsigned char room_idx, unsigned char exit_x, unsigned char exit_y) {
    Room *room = &rooms[room_idx];
    
    // OSCAR64 optimization: Reduce branches with early returns
    if (exit_x < room->x) return 0; // Left
    if (exit_x >= room->x + room->w) return 1; // Right  
    if (exit_y < room->y) return 2; // Top
    return 3; // Bottom (default case)
}


// Calculate door positions for diagonal rooms using L-shaped corridors
static void calculate_l_exits(unsigned char room1, unsigned char room2,
                            unsigned char *exit1_x, unsigned char *exit1_y,
                            unsigned char *exit2_x, unsigned char *exit2_y) {
    Room *r1 = &rooms[room1];
    Room *r2 = &rooms[room2];
    
    unsigned char r1_center_x = r1->x + r1->w / 2;
    unsigned char r1_center_y = r1->y + r1->h / 2;
    unsigned char r2_center_x = r2->x + r2->w / 2;
    unsigned char r2_center_y = r2->y + r2->h / 2;
    
    // Choose complementary sides for L-shaped connection - doors ON the wall (outside room)
    if (r2_center_x > r1_center_x && r2_center_y > r1_center_y) {
        // Room2 bottom-right of Room1: Room1 right wall, Room2 top wall
        *exit1_x = r1->x + r1->w; *exit1_y = r1->y + r1->h / 2; // Right wall (outside)
        *exit2_x = r2->x + r2->w / 2; *exit2_y = r2->y - 1; // Top wall (outside)
    } else if (r2_center_x < r1_center_x && r2_center_y > r1_center_y) {
        // Room2 bottom-left of Room1: Room1 bottom wall, Room2 right wall
        *exit1_x = r1->x + r1->w / 2; *exit1_y = r1->y + r1->h; // Bottom wall (outside)
        *exit2_x = r2->x + r2->w; *exit2_y = r2->y + r2->h / 2; // Right wall (outside)
    } else if (r2_center_x > r1_center_x && r2_center_y < r1_center_y) {
        // Room2 top-right of Room1: Room1 top wall, Room2 left wall
        *exit1_x = r1->x + r1->w / 2; *exit1_y = r1->y - 1; // Top wall (outside)
        *exit2_x = r2->x - 1; *exit2_y = r2->y + r2->h / 2; // Left wall (outside)
    } else {
        // Room2 top-left of Room1: Room1 left wall, Room2 bottom wall
        *exit1_x = r1->x - 1; *exit1_y = r1->y + r1->h / 2; // Left wall (outside)
        *exit2_x = r2->x + r2->w / 2; *exit2_y = r2->y + r2->h; // Bottom wall (outside)
    }
}


// Path safety check - avoid room intersections
static unsigned char path_is_safe(unsigned char start_x, unsigned char start_y, 
                                unsigned char end_x, unsigned char end_y,
                                unsigned char source_room, unsigned char dest_room, 
                                unsigned char corridor_type) {
    // Basic path intersection check - ensure path doesn't go through room interiors
    for (unsigned char i = 0; i < room_count; i++) {
        if (i == source_room || i == dest_room) continue;
        
        Room *room = &rooms[i];
        // Check if path would intersect this room's area + buffer
        unsigned char room_min_x = (room->x > 1) ? room->x - 1 : 0;
        unsigned char room_max_x = room->x + room->w + 1;
        unsigned char room_min_y = (room->y > 1) ? room->y - 1 : 0;
        unsigned char room_max_y = room->y + room->h + 1;
        
        // Simple bounding box check for path
        unsigned char path_min_x = (start_x < end_x) ? start_x : end_x;
        unsigned char path_max_x = (start_x > end_x) ? start_x : end_x;
        unsigned char path_min_y = (start_y < end_y) ? start_y : end_y;
        unsigned char path_max_y = (start_y > end_y) ? start_y : end_y;
        
        if (path_max_x >= room_min_x && path_min_x <= room_max_x &&
            path_max_y >= room_min_y && path_min_y <= room_max_y) {
            return 0; // Potential intersection
        }
    }
    return 1; // Path is safe
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
    
    Room *r1 = &rooms[room1];
    Room *r2 = &rooms[room2];
    
    // Calculate room centers for door positioning
    unsigned char r1_center_x = r1->x + r1->w / 2;
    unsigned char r1_center_y = r1->y + r1->h / 2;
    unsigned char r2_center_x = r2->x + r2->w / 2;
    unsigned char r2_center_y = r2->y + r2->h / 2;
    
    // Calculate door positions based on target centers
    unsigned char exit1_x, exit1_y, exit2_x, exit2_y;
    calculate_exit_from_target(room1, r2_center_x, r2_center_y, &exit1_x, &exit1_y);
    calculate_exit_from_target(room2, r1_center_x, r1_center_y, &exit2_x, &exit2_y);
    
    // Check room alignment for corridor type selection
    unsigned char has_horizontal_overlap, has_vertical_overlap;
    check_room_alignment(room1, room2, &has_horizontal_overlap, &has_vertical_overlap);
    
    // Corridor type selection based on room alignment
    unsigned char corridor_type;
    if (has_horizontal_overlap || has_vertical_overlap) {
        // ALIGNED ROOMS: 70% straight, 30% Z-shaped
        if (rnd(100) < 70) {
            corridor_type = 0; // Straight
            // Recalculate exits for straight corridors using overlap-based positioning
            calculate_straight_exits(room1, room2, has_horizontal_overlap, 
                                   &exit1_x, &exit1_y, &exit2_x, &exit2_y);
        } else {
            corridor_type = 2; // Z-shaped
        }
    } else {
        // DIAGONAL ROOMS: 50% L-shaped, 50% Z-shaped (NEVER straight)
        if (rnd(100) < 50) {
            corridor_type = 1; // L-shaped
            // Use diagonal door positioning for L-corridors
            calculate_l_exits(room1, room2, &exit1_x, &exit1_y, &exit2_x, &exit2_y);
        } else {
            corridor_type = 2; // Z-shaped
        }
    }
    
    // Check path intersection before drawing
    if (!path_is_safe(exit1_x, exit1_y, exit2_x, exit2_y, room1, room2, corridor_type)) {
        return 0; // Path would intersect rooms
    }
    
    // Secret flag is now passed as parameter
    
    // Draw corridor and store connection data
    unsigned char wall1 = get_wall_side_from_exit(room1, exit1_x, exit1_y);
    unsigned char wall2 = get_wall_side_from_exit(room2, exit2_x, exit2_y);
    
    draw_corridor_from_door(exit1_x, exit1_y, wall1, exit2_x, exit2_y, wall2, corridor_type, is_secret);
    
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
        rooms[room1].state |= ROOM_SECRET;
        rooms[room2].state |= ROOM_SECRET;
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
    
    return 1;
}

// init_connection_system() removed - initialization handled by init_rooms() to avoid duplication

// =============================================================================
// MST CONNECTION ALGORITHM
// =============================================================================

// Connect all rooms using Minimum Spanning Tree algorithm
void connect_rooms(void) {
    static unsigned char connected[MAX_ROOMS];
    
    // OSCAR64 optimization: Help compiler with range analysis
    __assume(room_count <= MAX_ROOMS);
    
    // Initialize - only first room is connected
    for (unsigned char i = 0; i < room_count; i++) {
        connected[i] = (i == 0) ? 1 : 0;
    }
    
    unsigned char connections_made = 0;
    
    // MST algorithm - connect closest unconnected rooms
    while (connections_made < room_count - 1) {
        unsigned char best_room1 = 255, best_room2 = 255;
        unsigned char min_distance = 255;
        
        // Find closest unconnected room pair
        for (unsigned char i = 0; i < room_count; i++) {
            if (!connected[i]) continue;
            
            for (unsigned char j = 0; j < room_count; j++) {
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
                update_progress_step(1, connections_made, room_count - 1);
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

// Convert corridors of single-connection rooms to secret passages
void convert_secret_corridors(void) {
    // Secret room conversion phase - progress handled by main generation loop
    unsigned char secrets_made = 0;
    
    for (unsigned char i = 0; i < room_count; i++) {
        // Only rooms with exactly one connection can be secret
        if (rooms[i].connections == 1 && rnd(100) < SECRET_ROOM_PERCENTAGE) {
            unsigned char connected_room = rooms[i].conn_data[0].room_id;
            
            // Get the wall side where connected room connects to this room
            unsigned char connected_wall_side = 0;
            get_connection_info(connected_room, i, 0, 0, &connected_wall_side, 0);
            
            // Count doors on the same wall in connected room
            unsigned char doors_on_wall = 0;
            for (unsigned char j = 0; j < rooms[connected_room].connections; j++) {
                if (rooms[connected_room].doors[j].wall_side == connected_wall_side) {
                    doors_on_wall++;
                }
            }
            // If more than 1 door on this wall, skip (would delete existing corridor)
            unsigned char wall_has_other_doors = (doors_on_wall > 1);
            if (wall_has_other_doors) continue;
            rooms[i].state |= ROOM_SECRET;
            
            if (rooms[i].connections > 0) {
                Door *secret_door = &rooms[i].doors[0];
                unsigned char connected_room = rooms[i].conn_data[0].room_id; // Use optimized conn_data
                unsigned char corridor_type = rooms[i].conn_data[0].corridor_type;
                
                // Find corresponding door in connected room using optimized validation
                unsigned char normal_door_x = 0, normal_door_y = 0, normal_wall_side = 0, temp_corridor_type = 0;
                unsigned char found_connection = get_connection_info(connected_room, i, 
                                                                   &normal_door_x, &normal_door_y, 
                                                                   &normal_wall_side, &temp_corridor_type);
                
                if (found_connection) {
                
                    // In MST, secret rooms were always "room2" (unconnected), connected rooms were "room1" 
                    // Original call: connect_rooms_directly(connected_room, secret_room, 0)
                    // So we need: draw_corridor_from_door(room1_door, room1_wall, room2_door, ...)
                    unsigned char secret_wall_side = secret_door->wall_side;
                    draw_corridor_from_door(normal_door_x, normal_door_y, normal_wall_side,
                                          secret_door->x, secret_door->y, secret_wall_side, corridor_type, 1);
                    
                    // Convert doors to secret passages
                    set_compact_tile(secret_door->x, secret_door->y, TILE_SECRET_PATH);
                    set_compact_tile(normal_door_x, normal_door_y, TILE_SECRET_PATH);
                    secrets_made++;
                    // Phase 2: Secret room progress
                    update_progress_step(2, secrets_made, room_count);
                }
            }
        }
    }
}


