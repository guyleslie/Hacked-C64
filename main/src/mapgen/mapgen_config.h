#ifndef MAPGEN_CONFIG_H
#define MAPGEN_CONFIG_H

// Preset levels for different configuration parameters
typedef enum {
    LEVEL_SMALL = 0,
    LEVEL_MEDIUM = 1,
    LEVEL_LARGE = 2
} PresetLevel;

// Main configuration structure (user-facing settings)
typedef struct {
    // Map size preset (determines MAP_W and MAP_H values)
    PresetLevel map_size;

    // Room count preset
    PresetLevel room_count;

    // Room size preset
    PresetLevel room_size;

    // Secret rooms preset
    PresetLevel secret_rooms;

    // False corridors preset
    PresetLevel false_corridors;

    // Secret treasures preset
    PresetLevel secret_treasures;

    // Hidden corridors preset
    PresetLevel hidden_corridors;

    // Difficulty level (auto-calculated or manually set)
    unsigned char difficulty_level; // 0-10 scale
} MapConfig;

// Concrete parameter values (computed from config)
typedef struct {
    unsigned char map_width;
    unsigned char map_height;
    unsigned char max_rooms;
    unsigned char min_room_size;
    unsigned char max_room_size;
    unsigned char secret_room_count;
    unsigned char false_corridor_count;
    unsigned char treasure_count;
    unsigned char hidden_corridor_count;  // Hidden corridor count (non-branching corridors to hide)
} MapParameters;

// Initialize default configuration
void init_default_config(MapConfig *config);

// Validate and compute concrete parameters from configuration
void validate_and_adjust_config(MapConfig *config, MapParameters *params);

// Calculate difficulty level from configuration (0-10 scale)
unsigned char calculate_difficulty(const MapConfig *config);

// Show configuration menu and allow user to adjust settings
void show_config_menu(MapConfig *config);

// Helper function to print preset level name
void print_level_name(PresetLevel level);

#endif // MAPGEN_CONFIG_H
