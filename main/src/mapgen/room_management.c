// Room Management Module for C64 Map Generator
// Contains room placement, validation, and priority management

#include <conio.h>
#include "mapgen_types.h"      // For Room, MAX_ROOMS, Viewport
#include "mapgen_internal.h"   // For room placement/validation

// External global references  
extern Room rooms[MAX_ROOMS];
extern unsigned char room_count;
extern unsigned char camera_center_x, camera_center_y;
extern Viewport view;

// Enhanced room placement validation with improved boundary and overlap checking
unsigned char can_place_room(unsigned char x, unsigned char y, unsigned char w, unsigned char h) {
    unsigned char ix, iy;
    
    // Enhanced boundary checks - ensure adequate space from map edges
    if (x < 3 || y < 3 || x + w + 3 >= MAP_W || y + h + 3 >= MAP_H) 
        return 0;
      // Enhanced overlap checking with more thorough distance validation
    for (iy = y - MIN_ROOM_DISTANCE; iy <= y + h + MIN_ROOM_DISTANCE; iy++) {
        for (ix = x - MIN_ROOM_DISTANCE; ix <= x + w + MIN_ROOM_DISTANCE; ix++) {
            if (coords_in_bounds(ix, iy)) {
                if (!tile_is_empty(ix, iy)) {
                    return 0; // Found existing structure
                }
            }
        }
    }
    
    // Additional check: ensure we're not too close to existing rooms
    unsigned char i;
    for (i = 0; i < room_count; i++) {
        // Check if any part of the new room would be too close to existing room
        unsigned char existing_right = rooms[i].x + rooms[i].w;
        unsigned char existing_bottom = rooms[i].y + rooms[i].h;
        unsigned char new_right = x + w;
        unsigned char new_bottom = y + h;
        
        // Calculate minimum distances
        unsigned char min_x_dist = MIN_ROOM_DISTANCE + 1;
        unsigned char min_y_dist = MIN_ROOM_DISTANCE + 1;
        
        // Check horizontal overlap/proximity
        if (!(x >= existing_right + min_x_dist || new_right + min_x_dist <= rooms[i].x)) {
            // Check vertical overlap/proximity
            if (!(y >= existing_bottom + min_y_dist || new_bottom + min_y_dist <= rooms[i].y)) {
                return 0; // Too close or overlapping
            }
        }
    }
    
    return 1; // Safe to place room
}

// Place a room with floor only
void place_room(unsigned char x, unsigned char y, unsigned char w, unsigned char h) {
    unsigned char ix, iy;
      for (iy = y; iy < y + h; iy++) {
        for (ix = x; ix < x + w; ix++) {
            if (coords_in_bounds(ix, iy)) {
                set_tile_raw(ix, iy, TILE_FLOOR);
            }
        }
    }
    
    if (room_count < MAX_ROOMS) {
        rooms[room_count].x = x;
        rooms[room_count].y = y;
        rooms[room_count].w = w;
        rooms[room_count].h = h;
        rooms[room_count].priority = 5; // Default priority
        rooms[room_count].connections = 0; // Initialize connections
        room_count++;
    }
}

// Grid-based room placement with enhanced randomization
unsigned char try_place_room_at_grid(unsigned char grid_index, unsigned char w, unsigned char h, 
                                    unsigned char *result_x, unsigned char *result_y) {
    unsigned char x, y;
    unsigned char attempts = 0;
    
    while (attempts < 20) {  // More attempts for better variety
        // Get base grid position
        get_grid_position(grid_index, &x, &y);
        
        // Add additional random offset for more variety (50% chance)
        if (rnd(10) < 5) {
            // Add random displacement within reasonable bounds
            unsigned char offset_range = 8; // Allow up to 8 pixel displacement
            x += rnd(offset_range) - (offset_range / 2);
            y += rnd(offset_range) - (offset_range / 2);
            
            // Keep within map bounds
            if (x < 4) x = 4;
            if (y < 4) y = 4;
            if (x + w + 3 >= MAP_W) x = MAP_W - w - 4;
            if (y + h + 3 >= MAP_H) y = MAP_H - h - 4;
        }
          if (can_place_room(x, y, w, h)) {
            *result_x = x;
            *result_y = y;
            return 1;
        }        attempts++;
          // No progress feedback for retry attempts to avoid confusion
    }

    
    return 0;
}

// Priority assignment
void assign_room_priorities(void) {
    unsigned char i;
    
    for (i = 0; i < room_count; i++) {
        if (i == 0) {
            rooms[i].priority = 10; // Starting room gets highest priority
        } else if (i == room_count - 1) {
            rooms[i].priority = 8;  // End room gets high priority
        } else {
            rooms[i].priority = 5 + rnd(3); // Others get medium priority
        }
    }
}

// Check if position is inside any room
unsigned char is_inside_room(unsigned char x, unsigned char y) {
    unsigned char i;
    for (i = 0; i < room_count; i++) {
        if (x >= rooms[i].x && x < rooms[i].x + rooms[i].w &&
            y >= rooms[i].y && y < rooms[i].y + rooms[i].h) {
            return 1;
        }
    }
    return 0;
}

// Returns 1 if (x, y) is outside all rooms (not inside any room)
unsigned char is_outside_any_room(unsigned char x, unsigned char y) {
    return !is_inside_room(x, y);
}

// Returns 1 if (x, y) is outside the given room (not inside its area)
unsigned char is_outside_room(unsigned char x, unsigned char y, unsigned char room_id) {
    if (room_id >= room_count) return 1; // Out of bounds room id is always outside
    Room *room = &rooms[room_id];
    if (x >= room->x && x < room->x + room->w &&
        y >= room->y && y < room->y + room->h) {
        return 0; // Inside the room
    }
    return 1; // Outside the room
}

