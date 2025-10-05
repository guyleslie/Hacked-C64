// =============================================================================
// ROOM CONNECTION SYSTEM
// Explicit data storage for room connections, doors, and corridor types
// =============================================================================

#include "mapgen_types.h"
#include "mapgen_internal.h"
#include "mapgen_utils.h"

// External reference to current generation parameters
extern MapParameters current_params;

typedef struct {
    unsigned char count;
    unsigned char x[2];
    unsigned char y[2];
} CorridorBreakpoints;

// =============================================================================
// HELPER FUNCTIONS
// =============================================================================


// place_door function moved to mapgen_utils.c

// Unified corridor placement check with validation levels
unsigned char can_place_corridor(unsigned char x, unsigned char y, unsigned char check_level) {
    if (!coords_in_bounds(x, y)) {
        return 0;
    }

    if (check_level == 0) {
        return 1;
    }

    if (check_level >= 2) {
        unsigned char room_idx;
        if (point_in_any_room(x, y, &room_idx)) {
            return 0;
        }

        unsigned char tile = get_compact_tile(x, y);
        if (tile == TILE_FLOOR || tile == TILE_DOOR || tile == TILE_SECRET_PATH) {
            return 0;
        }
    }

    return 1;
}



// Validity check for room connections - essential for array bounds safety
unsigned char can_connect_rooms_safely(unsigned char room1, unsigned char room2) {
    return (room1 != room2 && room1 < room_count && room2 < room_count);
}

static void compute_corridor_breakpoints(unsigned char start_x, unsigned char start_y,
                                         unsigned char end_x, unsigned char end_y,
                                         unsigned char wall_side, unsigned char corridor_type,
                                         CorridorBreakpoints *out) {
    out->count = 0;
    out->x[0] = 255; out->y[0] = 255;
    out->x[1] = 255; out->y[1] = 255;

    switch (corridor_type) {
        case 1: {
            unsigned char pivot_x;
            unsigned char pivot_y;

            if ((wall_side & 0x02) == 0) {
                pivot_x = end_x;
                pivot_y = start_y;
            } else {
                pivot_x = start_x;
                pivot_y = end_y;
            }

            out->count = 1;
            out->x[0] = pivot_x;
            out->y[0] = pivot_y;
            break;
        }

        case 2: {
            unsigned char seg1_end_x = start_x;
            unsigned char seg1_end_y = start_y;
            unsigned char seg2_end_x = start_x;
            unsigned char seg2_end_y = start_y;

            unsigned char dx = abs_diff_inline(end_x, start_x);
            unsigned char dy = abs_diff_inline(end_y, start_y);

            if ((wall_side & 0x02) == 0) {
                unsigned char leg_length = dx / 3;
                if (end_x > start_x) seg1_end_x = start_x + leg_length;
                else seg1_end_x = start_x - leg_length;
                seg1_end_y = start_y;
                seg2_end_x = seg1_end_x;
                seg2_end_y = end_y;
            } else {
                unsigned char leg_length = dy / 3;
                seg1_end_x = start_x;
                if (end_y > start_y) seg1_end_y = start_y + leg_length;
                else seg1_end_y = start_y - leg_length;
                seg2_end_x = end_x;
                seg2_end_y = seg1_end_y;
            }

            out->count = 2;
            out->x[0] = seg1_end_x;
            out->y[0] = seg1_end_y;
            out->x[1] = seg2_end_x;
            out->y[1] = seg2_end_y;
            break;
        }
    }
}


// =============================================================================
// CORRIDOR DRAWING FUNCTIONS (RESTORED WORKING ORIGINALS)
// =============================================================================

#define CORRIDOR_MODE_CHECK 0
#define CORRIDOR_MODE_DRAW 1

// Simple stepping logic
static void step_towards_target(unsigned char *x, unsigned char *y, unsigned char target_x, unsigned char target_y) {
    if (*x < target_x) (*x)++;
    else if (*x > target_x) (*x)--;

    if (*y < target_y) (*y)++;
    else if (*y > target_y) (*y)--;
}

