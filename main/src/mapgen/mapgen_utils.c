// =============================================================================
// MAPGEN UTILITIES MODULE - Unified Utility Functions
// Contains utility functions, API wrappers, tile access, RNG, and helper functions
// =============================================================================

#include <c64/vic.h>
#include <c64/cia.h>
#include <stdio.h>
#include <conio.h>
#include <string.h>
#include <stdlib.h>
#include "mapgen_types.h"     // For Room, MAP_W, MAP_H, MAX_ROOMS
#include "mapgen_api.h"       // For public API
#include "mapgen_utils.h"     // For utility/math/cache functions
#include "mapgen_internal.h"  // For internal helpers
#include "mapgen_display.h"   // For display/viewport reset

// =============================================================================
// EXTERNAL GLOBAL REFERENCES
// =============================================================================

extern unsigned char compact_map[MAP_H * MAP_W * 3 / 8];
extern unsigned int rng_seed;
extern Room rooms[MAX_ROOMS];
extern unsigned char room_count;
extern unsigned char camera_center_x, camera_center_y;
extern Viewport view;

// External references for display reset
extern unsigned char screen_buffer[VIEW_H][VIEW_W];
extern unsigned char screen_dirty;
extern unsigned char last_scroll_direction;

// =============================================================================
// STATIC VARIABLES
// =============================================================================

// Static counter for additional randomness
static unsigned int generation_counter = 0;

// Room center cache - C64 optimized central cache for all modules
static unsigned char room_center_cache[MAX_ROOMS][2]; // [room_id][0=x, 1=y]
static unsigned char room_center_cache_valid = 0;

// =============================================================================
// HARDWARE AND RNG FUNCTIONS
// =============================================================================

// Hardware entropy source for C64 with Oscar64
unsigned int get_hardware_entropy(void) {
    return cia1.ta ^ vic.raster;
}

// Enhanced RNG initialization with counter mixing
void init_rng(void) {
    unsigned int entropy1, entropy2, entropy3, entropy4;
    unsigned char i;
    
    // Collect multiple entropy samples with delays
    entropy1 = get_hardware_entropy();
    entropy2 = get_hardware_entropy();
    entropy3 = get_hardware_entropy();
    entropy4 = get_hardware_entropy();
    
    // Increment generation counter for unique seeds
    generation_counter++;
    
    // Enhanced mixing with multiple entropy sources
    rng_seed = entropy1 ^ (entropy2 << 3) ^ (entropy3 >> 2) ^ (entropy4 << 5);
    rng_seed ^= (generation_counter << 7) ^ (generation_counter >> 1);
    rng_seed = (rng_seed << 5) ^ (rng_seed >> 11) ^ 0xAC1DU;
    
    // Additional mixing with counter and time-based variations
    rng_seed ^= generation_counter * 0x9E37U;
    rng_seed ^= (entropy1 + entropy2) * 0x5A2FU;
    
    // Multiple rounds of mixing for better distribution
    for (i = 0; i < 4; i++) {
        rng_seed = (rng_seed << 3) ^ (rng_seed >> 13) ^ (i * 0x1F2E);
    }
    
    // Ensure non-zero seed
    if (rng_seed == 0) rng_seed = 0x1D21U + generation_counter;
    
    // Warm up the RNG by discarding first few values
    for (i = 0; i < 8; i++) {
        rnd(255);
    }
}

// Fast RNG for 6502 - Enhanced for better distribution
unsigned char rnd(unsigned char max) {
    if (max <= 1) return 0;
    
    // Enhanced LFSR with better mixing
    unsigned char old_high = (unsigned char)(rng_seed >> 8);
    unsigned char old_low = (unsigned char)(rng_seed & 0xFF);
    unsigned char carry_flag = (old_high & 0x80) ? 1 : 0;  // Check bit 15
    
    // 16-bit left shift 
    rng_seed <<= 1;
    
    // XOR with polynomial if bit 15 was set (better polynomial)
    if (carry_flag) {
        rng_seed ^= 0xB400;
    }
    
    // Additional mixing with previous values for better randomness
    rng_seed ^= (old_low >> 3) | (old_high << 5);
    
    // Get result with better distribution
    unsigned char result = (unsigned char)((rng_seed ^ (rng_seed >> 8)) & 0xFF);
    
    // Fast power-of-2 masking
    switch (max) {
        case 2: 
            return result & 1;    
        case 4:
            return result & 3;    
        case 8:
            return result & 7;    
        case 16:
            return result & 15;    
        default: 
            // For non-power-of-2, use modulo with bias reduction
            // Use rejection sampling for better distribution
            unsigned char threshold = (256 / max) * max;
            while (result >= threshold) {
                // Re-roll to avoid modulo bias
                rng_seed = (rng_seed << 1) ^ (rng_seed >> 15) ^ 0x9E37;
                result = (unsigned char)((rng_seed ^ (rng_seed >> 8)) & 0xFF);
            }
            return result % max;
    }
}

