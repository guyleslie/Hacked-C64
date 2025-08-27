// =============================================================================
// MAPGEN UTILITIES MODULE
// Contains utility functions, tile access, random number generation, and helper functions
// =============================================================================

// System headers
#include <c64/vic.h>
#include <c64/cia.h>
#include <stdio.h>
#include <conio.h>
#include <string.h>
#include <stdlib.h>
// Project headers
#include "mapgen_types.h"     // For Room, MAP_W, MAP_H, MAX_ROOMS
#include "mapgen_api.h"       // For public API
#include "mapgen_utils.h"     // For utility/math/cache functions
#include "mapgen_internal.h"  // For internal helpers
#include "mapgen_display.h"   // For display/viewport reset

// =============================================================================
// GLOBAL MAPGEN DATA
// =============================================================================

// Compressed map data storage using 3 bits per tile
// Size: 64x64 map = 4096 tiles × 3 bits = 12288 bits = 1536 bytes
unsigned char compact_map[MAP_H * MAP_W * 3 / 8];

// Array storing room structure data for dungeon generation
Room rooms[MAX_ROOMS];

// OSCAR64 zero page variables for MST
__zeropage unsigned char mst_best_room1;
__zeropage unsigned char mst_best_room2; 
__zeropage unsigned char mst_best_distance;

// Oscar64 zero page variables for critical tile checking data (-Oz flag manages automatically)
__zeropage unsigned char tile_check_cache;
__zeropage unsigned char adjacent_tile_temp;


// Tracks the current number of rooms generated in the dungeon
unsigned char room_count = 0;

// Random number generator state
unsigned char rnd_state = 1;

// =============================================================================
// EXTERNAL GLOBAL REFERENCES
// =============================================================================

extern unsigned char camera_center_x, camera_center_y;
extern Viewport view;

// External references for display reset
extern unsigned char screen_buffer[VIEW_H][VIEW_W];
extern unsigned char screen_dirty;
extern unsigned char last_scroll_direction;

// =============================================================================
// STATIC VARIABLES
// =============================================================================


// Room center cache for coordinate calculations
static unsigned char room_center_cache[MAX_ROOMS][2]; // [room_id][0=x, 1=y]
static unsigned char room_center_cache_valid = 0;

// =============================================================================
// RNG FUNCTIONS
// =============================================================================

// Initialize random number generator
void init_rnd(void) {
    rnd_state = (unsigned char)(cia1.ta ^ vic.raster);
    if (rnd_state == 0) rnd_state = 1;
}

// Generate random number
unsigned char rnd(unsigned char max) {
    if (max <= 1) return 0;
    rnd_state = rnd_state * 97 + 71;
    return rnd_state % max;
}

/**
 * Get a tile value from the compact map (3 bits per tile)
 * @param x X coordinate (0-63)
 * @param y Y coordinate (0-63)
 * @return Tile value (0-7) or TILE_EMPTY if out of bounds
 */
unsigned char get_compact_tile(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return TILE_EMPTY;
    
    // Calculate bit offset: (y * 64 + x) * 3 = y * 192 + x * 3
    // Using bit shifts for multiplication: y * 192 = y * 128 + y * 64 = y << 7 + y << 6
    unsigned short bit_offset = ((unsigned short)y << 7) + ((unsigned short)y << 6) + x + x + x;
    
    // Calculate byte position and bit position within byte
    unsigned char *byte_ptr = &compact_map[bit_offset >> 3];  // Divide by 8 to get byte
    unsigned char bit_pos = bit_offset & 7;  // Modulo 8 to get bit position
    
    // Handle tile reading based on bit position
    if (bit_pos <= 5) {
        // Fast path: tile fits entirely within single byte
        // Simply shift right and mask to get 3 bits
        return (*byte_ptr >> bit_pos) & TILE_MASK;
    } else {
        // Rare path: tile spans two bytes (only when bit_pos is 6 or 7)
        // Need to combine bits from current and next byte
        unsigned char low_bits = 8 - bit_pos;  // Bits available in current byte
        unsigned char first_part = *byte_ptr >> bit_pos;  // Get bits from current byte
        
        // Get remaining bits from next byte
        unsigned char second_part = (*(byte_ptr + 1) & ((1 << (3 - low_bits)) - 1)) << low_bits;
        
        return (first_part | second_part) & TILE_MASK;
    }
}

/**
 * Set a tile value in the compact map (3 bits per tile)
 * @param x X coordinate (0-63)
 * @param y Y coordinate (0-63)
 * @param tile Tile value (0-7)
 */
