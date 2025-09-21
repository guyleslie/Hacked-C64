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

// Local constants
#define MAP_BORDER 1
#define BORDER_PADDING 1
#define SCATTER_RANGE 3
#define PLACEMENT_ATTEMPTS 15
#define VARIATION_THRESHOLD 5
#define DEFAULT_PRIORITY 5
#define START_ROOM_PRIORITY 10
#define END_ROOM_PRIORITY 8
#define PRIORITY_VARIATION 3
#define RECTANGLE_CHANCE 6
#define RECTANGLE_TOTAL 10
#define SHUFFLE_PASSES 2

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
    
    // Check map boundaries
    if (buffer_x2 + BORDER_PADDING >= MAP_W || buffer_y2 + BORDER_PADDING >= MAP_H) {
        return 0;
    }
    
    // Clamp safety margin to map boundaries
    if (buffer_x2 >= MAP_W) buffer_x2 = MAP_W - 1;
    if (buffer_y2 >= MAP_H) buffer_y2 = MAP_H - 1;
    
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

// Attempts to place room at specified grid position with random variation
unsigned char try_place_room_at_grid(unsigned char grid_index, unsigned char w, unsigned char h, 
                                    unsigned char *result_x, unsigned char *result_y) {
    unsigned char attempts = 0;
    
    // Try multiple placement attempts
    while (attempts < PLACEMENT_ATTEMPTS) {
        unsigned char x, y;
        
        // Get base grid position - inline for OSCAR64 efficiency
        unsigned char grid_x = grid_index % GRID_SIZE;
        unsigned char grid_y = grid_index / GRID_SIZE;
        unsigned char cell_w = (MAP_W - 8) / GRID_SIZE;  // Adjusted for 72x72: (72-8)/4 = 16
        unsigned char cell_h = (MAP_H - 8) / GRID_SIZE;  // More conservative border for larger map
        
        // Calculate base grid position with randomization
        unsigned char base_x = 4 + grid_x * cell_w;  // Increased margin for 72x72
        unsigned char base_y = 4 + grid_y * cell_h;  // Increased margin for 72x72
        
        // Add randomness to break grid alignment
        unsigned char extra_range_x = cell_w;
        unsigned char extra_range_y = cell_h;
        
        // Random positioning with displacement
        unsigned char random_offset_x = rnd(extra_range_x + cell_w / 2);
        unsigned char random_offset_y = rnd(extra_range_y + cell_h / 2);
        
        // Apply random displacement from grid base
        x = base_x + random_offset_x - (extra_range_x / 2);
        y = base_y + random_offset_y - (extra_range_y / 2);
        
        // Add scatter to break grid patterns
        x += rnd(SCATTER_RANGE * 2 + 1) - SCATTER_RANGE;  // ±3 pixel random scatter
        y += rnd(SCATTER_RANGE * 2 + 1) - SCATTER_RANGE;  // ±3 pixel random scatter
        
        // Clamp to valid map bounds
        if (x < MAP_BORDER) x = MAP_BORDER;
        if (y < MAP_BORDER) y = MAP_BORDER;
        if (x + MAX_SIZE + BORDER_PADDING >= MAP_W) x = MAP_W - MAX_SIZE - MAP_BORDER;
        if (y + MAX_SIZE + BORDER_PADDING >= MAP_H) y = MAP_H - MAX_SIZE - MAP_BORDER;
        
        // Add random variation for later attempts
        if (attempts > VARIATION_THRESHOLD) {
            // Increase variation with more attempts
            unsigned char extra_variation = attempts - VARIATION_THRESHOLD;
            x += rnd(extra_variation * 2) - extra_variation;
            y += rnd(extra_variation * 2) - extra_variation;
            
            // Clamp to valid bounds
            if (x < MAP_BORDER) x = MAP_BORDER;
            if (y < MAP_BORDER) y = MAP_BORDER;
            if (x + w + BORDER_PADDING >= MAP_W) x = MAP_W - w - MAP_BORDER;
            if (y + h + BORDER_PADDING >= MAP_H) y = MAP_H - h - MAP_BORDER;
        }
        
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
            set_tile_raw(ix, iy, TILE_FLOOR);
        }
    }
    
    // Place walls around the room immediately
    place_walls_around_room(x, y, w, h);
    
    // Add room to list if capacity allows
    if (room_count < MAX_ROOMS) {
        rooms[room_count].x = x;
        rooms[room_count].y = y;
        rooms[room_count].w = w;
        rooms[room_count].h = h;
        rooms[room_count].priority = 0;    // Will be set by assign_room_priorities()
        
        room_count++;
    }
}

// =============================================================================
// ROOM PRIORITY SYSTEM
// =============================================================================

// Sets room priorities based on position and type
void assign_room_priorities(void) {
    for (unsigned char i = 0; i < room_count; i++) {
        if (i == 0) {
            rooms[i].priority = START_ROOM_PRIORITY; // Starting room
        } else if (i == room_count - 1) {
            rooms[i].priority = END_ROOM_PRIORITY;  // End room
        } else {
            // Random priority variation for other rooms
            rooms[i].priority = DEFAULT_PRIORITY + rnd(PRIORITY_VARIATION);
        }
    }
}

// =============================================================================
// DOOR MANAGEMENT FUNCTIONS
// =============================================================================

