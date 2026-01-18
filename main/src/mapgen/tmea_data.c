// =============================================================================
// TMEA v3 - Lookup Tables (const/ROM data)
// =============================================================================
//
// Static data for items and monsters. These tables are stored in ROM
// and referenced by type ID at runtime.
//
// Memory: ~200 bytes (const, not RAM)
//
// =============================================================================

#include "tmea_types.h"

// =============================================================================
// MONSTER LOOKUP TABLE
// =============================================================================
// Index matches MonsterType enum
// { base_hp, damage, xp_value, def_flags, sprite_id }

const MonsterDef monster_table[MON_TYPE_COUNT] = {
    // Regular enemies (0-7)
    {  4,  1,   3, 0,                                    0 },  // MON_RAT
    {  8,  2,   8, 0,                                    1 },  // MON_GOBLIN
    { 10,  3,  12, MDEF_UNDEAD,                          2 },  // MON_SKELETON
    { 15,  4,  18, 0,                                    3 },  // MON_ORC
    { 20,  3,  15, MDEF_UNDEAD,                          4 },  // MON_ZOMBIE
    { 25,  5,  25, MDEF_REGEN,                           5 },  // MON_TROLL
    { 12,  4,  20, MDEF_UNDEAD | MDEF_LIFE_DRAIN,        6 },  // MON_GHOST
    {  8,  2,  10, MDEF_POISON_ATK,                      7 },  // MON_SPIDER

    // Boss enemies (8-10)
    { 40,  8,  50, MDEF_BOSS,                            8 },  // MON_BOSS_DEMON
    { 35,  6,  60, MDEF_BOSS | MDEF_UNDEAD,              9 },  // MON_BOSS_LICH
    { 60, 10, 100, MDEF_BOSS | MDEF_FLYING,             10 },  // MON_BOSS_DRAGON
};

// =============================================================================
// ITEM LOOKUP TABLES
// =============================================================================
// { base_value (dmg/def/heal), gold_price, tile_id }

// -----------------------------------------------------------------------------
// Weapons (8 types) - base_value = damage
// -----------------------------------------------------------------------------
const ItemDef weapon_table[8] = {
    { 2,   5, 0 },  // DAGGER
    { 4,  15, 1 },  // SHORT_SWORD
    { 6,  30, 2 },  // LONG_SWORD
    { 8,  40, 3 },  // AXE
    { 5,  25, 4 },  // MACE (bonus vs undead in combat code)
    { 5,  20, 5 },  // SPEAR
    { 4,  35, 6 },  // BOW
    { 3,  10, 7 },  // STAFF (magic bonus in combat code)
};

// -----------------------------------------------------------------------------
// Armor (8 types) - base_value = defense
// -----------------------------------------------------------------------------
const ItemDef armor_table[8] = {
    { 1,   5, 8 },  // CLOTH
    { 2,  15, 9 },  // LEATHER
    { 3,  30, 10 }, // STUDDED
    { 4,  50, 11 }, // CHAIN
    { 5,  75, 12 }, // SCALE
    { 7, 120, 13 }, // PLATE
    { 1,  20, 14 }, // ROBE (magic bonus)
    { 1,  25, 15 }, // CLOAK (stealth bonus)
};

// -----------------------------------------------------------------------------
// Shields (5 types) - base_value = defense
// -----------------------------------------------------------------------------
const ItemDef shield_table[5] = {
    { 1,  10, 16 }, // BUCKLER
    { 2,  20, 17 }, // WOODEN
    { 3,  40, 18 }, // IRON
    { 4,  70, 19 }, // STEEL
    { 5, 100, 20 }, // TOWER
};

// -----------------------------------------------------------------------------
// Potions (6 types) - base_value = effect amount
// -----------------------------------------------------------------------------
const ItemDef potion_table[6] = {
    { 20, 15, 21 }, // HEAL (+20 HP)
    { 15, 15, 22 }, // MANA (+15 MP)
    {  0, 20, 23 }, // CURE (remove status)
    {  5, 30, 24 }, // SPEED (5 turns)
    {  5, 30, 25 }, // STRENGTH (5 turns, +2 DMG)
    { 10, 50, 26 }, // INVISIBILITY (10 turns)
};

