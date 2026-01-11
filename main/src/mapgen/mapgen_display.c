// =============================================================================
// Display and Navigation Module for C64 Map Generator
// Contains viewport management, input handling, and map display
// =============================================================================

// System headers
#include <c64/vic.h>
#include <c64/cia.h>
#include <conio.h>
#include <string.h>
#include <stdlib.h>
// Project headers
#include "mapgen_types.h"         // For Room, MAX_ROOMS, map constants
#include "mapgen_utils.h"         // For viewport utilities, tile access, helper functions
#include "mapgen_display.h"       // For display, viewport, input
#include "mapgen_config.h"        // For MapParameters

// External reference to current generation parameters
extern MapParameters current_params;


#ifdef DEBUG_MAPGEN

// =============================================================================
// DIRECT SCREEN ACCESS
// =============================================================================

// C64 screen memory pointer
volatile unsigned char * const screen_memory = (volatile unsigned char *)SCREEN_MEMORY_BASE;

// =============================================================================
// GLOBAL VARIABLES - CAMERA AND VIEWPORT
// =============================================================================

// Camera position in map space
unsigned char camera_center_x = 36;  // 72/2 = 36 (map center for 72x72)
unsigned char camera_center_y = 36;  // 72/2 = 36 (map center for 72x72)

// Current viewport position (top-left corner)
Viewport view = {0, 0};

// =============================================================================
// GLOBAL VARIABLES - DISPLAY
// =============================================================================

// Cache of previous screen contents for delta updates
unsigned char screen_buffer[VIEW_H][VIEW_W];

// Flag indicating screen needs refresh
unsigned char screen_dirty = 1;

// Tracks last scroll direction for optimization
// Values: 0=none, 1=up, 2=down, 3=left, 4=right
unsigned char last_scroll_direction = 0;

// =============================================================================
// CAMERA SYSTEM
// =============================================================================

// Initialize camera system for new map
void initialize_camera(void) {
    // Cache initialization removed for OSCAR64 efficiency
    
    // Position camera in first room if available
    if (room_count > 0) {
        camera_center_x = room_list[0].center_x;
        camera_center_y = room_list[0].center_y;
        update_camera();
    }

    // NOTE: render_map_viewport() moved out - will be called after progress bar finishes
    // NOTE: Progress tracking now handled by map_generation.c (Phase 6)
}

// Update viewport based on camera center position with boundary checking
void update_camera(void) {
    unsigned char old_x = view.x;
    unsigned char old_y = view.y;
    unsigned char old_camera_x = camera_center_x;
    unsigned char old_camera_y = camera_center_y;
    
    unsigned char half_w = VIEW_W / 2;
    unsigned char half_h = VIEW_H / 2;
    
    // Calculate viewport position to center camera
    if (camera_center_x >= half_w) {
        view.x = camera_center_x - half_w;
    } else {
        view.x = 0;
    }
    
    if (camera_center_y >= half_h) {
        view.y = camera_center_y - half_h;
    } else {
        view.y = 0;
    }
    
    // Ensure viewport doesn't go beyond map boundaries
    if (view.x + VIEW_W > current_params.map_width) {
        view.x = (current_params.map_width >= VIEW_W) ? current_params.map_width - VIEW_W : 0;
    }
    if (view.y + VIEW_H > current_params.map_height) {
        view.y = (current_params.map_height >= VIEW_H) ? current_params.map_height - VIEW_H : 0;
    }
    
    // CRITICAL FIX: Synchronize camera position back to actual viewport center
    // This ensures camera and viewport are always in sync, preventing boundary issues
    camera_center_x = view.x + half_w;
    camera_center_y = view.y + half_h;
    
    // Mark screen dirty if viewport changed
    if ((old_x != view.x) || (old_y != view.y)) {
        screen_dirty = 1;
    }
}


// =============================================================================
// MAP DISPLAY SYSTEM
// =============================================================================



// Full screen update - redraws entire viewport
void update_full_screen(void) {
    unsigned char screen_y, x;
    unsigned short screen_pos;
    unsigned char tile;
    
    // Update all 25 rows
    for (screen_y = 0; screen_y < VIEW_H; screen_y++) {
        screen_pos = screen_y * 40;  // Calculate screen memory offset
        
        // Update all 40 columns in this row
        for (x = 0; x < VIEW_W; x++) {
            // Get tile from map and convert to PETSCII
            tile = get_map_tile(view.x + x, view.y + screen_y);
            
            // Update both screen memory and buffer
            screen_memory[screen_pos + x] = tile;
            screen_buffer[screen_y][x] = tile;
        }
    }
}

// Main map rendering function
void render_map_viewport(unsigned char force_refresh) {
    // Handle force refresh
    if (force_refresh) {
        clrscr();
        screen_dirty = 1;
        last_scroll_direction = 0;
    }
    
    // Early exit if screen is clean
    if (!screen_dirty) {
        return;
    }
    
    // Store scroll direction before potential reset
    unsigned char current_scroll_direction = last_scroll_direction;
    
    // Choose rendering method based on scroll direction
    if (current_scroll_direction != 0) {
        // Use scroll for single-tile movements
        update_partial_screen(current_scroll_direction);
    } else {
        // Full screen update for initial display or force refresh
        update_full_screen();
    }
    
    // Clear dirty flag
    screen_dirty = 0;
    last_scroll_direction = 0;
}
    
// ============================================================================
// CAMERA MOVEMENT SYSTEM
// ============================================================================