static unsigned char walk_corridor_line(unsigned char start_x, unsigned char start_y,
                                        unsigned char end_x, unsigned char end_y,
                                        unsigned char mode, unsigned char tile_type) {
    unsigned char x = start_x;
    unsigned char y = start_y;

    if (mode == CORRIDOR_MODE_CHECK) {
        while (x != end_x || y != end_y) {
            if (!can_place_corridor(x, y, 2)) {
                return 0;
            }
            step_towards_target(&x, &y, end_x, end_y);
        }
    } else {
        while (x != end_x || y != end_y) {
            set_compact_tile(x, y, tile_type);
            place_walls_around_corridor_tile(x, y);
            step_towards_target(&x, &y, end_x, end_y);
        }
    }

    return 1;
}

static unsigned char process_corridor_path(unsigned char start_x, unsigned char start_y,
                                           unsigned char end_x, unsigned char end_y,
                                           unsigned char wall_side, unsigned char corridor_type,
                                           unsigned char mode, unsigned char tile_type) {
    CorridorBreakpoints breakpoints;
    unsigned char current_x = start_x;
    unsigned char current_y = start_y;

    compute_corridor_breakpoints(start_x, start_y, end_x, end_y, wall_side, corridor_type, &breakpoints);

    for (unsigned char i = 0; i < breakpoints.count; i++) {
        unsigned char next_x = breakpoints.x[i];
        unsigned char next_y = breakpoints.y[i];
        if (next_x == 255 || next_y == 255) {
            continue; // Skip sentinel breakpoints
        }
        if (!walk_corridor_line(current_x, current_y, next_x, next_y, mode, tile_type)) {
            return 0;
        }
        current_x = next_x;
        current_y = next_y;
    }

    if (!walk_corridor_line(current_x, current_y, end_x, end_y, mode, tile_type)) {
        return 0;
    }

    return 1;
}

void draw_corridor_from_door(unsigned char exit1_x, unsigned char exit1_y,
                            unsigned char wall1_side, unsigned char exit2_x, unsigned char exit2_y,
                            unsigned char corridor_type, unsigned char is_secret) {
    unsigned char tile_type = is_secret ? TILE_SECRET_PATH : TILE_FLOOR;
    process_corridor_path(exit1_x, exit1_y, exit2_x, exit2_y, wall1_side, corridor_type,
                          CORRIDOR_MODE_DRAW, tile_type);
}

// =============================================================================
// ROOM CONNECTION IMPLEMENTATION (RESTORED WORKING ORIGINALS)
// =============================================================================

// Calculate straight corridor exits
static void calculate_straight_exits(unsigned char room1, unsigned char room2,
                                    unsigned char *exit1_x, unsigned char *exit1_y,
                                    unsigned char *exit2_x, unsigned char *exit2_y) {
    Room *r1 = &room_list[room1];
    Room *r2 = &room_list[room2];
    
    unsigned char r1_cx, r1_cy, r2_cx, r2_cy;
    get_room_center_ptr(r1, &r1_cx, &r1_cy);
    get_room_center_ptr(r2, &r2_cx, &r2_cy);
    
    if (r1_cx == r2_cx) {
        // Vertical alignment
        *exit1_x = r1_cx; *exit2_x = r2_cx;
        if (r1_cy < r2_cy) {
            *exit1_y = r1->y + r1->h; *exit2_y = r2->y - 1;
        } else {
            *exit1_y = r1->y - 1; *exit2_y = r2->y + r2->h;
        }
    } else {
        // Horizontal alignment
        *exit1_y = r1_cy; *exit2_y = r2_cy;
        if (r1_cx < r2_cx) {
            *exit1_x = r1->x + r1->w; *exit2_x = r2->x - 1;
        } else {
            *exit1_x = r1->x - 1; *exit2_x = r2->x + r2->w;
        }
    }
}

// Check for straight corridor possibility
static unsigned char can_use_straight_corridor(unsigned char room1, unsigned char room2) {
    Room *r1 = &room_list[room1];
    Room *r2 = &room_list[room2];
    
    unsigned char r1_cx, r1_cy, r2_cx, r2_cy;
    get_room_center_ptr(r1, &r1_cx, &r1_cy);
    get_room_center_ptr(r2, &r2_cx, &r2_cy);
    
    if (r1_cx == r2_cx) {
        // Vertical alignment - check facing
        return (r1_cy < r2_cy) ? (r1->y + r1->h <= r2->y) : (r2->y + r2->h <= r1->y);
    }
    if (r1_cy == r2_cy) {
        // Horizontal alignment - check facing
        return (r1_cx < r2_cx) ? (r1->x + r1->w <= r2->x) : (r2->x + r2->w <= r1->x);
    }
    return 0;
}