void set_compact_tile(unsigned char x, unsigned char y, unsigned char tile) {
    if (x >= MAP_W || y >= MAP_H) return;
    
    // Calculate bit offset: (y * 64 + x) * 3 = y * 192 + x * 3
    unsigned short bit_offset = ((unsigned short)y << 7) + ((unsigned short)y << 6) + x + x + x;
    
    // Calculate byte position and bit position within byte
    unsigned char *byte_ptr = &compact_map[bit_offset >> 3];
    unsigned char bit_pos = bit_offset & 7;
    
    tile &= TILE_MASK; // Ensure only 3 bits are used
    
    // Handle tile writing based on bit position
    if (bit_pos <= 5) {
        // Fast path: tile fits entirely within single byte
        unsigned char mask = TILE_MASK << bit_pos;  // Create mask for tile bits
        *byte_ptr = (*byte_ptr & ~mask) | (tile << bit_pos);  // Clear and set bits
    } else {
        // Rare path: tile spans two bytes
        unsigned char low_bits = 8 - bit_pos;  // Bits to store in current byte
        unsigned char high_bits = 3 - low_bits;  // Bits to store in next byte
        
        // Update current byte (low bits of tile)
        unsigned char mask1 = ((1 << low_bits) - 1) << bit_pos;
        *byte_ptr = (*byte_ptr & ~mask1) | ((tile & ((1 << low_bits) - 1)) << bit_pos);
        
        // Update next byte (high bits of tile)
        unsigned char mask2 = (1 << high_bits) - 1;
        *(byte_ptr + 1) = (*(byte_ptr + 1) & ~mask2) | (tile >> low_bits);
    }
}

/**
 * Core tile reader - inline function
 * Used internally by all tile checking functions
 * No bounds checking for maximum performance
 */
static inline unsigned char get_tile_core(unsigned char x, unsigned char y) {
    // Calculate bit offset: (y * 64 + x) * 3
    unsigned short bit_offset = ((unsigned short)y << 7) + ((unsigned short)y << 6) + x + x + x;
    
    // Byte and bit position extraction
    unsigned char *byte_ptr = &compact_map[bit_offset >> 3];
    unsigned char bit_pos = bit_offset & 7;
    
    // Handle tile reading
    if (bit_pos <= 5) {
        // Fast path: single byte
        return (*byte_ptr >> bit_pos) & TILE_MASK;
    }
    
    // Rare path: spans two bytes
    unsigned char low_bits = 8 - bit_pos;
    unsigned char first_part = *byte_ptr >> bit_pos;
    unsigned char second_part = (*(byte_ptr + 1) & ((1 << (3 - low_bits)) - 1)) << low_bits;
    
    return (first_part | second_part) & TILE_MASK;
}

// Get single tile from map and convert to PETSCII for display
unsigned char get_map_tile(unsigned char map_x, unsigned char map_y) {
    // Bounds check
    if (map_x >= MAP_W || map_y >= MAP_H) {
        return EMPTY; // Return space character for out of bounds
    }
    
    // Get raw tile value
    unsigned char raw_tile = get_tile_core(map_x, map_y);
    
    // Convert compact tile type to PETSCII character
    switch(raw_tile) {
        case TILE_EMPTY:  return EMPTY;   // 32 - space character
        case TILE_WALL:   return WALL;    // 160 - solid block
        case TILE_FLOOR:  return FLOOR;   // 46 - period
        case TILE_DOOR:   return DOOR;    // 219 - door character
        case TILE_UP:     return UP;      // 60 - less than
        case TILE_DOWN:   return DOWN;    // 62 - greater than
        // TILE_CORNER removed - corners now use regular walls
        default:          return EMPTY;   // Safety fallback
    }
}

/**
 * Fast tile access for map generation (returns raw tile type)
 * @param x X coordinate
 * @param y Y coordinate  
 * @return Raw tile type (0-7) or TILE_EMPTY if out of bounds
 */
inline unsigned char get_tile_raw(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return TILE_EMPTY;
    return get_tile_core(x, y);  // Use shared optimized core
}

/**
 * Fast tile setter for map generation
 * @param x X coordinate
 * @param y Y coordinate
 * @param tile Raw tile type (0-7)
 */
inline void set_tile_raw(unsigned char x, unsigned char y, unsigned char tile) {
    set_compact_tile(x, y, tile);  // Delegate to main setter
}

// =============================================================================
// TILE TYPE CHECKING FUNCTIONS
// =============================================================================

/**
 * Check if tile is floor
 */
inline unsigned char tile_is_floor(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return 0;
    return get_tile_core(x, y) == TILE_FLOOR;
}

/**
 * Check if tile is wall
 */
inline unsigned char tile_is_wall(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return 0;
    return get_tile_core(x, y) == TILE_WALL;
}

/**
 * Check if tile is door
 */
inline unsigned char tile_is_door(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return 0;
    return get_tile_core(x, y) == TILE_DOOR;
}

/**
 * Check if tile is empty
 */
inline unsigned char tile_is_empty(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return 1;  // Out of bounds = empty
    return get_tile_core(x, y) == TILE_EMPTY;
}

