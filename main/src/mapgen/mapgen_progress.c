// =============================================================================
// Map Generator Progress Bar Module Implementation
// =============================================================================
// DEBUG-only progress bar and phase display system for map generation.
// Extracted from mapgen_utils.c for cleaner DEBUG/RELEASE separation.
//
// Only compiled when DEBUG_MAPGEN is defined.
// =============================================================================

#ifdef DEBUG_MAPGEN

#include <conio.h>
#include <stdio.h>
#include "mapgen_types.h"
#include "mapgen_config.h"
#include "mapgen_utils.h"
#include "mapgen_progress.h"

// External reference to generation parameters
extern MapParameters current_params;

// =============================================================================
// SCREEN CONSTANTS
// =============================================================================

// Progress bar PETSCII characters (quarter-block increments)
static const unsigned char PROGRESS_EMPTY = 0x20;
static const unsigned char PROGRESS_QUARTER = 0x65;
static const unsigned char PROGRESS_HALF = 0x61;
static const unsigned char PROGRESS_THREE_Q = 0xE7;
static const unsigned char PROGRESS_FULL = 0xA0;

// Progress bar position and state
static const unsigned char progress_x = 9;
static const unsigned char progress_y = 12;
static unsigned char progress_steps = 0;

// Phase boundary calculation (8 phases)
static unsigned char phase_boundaries[8];
static unsigned char phase_total_weight = 0;

static void render_progress_bar(void) {
    unsigned char pos = progress_steps >> 2;
    unsigned char phase_char = progress_steps & 3;
    volatile unsigned char * const screen_mem = (volatile unsigned char *)SCREEN_MEMORY_BASE;
    unsigned short base_pos = progress_y * 40 + (progress_x + 1);

    // Each cell has exactly five visible states:
    // empty, quarter, half, three-quarter, and full.
    for (unsigned char i = 0; i < 20; i++) {
        unsigned char progress_char_val = PROGRESS_EMPTY;

        if (i < pos) {
            progress_char_val = PROGRESS_FULL;
        } else if (i == pos) {
            if (phase_char == 1) progress_char_val = PROGRESS_QUARTER;
            else if (phase_char == 2) progress_char_val = PROGRESS_HALF;
            else if (phase_char == 3) progress_char_val = PROGRESS_THREE_Q;
        }

        screen_mem[base_pos + i] = progress_char_val;
    }
}

static unsigned char estimated_percentage_count(unsigned char total, unsigned char percentage) {
    return ((unsigned short)total * percentage + 99) / 100;
}

// =============================================================================
// CONSOLE OUTPUT
// =============================================================================

void print_text(const char* text) {
    while (*text) {
        unsigned char c = (*text == '\n') ? 13 : *text;
        __asm {
            lda c
            jsr $ffd2
        }
        text++;
    }
}

// =============================================================================
// PROGRESS BAR IMPLEMENTATION
// =============================================================================

void init_progress_weights(void) {
    unsigned char weights[8];
    unsigned char estimated_visible_rooms = current_params.max_rooms;
    unsigned char estimated_corridors = current_params.max_rooms - 1;

    if (estimated_visible_rooms > current_params.hidden_room_count) {
        estimated_visible_rooms -= current_params.hidden_room_count;
    } else {
        estimated_visible_rooms = 1;
    }

    if (estimated_corridors > current_params.hidden_room_count) {
        estimated_corridors -= current_params.hidden_room_count;
    } else {
        estimated_corridors = 1;
    }

    weights[0] = current_params.max_rooms;
    weights[1] = current_params.max_rooms - 1;
    weights[2] = current_params.hidden_room_count;
    // niche_count and deception_count are preset percentages at this point,
    // not generated object counts. Convert them to realistic work estimates.
    weights[3] = estimated_percentage_count(estimated_visible_rooms, current_params.niche_count);
    weights[4] = estimated_percentage_count(estimated_corridors, current_params.deception_count);
    weights[5] = weights[4];  // Hidden passage target follows actual decoys.
    weights[6] = 2;
    weights[7] = 1;

    phase_total_weight = 0;
    for (unsigned char i = 0; i < 8; i++) {
        phase_total_weight += weights[i];
    }

    unsigned char accumulated = 0;
    for (unsigned char i = 0; i < 8; i++) {
        phase_boundaries[i] = ((unsigned short)accumulated * 80) / phase_total_weight;
        accumulated += weights[i];
    }
}

