// ...existing code...
#include <c64/vic.h>
#include <c64/cia.h>
#include <stdio.h>
#include <conio.h>
#include <string.h>
#include <stdlib.h>
#include "../mapgen_types.h"      // For Room, MAP_W, MAP_H, MAX_ROOMS
#include "../mapgen_utility.h"    // For utility/math/cache functions
#include "../mapgen_internal.h"   // For internal helpers if needed


// =============================================================================
// DOOR PLACEMENT VALIDATION
// =============================================================================
// Checks if the given coordinate is a valid room wall tile for door placement
// Returns 1 if (x, y) is directly outside any room's wall (including corners), 0 otherwise
unsigned char is_valid_room_wall_for_door(unsigned char x, unsigned char y) {
    unsigned char i;
    for (i = 0; i < room_count; i++) {
        Room *room = &rooms[i];
        // Check left/right walls (including corners)
        if (y >= room->y && y <= room->y + room->h - 1) {
            if (x == room->x - 1 || x == room->x + room->w) {
                return 1;
            }
        }
        // Check top/bottom walls (including corners)
        if (x >= room->x && x <= room->x + room->w - 1) {
            if (y == room->y - 1 || y == room->y + room->h) {
                return 1;
            }
        }
    }
    return 0;
}
// Utility Functions Module for C64 Map Generator
// Contains bounds checking, tile access, RNG, and basic helper functions

// External global references
extern unsigned char compact_map[MAP_H * MAP_W * 3 / 8];
extern unsigned int rng_seed;
extern Room rooms[MAX_ROOMS];
extern unsigned char room_count;

// Static counter for additional randomness
static unsigned int generation_counter = 0;

// Room center cache - C64 optimized central cache for all modules
static unsigned char room_center_cache[MAX_ROOMS][2]; // [room_id][0=x, 1=y]
static unsigned char room_center_cache_valid = 0;

// Performance optimization: Inline calculations replace massive lookup tables
// C64 optimized: No memory waste, faster execution, no initialization needed

// Hardware entropy source for C64 with Oscar64
unsigned int get_hardware_entropy(void) {
    return cia1.ta ^ vic.raster;
}

// Enhanced RNG initialization with counter mixing
void init_rng(void) {
    unsigned int entropy1, entropy2, entropy3, entropy4;
    
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
    for (unsigned char i = 0; i < 4; i++) {
        rng_seed = (rng_seed << 3) ^ (rng_seed >> 13) ^ (i * 0x1F2E);
    }
    
    // Ensure non-zero seed
    if (rng_seed == 0) rng_seed = 0x1D21U + generation_counter;
    
    // Warm up the RNG by discarding first few values
    for (unsigned char i = 0; i < 8; i++) {
        rnd(255);
    }
}

// =============================================================================
// OPTIMIZED SCREEN OPERATIONS
// =============================================================================

// Ultra-fast hardware optimized screen clear for C64
// Clears entire screen memory ($0400-$07E7) using assembly loop
void oscar_clrscr(void) {
    __asm {
        lda #32     // Space character (PETSCII)
        
        // Clear first 256 bytes ($0400-$04FF)
        ldx #0
    loop1:
        sta $0400,x
        inx
        bne loop1
        
        // Clear second 256 bytes ($0500-$05FF)  
        ldx #0
    loop2:
        sta $0500,x
        inx
        bne loop2
          // Clear third 256 bytes ($0600-$06FF)
        ldx #0
    loop3:
        sta $0600,x
        inx
        bne loop3
        
        // Clear remaining bytes ($0700-$07E7) - 232 bytes
        ldx #0
    loop4:
        sta $0700,x
        inx
        cpx #232
        bne loop4
        
        // Reset cursor position to home (0,0)
        lda #0
        sta $d3      // Cursor column (PNTR)
        sta $d6      // Cursor row (TBLX)
        
        // Reset screen pointer to start of screen
        lda #$00
        sta $d1      // Screen line pointer low byte
        lda #$04
        sta $d2      // Screen line pointer high byte ($0400)
    }
}

// =============================================================================
// Fast RNG for 6502 - Enhanced for better distribution
// =============================================================================
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

