// Display and Navigation Module for C64 Map Generator
// Contains viewport management, input handling, and map display

#include <c64/vic.h>
#include <c64/cia.h>
#include <conio.h>
#include <string.h>
#include <stdlib.h>
#include "mapgen_types.h"      // For Room, MAP_W, MAP_H, MAX_ROOMS
#include "mapgen_display.h"    // For display, viewport, input
#include "../oscar64_console.h"   // For oscar_clrscr, etc.

// =============================================================================
// EXTERNAL VARIABLE REFERENCES
// =============================================================================

// External references to global variables defined in main.c
extern unsigned char compact_map[MAP_H * MAP_W * 3 / 8];
extern Room rooms[MAX_ROOMS];
extern unsigned char room_count;
extern unsigned int rng_seed;

// SIMPLIFIED CAMERA SYSTEM: Single camera structure
extern unsigned char camera_center_x;
extern unsigned char camera_center_y;
extern Viewport view;

// Display optimization: previous screen buffer for delta updates
extern unsigned char screen_buffer[VIEW_H][VIEW_W];
extern unsigned char screen_dirty;

// Scroll direction optimization
extern unsigned char last_scroll_direction;

// =============================================================================
// DIRECT OSCAR64 SCREEN ACCESS
// =============================================================================

// Oscar64 optimized direct screen memory access
// C64 screen memory is at $0400-$07E7 (1024-2023)
volatile unsigned char * const screen_memory = (volatile unsigned char *)0x0400;

// =============================================================================
// SIMPLIFIED CAMERA SYSTEM
// =============================================================================

