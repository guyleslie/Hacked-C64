#ifndef TILE_VIEWER_H
#define TILE_VIEWER_H

// =============================================================================
// Tile Map Viewer
// =============================================================================
// Scrolls a generated dungeon on screen using the 3x3 tile renderer, as a
// replacement for the one-character-per-cell PETSCII preview.
//
// The viewport shows 10x8 map cells instead of 40x25, so scrolling is how the
// map is inspected rather than an optional extra.
//
// Controls: joystick 2 scrolls, FIRE generates a new dungeon, Q quits.

/**
 * @brief Run the interactive viewer until the user quits
 * Expects a generated map to already be in memory. Takes over the VIC
 * character set and display mode, and restores them before returning.
 */
void tile_viewer_run(void);

#endif // TILE_VIEWER_H