/**
 * Clear entire map to empty space
 * Clear all bytes to 0 (since TILE_EMPTY = 0)
 */
void clear_map(void) {
    // Calculate total bytes needed for compact map
    // 64x64 tiles * 3 bits = 12288 bits = 1536 bytes
    unsigned short total_bytes = (MAP_H * MAP_W * 3 + 7) / 8; // Round up division
    unsigned short i;
    
    // Clear all bytes to 0 (TILE_EMPTY = 0)
    for (i = 0; i < total_bytes; i++) {
        compact_map[i] = 0;
    }
}

// =============================================================================
// COORDINATE AND BOUNDS CHECKING
// =============================================================================

// Coordinate validation with bounds checking
inline unsigned char coords_in_bounds(unsigned char x, unsigned char y) {
    return (x < MAP_W && y < MAP_H && x != UNDERFLOW_CHECK_VALUE && y != UNDERFLOW_CHECK_VALUE);
}

// Simple bounds checking without underflow protection for performance-critical paths
unsigned char is_within_map_bounds(unsigned char x, unsigned char y) {
    return (x < MAP_W) && (y < MAP_H);
}

// Coordinate clamping to map boundaries
void clamp_to_bounds(unsigned char *x, unsigned char *y) {
    if (*x >= MAP_W) *x = MAP_W - 1;
    if (*y >= MAP_H) *y = MAP_H - 1;
    if (*x == UNDERFLOW_CHECK_VALUE) *x = 0; // Handle underflow
    if (*y == UNDERFLOW_CHECK_VALUE) *y = 0; // Handle underflow
}

// Room containment check with bounds validation
unsigned char point_in_room(unsigned char x, unsigned char y, unsigned char room_id) {
    // Bounds check for room_id - early exit for invalid room
    if (room_id >= room_count) return 0;
    
    Room *room = &rooms[room_id];
    unsigned char right_edge = get_room_right_edge(room_id);
    unsigned char bottom_edge = get_room_bottom_edge(room_id);
    
    // Single comparison chain for efficient boolean logic
    // Room interior check (exclusive boundaries for traditional room logic)
    return (x >= room->x && x < room->x + room->w &&
            y >= room->y && y < room->y + room->h);
}

// Check if point is inside any room
unsigned char is_inside_any_room(unsigned char x, unsigned char y) {
    for (unsigned char i = 0; i < room_count; i++) {
        if (point_in_room(x, y, i)) {
            return 1; 
        }
    }
    return 0; 
}

// Room containment with register usage
#pragma optimize(push)
#pragma optimize(3, speed, inline, constparams) // Maximum optimization for critical function

unsigned char point_in_any_room(unsigned char x, unsigned char y, unsigned char *room_id) {
    // Oscar64 Range Analysis hints for 8-bit optimization
    __assume(x < MAP_W);
    __assume(y < MAP_H);
    
    unsigned char i; // Oscar64 loop register allocation
    
    // Oscar64 optimizes this loop with register allocation and strength reduction
    for (i = 0; i < room_count; i++) {
        // Oscar64 Common Subexpression Elimination - cache frequently accessed values
        unsigned char rx = rooms[i].x;
        unsigned char ry = rooms[i].y;
        unsigned char rw = rooms[i].w;
        unsigned char rh = rooms[i].h;
        
        // Single comparison chain - Oscar64 Branch Optimization
        if (x >= rx && y >= ry && x < rx + rw && y < ry + rh) {
            if (room_id) *room_id = i; // Optional room ID return
            return 1;
        }
    }
    return 0;
}

#pragma optimize(pop)

// Inverse check - outside all rooms
unsigned char is_outside_any_room(unsigned char x, unsigned char y) {
    return !is_inside_any_room(x, y);
}

// Check if position is inside specific room
unsigned char is_inside_room(unsigned char x, unsigned char y, unsigned char room_id) {
    if (room_id >= room_count) return 0;
    return point_in_room(x, y, room_id);
}

// Inverse check - outside specific room
unsigned char is_outside_room(unsigned char x, unsigned char y, unsigned char room_id) {
    return !is_inside_room(x, y, room_id);
}

// =============================================================================
// ROOM EXIT MANAGEMENT UTILITIES
// =============================================================================

