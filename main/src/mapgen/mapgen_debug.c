// =============================================================================
// Map Generator DEBUG Mode Implementation
// =============================================================================
// This module implements the interactive DEBUG mode for testing and debugging
// the map generation system. Includes configuration menu, navigation, and all
// DEBUG-only helper functions.
//
// Only compiled when DEBUG_MAPGEN is defined.
// =============================================================================

#ifdef DEBUG_MAPGEN

#include <conio.h>
#include <c64/cia.h>
#include <c64/vic.h>
#include "mapgen_api.h"
#include "mapgen_config.h"
#include "mapgen_display.h"
#include "map_export.h"

// =============================================================================
// DEBUG-ONLY DATA
// =============================================================================

// Screen memory address
#define SCREEN_RAM ((unsigned char*)0x0400)

// Level name strings (compact storage, lowercase for mixed charset)
static const char *level_names[3] = {
    "small ",
    "medium",
    "large "
};

// Menu line to screen row mapping
static const unsigned char menu_rows[6] = {5, 7, 9, 11, 13, 15};

// =============================================================================
// DEBUG-ONLY CONFIGURATION FUNCTIONS
// =============================================================================

/**
 * @brief Initialize default configuration (medium settings)
 */
void init_default_config(MapConfig *config) {
    config->map_size = LEVEL_MEDIUM;
    config->room_count = LEVEL_MEDIUM;
    config->room_size = LEVEL_MEDIUM;
    config->secret_rooms = LEVEL_MEDIUM;
    config->false_corridors = LEVEL_MEDIUM;
    config->secret_treasures = LEVEL_MEDIUM;
    config->hidden_corridors = LEVEL_MEDIUM;
    config->difficulty_level = 5; // Medium difficulty
}

/**
 * @brief Calculate difficulty level from configuration (0-10 scale)
 */
static unsigned char calculate_difficulty(const MapConfig *config) {
    signed char difficulty = 0;

    // Larger map increases difficulty (harder to navigate)
    difficulty += config->map_size * 1;

    // More rooms = easier navigation (more landmarks)
    difficulty -= config->room_count * 1;

    // Larger rooms = easier (more space)
    difficulty -= config->room_size * 1;

    // Hidden elements increase difficulty
    difficulty += config->secret_rooms * 2;
    difficulty += config->false_corridors * 1;
    difficulty += config->secret_treasures * 1;
    difficulty += config->hidden_corridors * 2;  // Hidden corridors significantly increase difficulty

    // Normalize to 0-10 scale
    if (difficulty < 0) difficulty = 0;
    if (difficulty > 10) difficulty = 10;

    return (unsigned char)difficulty;
}

/**
 * @brief Print level name at current cursor position
 */
static void print_level_name(PresetLevel level) {
    unsigned char i;
    const char *name = level_names[level];

    for (i = 0; i < 6; i++) {
        SCREEN_RAM[i] = name[i];
    }
}

// =============================================================================
// DEBUG-ONLY MENU HELPER FUNCTIONS
// =============================================================================

/**
 * @brief Print string at position
 */
static void print_at(unsigned char x, unsigned char y, const char *text) {
    unsigned char i = 0;
    unsigned int offset = y * 40 + x;

    while (text[i] != 0) {
        SCREEN_RAM[offset] = text[i];
        i++;
        offset++;
    }
}

/**
 * @brief Clear screen
 */
static void clear_screen(void) {
    unsigned int i;
    for (i = 0; i < 1000; i++) {
        SCREEN_RAM[i] = ' ';
    }
}

/**
 * @brief Update cursor position only
 */
static void update_cursor(unsigned char old_cursor, unsigned char new_cursor) {
    unsigned int old_offset = menu_rows[old_cursor] * 40 + 6;
    unsigned int new_offset = menu_rows[new_cursor] * 40 + 6;

    // Clear old cursor
    SCREEN_RAM[old_offset] = ' ';

    // Draw new cursor
    SCREEN_RAM[new_offset] = '>';
}

/**
 * @brief Update value at specific menu position
 */
static void update_value(unsigned char row, PresetLevel value) {
    unsigned int offset = row * 40 + 28;
    const char *name = level_names[value];

    for (unsigned char i = 0; i < 6; i++) {
        SCREEN_RAM[offset + i] = name[i];
    }
}

// =============================================================================
// DEBUG-ONLY CONFIGURATION MENU
// =============================================================================

/**
 * @brief Show configuration menu and allow user to adjust settings
 */
