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


// =============================================================================
// ROOM VALIDATION AND PLACEMENT FUNCTIONS
// =============================================================================

// Calculates grid-based position with randomization for room placement
static void get_grid_position(unsigned char grid_index, unsigned char *x, unsigned char *y) {
    unsigned char grid_x = grid_index % GRID_SIZE;
    unsigned char grid_y = grid_index / GRID_SIZE;
    unsigned char cell_w = (MAP_W - 8) / GRID_SIZE;  // Leave border space
    unsigned char cell_h = (MAP_H - 8) / GRID_SIZE;
    
    // Calculate base grid position
    unsigned char base_x = 4 + grid_x * cell_w;
    unsigned char base_y = 4 + grid_y * cell_h;
    
    // Add randomness to break grid alignment
    unsigned char extra_range_x = cell_w;
    unsigned char extra_range_y = cell_h;
    
    // Random positioning with displacement
    unsigned char random_offset_x = rnd(extra_range_x + cell_w / 2);
    unsigned char random_offset_y = rnd(extra_range_y + cell_h / 2);
    
    // Apply random displacement from grid base
    *x = base_x + random_offset_x - (extra_range_x / 2);
    *y = base_y + random_offset_y - (extra_range_y / 2);
    
    // Add scatter to break grid patterns
    *x += rnd(6) - 3;  // ±3 pixel random scatter
    *y += rnd(6) - 3;  // ±3 pixel random scatter
    
    // Clamp to valid map bounds
    if (*x < 4) *x = 4;
    if (*y < 4) *y = 4;
    if (*x + MAX_SIZE + 3 >= MAP_W) *x = MAP_W - MAX_SIZE - 4;
    if (*y + MAX_SIZE + 3 >= MAP_H) *y = MAP_H - MAX_SIZE - 4;
}

// Validates room placement by checking boundaries and overlaps
unsigned char can_place_room(unsigned char x, unsigned char y, unsigned char w, unsigned char h) {
    // Check map boundary constraints
    if (x < 3 || y < 3) return 0;
    if (x + w + 3 >= MAP_W || y + h + 3 >= MAP_H) return 0;
    
    // Check if room area is clear
    for (unsigned char iy = y; iy < y + h; iy++) {
        for (unsigned char ix = x; ix < x + w; ix++) {
            if (!tile_is_empty(ix, iy)) {
                return 0; // Area already occupied
            }
        }
    }
    
    // Calculate buffer zone boundaries
    unsigned char buffer_x1 = (x >= MIN_ROOM_DISTANCE) ? x - MIN_ROOM_DISTANCE : 0;
    unsigned char buffer_y1 = (y >= MIN_ROOM_DISTANCE) ? y - MIN_ROOM_DISTANCE : 0;
    unsigned char buffer_x2 = x + w + MIN_ROOM_DISTANCE;
    unsigned char buffer_y2 = y + h + MIN_ROOM_DISTANCE;
    
    // Clamp buffer zone to map boundaries
    if (buffer_x2 >= MAP_W) buffer_x2 = MAP_W - 1;
    if (buffer_y2 >= MAP_H) buffer_y2 = MAP_H - 1;
    
    // Check buffer zone for conflicts (excluding the room area)
    for (unsigned char iy = buffer_y1; iy <= buffer_y2; iy++) {
        for (unsigned char ix = buffer_x1; ix <= buffer_x2; ix++) {
            // Skip the room area itself
            if (ix >= x && ix < x + w && iy >= y && iy < y + h) continue;
            
            if (!tile_is_empty(ix, iy)) {
                return 0; // Buffer zone conflict
            }
        }
    }
    
    // Check distance to existing rooms
    for (unsigned char i = 0; i < room_count; i++) {
        unsigned char existing_x1, existing_y1, existing_x2, existing_y2;
        get_room_bounds(i, &existing_x1, &existing_y1, &existing_x2, &existing_y2);
        
        unsigned char new_x2 = x + w;
        unsigned char new_y2 = y + h;
        
        // Check minimum distance constraint
        unsigned char min_dist = MIN_ROOM_DISTANCE + 1;
        
        // Test for bounding box overlap with minimum distance
        if (!(x >= existing_x2 + min_dist || new_x2 + min_dist <= existing_x1 ||
              y >= existing_y2 + min_dist || new_y2 + min_dist <= existing_y1)) {
            return 0; // Too close to existing room
        }
    }
    
    return 1; // Placement is valid
}

// Attempts to place room at specified grid position with random variation
unsigned char try_place_room_at_grid(unsigned char grid_index, unsigned char w, unsigned char h, 
                                    unsigned char *result_x, unsigned char *result_y) {
    unsigned char attempts = 0;
    
    // Try multiple placement attempts
    while (attempts < 15) {
        unsigned char x, y;
        
        // Get base grid position
        get_grid_position(grid_index, &x, &y);
        
        // Add random variation for later attempts
        if (attempts > 5) {
            // Increase variation with more attempts
            unsigned char extra_variation = attempts - 5;
            x += rnd(extra_variation * 2) - extra_variation;
            y += rnd(extra_variation * 2) - extra_variation;
            
            // Clamp to valid bounds
            if (x < 4) x = 4;
            if (y < 4) y = 4;
            if (x + w + 3 >= MAP_W) x = MAP_W - w - 4;
            if (y + h + 3 >= MAP_H) y = MAP_H - h - 4;
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

// Creates room and adds it to the room list
void place_room(unsigned char x, unsigned char y, unsigned char w, unsigned char h) {
    // Fill room area with floor tiles
    for (unsigned char iy = y; iy < y + h; iy++) {
        for (unsigned char ix = x; ix < x + w; ix++) {
            set_tile_raw(ix, iy, TILE_FLOOR);
        }
    }
    
    // Add room to list if capacity allows
    if (room_count < MAX_ROOMS) {
        rooms[room_count].x = x;
        rooms[room_count].y = y;
        rooms[room_count].w = w;
        rooms[room_count].h = h;
        rooms[room_count].priority = 5;    // Default priority
        rooms[room_count].connections = 0; // Initialize connections
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
            rooms[i].priority = 10; // Starting room
        } else if (i == room_count - 1) {
            rooms[i].priority = 8;  // End room
        } else {
            // Random priority variation for other rooms
            rooms[i].priority = 5 + rnd(3);
        }
    }
}
// =============================================================================
// ROOM GENERATION
// =============================================================================

// Generates all rooms using grid-based placement
void create_rooms(void) {
    unsigned char placed_rooms = 0;
    unsigned char grid_positions[16]; // Maximum 4x4 grid
    unsigned char grid_count = 0;

    print_text("\nBuilding rooms");
    
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
    for (unsigned char pass = 0; pass < 2; pass++) {
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
        if (rnd(10) < 6) {
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
            print_text("."); // Progress indicator
        }
    }
    
    // Finalize room generation
    room_count = placed_rooms;
    assign_room_priorities();
    
    // Initialize room center cache
    init_room_center_cache();
    
    // Position camera in first room
    if (room_count > 0) {
        get_room_center(0, &camera_center_x, &camera_center_y);
        update_camera();
    }
}