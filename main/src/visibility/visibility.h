#ifndef VISIBILITY_H
#define VISIBILITY_H

// =============================================================================
// Player Visibility and Exploration Memory
// =============================================================================

enum VisibilityState {
    VISIBILITY_HIDDEN = 0,
    VISIBILITY_VISIBLE,
    VISIBILITY_REMEMBERED
};

/** Clear exploration memory and reveal the initial field of view. */
void visibility_reset(unsigned char player_x, unsigned char player_y);

/** Recalculate the current field of view and remember every visible cell. */
void visibility_update(unsigned char player_x, unsigned char player_y);

/** Query hidden/currently-visible/remembered state for one map cell. */
unsigned char visibility_state_at(unsigned char map_x, unsigned char map_y);

#endif // VISIBILITY_H