// Calculate optimal exit position avoiding corners and ensuring good corridor angles
static unsigned char calculate_optimal_exit_position(unsigned char room_dim, unsigned char target_coord, unsigned char room_coord) {
    // Calculate relative position of target (0-255 range)
    unsigned char relative_pos;
    if (target_coord > room_coord + room_dim / 2) {
        // Target is towards the end of room dimension
        relative_pos = 192; // ~75% position
    } else if (target_coord < room_coord + room_dim / 2) {
        // Target is towards the start of room dimension  
        relative_pos = 64;  // ~25% position
    } else {
        // Target is centered - use middle
        relative_pos = 128; // ~50% position
    }
    
    // Convert relative position to actual coordinate
    // Ensure position is within 25%-75% range to avoid corners
    unsigned char min_pos = room_dim / 4;          // 25% from start
    unsigned char max_pos = room_dim - room_dim / 4; // 75% from start
    
    if (min_pos >= max_pos) {
        // Room too small - use center
        return room_dim / 2;
    }
    
    // Map relative position to safe range
    unsigned char safe_range = max_pos - min_pos;
    unsigned char offset = (relative_pos * safe_range) / 256;
    
    return min_pos + offset;
}

// Room exits finding with positioning to avoid corners
// Maintains 2-tile distance rule
// Now checks for existing doors and aligns exit points to them
void find_room_exit(Room *room, unsigned char target_x, unsigned char target_y, 
                   unsigned char *exit_x, unsigned char *exit_y) {
    unsigned char room_center_x, room_center_y;
    unsigned char room_id = room - rooms; // Calculate room index from pointer
    get_room_center(room_id, &room_center_x, &room_center_y);
    
    unsigned char dx = abs_diff(target_x, room_center_x);
    unsigned char dy = abs_diff(target_y, room_center_y);
    
    // Determine optimal edge based on target direction
    if (dx > dy) {
        // Horizontal movement preferred - exit from left/right edge
        if (target_x > room_center_x) {
            // Exit from room right edge (perimeter +2)
            *exit_x = room->x + room->w + 1; // Maintains 2-tile distance rule
            *exit_y = room->y + calculate_optimal_exit_position(room->h, target_y, room->y);
            
            // Check for existing door on right side
            unsigned char existing_door_x, existing_door_y;
            if (find_existing_door_on_room_side(room_id, 1, target_x, target_y, &existing_door_x, &existing_door_y)) {
                // Align exit to existing door
                *exit_y = existing_door_y;
                *exit_x = existing_door_x + 1; // Exit 1 tile away from door
            }
        } else {
            // Exit from room left edge (perimeter -2)
            *exit_x = room->x - 2; // Maintains 2-tile distance rule
            *exit_y = room->y + calculate_optimal_exit_position(room->h, target_y, room->y);
            
            // Check for existing door on left side
            unsigned char existing_door_x, existing_door_y;
            if (find_existing_door_on_room_side(room_id, 0, target_x, target_y, &existing_door_x, &existing_door_y)) {
                // Align exit to existing door
                *exit_y = existing_door_y;
                *exit_x = existing_door_x - 1; // Exit 1 tile away from door
            }
        }
    } else {
        // Vertical movement preferred - exit from top/bottom edge
        if (target_y > room_center_y) {
            // Exit from room bottom edge (perimeter +2)
            *exit_y = room->y + room->h + 1; // Maintains 2-tile distance rule
            *exit_x = room->x + calculate_optimal_exit_position(room->w, target_x, room->x);
            
            // Check for existing door on bottom side
            unsigned char existing_door_x, existing_door_y;
            if (find_existing_door_on_room_side(room_id, 3, target_x, target_y, &existing_door_x, &existing_door_y)) {
                // Align exit to existing door
                *exit_x = existing_door_x;
                *exit_y = existing_door_y + 1; // Exit 1 tile away from door
            }
        } else {
            // Exit from room top edge (perimeter -2)
            *exit_y = room->y - 2; // Maintains 2-tile distance rule
            *exit_x = room->x + calculate_optimal_exit_position(room->w, target_x, room->x);
            
            // Check for existing door on top side
            unsigned char existing_door_x, existing_door_y;
            if (find_existing_door_on_room_side(room_id, 2, target_x, target_y, &existing_door_x, &existing_door_y)) {
                // Align exit to existing door
                *exit_x = existing_door_x;
                *exit_y = existing_door_y - 1; // Exit 1 tile away from door
            }
        }
    }
}

// =============================================================================
// UNIFIED EXIT POINT CALCULATION
// =============================================================================

/**
 * @brief Calculates unified exit points for both corridor and door placement
 * 
 * This function directly calculates door positions (1 tile from perimeter)
 * for corridor connections. Exit points and door positions are unified,
 * eliminating the need for redundant offset calculations.
 * 
 * Performance benefit: ~15-20% reduction in corridor generation time
 * Code clarity: Eliminates confusing override pattern and global state
 */