// Calculate L-corridor exits
static void calculate_l_exits(unsigned char room1, unsigned char room2,
                            unsigned char *exit1_x, unsigned char *exit1_y,
                            unsigned char *exit2_x, unsigned char *exit2_y) {
    Room *r1 = &room_list[room1];
    Room *r2 = &room_list[room2];
    
    unsigned char r1_center_x, r1_center_y, r2_center_x, r2_center_y;
    get_room_center_ptr(r1, &r1_center_x, &r1_center_y);
    get_room_center_ptr(r2, &r2_center_x, &r2_center_y);
    
    unsigned char dx = abs_diff_inline(r2_center_x, r1_center_x);
    unsigned char dy = abs_diff_inline(r2_center_y, r1_center_y);
    
    if (dx > dy) {
        // Horizontal distance greater - use vertical walls
        if (r2_center_x > r1_center_x) {
            *exit1_x = r1->x + r1->w; *exit1_y = r1_center_y;
        } else {
            *exit1_x = r1->x - 1; *exit1_y = r1_center_y;
        }
        if (r2_center_y > r1_center_y) {
            *exit2_x = r2_center_x; *exit2_y = r2->y - 1;
        } else {
            *exit2_x = r2_center_x; *exit2_y = r2->y + r2->h;
        }
    } else {
        // Vertical distance greater - use horizontal walls
        if (r2_center_y > r1_center_y) {
            *exit1_x = r1_center_x; *exit1_y = r1->y + r1->h;
        } else {
            *exit1_x = r1_center_x; *exit1_y = r1->y - 1;
        }
        if (r2_center_x > r1_center_x) {
            *exit2_x = r2->x - 1; *exit2_y = r2_center_y;
        } else {
            *exit2_x = r2->x + r2->w; *exit2_y = r2_center_y;
        }
    }
}

