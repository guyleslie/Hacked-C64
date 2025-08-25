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
#include "mapgen_types.h"         // For Room, MAP_W, MAP_H, MAX_ROOMS
#include "mapgen_utils.h"         // For viewport utilities, tile access, helper functions
#include "mapgen_display.h"       // For display, viewport, input


// =============================================================================
// DIRECT SCREEN ACCESS
// =============================================================================

// C64 screen memory pointer
volatile unsigned char * const screen_memory = (volatile unsigned char *)SCREEN_MEMORY_BASE;

// =============================================================================
// CAMERA SYSTEM
// =============================================================================

// Update viewport based on camera center position with boundary checking
void update_camera(void) {
    unsigned char old_x = view.x;
    unsigned char old_y = view.y;
    unsigned char old_camera_x = camera_center_x;
    unsigned char old_camera_y = camera_center_y;
    
    unsigned char half_w = get_viewport_half_width();
    unsigned char half_h = get_viewport_half_height();
    
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
    if (view.x + VIEW_W > MAP_W) {
        view.x = (MAP_W >= VIEW_W) ? MAP_W - VIEW_W : 0;
    }
    if (view.y + VIEW_H > MAP_H) {
        view.y = (MAP_H >= VIEW_H) ? MAP_H - VIEW_H : 0;
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

// Move camera to new position with bounds checking
void move_camera(unsigned char new_x, unsigned char new_y) {
    if ((new_x < MAP_W) && (new_y < MAP_H)) {
        camera_center_x = new_x;
        camera_center_y = new_y;
        update_camera();
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
            tile = get_map_tile_fast(view.x + x, view.y + screen_y);
            
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
        update_screen_with_scroll(current_scroll_direction);
    } else {
        // Full screen update for initial display or force refresh
        update_full_screen();
    }
    
    // Clear dirty flag
    screen_dirty = 0;
    last_scroll_direction = 0;
}
    
// ============================================================================
// INPUT HANDLING SYSTEM
// ============================================================================

// Input handling with direct camera movement
void process_navigation_input(unsigned char key) {
    unsigned char old_view_x = view.x;
    unsigned char old_view_y = view.y;
    unsigned char new_camera_x = camera_center_x;
    unsigned char new_camera_y = camera_center_y;
    unsigned char moved = 0;
    
    // Direct camera movement with bounds checking
    switch (key) {
        case 'w':
        case 'W':
            if (camera_center_y > 0) {
                new_camera_y--;
                moved = 1;
            }
            break;
            
        case 's':
        case 'S':
            if (camera_center_y < MAP_H - 1) {
                new_camera_y++;
                moved = 1;
            }
            break;
            
        case 'a':
        case 'A':
            if (camera_center_x > 0) {
                new_camera_x--;
                moved = 1;
            }
            break;
            
        case 'd':
        case 'D':
            if (camera_center_x < MAP_W - 1) {
                new_camera_x++;
                moved = 1;
            }
            break;
    }

    // Update camera position and viewport if moved
    if (moved) {
        // Store old camera positions for proper scroll detection
        unsigned char prev_camera_x = camera_center_x;
        unsigned char prev_camera_y = camera_center_y;
        
        camera_center_x = new_camera_x;
        camera_center_y = new_camera_y;
        update_camera();
        
        // Determine scroll direction based on ACTUAL camera movement
        // This fixes the boundary case where camera moves but viewport doesn't
        if (view.x != old_view_x || view.y != old_view_y) {
            // Viewport changed - use viewport movement for scroll direction
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
            // Viewport didn't change but camera moved (boundary case)
            // Set scroll direction based on camera movement for next input
            if (camera_center_y < prev_camera_y) {
                last_scroll_direction = 1; // Up scroll
            } else if (camera_center_y > prev_camera_y) {
                last_scroll_direction = 2; // Down scroll  
            } else if (camera_center_x < prev_camera_x) {
                last_scroll_direction = 3; // Left scroll
            } else if (camera_center_x > prev_camera_x) {
                last_scroll_direction = 4; // Right scroll
            } else {
                last_scroll_direction = 0; // No movement
            }
        }
    }
}

// =============================================================================
// SCROLL SYSTEM 
// =============================================================================
// Shifts only affected rows or columns in screen memory and buffer
// based on scroll direction, with edge and boundary checks.

void update_screen_with_scroll(unsigned char scroll_dir) {
    unsigned short screen_offset;
    unsigned char x, y;
    
    // Validate scroll direction parameter
    if (scroll_dir == 0 || scroll_dir > 4) {
        update_full_screen();
        return;
    }
    
    // Edge case check with fallback to full update
    switch(scroll_dir) {
        case 1: if (view.y == 0) { update_full_screen(); return; } break;
        case 2: if (view.y >= MAP_H - VIEW_H) { update_full_screen(); return; } break;
        case 3: if (view.x == 0) { update_full_screen(); return; } break;
        case 4: if (view.x >= MAP_W - VIEW_W) { update_full_screen(); return; } break;
    }
    
    // Always use single line/column scroll for precise movement
    unsigned char max_y = get_viewport_max_y();
    unsigned char max_x = get_viewport_max_x();
    
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
            unsigned char tile = get_map_tile_fast(view.x + x, view.y);
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
            unsigned char tile = get_map_tile_fast(view.x + x, view.y + max_y);
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
            unsigned char tile = get_map_tile_fast(view.x, view.y + y);
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
            unsigned char tile = get_map_tile_fast(view.x + max_x, view.y + y);
            screen_memory[y * 40 + max_x] = tile;
            screen_buffer[y][max_x] = tile;
        }
        break;
    }
}