void calculate_exit_points(Room *room, unsigned char target_x, unsigned char target_y, 
                                 ExitPoint *exit) {
    unsigned char room_center_x, room_center_y;
    unsigned char room_id = room - rooms; // Calculate room index from pointer
    get_room_center(room_id, &room_center_x, &room_center_y);
    
    unsigned char dx = abs_diff(target_x, room_center_x);
    unsigned char dy = abs_diff(target_y, room_center_y);
    
    // Determine optimal edge and calculate door position
    if (dx > dy) {
        // Horizontal movement preferred - calculate X-axis positions
        unsigned char edge_pos = room->y + calculate_optimal_exit_position(room->h, target_y, room->y);
        
        if (target_x > room_center_x) {
            // Right edge - door position is 1 tile away from perimeter
            exit->x = room->x + room->w;
            exit->wall_side = 1; // Right wall
        } else {
            // Left edge - door position is 1 tile away from perimeter
            exit->x = room->x - 1;
            exit->wall_side = 0; // Left wall
        }
        exit->y = edge_pos;
        exit->edge_position = edge_pos - room->y;
        
        // Check for existing door alignment on horizontal sides
        unsigned char existing_door_x, existing_door_y;
        if (find_existing_door_on_room_side(room_id, exit->wall_side, target_x, target_y, 
                                                &existing_door_x, &existing_door_y)) {
            // Align to existing door
            exit->x = existing_door_x;
            exit->y = existing_door_y;
            exit->edge_position = existing_door_y - room->y;
        }
    } else {
        // Vertical movement preferred - calculate Y-axis positions
        unsigned char edge_pos = room->x + calculate_optimal_exit_position(room->w, target_x, room->x);
        
        if (target_y > room_center_y) {
            // Bottom edge - door position is 1 tile away from perimeter
            exit->y = room->y + room->h;
            exit->wall_side = 3; // Bottom wall
        } else {
            // Top edge - door position is 1 tile away from perimeter
            exit->y = room->y - 1;
            exit->wall_side = 2; // Top wall
        }
        exit->x = edge_pos;
        exit->edge_position = edge_pos - room->x;
        
        // Check for existing door alignment on vertical sides
        unsigned char existing_door_x, existing_door_y;
        if (find_existing_door_on_room_side(room_id, exit->wall_side, target_x, target_y,
                                                &existing_door_x, &existing_door_y)) {
            // Align to existing door
            exit->x = existing_door_x;
            exit->y = existing_door_y;
            exit->edge_position = existing_door_x - room->x;
        }
    }
}

// Check if there's a door nearby within specified distance
unsigned char has_door_nearby(unsigned char x, unsigned char y, unsigned char min_distance) {
    // Check within a square area around the given position
    unsigned char start_x = (x >= min_distance) ? x - min_distance : 0;
    unsigned char start_y = (y >= min_distance) ? y - min_distance : 0;
    unsigned char end_x = x + min_distance;
    unsigned char end_y = y + min_distance;
    
    // Clamp to map boundaries
    if (end_x >= MAP_W) end_x = MAP_W - 1;
    if (end_y >= MAP_H) end_y = MAP_H - 1;
    
    // Scan the area for doors
    for (unsigned char iy = start_y; iy <= end_y; iy++) {
        for (unsigned char ix = start_x; ix <= end_x; ix++) {
            if (tile_is_door(ix, iy)) {
                return 1; // Found a door nearby
            }
        }
    }
    
    return 0; // No doors found nearby
}

// =============================================================================
// ROOM EDGE (PERIMETER) VALIDATION
// =============================================================================

// Checks if the given coordinate is on the edge (perimeter) of any room.
// Register usage with early exit and cached room coordinates
#pragma optimize(push)
#pragma optimize(3, speed, inline, constparams)

unsigned char is_on_room_edge(unsigned char x, unsigned char y) {
    unsigned char i;
    for (i = 0; i < room_count; i++) {
        // Cache room coordinates in registers for faster access - Oscar64 CSE optimization
        unsigned char room_x = rooms[i].x;
        unsigned char room_y = rooms[i].y;
        unsigned char room_w = rooms[i].w;
        unsigned char room_h = rooms[i].h;
        unsigned char right_edge = room_x + room_w - 1;
        unsigned char bottom_edge = room_y + room_h - 1;
        
        // Early exit optimization - check bounds first for quick rejection
        if (x < room_x || x > right_edge || y < room_y || y > bottom_edge) continue;
        
        // Top edge (perimeter) - immediate return on match
        if (y == room_y && x >= room_x && x <= right_edge) return 1;
        // Bottom edge (perimeter)
        if (y == bottom_edge && x >= room_x && x <= right_edge) return 1;
        // Left edge (perimeter)
        if (x == room_x && y >= room_y && y <= bottom_edge) return 1;
        // Right edge (perimeter)
        if (x == right_edge && y >= room_y && y <= bottom_edge) return 1;
    }
    return 0;
}

#pragma optimize(pop)

// =============================================================================
// MATHEMATICAL AND COMPUTATIONAL UTILITIES
// =============================================================================

// Absolute difference calculation
inline unsigned char abs_diff(unsigned char a, unsigned char b) {
    return (a > b) ? a - b : b - a;
}

