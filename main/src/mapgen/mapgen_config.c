// =============================================================================
// Map Generator Configuration Module (SHARED - Both DEBUG and Production)
// =============================================================================
// This module contains shared configuration data structures and conversion
// logic used by both DEBUG and Production modes.
//
// DEBUG-only functions (menu, defaults, helpers) are in mapgen_debug.c
// =============================================================================

#include "mapgen_config.h"

// =============================================================================
// PRESET TABLES - Used for configuration conversion
// =============================================================================

// Map size table (width, height) - optimized for consistent 14×14 grid cells
const unsigned char map_size_table[3][2] = {
    {50, 50},  // SMALL: 3×14+8=50
    {64, 64},  // MEDIUM: 4×14+8=64
    {78, 78}   // LARGE: 5×14+8=78
};

// Grid size table - determines max rooms per map size
// SMALL: 3×3=9, MEDIUM: 4×4=16, LARGE: 5×5=25 (clamped to MAX_ROOMS=20)
const unsigned char grid_size_table[3] = {
    3,   // SMALL: 3×3 = 9 rooms
    4,   // MEDIUM: 4×4 = 16 rooms
    5    // LARGE: 5×5 = 20 rooms (clamped)
};

// Feature ratios (percentage-based)
const unsigned char hidden_room_ratio[3] = { 10, 25, 50 };
const unsigned char niche_ratio[3] = { 10, 25, 50 };
const unsigned char deception_ratio[3] = { 10, 25, 50 };

// =============================================================================
// CONFIGURATION CONVERSION - Used by both DEBUG and Production modes
// =============================================================================

/**
 * @brief Validate config and compute concrete parameters
 *
 * Converts MapConfig (preset levels) to MapParameters.
 * Map geometry is set here. Feature counts are calculated post-MST
 * in calculate_post_mst_feature_counts() based on actual dungeon topology.
 */
void validate_and_adjust_config(MapConfig *config, MapParameters *params) {
    // Map dimensions from preset
    params->map_width = map_size_table[config->map_size][0];
    params->map_height = map_size_table[config->map_size][1];

    // Grid size determines max rooms (3×3=9, 4×4=16, 5×5=20 clamped to MAX_ROOMS)
    params->grid_size = grid_size_table[config->map_size];
    params->max_rooms = params->grid_size * params->grid_size;
    if (params->max_rooms > MAX_ROOMS) {
        params->max_rooms = MAX_ROOMS;
    }

    // Room size bounds (fixed 4-8)
    params->min_room_size = 4;
    params->max_room_size = 8;

    // Hidden room count - can be calculated upfront from max_rooms
    params->hidden_room_count = (params->max_rooms * hidden_room_ratio[config->hidden_rooms]) / 100;
    if (params->hidden_room_count == 0 && config->hidden_rooms > LEVEL_SMALL) {
        params->hidden_room_count = 1;
    }

    // Store preset ratios - actual counts calculated post-MST
    params->niche_count = niche_ratio[config->niches];
    params->deception_count = deception_ratio[config->deception];
}
