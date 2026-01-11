// =============================================================================
// Map Generator DEBUG Mode Module
// =============================================================================
// This module encapsulates all DEBUG-only functionality including:
// - Interactive configuration menu with joystick controls
// - Map preview and navigation
// - Real-time regeneration with FIRE button
// - Map export functionality ('M' key)
//
// Only compiled when DEBUG_MAPGEN is defined.
// =============================================================================

#ifndef MAPGEN_DEBUG_H
#define MAPGEN_DEBUG_H

#ifdef DEBUG_MAPGEN

// =============================================================================
// DEBUG MODE ENTRY POINT
// =============================================================================

/**
 * @brief Run interactive DEBUG mode with menu, generation, and navigation
 *
 * This function provides a complete interactive experience for testing and
 * debugging the map generation system. It includes:
 *
 * - Configuration menu with joystick controls
 * - Initial map generation with progress bar
 * - Interactive viewport navigation (joystick directions)
 * - Real-time map regeneration (FIRE button)
 * - Map export to disk ('M' key saves as MAPBIN file)
 * - Quit functionality ('Q' key)
 *
 * Controls:
 * - Joystick 2 UP/DOWN/LEFT/RIGHT: Navigate map viewport
 * - FIRE button: Show menu and regenerate map
 * - 'M' key: Export map to disk
 * - 'Q' key: Quit and return to BASIC
 *
 * @note This function only exists when DEBUG_MAPGEN is defined.
 * @note Uses blocking loop - never returns until user quits.
 */
void mapgen_run_debug_mode(void);

#endif // DEBUG_MAPGEN

#endif // MAPGEN_DEBUG_H
