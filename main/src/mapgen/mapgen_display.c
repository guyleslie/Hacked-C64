// =============================================================================
// Display and Navigation Module for C64 Map Generator
// Contains viewport management, input handling, and map display
// =============================================================================

// System headers
#include <c64/vic.h>
#include <c64/cia.h>
#include <conio.h>
// Project headers
#include "mapgen_types.h"         // For Room, MAX_ROOMS, map constants
#include "mapgen_utils.h"         // For viewport utilities, tile access, helper functions
#include "mapgen_display.h"       // For display, viewport, input
#include "mapgen_config.h"        // For MapParameters

// External reference to current generation parameters
extern MapParameters current_params;


#ifdef DEBUG_MAPGEN

// =============================================================================
// PETSCII TILE CONVERSION - Display-specific tile rendering
// =============================================================================

/**
 * @brief Convert raw tile type to PETSCII display character
 * @param map_x Map X coordinate
 * @param map_y Map Y coordinate
 * @return PETSCII character code for display
 */
unsigned char get_map_tile(unsigned char map_x, unsigned char map_y) {
    unsigned char raw_tile = get_compact_tile(map_x, map_y);

    switch(raw_tile) {
        case TILE_EMPTY:       return EMPTY;
        case TILE_WALL:        return WALL;
        case TILE_FLOOR:       return FLOOR;
        case TILE_DOOR:
            if (is_door_secret(map_x, map_y)) return SECRET_DOOR;
            return DOOR;
        case TILE_MARKER:
            if (is_door_secret(map_x, map_y)) return SECRET_DOOR;
            return DOOR;
        case TILE_UP:          return UP;
        case TILE_DOWN:        return DOWN;
        default:               return EMPTY;
    }
}

// =============================================================================
// VIEWPORT STATE MANAGEMENT
// =============================================================================

/**
 * @brief Reset viewport position to map center
 * Called before new map generation to ensure clean state
 */
void reset_viewport_state(void) {
    camera_center_x = current_params.map_width / 2;
    camera_center_y = current_params.map_height / 2;
    view.x = 0;
    view.y = 0;
}

/**
 * @brief Reset transient display state
 */
void reset_display_state(void) {
    // Rendering reads compact_map directly. The old 1000-byte shadow screen
    // was updated on every move but never read, so it needed no reset either.
}

// =============================================================================
// DIRECT SCREEN ACCESS
// =============================================================================

// C64 screen memory pointer. OSCAR64 recommends a constant, non-volatile
// pointer for video memory so absolute-address and loop optimizations remain
// available; volatile is intended for hardware registers and IRQ-shared data.
unsigned char * const screen_memory = (unsigned char *)SCREEN_MEMORY_BASE;

// =============================================================================
// GLOBAL VARIABLES - CAMERA AND VIEWPORT
// =============================================================================

// Camera position in map space
unsigned char camera_center_x = 36;  // 72/2 = 36 (map center for 72x72)
unsigned char camera_center_y = 36;  // 72/2 = 36 (map center for 72x72)

// Current viewport position (top-left corner)
Viewport view = {0, 0};

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
            
            // Update screen memory directly
            screen_memory[screen_pos + x] = tile;
        }
    }
}

// Main map rendering function
void render_map_viewport(unsigned char force_refresh) {
    if (force_refresh) {
        clrscr();
    }

    update_full_screen();
}
    
// ============================================================================
// CAMERA MOVEMENT SYSTEM
// ============================================================================

// Move both axes atomically. A diagonal joystick state must cause one viewport
// change and one render, not two complete character scrolls.
void move_camera(signed char dx, signed char dy) {
    unsigned char old_view_x = view.x;
    unsigned char old_view_y = view.y;
    unsigned char max_view_x = (current_params.map_width > VIEW_W) ?
                               current_params.map_width - VIEW_W : 0;
    unsigned char max_view_y = (current_params.map_height > VIEW_H) ?
                               current_params.map_height - VIEW_H : 0;

    if (dx < 0) {
        if (view.x > 0) view.x--;
    } else if (dx > 0) {
        if (view.x < max_view_x) view.x++;
    }

    if (dy < 0) {
        if (view.y > 0) view.y--;
    } else if (dy > 0) {
        if (view.y < max_view_y) view.y++;
    }

    // At a map boundary a blocked input performs no screen work at all. If
    // only one component of a diagonal is blocked, the other still scrolls.
    if (view.x == old_view_x && view.y == old_view_y) return;

    camera_center_x = view.x + VIEW_W / 2;
    camera_center_y = view.y + VIEW_H / 2;

    update_partial_screen((signed char)view.x - (signed char)old_view_x,
                          (signed char)view.y - (signed char)old_view_y);
}

// =============================================================================
// SCROLL SYSTEM 
// =============================================================================

// The build as a whole is size-oriented. These routines are the frame-critical
// exception, so compile them for speed and use OSCAR64's recommended vertical
// loop unrolling. Splitting the screen halves follows the official tutorials
// and keeps the copies ahead of the raster beam.
#pragma optimize(push, speed)

static void scroll_screen_left(void) {
    unsigned char x, y;

    for (x = 0; x < VIEW_W - 1; x++) {
        #pragma unroll(full)
        for (y = 0; y < 12; y++)
            screen_memory[40 * y + x] = screen_memory[40 * y + x + 1];
    }
    for (x = 0; x < VIEW_W - 1; x++) {
        #pragma unroll(full)
        for (y = 12; y < VIEW_H; y++)
            screen_memory[40 * y + x] = screen_memory[40 * y + x + 1];
    }
}