static void show_config_menu(MapConfig *config) {
    unsigned char cursor = 0;
    unsigned char done = 0;
    unsigned char old_cursor;
    unsigned char joy2, prev_joy2 = 0xFF;

    // Initial screen setup - draw once
    clear_screen();

    // Title - centered (lowercase for normal display in mixed charset)
    print_at(12, 2, "map configuration");
    print_at(10, 3, "--------------------");

    // Menu items - centered layout
    // Cursor(1) + Space(1) + Label(~17) + Space(2) + Value(6) = ~27 chars
    // Start at column (40-27)/2 = 6-7
    print_at(7, 5, "map size");
    print_at(7, 7, "room count");
    print_at(7, 9, "secret rooms");
    print_at(7, 11, "false corridors");
    print_at(7, 13, "secret treasures");
    print_at(7, 15, "hidden corridors");

    // Initial values - positioned after labels (column 26)
    update_value(5, config->map_size);
    update_value(7, config->room_count);
    update_value(9, config->secret_rooms);
    update_value(11, config->false_corridors);
    update_value(13, config->secret_treasures);
    update_value(15, config->hidden_corridors);

    // Instructions - centered
    print_at(12, 21, "joy2: navigation");
    print_at(15, 23, "fire: start");

    // Initial cursor (first menu item at row 5, column 6)
    SCREEN_RAM[5 * 40 + 6] = '>';

    while (!done) {
        // Read joystick 2 from CIA1 Port A
        joy2 = cia1.pra;

        old_cursor = cursor;

        // Detect joystick state changes (debounce)
        if (joy2 != prev_joy2) {
            // Navigation - UP
            if (!(joy2 & 0x01) && cursor > 0) {
                cursor--;
                update_cursor(old_cursor, cursor);
            }
            // Navigation - DOWN
            else if (!(joy2 & 0x02) && cursor < 5) {
                cursor++;
                update_cursor(old_cursor, cursor);
            }
            // FIRE button - start generation
            else if (!(joy2 & 0x10)) {
                done = 1;
            }

            // Value adjustment - RIGHT (increase)
            if (!(joy2 & 0x08)) {
                switch (cursor) {
                    case 0:
                        if (config->map_size < LEVEL_LARGE) {
                            config->map_size++;
                            update_value(5, config->map_size);
                        }
                        break;
                    case 1:
                        if (config->room_count < LEVEL_LARGE) {
                            config->room_count++;
                            update_value(7, config->room_count);
                        }
                        break;
                    case 2:
                        if (config->secret_rooms < LEVEL_LARGE) {
                            config->secret_rooms++;
                            update_value(9, config->secret_rooms);
                        }
                        break;
                    case 3:
                        if (config->false_corridors < LEVEL_LARGE) {
                            config->false_corridors++;
                            update_value(11, config->false_corridors);
                        }
                        break;
                    case 4:
                        if (config->secret_treasures < LEVEL_LARGE) {
                            config->secret_treasures++;
                            update_value(13, config->secret_treasures);
                        }
                        break;
                    case 5:
                        if (config->hidden_corridors < LEVEL_LARGE) {
                            config->hidden_corridors++;
                            update_value(15, config->hidden_corridors);
                        }
                        break;
                }
            }
            // Value adjustment - LEFT (decrease)
            else if (!(joy2 & 0x04)) {
                switch (cursor) {
                    case 0:
                        if (config->map_size > LEVEL_SMALL) {
                            config->map_size--;
                            update_value(5, config->map_size);
                        }
                        break;
                    case 1:
                        if (config->room_count > LEVEL_SMALL) {
                            config->room_count--;
                            update_value(7, config->room_count);
                        }
                        break;
                    case 2:
                        if (config->secret_rooms > LEVEL_SMALL) {
                            config->secret_rooms--;
                            update_value(9, config->secret_rooms);
                        }
                        break;
                    case 3:
                        if (config->false_corridors > LEVEL_SMALL) {
                            config->false_corridors--;
                            update_value(11, config->false_corridors);
                        }
                        break;
                    case 4:
                        if (config->secret_treasures > LEVEL_SMALL) {
                            config->secret_treasures--;
                            update_value(13, config->secret_treasures);
                        }
                        break;
                    case 5:
                        if (config->hidden_corridors > LEVEL_SMALL) {
                            config->hidden_corridors--;
                            update_value(15, config->hidden_corridors);
                        }
                        break;
                }
            }

            prev_joy2 = joy2;
        }
    }

    // Calculate difficulty before exiting
    config->difficulty_level = calculate_difficulty(config);
}

// =============================================================================
// DEBUG MODE MAIN LOOP
// =============================================================================

/**
 * @brief Run interactive DEBUG mode with menu, generation, and navigation
 *
 * Provides complete interactive experience:
 * - Configuration menu with joystick controls
 * - Initial map generation with progress bar
 * - Interactive viewport navigation
 * - Real-time map regeneration
 * - Map export functionality
 */
void mapgen_run_debug_mode(void) {
    unsigned char key;
    MapConfig config;
    MapParameters params;

    // Initialize default configuration
    init_default_config(&config);

    // Show configuration menu
    show_config_menu(&config);

    // Validate and compute parameters
    validate_and_adjust_config(&config, &params);

    // Set generation parameters
    mapgen_set_parameters(&params);

    // Clear screen before generation
    clrscr();

    // Generate complete level (includes all necessary resets)
    mapgen_generate_dungeon();

    // Interactive loop using joystick 2
    while (1) {
        // Check for keyboard commands
        key = getchx();
        if (key == 'Q' || key == 'q') {
            clrscr();
            break;
        } else if (key == 'M' || key == 'm') {
            save_map_seed("mapbin");
        }

        // Read joystick 2 from CIA1 Port A ($DC00)
        unsigned char joy2 = cia1.pra;

        // Joystick 2 bit mapping (active low):
        // Bit 0 = UP
        // Bit 1 = DOWN
        // Bit 2 = LEFT
        // Bit 3 = RIGHT
        // Bit 4 = FIRE

        // Check FIRE button for configuration menu
        if (!(joy2 & 0x10)) {
            clrscr();
            show_config_menu(&config);
            validate_and_adjust_config(&config, &params);
            mapgen_set_parameters(&params);
            clrscr();
            mapgen_generate_dungeon();
            // Wait for fire release
            while (!(cia1.pra & 0x10)) {}
        }

        // Check joystick directions (supports diagonal)
        if (!(joy2 & 0x01)) {  // UP
            move_camera_direction(MOVE_UP);
        }
        if (!(joy2 & 0x02)) {  // DOWN
            move_camera_direction(MOVE_DOWN);
        }
        if (!(joy2 & 0x04)) {  // LEFT
            move_camera_direction(MOVE_LEFT);
        }
        if (!(joy2 & 0x08)) {  // RIGHT
            move_camera_direction(MOVE_RIGHT);
        }
    }
}

#endif // DEBUG_MAPGEN
