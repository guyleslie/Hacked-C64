// =============================================================================
// Actor Hardware Sprites
// =============================================================================

#include <c64/memmap.h>
#include <c64/sprites.h>
#include <c64/vic.h>
#include <oscar.h>

#include "actor_sprites.h"
#include "../tiles/tile_render.h"

// VIC bank 3 spans $C000-$FFFF. The tile renderer occupies $C000-$CFFF;
// $E000-$E3FF provides exactly 16 aligned sprite blocks under Kernal ROM.
// The VIC always sees this RAM, while the CPU temporarily pages the ROM out
// only during the one-time decompression.
static char * const actor_sprite_ram = (char *)0xE000;
#define ACTOR_SPRITE_IMAGE_BASE  0x80

// Logical screen positions are retained even while spr_move16() hides an
// off-screen sprite. This also lets one camera phase move every active actor
// without reading the lossy hardware registers back.
static int actor_screen_x[8];
static int actor_screen_y[8];
static unsigned char actor_active_mask;

static const char actor_sprite_lzo[] = {
    #embed spd_sprites lzo "../../assets/sprites/actors.spd"
};

// SpritePad per-appearance colours. Shared multicolours are black and yellow.
static const unsigned char actor_sprite_colors[ACTOR_APPEAR_COUNT] = {
    VCOL_LT_GREY, // hero
    VCOL_BLUE,    // mage
    VCOL_GREEN,   // green brute
    VCOL_WHITE,   // skeleton warrior
    VCOL_GREEN,   // undead
    VCOL_ORANGE,  // devil
    VCOL_RED,     // giant bug
    VCOL_GREEN    // giant snake
};

void actor_sprites_init(void) {
    char old_map;

    mmap_trampoline();
    old_map = mmap_set(MMAP_RAM);
    oscar_expand_lzo(actor_sprite_ram, actor_sprite_lzo);
    mmap_set(old_map);

    vic.spr_enable = 0;
    vic.spr_multi = 0;
    vic.spr_expand_x = 0;
    vic.spr_expand_y = 0;
    vic.spr_priority = 0;
    vic.spr_mcolor0 = VCOL_BLACK;
    vic.spr_mcolor1 = VCOL_YELLOW;
    actor_active_mask = 0;
}

void actor_sprites_shutdown(void) {
    vic.spr_enable = 0;
    actor_active_mask = 0;
}

void actor_sprite_set(unsigned char slot, unsigned char appearance,
                      unsigned char facing) {
    unsigned char mask;
    unsigned char frame;

    if (slot >= 8 || appearance >= ACTOR_APPEAR_COUNT) return;

    facing &= 1;
    mask = 1 << slot;
    frame = (appearance << 1) + facing;

    // Both tile screens have their own sprite pointer table. Updating both
    // keeps the frame stable across the renderer's double-buffer flips.
    tiles_set_sprite_image(slot, ACTOR_SPRITE_IMAGE_BASE + frame);
    spr_color(slot, actor_sprite_colors[appearance]);
    spr_expand(slot, false, false);
    vic.spr_multi |= mask;
    vic.spr_priority &= ~mask;
    spr_show(slot, true);
    actor_active_mask |= mask;
}

void actor_sprite_move(unsigned char slot, int screen_x, int screen_y) {
    if (slot >= 8) return;
    actor_screen_x[slot] = screen_x;
    actor_screen_y[slot] = screen_y;
    spr_move16(slot, screen_x, screen_y);
}

void actor_sprites_shift_except(signed char screen_dx, signed char screen_dy,
                                unsigned char pinned_slot) {
    unsigned char mask = actor_active_mask;
    unsigned char slot = 0;

    while (mask) {
        if ((mask & 1) && slot != pinned_slot) {
            actor_screen_x[slot] += screen_dx;
            actor_screen_y[slot] += screen_dy;
            spr_move16(slot, actor_screen_x[slot], actor_screen_y[slot]);
        }
        mask >>= 1;
        slot++;
    }
}

void actor_sprites_shift(signed char screen_dx, signed char screen_dy) {
    actor_sprites_shift_except(screen_dx, screen_dy, 8);
}
