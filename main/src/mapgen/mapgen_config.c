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

// Map size table (width, height)
const unsigned char map_size_table[3][2] = {
    {48, 48},  // SMALL
    {64, 64},  // MEDIUM
    {80, 80}   // LARGE
};

// Room count table (limited by 4x4 grid = 16 positions)
const unsigned char room_count_table[3] = {
    8,   // SMALL
    12,  // MEDIUM
    16   // LARGE (maximum with 4x4 grid)
};

// Room size table (min, max) - balanced for grid system
const unsigned char room_size_table[3][2] = {
    {3, 5},   // SMALL
    {4, 7},   // MEDIUM (current default)
    {5, 8}    // LARGE (reduced from 10 to fit better in grid)
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
    unsigned char total_room_area, map_area;

    // Map size setup
    params->map_width = map_size_table[config->map_size][0];
    params->map_height = map_size_table[config->map_size][1];

    // Room count setup
    params->max_rooms = room_count_table[config->room_count];

    // Room size setup - fixed 4-8 (not configurable)
    params->min_room_size = 4;
    params->max_room_size = 8;

    // Secret room count (based on max rooms percentage)
    params->secret_room_count = (params->max_rooms * secret_room_ratio[config->secret_rooms]) / 100;

    // Validation: map size vs room count
    // Total maximum room area (worst case: all rooms at max size)
    total_room_area = params->max_rooms * params->max_room_size * params->max_room_size;
    map_area = params->map_width * params->map_height;

    // If too many rooms for map size, reduce room count
    if (total_room_area > map_area / 2) {
        // Reduce room count to fit in 40% of map
        params->max_rooms = (map_area / 2) / (params->max_room_size * params->max_room_size);

        // Recalculate secret room count based on adjusted max rooms
        params->secret_room_count = (params->max_rooms * secret_room_ratio[config->secret_rooms]) / 100;
    }

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