// =============================================================================
// TILE ACCESS AND MANIPULATION
// =============================================================================

// Optimized compact tile getter with direct bit manipulation
unsigned char get_compact_tile(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return TILE_EMPTY;
    
    // Calculate bit offset: (y * 64 + x) * 3 = y * 192 + x * 3
    unsigned int bit_offset = ((unsigned int)y << 7) + ((unsigned int)y << 6) + x + x + x;
    
    // Byte and bit position extraction
    unsigned char *byte_ptr = &compact_map[bit_offset >> BITS_PER_TILE];
    unsigned char bit_pos = bit_offset & THREE_BIT_MASK;
    
    // Handle tile reading based on bit position
    if (bit_pos <= MAX_BIT_POSITION_FOR_TILE) {
        // Fast path: tile fits in single byte
        return (*byte_ptr >> bit_pos) & TILE_MASK;
    }
    
    // Rare path: tile spans two bytes
    unsigned char low_bits = BITS_PER_BYTE - bit_pos;
    unsigned char first_part = *byte_ptr >> bit_pos;
    unsigned char second_part = (*(byte_ptr + 1) & ((1 << (BITS_PER_TILE - low_bits)) - 1)) << low_bits;
    
    return (first_part | second_part) & TILE_MASK;
}

// Optimized compact tile setter with direct bit manipulation
void set_compact_tile(unsigned char x, unsigned char y, unsigned char tile) {
    if (x >= MAP_W || y >= MAP_H) return;
    
    // Calculate bit offset: (y * 64 + x) * 3 = y * 192 + x * 3
    unsigned int bit_offset = ((unsigned int)y << 7) + ((unsigned int)y << 6) + x + x + x;
    
    // Byte and bit position extraction
    unsigned char *byte_ptr = &compact_map[bit_offset >> 3];
    unsigned char bit_pos = bit_offset & 7;
    
    tile &= TILE_MASK; // Ensure only 3 bits
    
    // Handle tile writing based on bit position
    if (bit_pos <= 5) {
        // Fast path: tile fits in single byte
        unsigned char mask = TILE_MASK << bit_pos;
        *byte_ptr = (*byte_ptr & ~mask) | (tile << bit_pos);
    } else {
        // Rare path: tile spans two bytes
        unsigned char low_bits = 8 - bit_pos;
        unsigned char high_bits = 3 - low_bits;
        
        unsigned char mask1 = ((1 << low_bits) - 1) << bit_pos;
        unsigned char mask2 = (1 << high_bits) - 1;
        
        *byte_ptr = (*byte_ptr & ~mask1) | ((tile & ((1 << low_bits) - 1)) << bit_pos);
        *(byte_ptr + 1) = (*(byte_ptr + 1) & ~mask2) | (tile >> low_bits);
    }
}

// Optimized core tile reader used by all tile checking functions
static inline unsigned char get_tile_core(unsigned char x, unsigned char y) {
    // Calculate bit offset: (y * 64 + x) * 3 = y * 192 + x * 3
    unsigned int bit_offset = ((unsigned int)y << 7) + ((unsigned int)y << 6) + x + x + x;
    
    // Byte and bit position extraction
    unsigned char *byte_ptr = &compact_map[bit_offset >> 3];
    unsigned char bit_pos = bit_offset & 7;
    
    // Handle tile reading based on bit position
    if (bit_pos <= 5) {
        // Fast path: tile fits in single byte
        return (*byte_ptr >> bit_pos) & TILE_MASK;
    }
    
    // Rare path: tile spans two bytes
    unsigned char low_bits = 8 - bit_pos;
    return ((*byte_ptr >> bit_pos) | ((*(byte_ptr + 1) & ((1 << (3 - low_bits)) - 1)) << low_bits)) & TILE_MASK;
}

