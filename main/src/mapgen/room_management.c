// =============================================================================
// ROOM MANAGEMENT MODULE 
// Room placement, validation, and connection management
// =============================================================================

// System headers
#include <conio.h>
// Project headers
#include "mapgen_types.h"      // For Room, MAX_ROOMS, Viewport
#include "mapgen_internal.h"   // For room placement/validation and global variable declarations
#include "mapgen_utils.h"      // For utility functions

// External reference to current generation parameters
extern MapParameters current_params;

// Local constants
// Use const instead of #define for better code generation
static const unsigned char MAP_BORDER = 1;
static const unsigned char BORDER_PADDING = 1;
static const unsigned char PLACEMENT_ATTEMPTS = 15;

// =============================================================================
// UTILITY FUNCTIONS
// ============================================================================="

// get_grid_position() wrapper removed - inlined for OSCAR64 efficiency

// =============================================================================
// ROOM VALIDATION FUNCTIONS
// =============================================================================

/**
 * @brief Validates if a room can be placed at the specified location
 * @param x Room top-left X coordinate
 * @param y Room top-left Y coordinate  
 * @param w Room width in tiles
 * @param h Room height in tiles
 * @return 1 if placement is valid, 0 if placement conflicts
 */
unsigned char can_place_room(unsigned char x, unsigned char y, unsigned char w, unsigned char h) {
    // Calculate safety margin boundaries with minimum room distance
    unsigned char buffer_x1 = (x >= MIN_ROOM_DISTANCE + BORDER_PADDING) ? x - MIN_ROOM_DISTANCE : BORDER_PADDING;
    unsigned char buffer_y1 = (y >= MIN_ROOM_DISTANCE + BORDER_PADDING) ? y - MIN_ROOM_DISTANCE : BORDER_PADDING;
    unsigned char buffer_x2 = x + w + MIN_ROOM_DISTANCE;
    unsigned char buffer_y2 = y + h + MIN_ROOM_DISTANCE;
    
    // Check map boundaries - early return if placement exceeds map
    if (buffer_x2 + BORDER_PADDING >= current_params.map_width || buffer_y2 + BORDER_PADDING >= current_params.map_height) {
        return 0;
    }

    // No clamp needed - early return above guarantees buffer_x2/y2 in bounds

    // Check if safety margin is clear
    for (unsigned char iy = buffer_y1; iy <= buffer_y2; iy++) {
        for (unsigned char ix = buffer_x1; ix <= buffer_x2; ix++) {
            if (get_compact_tile(ix, iy) != TILE_EMPTY) {
                return 0;
            }
        }
    }
    
    return 1;
}

// =============================================================================
// ROOM PLACEMENT FUNCTIONS
// =============================================================================

// Attempts to place room at specified grid position with simplified range calculation
unsigned char try_place_room_at_grid(unsigned char grid_index, unsigned char w, unsigned char h,
                                    unsigned char *result_x, unsigned char *result_y) {
    // Get base grid position using optimized inline helpers
    const unsigned char grid_x = get_grid_x(grid_index);
    const unsigned char grid_y = get_grid_y(grid_index);
    const unsigned char cell_w = get_grid_cell_width(current_params.map_width);
    const unsigned char cell_h = get_grid_cell_height(current_params.map_height);

    // Calculate grid cell boundaries
    const unsigned char cell_min_x = MAP_BORDER + grid_x * cell_w;
    const unsigned char cell_min_y = MAP_BORDER + grid_y * cell_h;
    const unsigned char cell_max_x = cell_min_x + cell_w - 1;
    const unsigned char cell_max_y = cell_min_y + cell_h - 1;

    // Expand placement boundaries with safety buffers for overlap
    const unsigned char buffer = MIN_ROOM_DISTANCE;
    unsigned char expanded_min_x = (cell_min_x > buffer) ? cell_min_x - buffer : MAP_BORDER;
    unsigned char expanded_min_y = (cell_min_y > buffer) ? cell_min_y - buffer : MAP_BORDER;
    unsigned char expanded_max_x = cell_max_x + buffer;
    unsigned char expanded_max_y = cell_max_y + buffer;

    // Clamp expanded boundaries to map limits using helper
    expanded_max_x = clamp_max(expanded_max_x, current_params.map_width - MAP_BORDER);
    expanded_max_y = clamp_max(expanded_max_y, current_params.map_height - MAP_BORDER);

    // Calculate valid placement range ensuring full room fits within boundaries
    const unsigned char placement_min_x = expanded_min_x;
    const unsigned char placement_min_y = expanded_min_y;
    
    // Room must fit entirely within expanded bounds
    if (expanded_max_x + 1 < w || expanded_max_y + 1 < h) {
        return 0; // Room too large for available space
    }
    
    const unsigned char placement_max_x = expanded_max_x - (w - 1);
    const unsigned char placement_max_y = expanded_max_y - (h - 1);
    
    // Validate that placement range is valid
    if (placement_min_x > placement_max_x || placement_min_y > placement_max_y) {
        return 0; // No valid placement area
    }

    // If min <= max, then range = max - min + 1 >= 1 (mathematically guaranteed)
    const unsigned char range_x = placement_max_x - placement_min_x + 1;
    const unsigned char range_y = placement_max_y - placement_min_y + 1;

    // Try multiple placement attempts within calculated range
    unsigned char attempts = 0;
    while (attempts < PLACEMENT_ATTEMPTS) {
        const unsigned char x = placement_min_x + rnd(range_x);
        const unsigned char y = placement_min_y + rnd(range_y);

        // Test placement validity
        if (can_place_room(x, y, w, h)) {
            *result_x = x;
            *result_y = y;
            return 1; // Success
        }

        attempts++;
    }

    return 0; // Failed to place
}

