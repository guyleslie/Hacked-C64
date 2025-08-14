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

// Enhanced room placement validation with C64-optimized edge and overlap checking
// Uses minimal loops and early exits for maximum C64 performance
unsigned char can_place_room(unsigned char x, unsigned char y, unsigned char w, unsigned char h) {
    // Fast edge boundary checks - ensure adequate space from map edges
    if (x < 3 || y < 3) return 0;
    if (x + w + 3 >= MAP_W || y + h + 3 >= MAP_H) return 0;
    
    // C64-optimized: Check proposed room area for existing tiles first
    // This early check saves time before expensive distance calculations
    for (unsigned char iy = y; iy < y + h; iy++) {
        for (unsigned char ix = x; ix < x + w; ix++) {
            if (!tile_is_empty(ix, iy)) {
                return 0; // Found existing structure
            }
        }
    }
    
    // Buffer zone validation with MIN_ROOM_DISTANCE
    // Check buffer area around proposed room for conflicts
    unsigned char buffer_x1 = (x >= MIN_ROOM_DISTANCE) ? x - MIN_ROOM_DISTANCE : 0;
    unsigned char buffer_y1 = (y >= MIN_ROOM_DISTANCE) ? y - MIN_ROOM_DISTANCE : 0;
    unsigned char buffer_x2 = x + w + MIN_ROOM_DISTANCE;
    unsigned char buffer_y2 = y + h + MIN_ROOM_DISTANCE;
    
    // Clamp buffer zone to map boundaries
    if (buffer_x2 >= MAP_W) buffer_x2 = MAP_W - 1;
    if (buffer_y2 >= MAP_H) buffer_y2 = MAP_H - 1;
    
    // Scan buffer zone for existing structures (excluding the room area itself)
    for (unsigned char iy = buffer_y1; iy <= buffer_y2; iy++) {
        for (unsigned char ix = buffer_x1; ix <= buffer_x2; ix++) {
            // Skip the actual room area - we already checked it above
            if (ix >= x && ix < x + w && iy >= y && iy < y + h) continue;
            
            if (!tile_is_empty(ix, iy)) {
                return 0; // Buffer zone conflict
            }
        }
    }
    
    // Room-to-room distance checking
    // Cached room centers for faster distance calculations
    for (unsigned char i = 0; i < room_count; i++) {
        unsigned char existing_x2 = rooms[i].x + rooms[i].w;
        unsigned char existing_y2 = rooms[i].y + rooms[i].h;
        unsigned char new_x2 = x + w;
        unsigned char new_y2 = y + h;
        
        // Fast bounding box proximity check with MIN_ROOM_DISTANCE
        unsigned char min_dist = MIN_ROOM_DISTANCE + 1;
        
        // Check if rooms are too close using expanded bounding boxes
        if (!(x >= existing_x2 + min_dist || new_x2 + min_dist <= rooms[i].x ||
              y >= existing_y2 + min_dist || new_y2 + min_dist <= rooms[i].y)) {
            return 0; // Too close to existing room
        }
    }
    
    return 1; // Safe to place room
}

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

// Use get_grid_position from utility.c

// Grid-based room placement with enhanced randomization and multiple attempts
unsigned char try_place_room_at_grid(unsigned char grid_index, unsigned char w, unsigned char h, 
                                    unsigned char *result_x, unsigned char *result_y) {
    unsigned char attempts = 0;
    
    // C64-optimized: Multiple attempts with increasing variation
    while (attempts < 15) {  // Reasonable attempt limit for C64
        unsigned char x, y;
        
        // Get base grid position
        get_grid_position(grid_index, &x, &y);
        
        // Add progressive variation for each attempt
        if (attempts > 5) {
            // Later attempts use more variation to find available space
            unsigned char extra_variation = attempts - 5;
            x += rnd(extra_variation * 2) - extra_variation;
            y += rnd(extra_variation * 2) - extra_variation;
            
            // Keep within bounds
            if (x < 4) x = 4;
            if (y < 4) y = 4;
            if (x + w + 3 >= MAP_W) x = MAP_W - w - 4;
            if (y + h + 3 >= MAP_H) y = MAP_H - h - 4;
        }
        
        // Test placement
        if (can_place_room(x, y, w, h)) {
            *result_x = x;
            *result_y = y;
            return 1; // Success
        }
        
        attempts++;
    }
    
    return 0; // Failed to place after all attempts
}

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

// Fast room containment check - C64 optimized single-pass
unsigned char is_inside_room(unsigned char x, unsigned char y) {
    for (unsigned char i = 0; i < room_count; i++) {
        if (x >= rooms[i].x && x < rooms[i].x + rooms[i].w &&
            y >= rooms[i].y && y < rooms[i].y + rooms[i].h) {
            return 1; // Inside this room
        }
    }
    return 0; // Outside all rooms
}

// Optimized inverse check - outside all rooms
inline unsigned char is_outside_any_room(unsigned char x, unsigned char y) {
    return !is_inside_room(x, y);
}

// Check if position is outside specific room
unsigned char is_outside_room(unsigned char x, unsigned char y, unsigned char room_id) {
    if (room_id >= room_count) return 1; // Invalid room ID = outside
    
    Room *room = &rooms[room_id];
    return !(x >= room->x && x < room->x + room->w &&
             y >= room->y && y < room->y + room->h);
}

// =============================================================================
// EXIT PLACEMENT SYSTEM
// =============================================================================
// Room exits finding with randomized positioning along room edges
// Maintains 2-tile distance rule while providing organic variation
// The exit is always placed 2 tiles away from the room perimeter:
//   Left:   x == room->x - 2
//   Right:  x == room->x + room->w + 1  
//   Top:    y == room->y - 2
//   Bottom: y == room->y + room->h + 1
// Position along the edge is randomized for more natural corridors

void find_room_exit(Room *room, unsigned char target_x, unsigned char target_y, 
                   unsigned char *exit_x, unsigned char *exit_y) {
    unsigned char room_center_x, room_center_y;
    unsigned char room_id = room - rooms; // Calculate room index from pointer
    get_room_center(room_id, &room_center_x, &room_center_y);
    
    unsigned char dx = fast_abs_diff(target_x, room_center_x);
    unsigned char dy = fast_abs_diff(target_y, room_center_y);
    
    // Determine optimal edge based on target direction
    if (dx > dy) {
        // Horizontal movement preferred - exit from left/right edge
        if (target_x > room_center_x) {
            // Exit from room right edge (perimeter +2)
            *exit_x = room->x + room->w + 1; // Maintains 2-tile distance rule
            // Random Y position along the edge
            *exit_y = room->y + rnd(room->h);
        } else {
            // Exit from room left edge (perimeter -2)
            *exit_x = room->x - 2; // Maintains 2-tile distance rule
            // Random Y position along the edge
            *exit_y = room->y + rnd(room->h);
        }
    } else {
        // Vertical movement preferred - exit from top/bottom edge
        if (target_y > room_center_y) {
            // Exit from room bottom edge (perimeter +2)
            *exit_y = room->y + room->h + 1; // Maintains 2-tile distance rule
            // Random X position along the edge
            *exit_x = room->x + rnd(room->w);
        } else {
            // Exit from room top edge (perimeter -2)
            *exit_y = room->y - 2; // Maintains 2-tile distance rule
            // Random X position along the edge
            *exit_x = room->x + rnd(room->w);
        }
    }
}

// All corridor endpoints are still exactly 2 tiles away from room perimeter
// Door placement logic remains unchanged - doors will be at perimeter +1
// All existing rules (MIN_ROOM_DISTANCE, adjacency, etc.) remain enforced

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