static void scroll_screen_right(void) {
    unsigned char x, y;

    for (x = VIEW_W - 1; x > 0; x--) {
        #pragma unroll(full)
        for (y = 0; y < 12; y++)
            screen_memory[40 * y + x] = screen_memory[40 * y + x - 1];
    }
    for (x = VIEW_W - 1; x > 0; x--) {
        #pragma unroll(full)
        for (y = 12; y < VIEW_H; y++)
            screen_memory[40 * y + x] = screen_memory[40 * y + x - 1];
    }
}

static void scroll_screen_up(void) {
    unsigned char x, y;

    for (x = 0; x < VIEW_W; x++) {
        #pragma unroll(full)
        for (y = 0; y < 12; y++)
            screen_memory[40 * y + x] = screen_memory[40 * (y + 1) + x];
    }
    for (x = 0; x < VIEW_W; x++) {
        #pragma unroll(full)
        for (y = 12; y < VIEW_H - 1; y++)
            screen_memory[40 * y + x] = screen_memory[40 * (y + 1) + x];
    }
}

static void scroll_screen_down(void) {
    unsigned char x, y;
    unsigned char middle_row[VIEW_W];

    for (x = 0; x < VIEW_W; x++)
        middle_row[x] = screen_memory[40 * 12 + x];

    for (x = 0; x < VIEW_W; x++) {
        #pragma unroll(full)
        for (y = 12; y > 0; y--)
            screen_memory[40 * y + x] = screen_memory[40 * (y - 1) + x];
    }
    for (x = 0; x < VIEW_W; x++) {
        #pragma unroll(full)
        for (y = VIEW_H - 1; y > 13; y--)
            screen_memory[40 * y + x] = screen_memory[40 * (y - 1) + x];
    }

    for (x = 0; x < VIEW_W; x++)
        screen_memory[40 * 13 + x] = middle_row[x];
}

static void scroll_screen_left_up(void) {
    unsigned char x, y;

    for (x = 0; x < VIEW_W - 1; x++) {
        #pragma unroll(full)
        for (y = 0; y < VIEW_H - 1; y++)
            screen_memory[40 * y + x] = screen_memory[40 * (y + 1) + x + 1];
    }
}

static void scroll_screen_right_up(void) {
    unsigned char x, y;

    for (x = VIEW_W - 1; x > 0; x--) {
        #pragma unroll(full)
        for (y = 0; y < VIEW_H - 1; y++)
            screen_memory[40 * y + x] = screen_memory[40 * (y + 1) + x - 1];
    }
}

static void scroll_screen_left_down(void) {
    unsigned char x, y;

    for (x = 0; x < VIEW_W - 1; x++) {
        #pragma unroll(full)
        for (y = VIEW_H - 1; y > 0; y--)
            screen_memory[40 * y + x] = screen_memory[40 * (y - 1) + x + 1];
    }
}

static void scroll_screen_right_down(void) {
    unsigned char x, y;

    for (x = VIEW_W - 1; x > 0; x--) {
        #pragma unroll(full)
        for (y = VIEW_H - 1; y > 0; y--)
            screen_memory[40 * y + x] = screen_memory[40 * (y - 1) + x - 1];
    }
}

static void fill_view_row(unsigned char screen_y) {
    unsigned char x;
    unsigned short row = (unsigned short)screen_y * 40;

    for (x = 0; x < VIEW_W; x++)
        screen_memory[row + x] = get_map_tile(view.x + x, view.y + screen_y);
}

static void fill_view_column(unsigned char screen_x,
                             unsigned char first_y,
                             unsigned char end_y) {
    unsigned char y;

    for (y = first_y; y < end_y; y++)
        screen_memory[40 * y + screen_x] =
            get_map_tile(view.x + screen_x, view.y + y);
}

// Shift the visible map once for any cardinal or diagonal one-tile move. A
// diagonal copies the shared 39x24 area directly instead of performing two
// complete scrolls, then fills only its newly exposed row and column.
void update_partial_screen(signed char dx, signed char dy) {
    if ((dx == 0 && dy == 0) || dx < -1 || dx > 1 || dy < -1 || dy > 1) {
        return;
    }

    // Start below the visible screen. This also paces a held joystick to the
    // video frames and gives every direction the same raster starting point.
    vic_waitBottom();

    if (dy == 0) {
        if (dx > 0) {
            scroll_screen_left();
            fill_view_column(VIEW_W - 1, 0, VIEW_H);
        } else {
            scroll_screen_right();
            fill_view_column(0, 0, VIEW_H);
        }
        return;
    }

    if (dx == 0) {
        if (dy > 0) {
            scroll_screen_up();
            fill_view_row(VIEW_H - 1);
        } else {
            scroll_screen_down();
            fill_view_row(0);
        }
        return;
    }

    if (dx > 0) {
        if (dy > 0) scroll_screen_left_up();
        else scroll_screen_left_down();
    } else {
        if (dy > 0) scroll_screen_right_up();
        else scroll_screen_right_down();
    }

    if (dy > 0) {
        fill_view_row(VIEW_H - 1);
        fill_view_column(dx > 0 ? VIEW_W - 1 : 0, 0, VIEW_H - 1);
    } else {
        fill_view_row(0);
        fill_view_column(dx > 0 ? VIEW_W - 1 : 0, 1, VIEW_H);
    }
}

#pragma optimize(pop)
#endif // DEBUG_MAPGEN