// Simple function to check if a point is at a room corner (exact corners only)
unsigned char is_at_room_corner(unsigned char x, unsigned char y) {
    unsigned char i;
    for (i = 0; i < room_count; i++) {
        // Check if point is at any of the 4 exact corners of this room
        if ((x == rooms[i].x && y == rooms[i].y) ||                                    // Top-left
            (x == rooms[i].x + rooms[i].w - 1 && y == rooms[i].y) ||                   // Top-right
            (x == rooms[i].x && y == rooms[i].y + rooms[i].h - 1) ||                   // Bottom-left
            (x == rooms[i].x + rooms[i].w - 1 && y == rooms[i].y + rooms[i].h - 1)) {  // Bottom-right
            return 1;
        }
    }
    return 0;
}

// OPTIMIZED room exit finding - avoids room corners and existing doors
void find_room_exit(Room *room, unsigned char target_x, unsigned char target_y, unsigned char *exit_x, unsigned char *exit_y) {
    unsigned char room_center_x, room_center_y;
    // Use optimized room center calculation - need room ID for the function
    unsigned char room_id = room - rooms; // Calculate room index from pointer
    get_room_center(room_id, &room_center_x, &room_center_y);
    // Calculate direction to target using optimized functions
    unsigned char dx = fast_abs_diff(target_x, room_center_x);
    unsigned char dy = fast_abs_diff(target_y, room_center_y);
    // Place exit OUTSIDE the room (on the wall, not on the last floor tile)
    if (dx > dy) {
        // Horizontal movement preferred - exit from left/right side
        if (target_x > room_center_x) {
            // Exit from room right side - outside the edge
            *exit_x = room->x + room->w; // One tile right of the room
            *exit_y = room_center_y;
        } else {
            // Exit from room left side - outside the edge
            *exit_x = room->x - 1; // One tile left of the room
            *exit_y = room_center_y;
        }
    } else {
        // Vertical movement preferred - exit from top/bottom side
        if (target_y > room_center_y) {
            // Exit from room bottom side - outside the edge
            *exit_y = room->y + room->h; // One tile below the room
            *exit_x = room_center_x;
        } else {
            // Exit from room top side - outside the edge
            *exit_y = room->y - 1; // One tile above the room
            *exit_x = room_center_x;
        }
    }
}



// PHASE 1: Simple grid-based room generation (much more efficient)
void create_rooms(void) {
    unsigned char i;
    unsigned char x, y, w, h;
    unsigned char placed_rooms = 0;
    unsigned char grid_positions[16]; // Max 4x4 grid positions
    unsigned char grid_count = 0;

    print_text("\nCREATING ROOMS");
    
    // Initialize available grid positions
    for (i = 0; i < GRID_SIZE * GRID_SIZE; i++) {
        grid_positions[i] = i;
        grid_count++;
    }    // Shuffle grid positions for random distribution with enhanced algorithm
    // Use Fisher-Yates shuffle for perfect randomization (no extra pass needed)
    for (i = grid_count - 1; i > 0; i--) {
        unsigned char j = rnd(i + 1);
        unsigned char temp = grid_positions[i];
        grid_positions[i] = grid_positions[j];
        grid_positions[j] = temp;
    }
    
    // Additional shuffle passes for even better randomization
    for (unsigned char pass = 0; pass < 2; pass++) {
        for (i = 0; i < grid_count - 1; i++) {
            if (rnd(2)) {  // 50% chance to swap each adjacent pair
                unsigned char temp = grid_positions[i];
                grid_positions[i] = grid_positions[i + 1];
                grid_positions[i + 1] = temp;
            }
        }
    }    // Generate rooms using grid positions with enhanced size variation
    for (i = 0; i < MAX_ROOMS && placed_rooms < MAX_ROOMS && i < grid_count; i++) {
        // Generate random room sizes with better distribution
        // 60% chance for rectangular rooms (not square)
        if (rnd(10) < 6) {
            // Create rectangular rooms with more size variation
            if (rnd(2)) {
                // Make wider room (width > height)
                w = MIN_SIZE + 1 + rnd(MAX_SIZE - MIN_SIZE);     // 5-8 wide
                h = MIN_SIZE + rnd(MAX_SIZE - MIN_SIZE - 1);     // 4-6 high
            } else {
                // Make taller room (height > width)
                w = MIN_SIZE + rnd(MAX_SIZE - MIN_SIZE - 1);     // 4-6 wide
                h = MIN_SIZE + 1 + rnd(MAX_SIZE - MIN_SIZE);     // 5-8 high
            }
        } else {
            // 40% chance for more square-ish rooms with full size range
            w = MIN_SIZE + rnd(MAX_SIZE - MIN_SIZE + 1);         // 4-8 wide
            h = MIN_SIZE + rnd(MAX_SIZE - MIN_SIZE + 1);         // 4-8 high
        }
        // Try to place room at grid position
        if (try_place_room_at_grid(grid_positions[i], w, h, &x, &y)) {
            place_room(x, y, w, h);
            placed_rooms++;
            print_text("."); // Print a dot for every successful room placement
        }
    }
    // Update room count and assign priorities
    room_count = placed_rooms;
    assign_room_priorities();
    
    // Initialize room center cache after rooms are created
    init_room_center_cache();
    
    // Set camera position in first room and update viewport
    if (room_count > 0) {
        get_room_center(0, &camera_center_x, &camera_center_y);
        update_camera();  // Camera-viewport synchronization is now handled in update_camera()
    }
}