// -----------------------------------------------------------------------------
// Scrolls (14 types) - base_value = effect amount/duration/damage
// -----------------------------------------------------------------------------
const ItemDef scroll_table[14] = {
    {  0, 10, 27 }, // LIGHT
    {  0, 25, 28 }, // TURN_UNDEAD
    { 15, 40, 29 }, // FIREBALL (15 DMG)
    { 12, 35, 30 }, // ICE_BOLT (12 DMG + FROZEN)
    { 20, 50, 31 }, // LIGHTNING (20 DMG chain)
    { 30, 30, 32 }, // HEAL (+30 HP)
    {  0, 20, 33 }, // TELEPORT
    {  0, 35, 34 }, // MAPPING
    {  0, 15, 35 }, // IDENTIFY
    {  0, 60, 36 }, // ENCHANT (+1 upgrade)
    {  0, 40, 37 }, // REMOVE_CURSE
    {  5, 25, 38 }, // PROTECTION (5 turns, +3 DEF)
    {  5, 30, 39 }, // CONFUSION (5 turns)
    {  5, 30, 40 }, // SLEEP (5 turns)
};

// -----------------------------------------------------------------------------
// Gems (5 types) - base_value = 0 (just gold value)
// -----------------------------------------------------------------------------
const ItemDef gem_table[5] = {
    { 0,  25, 41 }, // RUBY
    { 0,  35, 42 }, // SAPPHIRE
    { 0,  50, 43 }, // EMERALD
    { 0, 100, 44 }, // DIAMOND
    { 0,  20, 45 }, // AMETHYST
};

// -----------------------------------------------------------------------------
// Keys (4 types) - base_value = 0
// -----------------------------------------------------------------------------
const ItemDef key_table[4] = {
    { 0,  10, 46 }, // BRONZE
    { 0,  25, 47 }, // SILVER
    { 0,  50, 48 }, // GOLD
    { 0, 100, 49 }, // MASTER
};

// -----------------------------------------------------------------------------
// Misc items - base_value varies
// -----------------------------------------------------------------------------
const ItemDef misc_table[4] = {
    { 1,   0, 50 }, // GOLD (amount in data byte, value = data * 1)
    { 100, 5, 51 }, // TORCH (fuel in data byte, default 100)
    { 25,  8, 52 }, // FOOD (+25 hunger)
    { 0,  15, 53 }, // LOCKPICK
};

// =============================================================================
// HELPER FUNCTIONS - Get item definition by type
// =============================================================================

/**
 * @brief Get item definition from lookup table by item type
 *
 * @param item_type CCCC_SSSS encoded item type
 * @return Pointer to ItemDef, or NULL if invalid type
 */
const ItemDef* get_item_def(unsigned char item_type) {
    unsigned char category = ITEM_GET_CATEGORY(item_type);
    unsigned char subtype = ITEM_GET_SUBTYPE(item_type);

    switch (category) {
        case ITEM_CAT_WEAPON:
            if (subtype < 8) return &weapon_table[subtype];
            break;
        case ITEM_CAT_ARMOR:
            if (subtype < 8) return &armor_table[subtype];
            break;
        case ITEM_CAT_SHIELD:
            if (subtype < 5) return &shield_table[subtype];
            break;
        case ITEM_CAT_POTION:
            if (subtype < 6) return &potion_table[subtype];
            break;
        case ITEM_CAT_SCROLL:
            if (subtype < 14) return &scroll_table[subtype];
            break;
        case ITEM_CAT_GEM:
            if (subtype < 5) return &gem_table[subtype];
            break;
        case ITEM_CAT_KEY:
            if (subtype < 4) return &key_table[subtype];
            break;
        case ITEM_CAT_MISC:
            if (subtype < 4) return &misc_table[subtype];
            break;
    }

    return (const ItemDef*)0;  // NULL - invalid type
}

/**
 * @brief Get monster definition from lookup table
 *
 * @param mon_type MonsterType enum value
 * @return Pointer to MonsterDef, or NULL if invalid type
 */
const MonsterDef* get_monster_def(unsigned char mon_type) {
    if (mon_type < MON_TYPE_COUNT) {
        return &monster_table[mon_type];
    }
    return (const MonsterDef*)0;  // NULL
}