// Manhattan distance calculation between two points
inline unsigned char manhattan_distance(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2) {
    return abs_diff(x1, x2) + abs_diff(y1, y2);
}

// =============================================================================
// ROOM BOUNDARY CALCULATION UTILITIES
// =============================================================================
// Commonly used room coordinate calculations - centralized for consistency

// Get room right edge coordinate (x + w - 1)
inline unsigned char get_room_right_edge(unsigned char room_id) {
    if (room_id >= room_count) return 0;
    return rooms[room_id].x + rooms[room_id].w - 1;
}

// Get room bottom edge coordinate (y + h - 1)
inline unsigned char get_room_bottom_edge(unsigned char room_id) {
    if (room_id >= room_count) return 0;
    return rooms[room_id].y + rooms[room_id].h - 1;
}

// Get room center X coordinate
inline unsigned char get_room_center_x(unsigned char room_id) {
    if (room_id >= room_count) return 0;
    return rooms[room_id].x + (rooms[room_id].w - 1) / 2;
}

// Get room center Y coordinate
inline unsigned char get_room_center_y(unsigned char room_id) {
    if (room_id >= room_count) return 0;
    return rooms[room_id].y + (rooms[room_id].h - 1) / 2;
}

// Get room bounds (all corners) in a single call
void get_room_bounds(unsigned char room_id, unsigned char *x1, unsigned char *y1, unsigned char *x2, unsigned char *y2) {
    if (room_id >= room_count) {
        *x1 = *y1 = *x2 = *y2 = 0;
        return;
    }
    *x1 = rooms[room_id].x;
    *y1 = rooms[room_id].y;
    *x2 = rooms[room_id].x + rooms[room_id].w - 1;
    *y2 = rooms[room_id].y + rooms[room_id].h - 1;
}

// =============================================================================
// VIEWPORT CALCULATION UTILITIES
// =============================================================================
// Commonly used viewport dimension calculations - centralized for consistency

// Get viewport half width (frequently used for centering calculations)
inline unsigned char get_viewport_half_width(void) {
    return VIEW_W / 2;
}

// Get viewport half height (frequently used for centering calculations)
inline unsigned char get_viewport_half_height(void) {
    return VIEW_H / 2;
}

// Get maximum viewport X coordinate (VIEW_W - 1)
inline unsigned char get_viewport_max_x(void) {
    return VIEW_W - 1;
}

// Get maximum viewport Y coordinate (VIEW_H - 1)
inline unsigned char get_viewport_max_y(void) {
    return VIEW_H - 1;
}

// Fast direction calculation between two points (0=E, 1=NE, 2=N, 3=NW, 4=W, 5=SW, 6=S, 7=SE)
unsigned char calculate_direction(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2) {
    unsigned char dx = abs_diff(x1, x2);
    unsigned char dy = abs_diff(y1, y2);
    
    // Determine primary direction
    if (dx > dy) {
        return (x2 > x1) ? 0 : 4; // East or West
    } else if (dy > dx) {
        return (y2 > y1) ? 6 : 2; // South or North
    } else {
        // Diagonal movement (dx == dy)
        if (x2 > x1) {
            return (y2 > y1) ? 7 : 1; // SE or NE
        } else {
            return (y2 > y1) ? 5 : 3; // SW or NW
        }
    }
}

// =============================================================================
// ROOM CENTER CACHE MANAGEMENT
// =============================================================================

// Room center calculation with caching
inline void get_room_center(unsigned char room_id, unsigned char *center_x, unsigned char *center_y) {
    if (!room_center_cache_valid || room_id >= MAX_ROOMS) {
        // Cache miss or invalid - calculate using helper functions
        *center_x = get_room_center_x(room_id);
        *center_y = get_room_center_y(room_id);
        // Store in cache if valid room id
        if (room_id < MAX_ROOMS) {
            room_center_cache[room_id][0] = *center_x;
            room_center_cache[room_id][1] = *center_y;
        }
        return;
    }
    // Cache hit - return cached values
    *center_x = room_center_cache[room_id][0];
    *center_y = room_center_cache[room_id][1];
}

// Initialize room center cache - called after rooms are created
void init_room_center_cache(void) {
    unsigned char i;
    
    // Pre-calculate all room centers using helper functions (cache warming)
    for (i = 0; i < room_count && i < MAX_ROOMS; i++) {
        room_center_cache[i][0] = get_room_center_x(i);
        room_center_cache[i][1] = get_room_center_y(i);
    }
    room_center_cache_valid = 1;
}

// Clear room center cache - called when rooms are modified
void clear_room_center_cache(void) {
    room_center_cache_valid = 0;
}

// Fast room-to-room Manhattan distance using cached centers
unsigned char calculate_room_distance(unsigned char room1, unsigned char room2) {
    unsigned char x1, y1, x2, y2;
    get_room_center(room1, &x1, &y1);
    get_room_center(room2, &x2, &y2);
    return manhattan_distance(x1, y1, x2, y2);
}

