// =============================================================================
// ROOM CONNECTION SYSTEM
// Explicit data storage for room connections, doors, and corridor types
// =============================================================================

#include "mapgen_types.h"
#include "mapgen_internal.h"
#include "mapgen_utils.h"
#include "mapgen_progress.h" // For progress bar functions (DEBUG only)
#include "tmea_core.h"       // For add_secret_door_metadata() and TMEA functions

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
        if (tile == TILE_FLOOR || tile == TILE_DOOR) {
            return 0;
        }
    }

    return 1;
}

// can_connect_rooms_safely() removed - MST algorithm guarantees valid indices

// Determine corridor type based on geometry (shared by normal and false corridors)
static unsigned char determine_corridor_type(unsigned char start_x, unsigned char start_y,
                                             unsigned char end_x, unsigned char end_y) {
    // Straight corridor if aligned on one axis
    if (start_x == end_x || start_y == end_y) {
        return 0;
    }

    // Calculate distances
    unsigned char dx = (end_x > start_x) ? end_x - start_x : start_x - end_x;
    unsigned char dy = (end_y > start_y) ? end_y - start_y : start_y - end_y;

    // L-shaped corridor viable if both distances are significant
    // This matches the logic from calculate_l_exits which uses dx > dy comparison
    if (dx > 2 && dy > 2) {
        return 1; // L-shaped
    }

    // Default to Z-shaped for complex cases
    return 2;
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
            if ((wall_side & 0x02) == 0) {
                // Horizontal start: middle vertical segment
                unsigned char mid_x = (start_x + end_x) / 2;
                out->x[0] = mid_x;
                out->y[0] = start_y;
                out->x[1] = mid_x;
                out->y[1] = end_y;
            } else {
                // Vertical start: middle horizontal segment
                unsigned char mid_y = (start_y + end_y) / 2;
                out->x[0] = start_x;
                out->y[0] = mid_y;
                out->x[1] = end_x;
                out->y[1] = mid_y;
            }
            out->count = 2;
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

static unsigned char build_corridor_line(unsigned char start_x, unsigned char start_y,
                                         unsigned char end_x, unsigned char end_y,
                                         unsigned char mode, unsigned char tile_type) {
    unsigned char x = start_x;
    unsigned char y = start_y;

    if (mode == CORRIDOR_MODE_CHECK) {
        // Check all tiles INCLUDING endpoint
        while (1) {
            if (!can_place_corridor(x, y, 2)) {
                return 0;
            }
            if (x == end_x && y == end_y) break;
            step_towards_target(&x, &y, end_x, end_y);
        }
    } else {
        // Draw floor tiles INCLUDING endpoint - walling handled at segment level
        while (1) {
            set_compact_tile(x, y, tile_type);
            if (x == end_x && y == end_y) break;
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

    // Loop only over valid breakpoints - count is accurate, no sentinel check needed
    for (unsigned char i = 0; i < breakpoints.count; i++) {
        unsigned char next_x = breakpoints.x[i];
        unsigned char next_y = breakpoints.y[i];

        if (!build_corridor_line(current_x, current_y, next_x, next_y, mode, tile_type)) {
            return 0;
        }

        // Segment-based walling (DRAW mode only)
        if (mode == CORRIDOR_MODE_DRAW) {
            place_wall_straight_corridor(current_x, current_y, next_x, next_y);
            place_wall_corridor_junction(next_x, next_y);  // Fill diagonal corners at breakpoint
        }

        current_x = next_x;
        current_y = next_y;
    }

    if (!build_corridor_line(current_x, current_y, end_x, end_y, mode, tile_type)) {
        return 0;
    }

    // Final segment walling
    if (mode == CORRIDOR_MODE_DRAW) {
        place_wall_straight_corridor(current_x, current_y, end_x, end_y);
    }

    return 1;
}

void draw_corridor_from_door(unsigned char exit1_x, unsigned char exit1_y,
                            unsigned char wall1_side, unsigned char exit2_x, unsigned char exit2_y,
                            unsigned char corridor_type, unsigned char is_secret) {
    // Always draw corridor as TILE_FLOOR (doors placed separately with metadata)
    process_corridor_path(exit1_x, exit1_y, exit2_x, exit2_y, wall1_side, corridor_type,
                          CORRIDOR_MODE_DRAW, TILE_FLOOR);
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
    get_room_center_ptr_inline(r1, &r1_cx, &r1_cy);
    get_room_center_ptr_inline(r2, &r2_cx, &r2_cy);

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
    get_room_center_ptr_inline(r1, &r1_cx, &r1_cy);
    get_room_center_ptr_inline(r2, &r2_cx, &r2_cy);

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
    get_room_center_ptr_inline(r1, &r1_center_x, &r1_center_y);
    get_room_center_ptr_inline(r2, &r2_center_x, &r2_center_y);

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

// Try L-corridor with gap validation (sufficient for normal room connections)
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

    // L-corridor viable if both gaps > 0 (guarantees safe pivot point)
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
    get_room_center_ptr_inline(room, &room_center_x, &room_center_y);

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
// Note: Branching door detection is now automatic in add_connection_to_room()
// No separate function needed - wall_door_count tracks doors per wall automatically

// Connect two rooms with original working algorithm (optimized)
unsigned char connect_rooms(unsigned char room1, unsigned char room2, unsigned char is_secret) {
    // Check if already connected
    if (room_has_connection_to(room1, room2)) {
        return 1;
    }

    // No safety check needed - MST guarantees: room1 != room2, both < room_count
    Room *r1 = &room_list[room1];
    Room *r2 = &room_list[room2];

    // Calculate room centers using static inline helper
    unsigned char r1_center_x, r1_center_y, r2_center_x, r2_center_y;
    get_room_center_ptr_inline(r1, &r1_center_x, &r1_center_y);
    get_room_center_ptr_inline(r2, &r2_center_x, &r2_center_y);

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

    // Draw corridor
    unsigned char wall1 = get_wall_side_from_exit(room1, exit1_x, exit1_y);
    unsigned char wall2 = get_wall_side_from_exit(room2, exit2_x, exit2_y);

    draw_corridor_from_door(exit1_x, exit1_y, wall1, exit2_x, exit2_y, corridor_type, is_secret);

    // Place doors (always TILE_DOOR, metadata marks secret doors)
    place_door(exit1_x, exit1_y);
    place_door(exit2_x, exit2_y);

    // Add secret door metadata if needed
    if (is_secret) {
        add_secret_door_metadata(exit1_x, exit1_y);
        add_secret_door_metadata(exit2_x, exit2_y);
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

    // Branching door detection is now automatic in add_connection_to_room()
    // No manual marking needed!

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
                total_connections++; // Runtime tracking for percentage calculation
#ifdef DEBUG_MAPGEN
                // Batch progress updates - only update every 2 connections for performance
                if ((connections_made & 1) == 0 || connections_made == room_count - 1) {
                    update_progress_step(1, connections_made, room_count - 1);
                }
#endif
            } else {
                break;
            }
        } else {
            break;
        }
    }
}

// =============================================================================
// SHARED HELPER FUNCTIONS
// =============================================================================

// Check if corridor between two rooms is non-branching (shared by secret rooms and hidden corridors)
static unsigned char is_non_branching_corridor(unsigned char room1, unsigned char room2) {
    // Skip secret rooms (already hidden via different mechanism)
    if (room_list[room1].state & ROOM_SECRET) return 0;
    if (room_list[room2].state & ROOM_SECRET) return 0;

    // Find room1's door to room2
    for (unsigned char i = 0; i < room_list[room1].connections; i++) {
        if (room_list[room1].conn_data[i].room_id == room2) {
            // Check room1's door flags
            unsigned char door1_x = room_list[room1].doors[i].x;
            unsigned char door1_y = room_list[room1].doors[i].y;
            if (is_door_secret(door1_x, door1_y)) return 0;  // Already secret (via TMEA)
            if (room_list[room1].doors[i].is_branching) return 0;    // Branches at room1

            // Find room2's door to room1
            for (unsigned char j = 0; j < room_list[room2].connections; j++) {
                if (room_list[room2].conn_data[j].room_id == room1) {
                    // Check room2's door flags
                    unsigned char door2_x = room_list[room2].doors[j].x;
                    unsigned char door2_y = room_list[room2].doors[j].y;
                    if (is_door_secret(door2_x, door2_y)) return 0;  // Already secret (via TMEA)
                    if (room_list[room2].doors[j].is_branching) return 0;

                    return 1; // Non-branching corridor found!
                }
            }
        }
    }

    return 0; // Connection not found or invalid
}

// =============================================================================
// SECRET ROOM SYSTEM
// =============================================================================

// Create a single secret room from a room with exactly one connection
static unsigned char create_secret_room(unsigned char room_idx) {
    Room *room = &room_list[room_idx];

    // Skip if already secret or doesn't have exactly one connection
    if (room->state & ROOM_SECRET) return 0;
    if (room->connections != 1) return 0;

    // Random chance to convert (50% of eligible rooms)
    if (rnd(100) >= SECRET_ROOM_PERCENTAGE) return 0;

    unsigned char connected_room = room->conn_data[0].room_id;

    // Reuse is_non_branching_corridor logic - check if the connection is non-branching
    if (!is_non_branching_corridor(room_idx, connected_room)) {
        return 0; // Connection is branching or invalid
    }

    // Get the connected room's door position for this connection
    unsigned char connected_door_x, connected_door_y, connected_wall_side, temp_corridor_type;
    if (!get_connection_info(connected_room, room_idx, &connected_door_x, &connected_door_y, &connected_wall_side, &temp_corridor_type)) {
        return 0; // Connection not found
    }

    // OPTIMIZED: Instant O(1) wall door count check
    // If more than 1 door on this wall, skip (would delete existing corridor)
    if (room_list[connected_room].wall_door_count[connected_wall_side] > 1) {
        return 0;
    }

    // Mark room as secret
    room->state |= ROOM_SECRET;

    // Convert the normal room's door to secret door
    // This creates a hidden entrance to the secret room
    // Door tile is already TILE_DOOR, just add secret metadata
    add_secret_door_metadata(connected_door_x, connected_door_y);

    return 1; // Successfully created secret room
}

// Main secret room placement function
void place_secret_rooms(unsigned char room_count_target) {
    if (room_count == 0 || room_count_target == 0) return;

    unsigned char secrets_made = 0;

    for (unsigned char i = 0; i < room_count && secrets_made < room_count_target; i++) {
        __assume(room_count <= MAX_ROOMS);

        if (create_secret_room(i)) {
            secrets_made++;
            total_secret_rooms++; // Runtime tracking for percentage calculation

            // Exclude secret room walls from available_walls_count
            Room *room = &room_list[i];
            for (unsigned char w = 0; w < 4; w++) {
                if (room->wall_door_count[w] == 0) {
                    available_walls_count--; // Unused walls in secret rooms not available
                }
            }

#ifdef DEBUG_MAPGEN
            // Phase 2: Secret room progress
            update_progress_step(2, secrets_made, room_count_target);
#endif
        }
    }
}

// =============================================================================
// SECRET TREASURE PLACEMENT SYSTEM
// =============================================================================


// =============================================================================
// HIDDEN CORRIDOR SYSTEM
// =============================================================================

// Create a hidden corridor by converting both door tiles to secret doors
static unsigned char create_hidden_corridor(unsigned char room1, unsigned char room2) {
    // Reuse eligibility check from shared helper
    if (!is_non_branching_corridor(room1, room2)) {
        return 0; // Not eligible for hiding
    }
    // Get door positions
    unsigned char door1_x, door1_y, wall1_side, corridor_type;
    if (!get_connection_info(room1, room2, &door1_x, &door1_y, &wall1_side, &corridor_type)) {
        return 0;
    }

    unsigned char door2_x, door2_y, wall2_side, temp_type;
    if (!get_connection_info(room2, room1, &door2_x, &door2_y, &wall2_side, &temp_type)) {
        return 0;
    }

    // Convert door tiles to secret doors using TMEA metadata
    // Door tiles are already TILE_DOOR, just add secret metadata
    add_secret_door_metadata(door1_x, door1_y);
    add_secret_door_metadata(door2_x, door2_y);

    return 1;
}

// Main hidden corridor placement function
void place_hidden_corridors(unsigned char corridor_count) {
    if (room_count < 2 || corridor_count == 0) return;

    // Static candidate storage (max 40 pairs to limit memory)
    static unsigned char candidates_room1[40];
    static unsigned char candidates_room2[40];
    unsigned char candidate_count = 0;

    // Find all non-branching corridor candidates
    for (unsigned char i = 0; i < room_count && candidate_count < 40; i++) {
        __assume(room_count <= MAX_ROOMS);
        for (unsigned char j = i + 1; j < room_count && candidate_count < 40; j++) {
            __assume(j <= MAX_ROOMS);

            // Check if connected and eligible
            if (room_has_connection_to(i, j) && is_non_branching_corridor(i, j)) {
                candidates_room1[candidate_count] = i;
                candidates_room2[candidate_count] = j;
                candidate_count++;
            }
        }
    }

    // Early exit if no candidates
    if (candidate_count == 0) {
#ifdef DEBUG_MAPGEN
        update_progress_step(5, 0, corridor_count);
#endif
        return;
    }

    // Hide random corridors from candidates
    unsigned char hidden = 0;
    unsigned char attempts = 0;
    unsigned char max_attempts = candidate_count * 2; // Reasonable attempt limit

    while (hidden < corridor_count && attempts < max_attempts) {
        unsigned char idx = rnd(candidate_count);

        if (create_hidden_corridor(candidates_room1[idx], candidates_room2[idx])) {
            hidden++;
            total_hidden_corridors++; // Runtime tracking for percentage calculation
#ifdef DEBUG_MAPGEN
            update_progress_step(5, hidden, corridor_count);
#endif
        }
        attempts++;
    }
}

// =============================================================================
// FALSE CORRIDOR SYSTEM
// =============================================================================

// Create a false corridor - Calculate available space first to prevent unsigned wrap
static unsigned char create_false_corridor(unsigned char room_idx, unsigned char wall_side) {
    Room *room = &room_list[room_idx];

    // Quick eligibility checks
    if (room->state & ROOM_SECRET) return 0;
    if (room->wall_door_count[wall_side] > 0) return 0;
    if (room->treasure_wall_side == wall_side) return 0;

    // Calculate door position and available space in single switch
    unsigned char door_x, door_y, available;
    switch (wall_side) {
        case 0: // LEFT
            if (room->h <= 2) return 0;
            door_x = room->x - 1; door_y = room->center_y;
            available = (door_x > 2) ? door_x - 2 : 0;
            break;
        case 1: // RIGHT
            if (room->h <= 2) return 0;
            door_x = room->x + room->w; door_y = room->center_y;
            available = (current_params.map_width > door_x + 3) ? current_params.map_width - door_x - 3 : 0;
            break;
        case 2: // TOP
            if (room->w <= 2) return 0;
            door_x = room->center_x; door_y = room->y - 1;
            available = (door_y > 2) ? door_y - 2 : 0;
            break;
        default: // BOTTOM
            if (room->w <= 2) return 0;
            door_x = room->center_x; door_y = room->y + room->h;
            available = (current_params.map_height > door_y + 3) ? current_params.map_height - door_y - 3 : 0;
    }

    // Need minimum 4 tiles for a meaningful corridor
    if (available < 4) return 0;

    // Choose length within available space (bias toward longer)
    unsigned char max_len = (available > 15) ? 15 : available;
    unsigned char corridor_len = 4 + rnd(max_len - 3);

    // Calculate straight endpoint (guaranteed no wrap now)
    unsigned char endpoint_x = door_x;
    unsigned char endpoint_y = door_y;
    if (wall_side & 2) // vertical (TOP/BOTTOM)
        endpoint_y = (wall_side & 1) ? door_y + corridor_len : door_y - corridor_len;
    else // horizontal (LEFT/RIGHT)
        endpoint_x = (wall_side & 1) ? door_x + corridor_len : door_x - corridor_len;

    // Add shape variety (L/Z) if length permits
    unsigned char shape = (corridor_len >= 6) ? rnd(3) : 0;
    if (shape > 0) {
        signed char offset = (shape == 1) ? (signed char)(corridor_len / 3) : (signed char)(corridor_len / 4);
        if (offset < 2) offset = 2;
        if (rnd(2)) offset = -offset;

        if (!(wall_side & 2)) {
            // Horizontal corridor (LEFT/RIGHT) - add vertical offset
            signed char new_y = (signed char)endpoint_y + offset;
            if (new_y >= 3 && new_y < (signed char)(current_params.map_height - 3)) {
                endpoint_y = (unsigned char)new_y;
            } else {
                shape = 0;  // Can't fit, use straight
            }
        } else {
            // Vertical corridor - add horizontal offset
            signed char new_x = (signed char)endpoint_x + offset;
            if (new_x >= 3 && new_x < (signed char)(current_params.map_width - 3)) {
                endpoint_x = (unsigned char)new_x;
            } else {
                shape = 0;
            }
        }
    }

    // Validate path (catches room collisions and MST corridor crossings)
    // Also check endpoint is not adjacent to existing walkable tiles (0x0C = FLOOR|DOOR)
    unsigned char corridor_type = determine_corridor_type(door_x, door_y, endpoint_x, endpoint_y);
    if (!process_corridor_path(door_x, door_y, endpoint_x, endpoint_y, wall_side, corridor_type,
                               CORRIDOR_MODE_CHECK, TILE_FLOOR) ||
        check_adjacent_tile_types(endpoint_x, endpoint_y, 0x0C, 1)) {
        // Shaped/long failed or endpoint too close to walkable - try minimum straight
        corridor_len = 4;
        endpoint_x = door_x;
        endpoint_y = door_y;
        if (wall_side & 2)
            endpoint_y = (wall_side & 1) ? door_y + corridor_len : door_y - corridor_len;
        else
            endpoint_x = (wall_side & 1) ? door_x + corridor_len : door_x - corridor_len;
        corridor_type = 0;

        if (!process_corridor_path(door_x, door_y, endpoint_x, endpoint_y, wall_side, corridor_type,
                                   CORRIDOR_MODE_CHECK, TILE_FLOOR) ||
            check_adjacent_tile_types(endpoint_x, endpoint_y, 0x0C, 1)) {
            return 0;  // Even minimum straight doesn't work or endpoint invalid
        }
    }

    // Draw the corridor (endpoint included by build_corridor_line)
    process_corridor_path(door_x, door_y, endpoint_x, endpoint_y, wall_side, corridor_type,
                          CORRIDOR_MODE_DRAW, TILE_FLOOR);

    // Wall the dead-end (diagonal corners not covered by segment walling)
    place_walls_around_corridor_tile(endpoint_x, endpoint_y);

    place_door(door_x, door_y);

    room->state |= ROOM_HAS_FALSE_CORRIDOR;
    room->false_corridor_wall_side = wall_side;
    room->false_corridor_end_x = endpoint_x;
    room->false_corridor_end_y = endpoint_y;
    room->wall_door_count[wall_side]++;

    return 1;
}



// Place false corridors across the map - keep trying until target reached
void place_false_corridors(unsigned char corridor_count) {
    if (room_count == 0 || corridor_count == 0) return;

    unsigned char corridors_placed = 0;
    unsigned char attempts = 0;
    unsigned char max_attempts = room_count << 5;  // room_count * 32 - early exits are fast

    // Keep trying random room/wall combinations until we reach target or max attempts
    while (corridors_placed < corridor_count && attempts < max_attempts) {
        unsigned char room_idx = rnd(room_count);
        unsigned char wall_side = rnd(4);  // Choose random wall (0=left, 1=right, 2=top, 3=bottom)

        if (create_false_corridor(room_idx, wall_side)) {
            corridors_placed++;
            total_false_corridors++; // Runtime tracking for percentage calculation
            // NOTE: available_walls_count-- already handled in create_false_corridor() line ~811
#ifdef DEBUG_MAPGEN
            // Phase 4: False corridor placement progress
            update_progress_step(4, corridors_placed, corridor_count);
#endif
        }
        attempts++;
    }
}

// Create a single secret treasure for a room
static unsigned char create_secret_treasure(unsigned char room_idx) {
    Room *room = &room_list[room_idx];

    // Skip rooms that already have treasure or are secret rooms
    if (room->state & (ROOM_HAS_TREASURE | ROOM_SECRET)) {
        return 0; // Room already has treasure or is a secret room
    }

    // Try each wall side to find walls without doors
    for (unsigned char wall_side = 0; wall_side < 4; wall_side++) {
        // OPTIMIZED: Instant O(1) wall check using wall_door_count
        if (room->wall_door_count[wall_side] > 0) {
            continue;
        }

        // OPTIMIZED: Direct wall_side comparison (no coordinate recalculation!)
        if (room->false_corridor_wall_side == wall_side) {
            continue;
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

        // Boundary check: treasure chamber + surrounding walls must be ≥3 tiles from map edges
        // treasure_x/y ±1 for walls = 3 tiles minimum margin required
        if (treasure_x < 3 || treasure_x >= current_params.map_width - 3 ||
            treasure_y < 3 || treasure_y >= current_params.map_height - 3) {
            continue; // Skip this wall, treasure would be too close to map boundary
        }

        // set_compact_tile() already handles bounds checking
        // Create secret door in wall, normal floor in treasure chamber
        set_compact_tile(wall_x, wall_y, TILE_DOOR);
        add_secret_door_metadata(wall_x, wall_y);
        set_compact_tile(treasure_x, treasure_y, TILE_FLOOR);

        // Place walls around treasure chamber
        place_walls_around_corridor_tile(treasure_x, treasure_y);

        // OPTIMIZED: Store wall_side only (coordinates can be recalculated!)
        // Target coordinates can be calculated from wall_side + room geometry
        room->state |= ROOM_HAS_TREASURE;
        room->treasure_wall_side = wall_side;  // Only 1 byte!

        return 1; // Successfully placed treasure
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

        if (create_secret_treasure(room_idx)) {
            treasures_placed++;
            total_treasures++; // Runtime tracking for percentage calculation
            available_walls_count--; // Treasure uses 1 wall
#ifdef DEBUG_MAPGEN
            // Phase 3: Treasure placement progress
            update_progress_step(3, treasures_placed, treasure_count);
#endif
        }
        attempts++;
    }
}

// =============================================================================
// CORRIDOR BREAKPOINT CALCULATION SYSTEM
// =============================================================================

// =============================================================================
// CORRIDOR TILE CACHE SYSTEM
// =============================================================================


