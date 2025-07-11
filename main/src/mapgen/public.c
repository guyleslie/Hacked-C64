// Public Interface Module for C64 Map Generator
// Contains the main API functions for external use and integration

#include "mapgen_types.h"      // For Room, Viewport, etc.
#include "mapgen_api.h"        // For public API
#include "mapgen_display.h"    // For display/viewport reset

// External global references
extern Room rooms[MAX_ROOMS];
extern unsigned char room_count;
extern unsigned char camera_center_x, camera_center_y;
extern Viewport view;

// External references for display reset
extern unsigned char screen_buffer[VIEW_H][VIEW_W];
extern unsigned char screen_dirty;
extern unsigned char last_scroll_direction;

// Reset viewport and view state for fresh map generation
void reset_viewport_state(void) {
    // Reset camera position to default center
    camera_center_x = 32;
    camera_center_y = 32;
    view.x = 0;
    view.y = 0;
}

// Reset display buffers and optimization variables for new map
void reset_display_state(void) {
    // Clear screen buffer completely
    memset(screen_buffer, 32, VIEW_H * VIEW_W); // Fill with spaces
    
    // Force full screen refresh
    screen_dirty = 1;
    
    // Reset scroll optimization
    last_scroll_direction = 0;
}

// =============================================================================
// PUBLIC API FUNCTIONS
// =============================================================================

// Initialize the map generator system
void mapgen_init(void) {
    // Initial setup only - don't reset here since mapgen_generate_dungeon() will handle it
    // This prevents double initialization on first generation
    init_rng();
}

// Generate a complete dungeon level
unsigned char mapgen_generate_dungeon(void) {
    // Reset viewport state before generating new map
    reset_viewport_state();
    
    // Reset display buffers and optimization variables
    reset_display_state();
    
    // IMPORTANT: Reset generation data here to ensure consistent corridor reuse
    // This prevents double initialization during first generation
    reset_all_generation_data();
    
    return generate_level();
}

// Generate a specific type of dungeon layout
unsigned char mapgen_generate_themed_dungeon(unsigned char theme) {
    switch (theme) {
        case 0: // Standard random dungeon
            return generate_level();
            
        default:
            return generate_level();
    }
}

// Get the map tile at a specific position (safe public interface)
// Returns raw tile value (0-5)
unsigned char mapgen_get_tile(unsigned char x, unsigned char y) {
    return get_tile_raw(x, y);  // Direct raw tile access
}

// Set a map tile at a specific position (safe public interface)
// Expects raw tile value (0-5)
void mapgen_set_tile(unsigned char x, unsigned char y, unsigned char tile) {
    set_tile_raw(x, y, tile);  // Direct raw tile access
}

// Check if a position is within map bounds
unsigned char mapgen_in_bounds(unsigned char x, unsigned char y) {
    return coords_in_bounds(x, y);
}

// Get the total number of rooms in the current map
unsigned char mapgen_get_room_count(void) {
    return room_count;
}

// Get room information by index
unsigned char mapgen_get_room_info(unsigned char room_index, unsigned char *x, unsigned char *y, 
                                  unsigned char *w, unsigned char *h, unsigned char *priority) {
    if (room_index >= room_count) {
        return 0; // Invalid room index
    }
    
    if (x) *x = rooms[room_index].x;
    if (y) *y = rooms[room_index].y;
    if (w) *w = rooms[room_index].w;
    if (h) *h = rooms[room_index].h;
    if (priority) *priority = rooms[room_index].priority;
    
    return 1; // Success
}

// Find the room containing a specific position
unsigned char mapgen_find_room_at_position(unsigned char x, unsigned char y) {
    for (unsigned char i = 0; i < room_count; i++) {
        if (x >= rooms[i].x && x < rooms[i].x + rooms[i].w &&
            y >= rooms[i].y && y < rooms[i].y + rooms[i].h) {
            return i;
        }
    }
    return 255; // No room found (using 255 as "not found" value)
}

// Check if a position is inside any room
unsigned char mapgen_is_in_room(unsigned char x, unsigned char y) {
    return is_inside_room(x, y);
}

// Check if a position is outside any room
unsigned char mapgen_is_outside_any_room(unsigned char x, unsigned char y) {
    return is_outside_any_room(x, y);
}

// Find the starting room (highest priority room)
unsigned char mapgen_get_start_room(void) {
    if (room_count == 0) return 255;
    
    unsigned char start_room = 0;
    unsigned char highest_priority = rooms[0].priority;
    
    for (unsigned char i = 1; i < room_count; i++) {
        if (rooms[i].priority > highest_priority) {
            highest_priority = rooms[i].priority;
            start_room = i;
        }
    }
    
    return start_room;
}