// Fast tile access for generation (no PETSCII conversion)
inline unsigned char get_tile_raw(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return TILE_EMPTY;
    return get_tile_core(x, y);  // Use shared optimized core
}

inline void set_tile_raw(unsigned char x, unsigned char y, unsigned char tile) {
    set_compact_tile(x, y, tile);  // Delegate to optimized setter
}

// Fast tile type checking functions using shared core
inline unsigned char tile_is_floor(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return 0;
    return get_tile_core(x, y) == TILE_FLOOR;
}

inline unsigned char tile_is_wall(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return 0;
    return get_tile_core(x, y) == TILE_WALL;
}

inline unsigned char tile_is_door(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return 0;
    return get_tile_core(x, y) == TILE_DOOR;
}

inline unsigned char tile_is_empty(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return 1;  // Out of bounds = empty
    return get_tile_core(x, y) == TILE_EMPTY;
}

// Clear map to empty space
void clear_map(void) {
    unsigned int total_bytes = (MAP_H * MAP_W * 3 + 7) / 8; // Round up division
    unsigned int i;
    
    for (i = 0; i < total_bytes; i++) {
        compact_map[i] = 0; // All tiles set to TILE_EMPTY (0)
    }
}

// =============================================================================
// COORDINATE AND BOUNDS CHECKING
// =============================================================================

// Fast coordinate validation with single bounds check
inline unsigned char coords_in_bounds(unsigned char x, unsigned char y) {
    return (x < MAP_W && y < MAP_H && x != UNDERFLOW_CHECK_VALUE && y != UNDERFLOW_CHECK_VALUE);
}

// Simple fast bounds checking without underflow protection for performance-critical paths
unsigned char is_within_map_bounds(unsigned char x, unsigned char y) {
    return (x < MAP_W) && (y < MAP_H);
}

// Optimized coordinate clamping to map boundaries
void clamp_to_bounds(unsigned char *x, unsigned char *y) {
    if (*x >= MAP_W) *x = MAP_W - 1;
    if (*y >= MAP_H) *y = MAP_H - 1;
    if (*x == UNDERFLOW_CHECK_VALUE) *x = 0; // Handle underflow
    if (*y == UNDERFLOW_CHECK_VALUE) *y = 0; // Handle underflow
}

// Fast room edge (perimeter) checking
unsigned char point_in_room(unsigned char x, unsigned char y, unsigned char room_id) {
    return (x >= rooms[room_id].x && x < rooms[room_id].x + rooms[room_id].w &&
            y >= rooms[room_id].y && y < rooms[room_id].y + rooms[room_id].h);
}

// =============================================================================
// ROOM EDGE (PERIMETER) VALIDATION
// =============================================================================

// Checks if the given coordinate is on the edge (perimeter) of any room.
unsigned char is_on_room_edge(unsigned char x, unsigned char y) {
    unsigned char i;
    for (i = 0; i < room_count; i++) {
        Room *room = &rooms[i];
        // Top edge (perimeter)
        if (y == room->y && x >= room->x && x < room->x + room->w) return 1;
        // Bottom edge (perimeter)
        if (y == room->y + room->h - 1 && x >= room->x && x < room->x + room->w) return 1;
        // Left edge (perimeter)
        if (x == room->x && y >= room->y && y < room->y + room->h) return 1;
        // Right edge (perimeter)
        if (x == room->x + room->w - 1 && y >= room->y && y < room->y + room->h) return 1;
    }
    return 0;
}

// =============================================================================
// MATHEMATICAL AND COMPUTATIONAL UTILITIES
// =============================================================================

// Absolute difference calculation (Oscar64 optimized)
inline unsigned char abs_diff(unsigned char a, unsigned char b) {
    return (a > b) ? a - b : b - a;
}

