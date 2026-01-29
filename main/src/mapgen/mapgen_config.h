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
    // Map size preset (determines MAP_W, MAP_H, and grid size)
    PresetLevel map_size;

    // Secret rooms preset
    PresetLevel secret_rooms;

    // False corridors preset
    PresetLevel false_corridors;

    // Secret treasures preset
    PresetLevel secret_treasures;

    // Hidden corridors preset
    PresetLevel hidden_corridors;
} MapConfig;

// Concrete parameter values (computed from config)
typedef struct {
    unsigned char map_width;
    unsigned char map_height;
    unsigned char grid_size;
    unsigned char max_rooms;
    unsigned char min_room_size;
    unsigned char max_room_size;
    unsigned char secret_room_count;
    unsigned char false_corridor_count;
    unsigned char treasure_count;
    unsigned char hidden_corridor_count;  // Hidden corridor count (non-branching corridors to hide)
    unsigned char preset;  // Feature preset level (for percentage ratio lookups)
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
