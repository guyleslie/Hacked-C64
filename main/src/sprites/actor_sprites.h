#ifndef ACTOR_SPRITES_H
#define ACTOR_SPRITES_H

// =============================================================================
// Actor Hardware Sprites
// =============================================================================
// The SpritePad asset stores two frames per appearance: RIGHT, then LEFT.
// Only the hero is used by the tile viewer for now; the remaining appearance
// IDs keep the asset order explicit without deciding gameplay roles yet.

#define ACTOR_SPRITE_SLOT_PLAYER  0

enum ActorAppearance {
    ACTOR_APPEAR_HERO = 0,
    ACTOR_APPEAR_MAGE,
    ACTOR_APPEAR_GREEN_BRUTE,     // Orc or troll; gameplay role not fixed yet
    ACTOR_APPEAR_SKELETON_WARRIOR,
    ACTOR_APPEAR_UNDEAD,
    ACTOR_APPEAR_DEVIL,
    ACTOR_APPEAR_GIANT_BUG,
    ACTOR_APPEAR_GIANT_SNAKE,
    ACTOR_APPEAR_COUNT
};

enum ActorFacing {
    ACTOR_FACING_RIGHT = 0,
    ACTOR_FACING_LEFT = 1
};

/** Load the SpritePad images into VIC bank 3 and reset hardware sprites. */
void actor_sprites_init(void);

/** Hide all hardware sprites. */
void actor_sprites_shutdown(void);

/** Select an appearance/direction and show a hardware sprite slot. */
void actor_sprite_set(unsigned char slot, unsigned char appearance,
                      unsigned char facing);

/** Move a hardware sprite; off-screen coordinates hide it at the VIC edge. */
void actor_sprite_move(unsigned char slot, int screen_x, int screen_y);

/** Move every active actor with a screen-space camera phase. */
void actor_sprites_shift(signed char screen_dx, signed char screen_dy);

/** Move every active actor except one screen-pinned sprite slot. */
void actor_sprites_shift_except(signed char screen_dx, signed char screen_dy,
                                unsigned char pinned_slot);

#endif // ACTOR_SPRITES_H