// Find the ending room (second highest priority room)
unsigned char mapgen_get_end_room(void) {
    if (room_count < 2) return 255;
    
    unsigned char start_room = mapgen_get_start_room();
    unsigned char end_room = (start_room == 0) ? 1 : 0;
    unsigned char highest_priority = rooms[end_room].priority;
    
    for (unsigned char i = 0; i < room_count; i++) {
        if (i != start_room && rooms[i].priority > highest_priority) {
            highest_priority = rooms[i].priority;
            end_room = i;
        }
    }
    
    return end_room;
}

// Get the center position of a room
unsigned char mapgen_get_room_center(unsigned char room_index, unsigned char *center_x, unsigned char *center_y) {
    if (room_index >= room_count) {
        return 0; // Invalid room index
    }
    
    get_room_center(room_index, center_x, center_y);
    
    return 1; // Success
}

// ...existing code...

// =============================================================================
// MAP ANALYSIS FUNCTIONS
// =============================================================================

// Count specific tile types in the map
// Expects raw tile value (0-5)
unsigned int mapgen_count_tiles(unsigned char tile_type) {
    unsigned int count = 0;
    unsigned char x, y;
    
    for (y = 0; y < MAP_H; y++) {
        for (x = 0; x < MAP_W; x++) {
            if (get_tile_raw(x, y) == tile_type) {  // Direct raw tile comparison
                count++;
            }
        }
    }
    
    return count;
}

// Get map statistics
void mapgen_get_statistics(unsigned int *floor_tiles, unsigned int *wall_tiles, 
                          unsigned int *door_tiles, unsigned char *total_rooms) {
    if (floor_tiles) *floor_tiles = mapgen_count_tiles(TILE_FLOOR);
    if (wall_tiles) *wall_tiles = mapgen_count_tiles(TILE_WALL);
    if (door_tiles) *door_tiles = mapgen_count_tiles(TILE_DOOR);
    if (total_rooms) *total_rooms = room_count;
}

// Find all tiles of a specific type
// Expects raw tile value (0-5)
unsigned char mapgen_find_tiles(unsigned char tile_type, unsigned char *x_positions, 
                               unsigned char *y_positions, unsigned char max_results) {
    unsigned char found = 0;
    unsigned char x, y;
    
    for (y = 0; y < MAP_H && found < max_results; y++) {
        for (x = 0; x < MAP_W && found < max_results; x++) {
            if (get_tile_raw(x, y) == tile_type) {  // Direct raw tile comparison
                if (x_positions) x_positions[found] = x;
                if (y_positions) y_positions[found] = y;
                found++;
            }
        }
    }
    
    return found;
}

// =============================================================================
// UTILITY FUNCTIONS FOR INTEGRATION
// =============================================================================

// Validate the current map for logical consistency
unsigned char mapgen_validate_map(void) {
    // Check if we have at least one room
    if (room_count == 0) return 0;
    
    // Check if rooms are properly placed
    for (unsigned char i = 0; i < room_count; i++) {
        // Verify room bounds
        if (rooms[i].x + rooms[i].w >= MAP_W || rooms[i].y + rooms[i].h >= MAP_H) {
            return 0; // Room extends beyond map
        }
          // Verify room has floor tiles
        unsigned char has_floor = 0;
        for (unsigned char y = rooms[i].y; y < rooms[i].y + rooms[i].h; y++) {
            for (unsigned char x = rooms[i].x; x < rooms[i].x + rooms[i].w; x++) {
                if (get_tile_raw(x, y) == TILE_FLOOR) {  // Use fast raw tile access
                    has_floor = 1;
                    break;
                }
            }
            if (has_floor) break;
        }
        if (!has_floor) return 0; // Room has no floor tiles
    }
      // Check for stairs
    unsigned int up_stairs = mapgen_count_tiles(TILE_UP);
    unsigned int down_stairs = mapgen_count_tiles(TILE_DOWN);
    
    if (up_stairs == 0 || down_stairs == 0) {
        return 0; // Missing stairs
    }
    
    return 1; // Map is valid
}

// Clear a specific area of the map
void mapgen_clear_area(unsigned char x, unsigned char y, unsigned char w, unsigned char h) {
    for (unsigned char iy = y; iy < y + h && iy < MAP_H; iy++) {
        for (unsigned char ix = x; ix < x + w && ix < MAP_W; ix++) {
            set_tile_raw(ix, iy, TILE_EMPTY);  // Use fast raw access for EMPTY
        }
    }
}

// Fill a specific area with a tile type
// Expects raw tile value (0-5)
void mapgen_fill_area(unsigned char x, unsigned char y, unsigned char w, unsigned char h, unsigned char tile) {
    for (unsigned char iy = y; iy < y + h && iy < MAP_H; iy++) {
        for (unsigned char ix = x; ix < x + w && ix < MAP_W; ix++) {
            set_tile_raw(ix, iy, tile);  // Direct raw tile access
        }
    }
}

// Get map dimensions
void mapgen_get_dimensions(unsigned char *width, unsigned char *height) {
    if (width) *width = MAP_W;
    if (height) *height = MAP_H;
}
