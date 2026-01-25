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
#include "mapgen_progress.h"

// External reference to generation parameters
extern MapParameters current_params;

// =============================================================================
// SCREEN CONSTANTS
// =============================================================================

#define SCREEN_MEMORY_BASE 0x0400

// Progress bar PETSCII characters (quarter-block increments)
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
    weights[0] = current_params.max_rooms;
    weights[1] = current_params.max_rooms - 1;
    weights[2] = current_params.secret_room_count;
    weights[3] = current_params.treasure_count;
    weights[4] = current_params.false_corridor_count;
    weights[5] = current_params.hidden_corridor_count;
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
}

void update_progress_step(unsigned char phase, unsigned char current, unsigned char total) {
    if (total == 0) return;

    unsigned char phase_start = phase_boundaries[phase];
    unsigned char phase_end = (phase < 7) ? phase_boundaries[phase + 1] : 80;
    unsigned char phase_range = phase_end - phase_start;

    unsigned char phase_progress = 0;
    if (current >= total) {
        phase_progress = phase_range;
    } else if (phase_range > 0) {
        phase_progress = ((unsigned short)current * phase_range) / total;
    }

    progress_steps = phase_start + phase_progress;
    if (progress_steps > 80) progress_steps = 80;

    unsigned char pos = progress_steps >> 2;
    unsigned char phase_char = progress_steps & 3;

    volatile unsigned char * const screen_mem = (volatile unsigned char *)SCREEN_MEMORY_BASE;
    unsigned short base_pos = progress_y * 40 + (progress_x + 1);

    for (unsigned char i = 0; i < pos && i < 20; i++) {
        screen_mem[base_pos + i] = PROGRESS_FULL;
    }

    if (pos < 20) {
        unsigned char progress_char_val = PROGRESS_QUARTER;
        if (phase_char == 1) progress_char_val = PROGRESS_HALF;
        else if (phase_char == 2) progress_char_val = PROGRESS_THREE_Q;
        else if (phase_char == 3) progress_char_val = PROGRESS_FULL;
        screen_mem[base_pos + pos] = progress_char_val;
    }
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

static const char phase_strings[] =
    "Building Rooms\0"
    "Connecting Rooms\0"
    "Secret Areas\0"
    "Secret Treasures\0"
    "False Corridors\0"
    "Hidden Corridors\0"
    "Placing Stairs\0"
    "Generation Complete!";

static const unsigned char phase_offsets[8] = {0, 15, 32, 45, 62, 78, 95, 110};

void show_phase(unsigned char phase_id) {
    if (phase_id >= 8) return;

    const char* text = phase_strings + phase_offsets[phase_id];
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