// Move camera in specified direction
void move_camera_direction(unsigned char direction) {
    unsigned char old_view_x = view.x;
    unsigned char old_view_y = view.y;
    unsigned char new_camera_x = camera_center_x;
    unsigned char new_camera_y = camera_center_y;
    unsigned char moved = 0;
    
    // Direct camera movement - update_camera() clamps to boundaries
    switch (direction) {
        case MOVE_UP:
            new_camera_y--;
            moved = 1;
            break;

        case MOVE_DOWN:
            new_camera_y++;
            moved = 1;
            break;

        case MOVE_LEFT:
            new_camera_x--;
            moved = 1;
            break;

        case MOVE_RIGHT:
            new_camera_x++;
            moved = 1;
            break;
    }

    // Update camera position and viewport if moved
    if (moved) {
        // Store previous camera positions for scroll detection
        unsigned char prev_camera_x = camera_center_x;
        unsigned char prev_camera_y = camera_center_y;
        
        camera_center_x = new_camera_x;
        camera_center_y = new_camera_y;
        update_camera();
        
        // Determine scroll direction ONLY if viewport actually changed
        // This prevents full screen updates at map boundaries
        if (view.x != old_view_x || view.y != old_view_y) {
            // Viewport changed - set scroll direction for optimized rendering
            if (view.y < old_view_y) {
                last_scroll_direction = 1; // Up scroll
            } else if (view.y > old_view_y) {
                last_scroll_direction = 2; // Down scroll
            } else if (view.x < old_view_x) {
                last_scroll_direction = 3; // Left scroll
            } else if (view.x > old_view_x) {
                last_scroll_direction = 4; // Right scroll
            } else {
                last_scroll_direction = 0; // No scroll
            }
        } else {
            // Viewport didn't change (at boundary) - no scroll optimization
            // This prevents slow full screen updates when hitting map edges
            last_scroll_direction = 0;
        }
        
        // Mark screen as dirty for redraw
        screen_dirty = 1;
        
        // Update display after movement
        render_map_viewport(0);
    }
}

// =============================================================================
// SCROLL SYSTEM 
// =============================================================================
// Shifts only affected rows or columns in screen memory and buffer
// based on scroll direction, with edge and boundary checks.

void update_partial_screen(unsigned char scroll_dir) {
    unsigned short screen_offset;
    unsigned char x, y;

    // Validate scroll direction parameter
    if (scroll_dir == 0 || scroll_dir > 4) {
        update_full_screen();
        return;
    }

    // Edge case checks removed - partial scroll works fine at boundaries!
    // The get_map_tile() bounds checking handles out-of-bounds safely
    // This eliminates slow full screen updates on the last scroll before boundary

    // Always use single line/column scroll for precise movement
    unsigned char max_y = VIEW_H - 1;
    unsigned char max_x = VIEW_W - 1;
    
    switch(scroll_dir) {          
        
        case 1: 
        // Scroll UP - move content down by one line only
        // Shift screen content down by 1 line
        for (y = max_y; y >= 1; y--) {
            // Shift this line in screen memory
            for (x = 0; x < VIEW_W; x++) {
                screen_memory[y * 40 + x] = screen_memory[(y - 1) * 40 + x];
            }
            // Shift this line in buffer (integrated processing)
            memmove(&screen_buffer[y][0], &screen_buffer[y - 1][0], VIEW_W);
        }
        // Fill top line with new content
        for (x = 0; x < VIEW_W; x++) {
            unsigned char tile = get_map_tile(view.x + x, view.y);
            screen_memory[0 * 40 + x] = tile;
            screen_buffer[0][x] = tile;
        }
        break;
        
        case 2: 
        // Scroll DOWN - move content up by one line only
        // Shift screen content up by 1 line  
        for (y = 0; y < max_y; y++) {
            // Shift this line in screen memory
            for (x = 0; x < VIEW_W; x++) {
                screen_memory[y * 40 + x] = screen_memory[(y + 1) * 40 + x];
            }
            // Shift this line in buffer (integrated processing)
            memmove(&screen_buffer[y][0], &screen_buffer[y + 1][0], VIEW_W);
        }
        // Fill bottom line with new content
        screen_offset = max_y * 40;
        for (x = 0; x < VIEW_W; x++) {
            unsigned char tile = get_map_tile(view.x + x, view.y + max_y);
            screen_memory[screen_offset + x] = tile;
            screen_buffer[max_y][x] = tile;
        }
        break;
            
        case 3:
        // Scroll LEFT - move content right by one column only
        // Shift screen content right by 1 column
        for (y = 0; y < VIEW_H; y++) {
            for (x = max_x; x >= 1; x--) {
                screen_memory[y * 40 + x] = screen_memory[y * 40 + x - 1];
            }
            // Shift buffer content
            memmove(&screen_buffer[y][1], &screen_buffer[y][0], max_x);
            // Fill leftmost column
            unsigned char tile = get_map_tile(view.x, view.y + y);
            screen_memory[y * 40] = tile;
            screen_buffer[y][0] = tile;
        }
        break;        
        
        case 4: 
        // Scroll RIGHT - move content left by one column only
        // Shift screen content left by 1 column
        for (y = 0; y < VIEW_H; y++) {
            for (x = 0; x < max_x; x++) {
                screen_memory[y * 40 + x] = screen_memory[y * 40 + x + 1];
            }
            // Shift buffer content
            memmove(&screen_buffer[y][0], &screen_buffer[y][1], max_x);
            // Fill rightmost column
            unsigned char tile = get_map_tile(view.x + max_x, view.y + y);
            screen_memory[y * 40 + max_x] = tile;
            screen_buffer[y][max_x] = tile;
        }
        break;
    }
}
#endif // DEBUG_MAPGEN