void init_progress_bar_simple(const char* title) {
    progress_steps = 0;
    clrscr();
    gotoxy(13, 10);
    print_text(title);
    render_progress_bar();
}

void update_progress_step(unsigned char phase, unsigned char current, unsigned char total) {
    if (phase >= 8 || total == 0) return;

    unsigned char phase_start = phase_boundaries[phase];
    unsigned char phase_end = (phase < 7) ? phase_boundaries[phase + 1] : 80;
    unsigned char phase_range = phase_end - phase_start;

    unsigned char phase_progress = 0;
    if (current >= total) {
        phase_progress = phase_range;
    } else if (phase_range > 0) {
        phase_progress = ((unsigned short)current * phase_range) / total;
    }

    unsigned char new_progress_steps = phase_start + phase_progress;
    if (new_progress_steps > 80) new_progress_steps = 80;

    // A rejected room layout can restart phase 0 internally. Keep the visible
    // bar monotonic instead of making it jump backwards during that retry.
    if (new_progress_steps < progress_steps) return;
    progress_steps = new_progress_steps;
    render_progress_bar();
}

void finish_progress_bar(void) {
    progress_steps = 80;
    volatile unsigned char * const screen_mem = (volatile unsigned char *)SCREEN_MEMORY_BASE;
    unsigned short base_pos = progress_y * 40 + (progress_x + 1);
    for (unsigned char i = 0; i < 20; i++) {
        screen_mem[base_pos + i] = PROGRESS_FULL;
    }
}

// =============================================================================
// PHASE DISPLAY
// =============================================================================

// Three dungeon-themed captions per generation phase. Selection is derived
// from the stored map seed without advancing the generator RNG, so cosmetic
// variety can never change the generated dungeon.
static const char* const phase_strings[8][3] = {
    {
        "Carving Chambers",
        "Carving Dusty Chambers",
        "Carving Ancient Chambers"
    },
    {
        "Digging Corridors",
        "Digging Winding Corridors",
        "Digging Crooked Corridors"
    },
    {
        "Hiding Rooms",
        "Hiding Forgotten Rooms",
        "Hiding Suspicious Rooms"
    },
    {
        "Carving Niches",
        "Carving Secret Niches",
        "Carving Treasure Niches"
    },
    {
        "Laying False Passages",
        "Laying Devious Dead Ends",
        "Laying Misleading Paths"
    },
    {
        "Concealing Doors",
        "Concealing Secret Doors",
        "Concealing Hidden Passages"
    },
    {
        "Placing Stairs",
        "Placing Distant Stairs",
        "Placing Ancient Stairs"
    },
    {
        "Generation Complete!",
        "Dungeon Complete!",
        "The Dungeon Awaits!"
    }
};

void show_phase(unsigned char phase_id) {
    if (phase_id >= 8) return;

    // Entering a new phase means all previous work is finished, even when a
    // feature phase could create fewer optional objects than its target.
    if (phase_boundaries[phase_id] > progress_steps) {
        progress_steps = phase_boundaries[phase_id];
        render_progress_bar();
    }

    unsigned int seed = mapgen_get_seed();
    unsigned char variant = (unsigned char)((seed ^ ((unsigned int)phase_id * 73)) % 3);
    const char* text = phase_strings[phase_id][variant];
    unsigned char text_len = 0;
    const char* p = text;
    while (*p++) text_len++;

    unsigned char phase_x = (40 - text_len) / 2;

    gotoxy(0, progress_y + 2);
    for (unsigned char i = 0; i < 40; i++) putchar(' ');
    gotoxy(phase_x, progress_y + 2);
    print_text(text);
}

void init_generation_progress(void) {
    init_progress_bar_simple("MAP GENERATION");
}

#endif // DEBUG_MAPGEN
