#include <c64/vic.h>
#include <c64/cia.h>
#include <conio.h>
#include <string.h>
#include "mapgen_config.h"

// Preset tables for configuration

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
    20,  // MEDIUM (20%)
    30   // LARGE (30%)
};

// False corridor count table
const unsigned char false_corridor_table[3] = {
    3,   // SMALL
    5,   // MEDIUM (current default)
    8    // LARGE
};

// Secret treasure count table
const unsigned char treasure_table[3] = {
    2,   // SMALL
    4,   // MEDIUM
    6    // LARGE
};

// Level name strings (compact storage, lowercase for mixed charset)
const char *level_names[3] = {
    "small ",
    "medium",
    "large "
};

// Initialize default configuration (medium settings)
void init_default_config(MapConfig *config) {
    config->map_size = LEVEL_MEDIUM;
    config->room_count = LEVEL_MEDIUM;
    config->room_size = LEVEL_MEDIUM;
    config->secret_rooms = LEVEL_MEDIUM;
    config->false_corridors = LEVEL_MEDIUM;
    config->secret_treasures = LEVEL_MEDIUM;
    config->difficulty_level = 5; // Medium difficulty
}

// Validate and compute concrete parameters from configuration
void validate_and_adjust_config(MapConfig *config, MapParameters *params) {
    unsigned char total_room_area, map_area, max_treasure_rooms;

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

    // False corridor count
    params->false_corridor_count = false_corridor_table[config->false_corridors];

    // Secret treasure count
    params->treasure_count = treasure_table[config->secret_treasures];

    // Secret treasure validation: can't be more than non-secret rooms
    max_treasure_rooms = params->max_rooms - params->secret_room_count;
    if (params->treasure_count > max_treasure_rooms) {
        params->treasure_count = max_treasure_rooms;
    }

    // Ensure at least 1 of each if not zero preset
    if (params->secret_room_count == 0 && config->secret_rooms > LEVEL_SMALL) {
        params->secret_room_count = 1;
    }
    if (params->treasure_count == 0 && config->secret_treasures > LEVEL_SMALL) {
        params->treasure_count = 1;
    }
}

// Calculate difficulty level from configuration (0-10 scale)
unsigned char calculate_difficulty(const MapConfig *config) {
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

    // Normalize to 0-10 scale
    if (difficulty < 0) difficulty = 0;
    if (difficulty > 10) difficulty = 10;

    return (unsigned char)difficulty;
}

// Screen memory address
#define SCREEN_RAM ((unsigned char*)0x0400)

// Print level name at current cursor position
void print_level_name(PresetLevel level) {
    unsigned char i;
    const char *name = level_names[level];

    for (i = 0; i < 6; i++) {
        SCREEN_RAM[i] = name[i];
    }
}

// Helper: Print string at position
static void print_at(unsigned char x, unsigned char y, const char *text) {
    unsigned char i = 0;
    unsigned int offset = y * 40 + x;

    while (text[i] != 0) {
        SCREEN_RAM[offset] = text[i];
        i++;
        offset++;
    }
}

// Helper: Clear screen
static void clear_screen(void) {
    unsigned int i;
    for (i = 0; i < 1000; i++) {
        SCREEN_RAM[i] = ' ';
    }
}

// PETSCII key codes are defined in conio.h:
// PETSCII_CURSOR_UP = 0x91 (145)
// PETSCII_CURSOR_DOWN = 0x11 (17)
// PETSCII_CURSOR_LEFT = 0x9d (157)
// PETSCII_CURSOR_RIGHT = 0x1d (29)
// PETSCII_RETURN = 0x0d (13)

// Menu line to screen row mapping (no room size, no start generation)
const unsigned char menu_rows[5] = {5, 7, 9, 11, 13};

// Helper: Update cursor position only
static void update_cursor(unsigned char old_cursor, unsigned char new_cursor) {
    unsigned int old_offset = menu_rows[old_cursor] * 40 + 6;
    unsigned int new_offset = menu_rows[new_cursor] * 40 + 6;

    // Clear old cursor
    SCREEN_RAM[old_offset] = ' ';

    // Draw new cursor
    SCREEN_RAM[new_offset] = '>';
}

// Helper: Update value at specific menu position
static void update_value(unsigned char row, PresetLevel value) {
    unsigned int offset = row * 40 + 28;
    const char *name = level_names[value];

    for (unsigned char i = 0; i < 6; i++) {
        SCREEN_RAM[offset + i] = name[i];
    }
}

// Show configuration menu and allow user to adjust settings
void show_config_menu(MapConfig *config) {
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

    // Initial values - positioned after labels (column 26)
    update_value(5, config->map_size);
    update_value(7, config->room_count);
    update_value(9, config->secret_rooms);
    update_value(11, config->false_corridors);
    update_value(13, config->secret_treasures);

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
            else if (!(joy2 & 0x02) && cursor < 4) {
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
                }
            }

            prev_joy2 = joy2;
        }
    }

    // Calculate difficulty before exiting
    config->difficulty_level = calculate_difficulty(config);
}