// Update viewport based on camera center position - FIXED BOUNDARY LOGIC
void update_camera(void) {
    unsigned char old_x = view.x;
    unsigned char old_y = view.y;
    unsigned char old_camera_x = camera_center_x;
    unsigned char old_camera_y = camera_center_y;
    
    // Calculate viewport position to center camera
    if (camera_center_x >= VIEW_W / 2) {
        view.x = camera_center_x - (VIEW_W / 2);
    } else {
        view.x = 0;
    }
    
    if (camera_center_y >= VIEW_H / 2) {
        view.y = camera_center_y - (VIEW_H / 2);
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
    camera_center_x = view.x + (VIEW_W / 2);
    camera_center_y = view.y + (VIEW_H / 2);
    
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
// ULTRA-OPTIMIZED MAP DISPLAY SYSTEM - V4.0 - PERFECT SCROLL
// =============================================================================

// Forward declarations
void update_full_screen(void);
void update_screen_with_perfect_scroll(unsigned char scroll_dir);

// Get single tile from map with inline optimization - FIXED BIT MANIPULATION
static unsigned char get_map_tile_fast(unsigned char map_x, unsigned char map_y) {
    if (map_x >= MAP_W || map_y >= MAP_H) {
        return EMPTY; // FIXED: Use constant instead of magic number
    }
    
    // FIXED: Use exact same bit manipulation as utility.c for consistency
    unsigned int bit_offset = ((unsigned int)map_y << 7) + ((unsigned int)map_y << 6) + map_x + map_x + map_x;
    unsigned char *byte_ptr = &compact_map[bit_offset >> 3];
    unsigned char bit_pos = bit_offset & 7;
    
    unsigned char raw_tile;
    if (bit_pos <= 5) {
        // Fast path: tile fits in single byte
        raw_tile = (*byte_ptr >> bit_pos) & TILE_MASK;
    } else {
        // FIXED: Rare path with corrected bit handling
        unsigned char low_bits = 8 - bit_pos;
        unsigned char first_part = *byte_ptr >> bit_pos;
        unsigned char second_part = (*(byte_ptr + 1) & ((1 << (3 - low_bits)) - 1)) << low_bits;
        raw_tile = (first_part | second_part) & TILE_MASK;
    }
      // Inline TILE_TO_PETSCII conversion with bounds check
    switch(raw_tile) {
        case TILE_EMPTY: return EMPTY; // 32
        case TILE_WALL:  return WALL;  // 35
        case TILE_FLOOR: return FLOOR; // 46
        case TILE_DOOR:  return DOOR;  // 43
        case TILE_UP:    return UP;    // 60
        case TILE_DOWN:  return DOWN;  // 62
        case TILE_CORNER: return CORNER; // 67 ('C')
        default: return EMPTY; // Safety fallback
    }
}

// Ultra-fast map display with perfect scroll optimization
void render_map_viewport(unsigned char force_refresh) {
    // Handle force refresh
    if (force_refresh) {
        // Use optimized hardware clear from utility
        oscar_clrscr();
        
        // Clear both screen memory AND buffer completely
        memset((void*)screen_memory, EMPTY, 25 * 40);
        memset(screen_buffer, EMPTY, VIEW_H * VIEW_W);
        screen_dirty = 1;
        last_scroll_direction = 0; // Reset scroll tracking
    }
    
    // Early exit if not dirty
    if (!screen_dirty) {
        return;
    }
    
    // FIXED: Store scroll direction before potential reset
    unsigned char current_scroll_direction = last_scroll_direction;
    
    // PERFECT SCROLL SYSTEM: One solution for all cases
    if (current_scroll_direction != 0) {
        // Use perfect scroll optimization with adaptive edge buffering
        update_screen_with_perfect_scroll(current_scroll_direction);
    } else {
        // Full screen update for initial display or force refresh
        update_full_screen();
    }
    
    screen_dirty = 0;
    // FIXED: Reset scroll direction AFTER display update
    last_scroll_direction = 0;
}

// ============================================================================
// SIMPLIFIED INPUT HANDLING SYSTEM
// ============================================================================

// Simplified input handling with direct camera movement - MUCH CLEANER LOGIC
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
        
        // IMPROVED: Determine scroll direction based on ACTUAL camera movement
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
// PERFECT SCROLL SYSTEM - SINGLE SOLUTION FOR ALL CASES
// =============================================================================

// Perfect scroll optimization - handles all edge cases smoothly
void update_screen_with_perfect_scroll(unsigned char scroll_dir) {
    unsigned int screen_offset;
    unsigned char x, y;
    
    // SAFETY CHECK: Validate scroll direction
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
    
    // FIXED: Always use single line/column scroll for precise movement
      switch(scroll_dir) {          case 1: // Scroll UP - move content down by one line only
            // OPTIMIZED: Line-by-line processing like horizontal scroll
            // Shift screen content down by 1 line
            for (y = VIEW_H - 1; y >= 1; y--) {
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
            break;        case 2: // Scroll DOWN - move content up by one line only
            // OPTIMIZED: Line-by-line processing like horizontal scroll
            // Shift screen content up by 1 line  
            for (y = 0; y < VIEW_H - 1; y++) {
                // Shift this line in screen memory
                for (x = 0; x < VIEW_W; x++) {
                    screen_memory[y * 40 + x] = screen_memory[(y + 1) * 40 + x];
                }
                // Shift this line in buffer (integrated processing)
                memmove(&screen_buffer[y][0], &screen_buffer[y + 1][0], VIEW_W);
            }
            
            // Fill bottom line with new content
            screen_offset = (VIEW_H - 1) * 40;
            for (x = 0; x < VIEW_W; x++) {
                unsigned char tile = get_map_tile_fast(view.x + x, view.y + VIEW_H - 1);
                screen_memory[screen_offset + x] = tile;
                screen_buffer[VIEW_H - 1][x] = tile;
            }
            break;
            
        case 3: // Scroll LEFT - move content right by one column only
            // Shift screen content right by 1 column
            for (y = 0; y < VIEW_H; y++) {
                for (x = VIEW_W - 1; x >= 1; x--) {
                    screen_memory[y * 40 + x] = screen_memory[y * 40 + x - 1];
                }
                // Shift buffer content
                memmove(&screen_buffer[y][1], &screen_buffer[y][0], VIEW_W - 1);
                
                // Fill leftmost column
                unsigned char tile = get_map_tile_fast(view.x, view.y + y);
                screen_memory[y * 40] = tile;
                screen_buffer[y][0] = tile;
            }
            break;        
        
        case 4: // Scroll RIGHT - move content left by one column only
            // Shift screen content left by 1 column
            for (y = 0; y < VIEW_H; y++) {
                for (x = 0; x < VIEW_W - 1; x++) {
                    screen_memory[y * 40 + x] = screen_memory[y * 40 + x + 1];
                }
                // Shift buffer content
                memmove(&screen_buffer[y][0], &screen_buffer[y][1], VIEW_W - 1);
                
                // Fill rightmost column
                unsigned char tile = get_map_tile_fast(view.x + VIEW_W - 1, view.y + y);
                screen_memory[y * 40 + VIEW_W - 1] = tile;
                screen_buffer[y][VIEW_W - 1] = tile;
            }
            break;
    }
}

// Full screen update for force refresh or initial display - FIXED DELTA LOGIC
void update_full_screen(void) {
    for (unsigned char screen_y = 0; screen_y < VIEW_H; screen_y++) {
        unsigned int screen_pos = screen_y * 40;
        
        for (unsigned char x = 0; x < VIEW_W; x++) {
            unsigned char tile = get_map_tile_fast(view.x + x, view.y + screen_y);
            
            // CRITICAL FIX: Always update first, then check for optimization later
            // Delta comparison can fail with uninitialized buffer
            screen_memory[screen_pos + x] = tile;
            screen_buffer[screen_y][x] = tile;
        }
    }
}

