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

// Secret room ratio (percentage of max rooms)
const unsigned char secret_room_ratio[3] = {
    10,  // SMALL (10%)
    25,  // MEDIUM (25%)
    50   // LARGE (50%)
};

// False corridor ratio (percentage of available walls)
const unsigned char false_corridor_ratio[3] = {
    10,  // SMALL (10%)
    25,  // MEDIUM (25%)
    50   // LARGE (50%)
};

// Secret treasure ratio (percentage of non-secret rooms)
const unsigned char treasure_ratio[3] = {
    10,  // SMALL (10%)
    25,  // MEDIUM (25%)
    50   // LARGE (50%)
};

// Hidden corridor ratio (percentage of non-branching corridors)
const unsigned char hidden_corridor_ratio[3] = {
    10,  // SMALL (10%)
    25,  // MEDIUM (25%)
    50   // LARGE (50%)
};

// =============================================================================
// CONFIGURATION CONVERSION - Used by both DEBUG and Production modes
// =============================================================================

/**
 * @brief Validate and compute concrete parameters from configuration
 *
 * Converts user-facing MapConfig (preset levels) to concrete MapParameters
 * (actual values). Performs validation and adjustments to ensure valid
 * combinations (e.g., map size vs room count).
 *
 * Used by:
 * - DEBUG mode: After interactive menu configuration
 * - Production mode: From mapgen_generate_with_params() parameters
 */
void validate_and_adjust_config(MapConfig *config, MapParameters *params) {
    // Map size setup
    params->map_width = map_size_table[config->map_size][0];
    params->map_height = map_size_table[config->map_size][1];

    // Grid size and max rooms - automatic from map size
    params->grid_size = grid_size_table[config->map_size];
    params->max_rooms = params->grid_size * params->grid_size;

    // Clamp to MAX_ROOMS (20)
    if (params->max_rooms > MAX_ROOMS) {
        params->max_rooms = MAX_ROOMS;
    }

    // Room size - fixed 4-8
    params->min_room_size = 4;
    params->max_room_size = 8;

    // Secret room count (based on max rooms percentage)
    params->secret_room_count = (params->max_rooms * secret_room_ratio[config->secret_rooms]) / 100;

    // Percentage-based feature configuration (actual counts calculated post-MST)
    // Store preset for post-MST percentage calculation
    params->preset = config->secret_treasures; // Use secret_treasures preset as primary

    // These are placeholder values - will be recalculated in calculate_post_mst_feature_counts()
    params->false_corridor_count = false_corridor_ratio[config->false_corridors];
    params->treasure_count = treasure_ratio[config->secret_treasures];
    params->hidden_corridor_count = hidden_corridor_ratio[config->hidden_corridors];

    // Ensure at least 1 of each if not zero preset
    if (params->secret_room_count == 0 && config->secret_rooms > LEVEL_SMALL) {
        params->secret_room_count = 1;
    }
    if (params->treasure_count == 0 && config->secret_treasures > LEVEL_SMALL) {
        params->treasure_count = 1;
    }
}