// Optimized compact tile getter with direct bit manipulation
unsigned char get_compact_tile_fast(unsigned char x, unsigned char y) {
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
void set_compact_tile_fast(unsigned char x, unsigned char y, unsigned char tile) {
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

// Fast tile type checking functions using shared core
inline unsigned char tile_is_floor(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return 0;
    return get_tile_core(x, y) == TILE_FLOOR;
}

inline unsigned char tile_is_wall(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return 0;  // Fast bounds check
    return get_tile_core(x, y) == TILE_WALL;
}

inline unsigned char tile_is_door(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return 0;  // Fast bounds check
    return get_tile_core(x, y) == TILE_DOOR;
}

inline unsigned char tile_is_empty(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return 1;  // Out of bounds = empty
    return get_tile_core(x, y) == TILE_EMPTY;
}

// Fast tile access for generation (no PETSCII conversion)
// Optimized inline wrapper for most common use case - now uses shared core!
inline unsigned char get_tile_raw(unsigned char x, unsigned char y) {
    if (x >= MAP_W || y >= MAP_H) return TILE_EMPTY;  // Fast bounds check
    return get_tile_core(x, y);  // Use shared optimized core
}

inline void set_tile_raw(unsigned char x, unsigned char y, unsigned char tile) {
    set_compact_tile_fast(x, y, tile);  // Delegate to optimized setter
}

// Clear map to empty space
void clear_map(void) {
    unsigned int total_bytes = (MAP_H * MAP_W * 3 + 7) / 8; // Round up division
    unsigned int i;
    
    for (i = 0; i < total_bytes; i++) {
        compact_map[i] = 0; // All tiles set to TILE_EMPTY (0)
    }
}

// Optimized adjacency checker - uses bit flag system for improved efficiency
unsigned char check_tile_adjacency(unsigned char x, unsigned char y, unsigned char include_diagonals, unsigned char tile_types) {
    if (!coords_in_bounds(x, y)) return 0;
    
    // Convert old tile_types parameter to new bit flags
    unsigned char type_flags = 0;
    if (tile_types & CHECK_DOORS_ONLY) type_flags |= TILE_CHECK_DOOR;
    if (tile_types & CHECK_FLOORS_ONLY) type_flags |= TILE_CHECK_FLOOR;
    
    // Use the new optimized bit flag adjacency system
    return check_adjacent_tile_types(x, y, type_flags, include_diagonals);
}

// =============================================================================
// OPTIMIZED COMPUTATIONAL PATTERNS - C64 OSCAR64 OPTIMIZED
// =============================================================================

// Fast absolute difference calculation (Oscar64 optimized)
inline unsigned char fast_abs_diff(unsigned char a, unsigned char b) {
    return (a > b) ? a - b : b - a;
}

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

// Optimized Manhattan distance calculation between two points
inline unsigned char manhattan_distance(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2) {
    return fast_abs_diff(x1, x2) + fast_abs_diff(y1, y2);
}

// Fast room-to-room Manhattan distance using cached centers
unsigned char calculate_room_distance(unsigned char room1, unsigned char room2) {
    unsigned char x1, y1, x2, y2;
    get_room_center(room1, &x1, &y1);
    get_room_center(room2, &x2, &y2);
    return manhattan_distance(x1, y1, x2, y2);
}

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
// BOUNDS CHECKING AND MAP ACCESS
// =============================================================================

// =============================================================================
// ADVANCED COORDINATE AND DIRECTION UTILITIES - C64 OPTIMIZED
// =============================================================================

// Fast direction calculation between two points (0=E, 1=NE, 2=N, 3=NW, 4=W, 5=SW, 6=S, 7=SE)
unsigned char calculate_direction(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2) {
    unsigned char dx = fast_abs_diff(x1, x2);
    unsigned char dy = fast_abs_diff(y1, y2);
    
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

// Fast coordinate validation with single bounds check
inline unsigned char coords_in_bounds(unsigned char x, unsigned char y) {
    return (x < MAP_W && y < MAP_H && x != UNDERFLOW_CHECK_VALUE && y != UNDERFLOW_CHECK_VALUE);
}

// Optimized coordinate clamping to map boundaries
void clamp_to_bounds(unsigned char *x, unsigned char *y) {
    if (*x >= MAP_W) *x = MAP_W - 1;
    if (*y >= MAP_H) *y = MAP_H - 1;
    if (*x == UNDERFLOW_CHECK_VALUE) *x = 0; // Handle underflow
    if (*y == UNDERFLOW_CHECK_VALUE) *y = 0; // Handle underflow
}

// Fast room boundary checking
unsigned char point_in_room(unsigned char x, unsigned char y, unsigned char room_id) {
    return (x >= rooms[room_id].x && x < rooms[room_id].x + rooms[room_id].w &&
            y >= rooms[room_id].y && y < rooms[room_id].y + rooms[room_id].h);
}

// Optimized room overlap detection
unsigned char rooms_overlap(unsigned char room1, unsigned char room2) {
    return !(rooms[room1].x + rooms[room1].w <= rooms[room2].x ||
             rooms[room2].x + rooms[room2].w <= rooms[room1].x ||
             rooms[room1].y + rooms[room1].h <= rooms[room2].y ||
             rooms[room2].y + rooms[room2].h <= rooms[room1].y);
}

// =============================================================================
// OPTIMIZED LOOP CONSTRUCTS AND ITERATION PATTERNS
// =============================================================================

// Common double-loop pattern for room pairs (avoids redundant iterations)
void iterate_room_pairs(void (*callback)(unsigned char room1, unsigned char room2)) {
    unsigned char i, j;
    for (i = 0; i < room_count - 1; i++) {
        for (j = i + 1; j < room_count; j++) {
            callback(i, j);
        }
    }
}

// Optimized map area iteration with pre-clamped bounds (no redundant checking)
void iterate_map_area(unsigned char start_x, unsigned char start_y, unsigned char width, unsigned char height,
                     void (*callback)(unsigned char x, unsigned char y)) {
    unsigned char end_x = start_x + width;
    unsigned char end_y = start_y + height;
    unsigned char x, y;
    
    // Pre-clamp to map bounds once
    if (end_x > MAP_W) end_x = MAP_W;
    if (end_y > MAP_H) end_y = MAP_H;
    if (start_x >= MAP_W) return; // Early exit for invalid start
    if (start_y >= MAP_H) return; // Early exit for invalid start
    
    // No need for coords_in_bounds() check - bounds are already guaranteed
    for (y = start_y; y < end_y; y++) {
        for (x = start_x; x < end_x; x++) {
            callback(x, y);
        }
    }
}

// =============================================================================
// ADVANCED CACHE-FRIENDLY ITERATION PATTERNS
// =============================================================================

// Cache-friendly room validation pattern - processes rooms in memory order
void iterate_rooms_cache_friendly(void (*callback)(unsigned char room_id)) {
    unsigned char i;
    // Room array is already in memory order, simple sequential access
    for (i = 0; i < room_count; i++) {
        callback(i);
    }
}

// Memory-efficient tile scanning with stride pattern
void scan_map_with_stride(unsigned char stride, unsigned char offset,
                         void (*callback)(unsigned char x, unsigned char y)) {
    unsigned char x, y;
    
    // Process tiles with memory-friendly access pattern
    for (y = offset; y < MAP_H; y += stride) {
        for (x = 0; x < MAP_W; x++) {
            callback(x, y);
        }
    }
}

// Optimized rectangular area processing with bounds pre-check
void process_rect_area_optimized(unsigned char x1, unsigned char y1, 
                                unsigned char x2, unsigned char y2,
                                void (*callback)(unsigned char x, unsigned char y)) {
    // Ensure valid rectangle
    if (x1 > x2) { unsigned char temp = x1; x1 = x2; x2 = temp; }
    if (y1 > y2) { unsigned char temp = y1; y1 = y2; y2 = temp; }
    
    // Clamp to map bounds once
    if (x1 >= MAP_W || y1 >= MAP_H) return;
    if (x2 >= MAP_W) x2 = MAP_W - 1;
    if (y2 >= MAP_H) y2 = MAP_H - 1;
    
    unsigned char x, y;
    // No bounds checking needed inside loop
    for (y = y1; y <= y2; y++) {
        for (x = x1; x <= x2; x++) {
            callback(x, y);
        }
    }
}

// =============================================================================
// OPTIMIZED TILE VALIDATION PATTERNS - C64 ULTRA-FAST VERSION
// =============================================================================

// Lookup table for tile type matching (1 bit per tile type) - OPTIMIZED
// Moved to static const for better compiler optimization
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

// Ultra-fast tile type checking using lookup table - primary function
// Optimized: Reduced function call overhead with inline + uses shared core
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

// Memory-efficient text output function (uses assembly code for direct KERNAL calls)
void print_text(const char* text) {
    unsigned char i = 0;
    while (text[i] != '\0') {
        if (text[i] == '\n') {
            // Handle newline properly on C64 using direct KERNAL call
            __asm {
                lda #13    // CR character
                jsr $ffd2  // CHROUT KERNAL routine
            }
        } else {
            // Output regular character using direct KERNAL call
            __asm {
                ldy i      // Load index into Y register
                lda (text),y // Load character from text[i]
                jsr $ffd2  // CHROUT KERNAL routine
            }
        }
        i++;
    }
}

// =============================================================================
// CENTRAL RESET SYSTEM
// =============================================================================

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
    init_rule_based_connection_system();
    
    // 6. Display and viewport state reset (if needed)
    // Note: these are handled separately in the public API
}