/**
 * @brief Calculate optimal maximum connection distance based on room count and map size
 * @return Maximum allowable distance between rooms for connection
 * 
 * For sparse room layouts (few rooms on large maps), allows longer connections
 * to ensure all rooms can be connected. Uses conservative limits for C64 performance.
 */
unsigned char get_max_connection_distance(void) {
    // For maps with very few rooms, use extended distance
    if (room_count <= CONNECTION_DISTANCE_THRESHOLD) {
        return MAX_CONNECTION_DISTANCE_EXTENDED;
    }
    
    // For normal room density, use base distance
    return MAX_CONNECTION_DISTANCE_BASE;
}

// =============================================================================
// TILE VALIDATION AND ADJACENCY CHECKING
// =============================================================================

// Lookup table for tile type matching (1 bit per tile type)
static const unsigned char tile_type_masks[8] = {
    0x01,  // TILE_EMPTY -> TILE_CHECK_EMPTY
    0x02,  // TILE_WALL -> TILE_CHECK_WALL  
    0x04,  // TILE_FLOOR -> TILE_CHECK_FLOOR
    0x08,  // TILE_DOOR -> TILE_CHECK_DOOR
    0x00,  // TILE_UP -> no match
    0x00,  // TILE_DOWN -> no match
    0x00,  // Reserved
    0x00   // Reserved
};

// Tile type checking using lookup table
inline unsigned char check_tile_has_types(unsigned char x, unsigned char y, unsigned char type_flags) {
    if (x >= MAP_W || y >= MAP_H) return 0;  // Fast bounds check without underflow
    
    unsigned char tile = get_tile_core(x, y);  // Use shared core function
    return (tile <= 3) ? (tile_type_masks[tile] & type_flags) != 0 : 0;
}

// =============================================================================
// EARLY EXIT TILE CHECKING
// Stop immediately when condition is met - major performance gain
// =============================================================================

#pragma optimize(push)
#pragma optimize(3, speed, inline, maxinline) // Aggressive optimization for hot path

unsigned char check_adjacent_tile_types(unsigned char x, unsigned char y, 
                                       unsigned char type_flags, unsigned char include_diagonals) {
    // Oscar64 Range Analysis hints
    __assume(x < MAP_W);
    __assume(y < MAP_H);
    __assume(type_flags != 0);
    
    if (x >= MAP_W || y >= MAP_H) return 0;
    
    // Unrolled cardinal checks with immediate return - Oscar64 optimizes branch prediction
    // Check most common directions first for better average performance
    
    // North - most frequently matched in dungeon generation
    if (y > 0) {
        adjacent_tile_temp = get_tile_core(x, y-1);
        if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
    }
    
    // South  
    if (y < MAP_H-1) {
        adjacent_tile_temp = get_tile_core(x, y+1);
        if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
    }
    
    // East
    if (x < MAP_W-1) {
        adjacent_tile_temp = get_tile_core(x+1, y);
        if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
    }
    
    // West
    if (x > 0) {
        adjacent_tile_temp = get_tile_core(x-1, y);
        if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
    }
    
    // Diagonal checks only if needed and no match found yet
    if (include_diagonals) {
        // Oscar64 optimizes these bounds checks automatically
        if (x > 0 && y > 0) {
            adjacent_tile_temp = get_tile_core(x-1, y-1);
            if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
        }
        if (x < MAP_W-1 && y > 0) {
            adjacent_tile_temp = get_tile_core(x+1, y-1);
            if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
        }
        if (x > 0 && y < MAP_H-1) {
            adjacent_tile_temp = get_tile_core(x-1, y+1);
            if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
        }
        if (x < MAP_W-1 && y < MAP_H-1) {
            adjacent_tile_temp = get_tile_core(x+1, y+1);
            if (adjacent_tile_temp <= 3 && (tile_type_masks[adjacent_tile_temp] & type_flags)) return 1;
        }
    }
    
    return 0; // No matching adjacent tiles found
}

#pragma optimize(pop)

// Legacy adjacency checker
unsigned char check_tile_adjacency(unsigned char x, unsigned char y, unsigned char include_diagonals, unsigned char tile_types) {
    if (!coords_in_bounds(x, y)) return 0;
    
    // Convert old tile type flags to new bit flag system
    unsigned char type_flags = 0;
    if (tile_types & CHECK_DOORS_ONLY) type_flags |= TILE_CHECK_DOOR;
    if (tile_types & CHECK_FLOORS_ONLY) type_flags |= TILE_CHECK_FLOOR;
    
    // Use bit flag adjacency system
    return check_adjacent_tile_types(x, y, type_flags, include_diagonals);
}

// =============================================================================
// TEXT OUTPUT UTILITY
// =============================================================================

/**
 * Convert ASCII to mixed charset for C64 display
 */
