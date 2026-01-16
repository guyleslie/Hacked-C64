// =============================================================================
// Map Generator Progress Bar Module
// =============================================================================
// DEBUG-only progress bar and phase display system for map generation.
// Provides visual feedback during the 8-phase generation pipeline.
//
// Only compiled when DEBUG_MAPGEN is defined.
// =============================================================================

#ifndef MAPGEN_PROGRESS_H
#define MAPGEN_PROGRESS_H

#ifdef DEBUG_MAPGEN

// =============================================================================
// CONSOLE OUTPUT
// =============================================================================

/**
 * @brief Print text string to screen using KERNAL CHROUT
 * @param text Null-terminated string to print
 */
void print_text(const char* text);

// =============================================================================
// PROGRESS BAR SYSTEM
// =============================================================================

/**
 * @brief Initialize dynamic phase boundaries from current_params
 *
 * Calculates weighted boundaries for 8 generation phases based on
 * actual room counts and feature percentages. Must be called after
 * current_params is set but before generation starts.
 */
void init_progress_weights(void);

/**
 * @brief Initialize progress bar display with title
 * @param title Text to display above progress bar (e.g., "MAP GENERATION")
 */
void init_progress_bar_simple(const char* title);

/**
 * @brief Update progress bar for current phase
 * @param phase Phase index (0-7)
 * @param current Current step within phase
 * @param total Total steps in phase
 */
void update_progress_step(unsigned char phase, unsigned char current, unsigned char total);

/**
 * @brief Fill progress bar to 100% complete
 */
void finish_progress_bar(void);

/**
 * @brief Display phase name centered below progress bar
 * @param phase_id Phase index (0-7)
 *
 * Phase names:
 * 0: "Building Rooms"
 * 1: "Connecting Rooms"
 * 2: "Secret Areas"
 * 3: "Secret Treasures"
 * 4: "False Corridors"
 * 5: "Hidden Corridors"
 * 6: "Placing Stairs"
 * 7: "Generation Complete!"
 */
void show_phase(unsigned char phase_id);

/**
 * @brief Initialize complete progress display for generation
 *
 * Convenience function that calls init_progress_bar_simple("MAP GENERATION")
 */
void init_generation_progress(void);

#endif // DEBUG_MAPGEN

#endif // MAPGEN_PROGRESS_H