// Centralized connection validation - checks if rooms are already connected
unsigned char room_has_connection_to(unsigned char room_idx, unsigned char target_room) {
    if (room_idx >= room_count) return 0;
    
    for (unsigned char i = 0; i < rooms[room_idx].connections; i++) {
        if (rooms[room_idx].conn_data[i].room_id == target_room) {
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
    
    for (unsigned char i = 0; i < rooms[room_idx].connections; i++) {
        if (rooms[room_idx].conn_data[i].room_id == target_room) {
            *door_x = rooms[room_idx].doors[i].x;
            *door_y = rooms[room_idx].doors[i].y;
            *wall_side = rooms[room_idx].doors[i].wall_side;
            *corridor_type = rooms[room_idx].conn_data[i].corridor_type;
            return 1; // Found connection
        }
    }
    return 0; // Connection not found
}

// Find existing door on specified wall side within tolerance
unsigned char find_existing_door_on_wall(unsigned char room_idx, unsigned char wall_side, 
                                        unsigned char target_x, unsigned char target_y,
                                        unsigned char *found_x, unsigned char *found_y) {
    if (room_idx >= room_count) return 0;
    
    // Use connections counter instead of iterating through unused slots
    for (unsigned char i = 0; i < rooms[room_idx].connections; i++) {
        Door *door = &rooms[room_idx].doors[i];
        if (door->wall_side == wall_side) {
            // Check if door is within reasonable distance (±2 tiles)
            unsigned char dx = abs_diff(door->x, target_x);
            unsigned char dy = abs_diff(door->y, target_y);
            if (dx <= 2 && dy <= 2) {
                *found_x = door->x;
                *found_y = door->y;
                return 1; // Found existing door
            }
        }
    }
    return 0; // No suitable door found
}

// Atomic connection management - adds connection metadata in single operation
unsigned char add_connection_to_room(unsigned char room_idx, unsigned char connected_room,
                                    unsigned char door_x, unsigned char door_y, 
                                    unsigned char wall_side, unsigned char corridor_type) {
    // Validate room capacity
    if (room_idx >= room_count || rooms[room_idx].connections >= 4) {
        return 0; // Failed - room full or invalid
    }
    
    unsigned char idx = rooms[room_idx].connections;
    
    // Atomic update - all metadata synchronized in single operation
    rooms[room_idx].conn_data[idx].room_id = connected_room;
    rooms[room_idx].conn_data[idx].corridor_type = corridor_type;
    
    rooms[room_idx].doors[idx].x = door_x;
    rooms[room_idx].doors[idx].y = door_y;
    rooms[room_idx].doors[idx].wall_side = wall_side;
    rooms[room_idx].doors[idx].reserved = 0; // Clear reserved bits
    
    rooms[room_idx].connections++; // Update counter last
    return 1; // Success
}

// Atomic rollback - removes last connection from room safely
unsigned char remove_last_connection_from_room(unsigned char room_idx) {
    if (room_idx >= room_count || rooms[room_idx].connections == 0) {
        return 0; // Nothing to remove or invalid room
    }
    
    // Atomic rollback - simply decrement counter (connection data will be overwritten)
    rooms[room_idx].connections--;
    return 1; // Success
}

// Clean implementation - all metadata management through atomic operations

// =============================================================================
// ROOM GENERATION
// =============================================================================

// Initialize room data structures using OSCAR64 optimized packed structures
void init_rooms(void) {
    for (unsigned char i = 0; i < MAX_ROOMS; i++) {
        rooms[i].connections = 0;
        rooms[i].state = 0;
        rooms[i].hub_distance = 0;
        rooms[i].priority = 0;
        
        // Initialize packed connection data
        for (unsigned char j = 0; j < 4; j++) {
            rooms[i].conn_data[j].room_id = 31; // Invalid room index (unused slot marker)
            rooms[i].conn_data[j].corridor_type = 0;
            
            // Initialize doors
            rooms[i].doors[j].x = 0;
            rooms[i].doors[j].y = 0;
            rooms[i].doors[j].wall_side = 0;
            rooms[i].doors[j].reserved = 0; // Clear reserved bits
        }
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
    
    // Additional shuffle passes
    for (unsigned char pass = 0; pass < SHUFFLE_PASSES; pass++) {
        for (unsigned char i = 0; i < grid_count - 1; i++) {
            if (rnd(2)) {  // 50% chance to swap adjacent pairs
                unsigned char temp = grid_positions[i];
                grid_positions[i] = grid_positions[i + 1];
                grid_positions[i + 1] = temp;
            }
        }
    }

    // Generate rooms at shuffled grid positions
    for (unsigned char i = 0; i < MAX_ROOMS && placed_rooms < MAX_ROOMS && i < grid_count; i++) {
        unsigned char w, h, x, y;
        
        // Generate room size with bias toward rectangles
        if (rnd(RECTANGLE_TOTAL) < RECTANGLE_CHANCE) {
            // 60% chance for rectangular rooms
            if (rnd(2)) {
                // Wider than tall
                w = MIN_SIZE + 1 + rnd(MAX_SIZE - MIN_SIZE);     // 5-8 wide
                h = MIN_SIZE + rnd(MAX_SIZE - MIN_SIZE - 1);     // 4-6 high
            } else {
                // Taller than wide
                w = MIN_SIZE + rnd(MAX_SIZE - MIN_SIZE - 1);     // 4-6 wide
                h = MIN_SIZE + 1 + rnd(MAX_SIZE - MIN_SIZE);     // 5-8 high
            }
        } else {
            // 40% chance for square-ish rooms
            w = MIN_SIZE + rnd(MAX_SIZE - MIN_SIZE + 1);         // 4-8 wide
            h = MIN_SIZE + rnd(MAX_SIZE - MIN_SIZE + 1);         // 4-8 high
        }
        
        // Attempt to place room at grid position
        if (try_place_room_at_grid(grid_positions[i], w, h, &x, &y)) {
            place_room(x, y, w, h);
            placed_rooms++;
            // Phase 0: Room placement progress
            update_progress_step(0, placed_rooms, MAX_ROOMS);
        }
    }
    
    // Finalize room generation
    room_count = placed_rooms;
    assign_room_priorities();
}