// Creates room and adds it to the room list with walls
void place_room(unsigned char x, unsigned char y, unsigned char w, unsigned char h) {
    // Fill room area with floor tiles
    for (unsigned char iy = y; iy < y + h; iy++) {
        for (unsigned char ix = x; ix < x + w; ix++) {
            set_compact_tile(ix, iy, TILE_FLOOR);
        }
    }
    
    // Place walls around the room immediately
    place_walls_around_room(x, y, w, h);
    
    // Add room to list if capacity allows
    if (room_count < MAX_ROOMS) {
        room_list[room_count].x = x;
        room_list[room_count].y = y;
        room_list[room_count].w = w;
        room_list[room_count].h = h;
        room_list[room_count].center_x = x + (w - 1) / 2;
        room_list[room_count].center_y = y + (h - 1) / 2;

        // Reset per-room metadata to sentinel defaults on placement
        room_list[room_count].treasure_wall_side = 255;       // 255 = no treasure
        room_list[room_count].false_corridor_wall_side = 255; // 255 = no false corridor
        room_list[room_count].false_corridor_end_x = 255;
        room_list[room_count].false_corridor_end_y = 255;

        room_count++;
    }
}

// =============================================================================
// DOOR MANAGEMENT FUNCTIONS
// =============================================================================

// Centralized connection validation - checks if rooms are already connected
unsigned char room_has_connection_to(unsigned char room_idx, unsigned char target_room) {
    if (room_idx >= room_count) return 0;
    
    for (unsigned char i = 0; i < room_list[room_idx].connections; i++) {
        if (room_list[room_idx].conn_data[i].room_id == target_room) {
            return 1; // Connection exists
        }
    }
    return 0; // No connection found
}

// Get connection info for specific connected room
unsigned char get_connection_info(unsigned char room_idx, unsigned char target_room,
                                 unsigned char *door_x, unsigned char *door_y, 
                                 unsigned char *wall_side, unsigned char *corridor_type) {
    if (room_idx >= room_count) return 0;
    
    for (unsigned char i = 0; i < room_list[room_idx].connections; i++) {
        if (room_list[room_idx].conn_data[i].room_id == target_room) {
            *door_x = room_list[room_idx].doors[i].x;
            *door_y = room_list[room_idx].doors[i].y;
            *wall_side = room_list[room_idx].doors[i].wall_side;
            *corridor_type = room_list[room_idx].conn_data[i].corridor_type;
            return 1; // Found connection
        }
    }
    return 0; // Connection not found
}


// Atomic connection management - adds connection metadata in single operation
unsigned char add_connection_to_room(unsigned char room_idx, unsigned char connected_room,
                                    unsigned char door_x, unsigned char door_y,
                                    unsigned char wall_side, unsigned char corridor_type) {
    // Validate room capacity
    if (room_idx >= room_count || room_list[room_idx].connections >= 4) {
        return 0; // Failed - room full or invalid
    }

    unsigned char idx = room_list[room_idx].connections;

    // Atomic update - all metadata synchronized in single operation
    room_list[room_idx].conn_data[idx].room_id = connected_room;
    room_list[room_idx].conn_data[idx].corridor_type = corridor_type;

    room_list[room_idx].doors[idx].x = door_x;
    room_list[room_idx].doors[idx].y = door_y;
    room_list[room_idx].doors[idx].wall_side = wall_side;
    room_list[room_idx].doors[idx].reserved = 0; // Clear reserved bits

    // Increment wall door counter for instant O(1) wall queries
    room_list[room_idx].wall_door_count[wall_side]++;

    // Auto-mark branching if multiple doors on this wall
    // This eliminates the need for mark_branching_doors_for_connection()
    if (room_list[room_idx].wall_door_count[wall_side] > 1) {
        // Mark ALL doors on this wall as branching (includes current door!)
        for (unsigned char i = 0; i <= idx; i++) {
            if (room_list[room_idx].doors[i].wall_side == wall_side) {
                room_list[room_idx].doors[i].is_branching = 1;
            }
        }
    }

    room_list[room_idx].connections++; // Update counter last
    return 1; // Success
}