// Try L-corridor with gap validation
static unsigned char try_calculate_l_corridor(unsigned char room1, unsigned char room2,
                                            unsigned char *exit1_x, unsigned char *exit1_y,
                                            unsigned char *exit2_x, unsigned char *exit2_y) {
    Room *r1 = &room_list[room1];
    Room *r2 = &room_list[room2];
    
    // Calculate gaps between room boundaries
    unsigned char horizontal_gap = 0, vertical_gap = 0;
    
    if (r1->x + r1->w <= r2->x) {
        horizontal_gap = r2->x - (r1->x + r1->w);
    } else if (r2->x + r2->w <= r1->x) {
        horizontal_gap = r1->x - (r2->x + r2->w);
    } else {
        return 0; // Overlap horizontally
    }
    
    if (r1->y + r1->h <= r2->y) {
        vertical_gap = r2->y - (r1->y + r1->h);
    } else if (r2->y + r2->h <= r1->y) {
        vertical_gap = r1->y - (r2->y + r2->h);
    } else {
        return 0; // Overlap vertically
    }
    
    // L-corridor viable if both gaps > 0
    if (horizontal_gap > 0 && vertical_gap > 0) {
        calculate_l_exits(room1, room2, exit1_x, exit1_y, exit2_x, exit2_y);
        return 1;
    }
    return 0;
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

// =============================================================================
// ROOM CONNECTION LOGIC
// =============================================================================

// Connect two rooms with original working algorithm (optimized)
unsigned char connect_rooms(unsigned char room1, unsigned char room2, unsigned char is_secret) {
    // Check if already connected
    if (room_has_connection_to(room1, room2)) {
        return 1;
    }
    
    // Safety check
    if (!can_connect_rooms_safely(room1, room2)) {
        return 0;
    }
    
    Room *r1 = &room_list[room1];
    Room *r2 = &room_list[room2];
    
    // Calculate room centers
    unsigned char r1_center_x, r1_center_y, r2_center_x, r2_center_y;
    get_room_center_ptr(r1, &r1_center_x, &r1_center_y);
    get_room_center_ptr(r2, &r2_center_x, &r2_center_y);
    
    // Corridor type selection with original working logic
    unsigned char corridor_type = 2; // Default to Z-shaped
    unsigned char exit1_x, exit1_y, exit2_x, exit2_y;
    
    // Priority: Straight > L-shaped > Z-shaped
    if (can_use_straight_corridor(room1, room2)) {
        corridor_type = 0;
        calculate_straight_exits(room1, room2, &exit1_x, &exit1_y, &exit2_x, &exit2_y);
    } else if (try_calculate_l_corridor(room1, room2, &exit1_x, &exit1_y, &exit2_x, &exit2_y)) {
        corridor_type = 1;
    } else {
        corridor_type = 2;
        calculate_exit_from_target(room1, r2_center_x, r2_center_y, &exit1_x, &exit1_y);
        calculate_exit_from_target(room2, r1_center_x, r1_center_y, &exit2_x, &exit2_y);
    }
    
    // Draw corridor using original working algorithm
    unsigned char wall1 = get_wall_side_from_exit(room1, exit1_x, exit1_y);
    unsigned char wall2 = get_wall_side_from_exit(room2, exit2_x, exit2_y);

    draw_corridor_from_door(exit1_x, exit1_y, wall1, exit2_x, exit2_y, corridor_type, is_secret);
    
    // Place doors
    if (is_secret) {
        set_compact_tile(exit1_x, exit1_y, TILE_SECRET_PATH);
        set_compact_tile(exit2_x, exit2_y, TILE_SECRET_PATH);
    } else {
        place_door(exit1_x, exit1_y);
        place_door(exit2_x, exit2_y);
    }
    
    // Mark secret rooms
    if (is_secret) {
        room_list[room1].state |= ROOM_SECRET;
        room_list[room2].state |= ROOM_SECRET;
    }
    
    // Store connection metadata
    if (!add_connection_to_room(room1, room2, exit1_x, exit1_y, wall1, corridor_type)) {
        return 0;
    }
    
    if (!add_connection_to_room(room2, room1, exit2_x, exit2_y, wall2, corridor_type)) {
        remove_last_connection_from_room(room1);
        return 0;
    }
    
    // Calculate breakpoints
    calculate_and_store_breakpoints(room1, room_list[room1].connections - 1);
    calculate_and_store_breakpoints(room2, room_list[room2].connections - 1);
    
    return 1;
}

// init_connection_system() removed - initialization handled by init_rooms() to avoid duplication

// =============================================================================
// MST CONNECTION ALGORITHM
// =============================================================================

// Connect all rooms using Minimum Spanning Tree algorithm
void build_room_network(void) {
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
            if (connect_rooms(best_room1, best_room2, 0)) {
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
    unsigned char target_secret_count = current_params.secret_room_count;

    for (unsigned char i = 0; i < room_count && secrets_made < target_secret_count; i++) {
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


// =============================================================================
// FALSE CORRIDOR SYSTEM
// =============================================================================

// Create a false corridor with optimized logic
static unsigned char create_false_corridor(unsigned char room_idx, unsigned char wall_side) {
    Room *room = &room_list[room_idx];

    if (room->state & ROOM_SECRET) return 0;
    if (wall_has_doors(room_idx, wall_side)) return 0;

    if ((room->state & ROOM_HAS_TREASURE) &&
        room->treasure_wall_x != 255 && room->treasure_wall_y != 255) {
        unsigned char treasure_wall = get_wall_side_from_exit(room_idx,
                                                              room->treasure_wall_x,
                                                              room->treasure_wall_y);
        if (treasure_wall == wall_side) {
            return 0;
        }
    }

    unsigned char door_x;
    unsigned char door_y;

    if (wall_side == 0) {
        if (room->h <= 2) return 0;
        door_x = room->x - 1;
        door_y = room->y + 1 + rnd(room->h - 2);
    } else if (wall_side == 1) {
        if (room->h <= 2) return 0;
        door_x = room->x + room->w;
        door_y = room->y + 1 + rnd(room->h - 2);
    } else if (wall_side == 2) {
        if (room->w <= 2) return 0;
        door_x = room->x + 1 + rnd(room->w - 2);
        door_y = room->y - 1;
    } else if (wall_side == 3) {
        if (room->w <= 2) return 0;
        door_x = room->x + 1 + rnd(room->w - 2);
        door_y = room->y + room->h;
    } else {
        return 0;
    }

    unsigned char base_length = 4 + rnd(6);
    signed char dx = 0;
    signed char dy = 0;

    switch (wall_side) {
        case 0: dx = -1; dy = 0; break;
        case 1: dx = 1; dy = 0; break;
        case 2: dx = 0; dy = -1; break;
        case 3: dx = 0; dy = 1; break;
        default: return 0;
    }

    signed char target_x = (signed char)door_x;
    signed char target_y = (signed char)door_y;

    target_x += (signed char)(dx * base_length);
    target_y += (signed char)(dy * base_length);

    if (rnd(100) < 70) {
        signed char offset_x = rnd(2) ? (signed char)(1 + rnd(4)) : (signed char)-(1 + rnd(4));
        signed char offset_y = rnd(2) ? (signed char)(1 + rnd(4)) : (signed char)-(1 + rnd(4));
        target_x += offset_x;
        target_y += offset_y;
    }

    if (target_x < 2 || target_x >= (signed char)(MAP_W - 2) ||
        target_y < 2 || target_y >= (signed char)(MAP_H - 2)) {
        return 0;
    }

    unsigned char final_x = (unsigned char)target_x;
    unsigned char final_y = (unsigned char)target_y;

    unsigned char collision_room;
    if (point_in_any_room(final_x, final_y, &collision_room)) {
        return 0;
    }

    unsigned char corridor_type;
    if (door_x == final_x || door_y == final_y) {
        corridor_type = 0;
    } else {
        unsigned char dx_abs = (final_x > door_x) ? final_x - door_x : door_x - final_x;
        unsigned char dy_abs = (final_y > door_y) ? final_y - door_y : door_y - final_y;
        corridor_type = (dx_abs > 2 && dy_abs > 2) ? 1 : 2;
    }

    if (!process_corridor_path(door_x, door_y, final_x, final_y, wall_side, corridor_type,
                               CORRIDOR_MODE_CHECK, TILE_FLOOR)) {
        return 0;
    }

    process_corridor_path(door_x, door_y, final_x, final_y, wall_side, corridor_type,
                          CORRIDOR_MODE_DRAW, TILE_FLOOR);

    place_door(door_x, door_y);

    // Store corridor endpoints only - type can be recalculated from coordinates if needed
    room->state |= ROOM_HAS_FALSE_CORRIDOR;
    room->false_corridor_door_x = door_x;
    room->false_corridor_door_y = door_y;
    room->false_corridor_end_x = final_x;
    room->false_corridor_end_y = final_y;

    return 1;
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
        
        if (create_false_corridor(room_idx, wall_side)) {
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
        // Skip walls that already host doors or false corridor entrances
        if (wall_has_doors(room_idx, wall_side)) {
            continue;
        }
        if ((room->state & ROOM_HAS_FALSE_CORRIDOR) &&
            room->false_corridor_door_x != 255 && room->false_corridor_door_y != 255) {
            unsigned char corridor_wall = get_wall_side_from_exit(room_idx,
                                                                  room->false_corridor_door_x,
                                                                  room->false_corridor_door_y);
            if (corridor_wall == wall_side) {
                continue;
            }
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

            // Mark room as having treasure and store wall position only
            // Target coordinates can be recalculated from wall position and wall side
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

    // Reset stored breakpoints to invalid markers before recomputing
    room->breakpoints[connection_idx][0].x = 255;
    room->breakpoints[connection_idx][0].y = 255;
    room->breakpoints[connection_idx][1].x = 255;
    room->breakpoints[connection_idx][1].y = 255;

    CorridorBreakpoints computed;
    compute_corridor_breakpoints(door1_x, door1_y, door2_x, door2_y, wall1_side, corridor_type, &computed);

    for (unsigned char i = 0; i < computed.count && i < 2; i++) {
        unsigned char bp_x = computed.x[i];
        unsigned char bp_y = computed.y[i];
        if (bp_x == 255 || bp_y == 255) continue;
        room->breakpoints[connection_idx][i].x = bp_x;
        room->breakpoints[connection_idx][i].y = bp_y;
    }
}



