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

// Seed value for random number generation
unsigned int rng_seed = 1;

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

// Static counter for additional randomness
static unsigned int generation_counter = 0;

// Room center cache for coordinate calculations
static unsigned char room_center_cache[MAX_ROOMS][2]; // [room_id][0=x, 1=y]
static unsigned char room_center_cache_valid = 0;

// Cache for room distance calculations
static unsigned char room_distance_cache[MAX_ROOMS][MAX_ROOMS];
static unsigned char distance_cache_valid = 0;