// Atomic rollback - removes last connection from room safely
unsigned char remove_last_connection_from_room(unsigned char room_idx) {
    if (room_idx >= room_count || room_list[room_idx].connections == 0) {
        return 0; // Nothing to remove or invalid room
    }
    
    // Atomic rollback - simply decrement counter (connection data will be overwritten)
    room_list[room_idx].connections--;
    return 1; // Success
}

// Clean implementation - all metadata management through atomic operations

// =============================================================================
// ROOM GENERATION
// =============================================================================

// Initialize room data structures
void init_rooms(void) {
    for (unsigned char i = 0; i < MAX_ROOMS; i++) {
        room_list[i].x = 0;
        room_list[i].y = 0;
        room_list[i].w = 0;
        room_list[i].h = 0;
        room_list[i].center_x = 0;
        room_list[i].center_y = 0;
        room_list[i].connections = 0;
        room_list[i].state = 0;

        // Initialize wall door counters (optimization)
        for (unsigned char w = 0; w < 4; w++) {
            room_list[i].wall_door_count[w] = 0;
        }

        // Initialize packed connection data
        for (unsigned char j = 0; j < 4; j++) {
            room_list[i].conn_data[j].room_id = 31; // Invalid room index (unused slot marker)
            room_list[i].conn_data[j].corridor_type = 0;

            // Initialize doors
            room_list[i].doors[j].x = 0;
            room_list[i].doors[j].y = 0;
            room_list[i].doors[j].wall_side = 0;
            room_list[i].doors[j].is_secret_door = 0;
            room_list[i].doors[j].has_treasure = 0;
            room_list[i].doors[j].is_branching = 0; // Initialize as non-branching
            room_list[i].doors[j].reserved = 0; // Clear reserved bits

            // Initialize corridor breakpoints (invalid coordinates)
            room_list[i].breakpoints[j][0].x = 255; // Invalid marker
            room_list[i].breakpoints[j][0].y = 255;
            room_list[i].breakpoints[j][1].x = 255; // Invalid marker
            room_list[i].breakpoints[j][1].y = 255;
        }

        // Initialize treasure and corridor metadata (optimized - wall_side only)
        room_list[i].treasure_wall_side = 255;       // 255 = no treasure
        room_list[i].false_corridor_wall_side = 255; // 255 = no false corridor
        room_list[i].false_corridor_end_x = 255;
        room_list[i].false_corridor_end_y = 255;
    }
    room_count = 0;
}

// Generates all rooms using grid-based placement
void create_rooms(void) {
    unsigned char placed_rooms = 0;
    unsigned char grid_positions[16]; // Maximum 4x4 grid
    unsigned char grid_count = 0;

    // Initialize room structures
    init_rooms();
    
    // Room creation phase - progress handled by main generation loop
    
    // Initialize grid position array
    for (unsigned char i = 0; i < GRID_SIZE * GRID_SIZE; i++) {
        grid_positions[i] = i;
        grid_count++;
    }
    
    // Shuffle grid positions using Fisher-Yates algorithm
    for (unsigned char i = grid_count - 1; i > 0; i--) {
        unsigned char j = rnd(i + 1);
        unsigned char temp = grid_positions[i];
        grid_positions[i] = grid_positions[j];
        grid_positions[j] = temp;
    }

    // Generate rooms at shuffled grid positions
    for (unsigned char i = 0; i < current_params.max_rooms && placed_rooms < current_params.max_rooms && i < grid_count; i++) {
        unsigned char w, h, x, y;
        unsigned char min_size = current_params.min_room_size;
        unsigned char max_size = current_params.max_room_size;
        unsigned char size_range = max_size - min_size;

        // Generate room size - both dimensions random from range
        w = min_size + rnd(size_range + 1);
        h = min_size + rnd(size_range + 1);
        
        // Attempt to place room at grid position
        if (try_place_room_at_grid(grid_positions[i], w, h, &x, &y)) {
            place_room(x, y, w, h);
            placed_rooms++;
            // Phase 0: Room placement progress
            update_progress_step(0, placed_rooms, current_params.max_rooms);
        }
    }
    
    // Finalize room generation
    room_count = placed_rooms;
}