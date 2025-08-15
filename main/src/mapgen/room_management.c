// =============================================================================
// ROOM MANAGEMENT MODULE 
// Room placement, validation, and connection start/exit management
// All functions use static memory allocation and C64-friendly algorithms
// =============================================================================

#include <conio.h>
#include "mapgen_types.h"      // For Room, MAX_ROOMS, Viewport
#include "mapgen_internal.h"   // For room placement/validation
#include "mapgen_utils.h"    // For utility functions

// =============================================================================
// EXTERNAL GLOBAL REFERENCES
// =============================================================================

extern Room rooms[MAX_ROOMS];
extern unsigned char room_count;
extern unsigned char camera_center_x, camera_center_y;
extern Viewport view;

// =============================================================================
// ROOM VALIDATION AND PLACEMENT CORE FUNCTIONS
// =============================================================================
// Note: can_place_room, try_place_room_at_grid, is_outside_room, find_room_exit 
// and has_door_nearby functions moved to mapgen_utils.c for better accessibility

// Place room with floor tiles
void place_room(unsigned char x, unsigned char y, unsigned char w, unsigned char h) {
    // Fast tile placement with bounds checking
    for (unsigned char iy = y; iy < y + h; iy++) {
        for (unsigned char ix = x; ix < x + w; ix++) {
            set_tile_raw(ix, iy, TILE_FLOOR);
        }
    }
    
    // Add room to global room list if space available
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
// GRID-BASED ROOM PLACEMENT SYSTEM
// =============================================================================
// Note: try_place_room_at_grid function moved to mapgen_utils.c

// =============================================================================
// ROOM PRIORITY AND ORGANIZATION SYSTEM
// =============================================================================

// Assign room priorities for stairs and special features
void assign_room_priorities(void) {
    for (unsigned char i = 0; i < room_count; i++) {
        if (i == 0) {
            rooms[i].priority = 10; // Starting room gets highest priority
        } else if (i == room_count - 1) {
            rooms[i].priority = 8;  // End room gets high priority
        } else {
            // Other rooms get medium priority with slight variation
            rooms[i].priority = 5 + rnd(3);
        }
    }
}

// =============================================================================
// ROOM QUERY AND VALIDATION FUNCTIONS
// =============================================================================
// Note: is_inside_any_room, is_outside_any_room, is_outside_room and find_room_exit 
// functions moved to mapgen_utils.c for better accessibility across multiple modules

// =============================================================================
// MAIN ROOM GENERATION PIPELINE
// =============================================================================

// Enhanced room generation with C64-optimized grid-based placement
void create_rooms(void) {
    unsigned char placed_rooms = 0;
    unsigned char grid_positions[16]; // Max 4x4 grid positions
    unsigned char grid_count = 0;

    print_text("\nBuilding rooms");
    
    // Initialize available grid positions
    for (unsigned char i = 0; i < GRID_SIZE * GRID_SIZE; i++) {
        grid_positions[i] = i;
        grid_count++;
    }
    
    // C64-optimized Fisher-Yates shuffle for perfect randomization
    for (unsigned char i = grid_count - 1; i > 0; i--) {
        unsigned char j = rnd(i + 1);
        unsigned char temp = grid_positions[i];
        grid_positions[i] = grid_positions[j];
        grid_positions[j] = temp;
    }
    
    // Additional shuffle passes for enhanced randomization
    for (unsigned char pass = 0; pass < 2; pass++) {
        for (unsigned char i = 0; i < grid_count - 1; i++) {
            if (rnd(2)) {  // 50% chance to swap adjacent pairs
                unsigned char temp = grid_positions[i];
                grid_positions[i] = grid_positions[i + 1];
                grid_positions[i + 1] = temp;
            }
        }
    }
    
    // Generate rooms using shuffled grid positions with enhanced size variation
    for (unsigned char i = 0; i < MAX_ROOMS && placed_rooms < MAX_ROOMS && i < grid_count; i++) {
        unsigned char w, h, x, y;
        
        // Enhanced room size generation with better distribution
        if (rnd(10) < 6) {
            // 60% chance for rectangular rooms (non-square)
            if (rnd(2)) {
                // Wider room (width > height)
                w = MIN_SIZE + 1 + rnd(MAX_SIZE - MIN_SIZE);     // 5-8 wide
                h = MIN_SIZE + rnd(MAX_SIZE - MIN_SIZE - 1);     // 4-6 high
            } else {
                // Taller room (height > width)
                w = MIN_SIZE + rnd(MAX_SIZE - MIN_SIZE - 1);     // 4-6 wide
                h = MIN_SIZE + 1 + rnd(MAX_SIZE - MIN_SIZE);     // 5-8 high
            }
        } else {
            // 40% chance for more square-ish rooms with full size range
            w = MIN_SIZE + rnd(MAX_SIZE - MIN_SIZE + 1);         // 4-8 wide
            h = MIN_SIZE + rnd(MAX_SIZE - MIN_SIZE + 1);         // 4-8 high
        }
        
        // Try to place room at grid position with enhanced placement logic
        if (try_place_room_at_grid(grid_positions[i], w, h, &x, &y)) {
            place_room(x, y, w, h);
            placed_rooms++;
            print_text("."); // Progress indicator
        }
    }
    
    // Update global room count and assign priorities
    room_count = placed_rooms;
    assign_room_priorities();
    
    // Initialize room center cache for fast access
    init_room_center_cache();
    
    // Set initial camera position in first room if available
    if (room_count > 0) {
        get_room_center(0, &camera_center_x, &camera_center_y);
        update_camera();
    }
}