#ifndef MAPGEN_CONFIG_H
#define MAPGEN_CONFIG_H

// =============================================================================
// Map Generator Configuration Module (SHARED - Both DEBUG and Production)
// =============================================================================
// This module contains shared configuration data structures and conversion
// logic used by both DEBUG and Production modes.
//
// DEBUG-only functions (menu, defaults, helpers) are in mapgen_debug.c/.h
// =============================================================================

// Preset levels for different configuration parameters
typedef enum {
    LEVEL_SMALL = 0,
    LEVEL_MEDIUM = 1,
    LEVEL_LARGE = 2
} PresetLevel;

// Main configuration structure (user-facing settings)
typedef struct {
    PresetLevel map_size;        // Map size (determines grid)
    PresetLevel hidden_rooms;    // Hidden room percentage
    PresetLevel niches;          // Wall niche percentage
    PresetLevel deception;       // Deception level (decoys + hidden passages)
} MapConfig;

// Concrete parameter values (computed from config)
typedef struct {
    unsigned char map_width;
    unsigned char map_height;
    unsigned char grid_size;
    unsigned char max_rooms;
    unsigned char min_room_size;
    unsigned char max_room_size;
    unsigned char hidden_room_count;
    unsigned char niche_count;
    unsigned char deception_count;
} MapParameters;

// =============================================================================
// SHARED API - Used by both DEBUG and Production modes
// =============================================================================

/**
 * @brief Validate and compute concrete parameters from configuration
 *
 * Converts user-facing MapConfig (preset levels) to concrete MapParameters
 * (actual values). Performs validation and adjustments to ensure valid
 * combinations (e.g., map size vs room count).
 *
 * @param config Input configuration (preset levels)
 * @param params Output parameters (concrete values)
 *
 * @note Used by both:
 *       - DEBUG mode: After interactive menu configuration
 *       - Production mode: From mapgen_generate_with_params() parameters
 */
void validate_and_adjust_config(MapConfig *config, MapParameters *params);

#endif // MAPGEN_CONFIG_H
