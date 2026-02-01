// =============================================================================
// TMEA v4 - Lookup Tables (const/ROM data)
// =============================================================================
//
// Static data for items and monsters. These tables are stored in ROM
// and referenced by type ID at runtime.
//
// Memory: ~340 bytes (const, not RAM)
//
// =============================================================================

#include "tmea_types.h"

// =============================================================================
// MONSTER LOOKUP TABLE (88 bytes)
// =============================================================================
// { base_hp, damage, defense, armor_class, xp_value, def_flags, sprite_id, ai_type }

const MonsterDef monster_table[MON_TYPE_COUNT] = {
    // Regular enemies (0-7)
    //  hp  dmg def  ac  xp  flags                                          sprite  ai
    {   4,   2,  0,  0,   5, 0,                                                  0, AI_SIMPLE_CHASE }, // RAT
    {   8,   3,  1,  1,  10, 0,                                                  1, AI_SIMPLE_CHASE }, // GOBLIN
    {  10,   4,  1,  2,  15, MDEF_UNDEAD,                                        2, AI_SIMPLE_CHASE }, // SKELETON
    {  15,   5,  2,  3,  25, 0,                                                  3, AI_SMART_CHASE  }, // ORC
    {  18,   4,  1,  2,  20, MDEF_UNDEAD | MDEF_REGENERATE,                      4, AI_SLOW_CHASE   }, // ZOMBIE
    {  25,   6,  2,  4,  40, MDEF_REGENERATE,                                    5, AI_SMART_CHASE  }, // TROLL
    {  12,   5,  3,  5,  30, MDEF_UNDEAD | MDEF_LIFE_DRAIN | MDEF_FLYING,        6, AI_SMART_CHASE  }, // GHOST
    {  10,   3,  1,  2,  15, MDEF_POISON_ATK,                                    7, AI_SIMPLE_CHASE }, // SPIDER

    // Boss enemies (8-10)
    {  50,   8,  3,  6, 100, MDEF_BOSS | MDEF_DEMON | MDEF_RANGED,               8, AI_BOSS         }, // DEMON
    {  40,   7,  4,  7, 120, MDEF_BOSS | MDEF_UNDEAD | MDEF_LIFE_DRAIN | MDEF_RANGED, 9, AI_BOSS    }, // LICH
    {  80,  10,  3,  8, 200, MDEF_BOSS | MDEF_FLYING | MDEF_RANGED,             10, AI_BOSS         }, // DRAGON
};

// =============================================================================
// WEAPON LOOKUP TABLE (64 bytes)
// =============================================================================
// { damage, hit_bonus, speed, crit_chance, special, range, gold_price, tile_id }

const WeaponDef weapon_table[8] = {
    {  3,  3, 14, 10, WEAPON_SPECIAL_POISON,                                      1,  10, 0 }, // DAGGER
    {  5,  2, 12,  5, WEAPON_SPECIAL_NONE,                                        1,  25, 1 }, // SHORT_SWORD
    {  7,  1, 10,  8, WEAPON_SPECIAL_NONE,                                        1,  50, 2 }, // LONG_SWORD
    { 10,  0,  6, 12, WEAPON_SPECIAL_CLEAVE | WEAPON_SPECIAL_TWO_HANDED,          1,  80, 3 }, // BATTLE_AXE
    {  6,  1, 10,  5, WEAPON_SPECIAL_VS_UNDEAD | WEAPON_SPECIAL_STUN,             1,  40, 4 }, // MACE
    {  5,  2, 11,  6, WEAPON_SPECIAL_PIERCE_ARMOR,                                2,  35, 5 }, // SPEAR
    {  4,  3, 12,  8, WEAPON_SPECIAL_NONE,                                        3,  60, 6 }, // BOW
    {  8,  2, 13, 15, WEAPON_SPECIAL_LIFE_DRAIN | WEAPON_SPECIAL_VS_DEMON,        1, 100, 7 }, // CURSED_BLADE
};

// =============================================================================
// ARMOR LOOKUP TABLE (40 bytes)
// =============================================================================
// { armor_class, weight, special, gold_price, tile_id }

const ArmorDef armor_table[8] = {
    { 1, 0, ARMOR_SPECIAL_STEALTH,        10,  8 }, // CLOTH
    { 3, 0, ARMOR_SPECIAL_NONE,           25,  9 }, // LEATHER
    { 4, 1, ARMOR_SPECIAL_NONE,           50, 10 }, // STUDDED_LEATHER
    { 6, 2, ARMOR_SPECIAL_NONE,           80, 11 }, // CHAIN_MAIL
    { 7, 2, ARMOR_SPECIAL_FIRE_RESIST,   120, 12 }, // SCALE_MAIL
    { 9, 3, ARMOR_SPECIAL_NONE,          180, 13 }, // PLATE_MAIL
    { 2, 0, ARMOR_SPECIAL_MAGIC_RESIST,   60, 14 }, // ROBE
    { 5, 1, ARMOR_SPECIAL_POISON_IMMUNE, 100, 15 }, // DRAGON_SCALE
};

// =============================================================================
// SHIELD LOOKUP TABLE (25 bytes)
// =============================================================================
// { defense, block_chance, special, gold_price, tile_id }

