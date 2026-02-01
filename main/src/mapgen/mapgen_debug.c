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

// Display strings for different setting types
static const char *size_names[3] = {
    "small ",
    "medium",
    "large "
};

static const char *percent_names[3] = {
    "10%   ",
    "25%   ",
    "50%   "
};

// Menu line to screen row mapping (5 items: 4 settings + seed)
static const unsigned char menu_rows[5] = {5, 7, 9, 11, 13};

// Setting type for each menu item (0=size, 1=percent)
static const unsigned char setting_types[4] = {0, 1, 1, 1};

// Current seed value (0 = random)
static unsigned int menu_seed = 0;

// =============================================================================
// DEBUG-ONLY CONFIGURATION FUNCTIONS
// =============================================================================

/**
 * @brief Initialize default configuration (medium settings)
 */
void init_default_config(MapConfig *config) {
    config->map_size = LEVEL_MEDIUM;
    config->hidden_rooms = LEVEL_MEDIUM;
    config->niches = LEVEL_MEDIUM;
    config->deception = LEVEL_MEDIUM;
}

/**
 * @brief Print seed value at specified position (5 digits, right-aligned)
 */
static void print_seed_value(unsigned char row, unsigned int seed) {
    unsigned int offset = row * 40 + 28;
    unsigned int temp = seed;
    unsigned char digits[5];
    unsigned char i;

    // Convert to digits (right to left)
    for (i = 0; i < 5; i++) {
        digits[4 - i] = '0' + (temp % 10);
        temp /= 10;
    }

    // Print digits
    for (i = 0; i < 5; i++) {
        SCREEN_RAM[offset + i] = digits[i];
    }

    // Add space padding
    SCREEN_RAM[offset + 5] = ' ';
}

/**
 * @brief Input seed value from keyboard (numeric only, max 5 digits)
 * @return Entered seed value (0-65535)
 */
static unsigned int input_seed_value(void) {
    unsigned int offset = 13 * 40 + 28;
    unsigned char input_buf[6];  // 5 digits + null
    unsigned char pos = 0;
    unsigned char key;
    unsigned long value;
    unsigned char i;
    unsigned char joy2;

    // Wait for FIRE release first
    while (!(cia1.pra & 0x10)) {}

    // Clear input area and show cursor
    for (i = 0; i < 6; i++) {
        SCREEN_RAM[offset + i] = ' ';
    }
    SCREEN_RAM[offset] = '_';  // Cursor

    while (1) {
        // Check FIRE button to finish input
        joy2 = cia1.pra;
        if (!(joy2 & 0x10)) {
            // Wait for release to prevent immediate re-trigger
            while (!(cia1.pra & 0x10)) {}
            break;
        }

        key = getchx();

        // Check for RETURN (13) - finish input
        if (key == 13) {
            break;
        }

        // Check for backspace/delete (20 on C64)
        if (key == 20 && pos > 0) {
            pos--;
            SCREEN_RAM[offset + pos] = '_';
            SCREEN_RAM[offset + pos + 1] = ' ';
            continue;
        }

        // Check for numeric input (0-9)
        if (key >= '0' && key <= '9' && pos < 5) {
            input_buf[pos] = key;
            SCREEN_RAM[offset + pos] = key;
            pos++;
            if (pos < 5) {
                SCREEN_RAM[offset + pos] = '_';  // Move cursor
            }
        }
    }

    // Convert string to number
    input_buf[pos] = 0;
    value = 0;
    for (i = 0; i < pos; i++) {
        value = value * 10 + (input_buf[i] - '0');
    }

    // Clamp to 16-bit max
    if (value > 65535) {
        value = 65535;
    }

    return (unsigned int)value;
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
 * @brief Update value at specific menu position using correct display type
 * @param menu_item Menu item index (0-4, determines display type)
 * @param value Preset level value (0-2)
 */
static void update_value(unsigned char menu_item, PresetLevel value) {
    unsigned char row = menu_rows[menu_item];
    unsigned int offset = row * 40 + 28;
    const char *name;
    unsigned char i;

    // Select display string based on setting type
    if (setting_types[menu_item] == 0) {
        name = size_names[value];
    } else {
        name = percent_names[value];
    }

    for (i = 0; i < 6; i++) {
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
    print_at(7, 5, "map size");
    print_at(7, 7, "hidden rooms");
    print_at(7, 9, "niches");
    print_at(7, 11, "deception");
    print_at(7, 13, "seed");

    // Initial values - use menu item index (0-3) for correct display type
    update_value(0, config->map_size);
    update_value(1, config->hidden_rooms);
    update_value(2, config->niches);
    update_value(3, config->deception);

    // Seed value (0 = random)
    print_seed_value(13, menu_seed);

    // Instructions - centered
    print_at(10, 21, "joy2: navigation");
    print_at(8, 23, "fire: start  seed 0=rnd");

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
            // Navigation - DOWN (5 menu items: 0-4)
            else if (!(joy2 & 0x02) && cursor < 4) {
                cursor++;
                update_cursor(old_cursor, cursor);
            }
            // FIRE button - start generation or seed input
            else if (!(joy2 & 0x10)) {
                if (cursor == 4) {
                    // Seed selected - enter numeric input mode
                    menu_seed = input_seed_value();
                    print_seed_value(13, menu_seed);
                } else {
                    // Start generation
                    done = 1;
                }
            }

            // Value adjustment - RIGHT (increase)
            if (!(joy2 & 0x08)) {
                switch (cursor) {
                    case 0:
                        if (config->map_size < LEVEL_LARGE) {
                            config->map_size++;
                            update_value(0, config->map_size);
                        }
                        break;
                    case 1:
                        if (config->hidden_rooms < LEVEL_LARGE) {
                            config->hidden_rooms++;
                            update_value(1, config->hidden_rooms);
                        }
                        break;
                    case 2:
                        if (config->niches < LEVEL_LARGE) {
                            config->niches++;
                            update_value(2, config->niches);
                        }
                        break;
                    case 3:
                        if (config->deception < LEVEL_LARGE) {
                            config->deception++;
                            update_value(3, config->deception);
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
                            update_value(0, config->map_size);
                        }
                        break;
                    case 1:
                        if (config->hidden_rooms > LEVEL_SMALL) {
                            config->hidden_rooms--;
                            update_value(1, config->hidden_rooms);
                        }
                        break;
                    case 2:
                        if (config->niches > LEVEL_SMALL) {
                            config->niches--;
                            update_value(2, config->niches);
                        }
                        break;
                    case 3:
                        if (config->deception > LEVEL_SMALL) {
                            config->deception--;
                            update_value(3, config->deception);
                        }
                        break;
                }
            }

            prev_joy2 = joy2;
        }
    }
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

    // Apply seed setting (0 = random, >0 = specific seed)
    if (menu_seed > 0) {
        mapgen_init(menu_seed);
    } else {
        mapgen_reset_seed_flag();
    }

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
        } else if (key == 'L' || key == 'l') {
            if (load_map_seed("mapbin", &config)) {
                // Load successful - regenerate with loaded settings
                validate_and_adjust_config(&config, &params);
                mapgen_set_parameters(&params);
                clrscr();
                mapgen_generate_dungeon();
            }
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
            // Apply seed setting
            if (menu_seed > 0) {
                mapgen_init(menu_seed);
            } else {
                mapgen_reset_seed_flag();
            }
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