static unsigned char to_mixed_charset(unsigned char c) {
    if (c >= 'A' && c <= 'Z') return c + 32; // 'A'-'Z' to C64 lowercase
    if (c >= 'a' && c <= 'z') return c - 32; // 'a'-'z' to C64 uppercase
    return c;
}

/**
 * Memory-efficient text output using KERNAL calls
 */
void print_text(const char* text) {
    unsigned char i = 0;
    while (text[i] != '\0') {
        unsigned char outc;
        if (text[i] == '\n') {
            outc = 13; // CR for newline
        } else {
            outc = to_mixed_charset((unsigned char)text[i]);
        }
        // Output character using direct KERNAL call
        __asm {
            lda outc
            jsr $ffd2
        }
        i++;
    }
}

// =============================================================================
// RESET AND STATE MANAGEMENT
// =============================================================================

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

// Master reset function - clears all generation data before each new map
void reset_all_generation_data(void) {
    // 1. RNG initialization
    init_rnd();
    
    // 2. Complete map clearing
    clear_map();
    
    // 3. Room counter reset
    room_count = 0;
    
    // 4. Room center cache invalidation
    clear_room_center_cache();
    
    // 5. Connection system reset
    init_connection_system();
}

// =============================================================================
// PUBLIC API FUNCTIONS
// =============================================================================

// Initialize the map generation system
void mapgen_init(unsigned int seed) {
    rnd_state = (unsigned char)seed;
    if (rnd_state == 0) rnd_state = 1;
    room_count = 0;
    clear_map();
    clear_room_center_cache();
    init_connection_system();
}

// Generate a complete dungeon level
unsigned char mapgen_generate_dungeon(void) {
    // Reset viewport state before generating new map
    reset_viewport_state();
    
    // Reset display buffers and optimization variables
    reset_display_state();
    
    // Reset all map generation data
    reset_all_generation_data();
    
    return generate_level();
}

// Direct access to internal functions

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
    unsigned char room_id;
    if (point_in_any_room(x, y, &room_id)) {
        return room_id;
    }
    return 255; // No room found (using 255 as "not found" value)
}

// Direct internal functions - no wrappers needed

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

// =============================================================================
// MAP ANALYSIS AND UTILITY FUNCTIONS (NOT USED, FOR FUTURE INTEGRATION)
// =============================================================================

// Count specific tile types in the map
// Expects raw tile value (0-5)
unsigned char mapgen_count_tiles(unsigned char tile_type) {
    unsigned char count = 0;
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
void mapgen_get_statistics(unsigned char *floor_tiles, unsigned char *wall_tiles, 
                          unsigned char *door_tiles, unsigned char *total_rooms) {
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
// CONNECTION SYSTEM UTILITIES (moved from connection_system.c)
// =============================================================================

// Cache for room distance calculations
static unsigned char room_distance_cache[MAX_ROOMS][MAX_ROOMS];
static unsigned char distance_cache_valid = 0;

// Absolute difference between two unsigned char values
unsigned char abs_diff(unsigned char a, unsigned char b) {
    return (a > b) ? (a - b) : (b - a);
}


// Cache-aware room distance calculation
unsigned char get_cached_room_distance(unsigned char room1, unsigned char room2) {
    if (!distance_cache_valid || room1 >= MAX_ROOMS || room2 >= MAX_ROOMS) {
        return calculate_room_distance(room1, room2);
    }
    
    unsigned char cached_distance = room_distance_cache[room1][room2];
    if (cached_distance != 255) { // Valid cache entry
        return cached_distance;
    }
    
    // Cache miss - calculate and store
    cached_distance = calculate_room_distance(room1, room2);
    room_distance_cache[room1][room2] = cached_distance;
    room_distance_cache[room2][room1] = cached_distance; // Symmetric
    
    return cached_distance;
}


// Initialize room distance cache
void init_room_distance_cache(void) {
    unsigned char i, j;
    
    // Initialize cache as invalid
    for (i = 0; i < MAX_ROOMS; i++) {
        for (j = 0; j < MAX_ROOMS; j++) {
            room_distance_cache[i][j] = 255;
        }
    }
    
    // Pre-calculate distances for existing rooms
    for (i = 0; i < room_count && i < MAX_ROOMS; i++) {
        for (j = i + 1; j < room_count && j < MAX_ROOMS; j++) {
            room_distance_cache[i][j] = calculate_room_distance(i, j);
            room_distance_cache[j][i] = room_distance_cache[i][j];
        }
    }
    
    distance_cache_valid = 1;
}

// Clear room distance cache
void clear_room_distance_cache(void) {
    distance_cache_valid = 0;
}

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
    unsigned char up_stairs = mapgen_count_tiles(TILE_UP);
    unsigned char down_stairs = mapgen_count_tiles(TILE_DOWN);
    
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