const ShieldDef shield_table[5] = {
    { 1, 10, SHIELD_SPECIAL_NONE,        15, 16 }, // BUCKLER
    { 2, 15, SHIELD_SPECIAL_BASH,        30, 17 }, // ROUND_SHIELD
    { 3, 20, SHIELD_SPECIAL_NONE,        50, 18 }, // KITE_SHIELD
    { 4, 25, SHIELD_SPECIAL_SPELL_BLOCK, 80, 19 }, // TOWER_SHIELD
    { 5, 30, SHIELD_SPECIAL_REFLECT,    150, 20 }, // MIRROR_SHIELD
};

// =============================================================================
// POTION LOOKUP TABLE (36 bytes)
// =============================================================================
// { effect_type, magnitude, duration, special, gold_price, tile_id }

const PotionDef potion_table[6] = {
    { EFFECT_HEAL,        15,   0, 0, 20, 21 }, // POTION_HEAL (+15 HP)
    { EFFECT_FULL_HEAL,  255,   0, 0, 80, 22 }, // POTION_FULL_HEAL
    { EFFECT_BERSERK,      0,  10, 0, 40, 23 }, // POTION_BERSERK
    { EFFECT_REGEN,        2,  10, 0, 40, 24 }, // POTION_REGEN (+2 HP/turn)
    { EFFECT_CURE_POISON,  0,   0, 0, 30, 25 }, // POTION_CURE_POISON
    { EFFECT_INVISIBLE,    0,  15, 0, 60, 26 }, // POTION_INVISIBILITY
};

// =============================================================================
// SCROLL LOOKUP TABLE (84 bytes)
// =============================================================================
// { effect_type, magnitude, duration, special, gold_price, tile_id }

const ScrollDef scroll_table[14] = {
    { EFFECT_LIGHT,           5,  50, 0,  10, 27 }, // SCROLL_LIGHT
    { EFFECT_MAP_REVEAL,      0,   0, 0,  50, 28 }, // SCROLL_MAGIC_MAPPING
    { EFFECT_DETECT_SECRET,   0,   0, 0,  30, 29 }, // SCROLL_DETECT_SECRET
    { EFFECT_TELEPORT,        0,   0, 0,  25, 30 }, // SCROLL_TELEPORT
    { EFFECT_IDENTIFY,        1,   0, 0,  40, 31 }, // SCROLL_IDENTIFY
    { EFFECT_ENCHANT_WEAPON,  1,   0, 0,  80, 32 }, // SCROLL_ENCHANT_WEAPON
    { EFFECT_ENCHANT_ARMOR,   1,   0, 0,  80, 33 }, // SCROLL_ENCHANT_ARMOR
    { EFFECT_REMOVE_CURSE,    0,   0, 0,  60, 34 }, // SCROLL_REMOVE_CURSE
    { EFFECT_SUMMON_ENEMY,    1,   0, 1,   0, 35 }, // SCROLL_SUMMON (cursed)
    { EFFECT_BREAK_WALLS,     1,   0, 0, 100, 36 }, // SCROLL_EARTHQUAKE
    { EFFECT_TURN_UNDEAD,    10,   0, 0,  70, 37 }, // SCROLL_TURN_UNDEAD
    { EFFECT_FIREBALL,       12,   0, 0,  60, 38 }, // SCROLL_FIREBALL
    { EFFECT_HASTE,           0,  10, 0,  50, 39 }, // SCROLL_HASTE
    { EFFECT_SHIELD_BUFF,     3,   5, 0,  40, 40 }, // SCROLL_SHIELD
};

// =============================================================================
// GEM LOOKUP TABLE (15 bytes)
// =============================================================================
// { gold_value, rarity, tile_id }

const GemDef gem_table[5] = {
    {  25, 10, 41 }, // RUBY
    {  35,  8, 42 }, // SAPPHIRE
    {  50,  5, 43 }, // EMERALD
    { 100,  2, 44 }, // DIAMOND
    {  20, 12, 45 }, // AMETHYST
};

// =============================================================================
// HELPER FUNCTIONS
// =============================================================================

const WeaponDef* get_weapon_def(unsigned char weapon_subtype) {
    if (weapon_subtype < 8) {
        return &weapon_table[weapon_subtype];
    }
    return (const WeaponDef*)0;
}

const ArmorDef* get_armor_def(unsigned char armor_subtype) {
    if (armor_subtype < 8) {
        return &armor_table[armor_subtype];
    }
    return (const ArmorDef*)0;
}

const ShieldDef* get_shield_def(unsigned char shield_subtype) {
    if (shield_subtype < 5) {
        return &shield_table[shield_subtype];
    }
    return (const ShieldDef*)0;
}

const PotionDef* get_potion_def(unsigned char potion_subtype) {
    if (potion_subtype < 6) {
        return &potion_table[potion_subtype];
    }
    return (const PotionDef*)0;
}

const ScrollDef* get_scroll_def(unsigned char scroll_subtype) {
    if (scroll_subtype < 14) {
        return &scroll_table[scroll_subtype];
    }
    return (const ScrollDef*)0;
}

const GemDef* get_gem_def(unsigned char gem_subtype) {
    if (gem_subtype < 5) {
        return &gem_table[gem_subtype];
    }
    return (const GemDef*)0;
}

const MonsterDef* get_monster_def(unsigned char mon_type) {
    if (mon_type < MON_TYPE_COUNT) {
        return &monster_table[mon_type];
    }
    return (const MonsterDef*)0;
}