// Optimized Manhattan distance calculation between two points
inline unsigned char manhattan_distance(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2) {
    return abs_diff(x1, x2) + abs_diff(y1, y2);
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

// Fast room center calculation with cache - C64 optimized central function
inline void get_room_center(unsigned char room_id, unsigned char *center_x, unsigned char *center_y) {
    if (!room_center_cache_valid || room_id >= MAX_ROOMS) {
        // Cache miss or invalid - calculate directly
        // Use (w-1)/2 and (h-1)/2 to ensure center is always inside the room and closer to the edge
        *center_x = rooms[room_id].x + (rooms[room_id].w - 1) / 2;
        *center_y = rooms[room_id].y + (rooms[room_id].h - 1) / 2;
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
    
    // Pre-calculate all room centers (cache warming)
    for (i = 0; i < room_count && i < MAX_ROOMS; i++) {
        // Use (w-1)/2 and (h-1)/2 to ensure center is always inside the room and closer to the edge
        room_center_cache[i][0] = rooms[i].x + (rooms[i].w - 1) / 2;
        room_center_cache[i][1] = rooms[i].y + (rooms[i].h - 1) / 2;
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

// =============================================================================
// GRID AND PLACEMENT UTILITIES
// =============================================================================

// Grid position calculation for room placement with enhanced randomization
void get_grid_position(unsigned char grid_index, unsigned char *x, unsigned char *y) {
    unsigned char grid_x = grid_index % GRID_SIZE;
    unsigned char grid_y = grid_index / GRID_SIZE;
    unsigned char cell_w = (MAP_W - 8) / GRID_SIZE;  // Leave 8 pixels border
    unsigned char cell_h = (MAP_H - 8) / GRID_SIZE;
    
    // Base grid position
    unsigned char base_x = 4 + grid_x * cell_w;
    unsigned char base_y = 4 + grid_y * cell_h;
    
    // Add much more randomness to break grid alignment
    unsigned char extra_range_x = cell_w;      // Full cell width range for overlap
    unsigned char extra_range_y = cell_h;      // Full cell height range for overlap
    
    // Enhanced random positioning with larger displacement to break grid patterns
    unsigned char random_offset_x = rnd(extra_range_x + cell_w / 2);  // Even more randomness
    unsigned char random_offset_y = rnd(extra_range_y + cell_h / 2);  // Even more randomness
    
    // Apply random displacement from grid base
    *x = base_x + random_offset_x - (extra_range_x / 2);
    *y = base_y + random_offset_y - (extra_range_y / 2);
    
    // Add additional random scatter to completely break grid alignment
    *x += rnd(6) - 3;  // +/- 3 pixel random scatter
    *y += rnd(6) - 3;  // +/- 3 pixel random scatter
    
    // Ensure we don't go outside map bounds
    if (*x < 4) *x = 4;
    if (*y < 4) *y = 4;
    if (*x + MAX_SIZE + 3 >= MAP_W) *x = MAP_W - MAX_SIZE - 4;
    if (*y + MAX_SIZE + 3 >= MAP_H) *y = MAP_H - MAX_SIZE - 4;
}

// =============================================================================
// RANDOMIZATION UTILITIES
// =============================================================================

// Shuffle array of room indices to randomize processing order
void shuffle_room_indices(unsigned char *indices, unsigned char count) {
    unsigned char i, j, temp;
    
    for (i = count - 1; i > 0; i--) {
        if (i % 4 == 0) print_text("."); // Progress indicator every 4th iteration
        j = rnd(i + 1);  // Random index from 0 to i
        // Swap indices[i] and indices[j]
        temp = indices[i];
        indices[i] = indices[j];
        indices[j] = temp;
    }
}

// Create randomized room processing order
void create_random_room_order(unsigned char *order) {
    unsigned char i;
    
    // Initialize with sequential order
    for (i = 0; i < room_count; i++) {
        if (i % 4 == 0) print_text("."); // Progress indicator every 4th iteration
        order[i] = i;
    }
    
    // Shuffle to randomize
    shuffle_room_indices(order, room_count);
}

// =============================================================================
// TILE VALIDATION AND ADJACENCY CHECKING
// =============================================================================

// Lookup table for tile type matching (1 bit per tile type) - OPTIMIZED
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

// Ultra-fast tile type checking using lookup table
inline unsigned char check_tile_has_types(unsigned char x, unsigned char y, unsigned char type_flags) {
    if (x >= MAP_W || y >= MAP_H) return 0;  // Fast bounds check without underflow
    
    unsigned char tile = get_tile_core(x, y);  // Use shared optimized core
    return (tile <= 3) ? (tile_type_masks[tile] & type_flags) != 0 : 0;
}

// Single-pass adjacency checking with minimal function calls
unsigned char check_adjacent_tile_types(unsigned char x, unsigned char y, unsigned char type_flags, unsigned char include_diagonals) {
    // Fast early bounds check for center position
    if (x >= MAP_W || y >= MAP_H) return 0;
    
    unsigned char found = 0;
    unsigned char tile;
    
    // Cardinal directions - unrolled with minimal bounds checking
    // North
    if (y > 0) {
        tile = get_tile_raw(x, y-1);
        if (tile <= 3 && (tile_type_masks[tile] & type_flags)) found = 1;
    }
    
    // South  
    if (!found && y < MAP_H-1) {
        tile = get_tile_raw(x, y+1);
        if (tile <= 3 && (tile_type_masks[tile] & type_flags)) found = 1;
    }
    
    // West
    if (!found && x > 0) {
        tile = get_tile_raw(x-1, y);
        if (tile <= 3 && (tile_type_masks[tile] & type_flags)) found = 1;
    }
    
    // East
    if (!found && x < MAP_W-1) {
        tile = get_tile_raw(x+1, y);
        if (tile <= 3 && (tile_type_masks[tile] & type_flags)) found = 1;
    }
    
    // Diagonal directions if requested and not found yet
    if (!found && include_diagonals) {
        // Northwest
        if (x > 0 && y > 0) {
            tile = get_tile_raw(x-1, y-1);
            if (tile <= 3 && (tile_type_masks[tile] & type_flags)) found = 1;
        }
        
        // Northeast
        if (!found && x < MAP_W-1 && y > 0) {
            tile = get_tile_raw(x+1, y-1);
            if (tile <= 3 && (tile_type_masks[tile] & type_flags)) found = 1;
        }
        
        // Southwest
        if (!found && x > 0 && y < MAP_H-1) {
            tile = get_tile_raw(x-1, y+1);
            if (tile <= 3 && (tile_type_masks[tile] & type_flags)) found = 1;
        }
        
        // Southeast
        if (!found && x < MAP_W-1 && y < MAP_H-1) {
            tile = get_tile_raw(x+1, y+1);
            if (tile <= 3 && (tile_type_masks[tile] & type_flags)) found = 1;
        }
    }
    
    return found;
}

// Legacy adjacency checker
unsigned char check_tile_adjacency(unsigned char x, unsigned char y, unsigned char include_diagonals, unsigned char tile_types) {
    if (!coords_in_bounds(x, y)) return 0;
    
    // Convert old tile type flags to new bit flag system
    unsigned char type_flags = 0;
    if (tile_types & CHECK_DOORS_ONLY) type_flags |= TILE_CHECK_DOOR;
    if (tile_types & CHECK_FLOORS_ONLY) type_flags |= TILE_CHECK_FLOOR;
    
    // Use the new optimized bit flag adjacency system
    return check_adjacent_tile_types(x, y, type_flags, include_diagonals);
}

// =============================================================================
// TEXT OUTPUT UTILITY
// =============================================================================

// Memory-efficient text output function (uses assembly code for direct KERNAL calls)
// Converts ASCII upper/lowercase to correct mixed charset code for C64 display
static unsigned char to_mixed_charset(unsigned char c) {
    if (c >= 'A' && c <= 'Z') return c + 32; // 'A'-'Z' to C64 lowercase
    if (c >= 'a' && c <= 'z') return c - 32; // 'a'-'z' to C64 uppercase
    return c;
}

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

// Central reset system - clears all generation data before each new map
void reset_all_generation_data(void) {
    // 1. RNG initialization with hardware entropy
    init_rng();
    
    // 2. Complete map clearing
    clear_map();
    
    // 3. Room counter reset
    room_count = 0;
    
    // 4. Room center cache invalidation
    clear_room_center_cache();
    
    // 5. Rule-based connection system reset
    init_connection_system();
    
    // 6. Display and viewport state reset (if needed)
    // Note: these are handled separately in the public API
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

// =============================================================================
// MAP ANALYSIS AND UTILITY FUNCTIONS (NOT USED, FOR FUTURE INTEGRATION)
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
