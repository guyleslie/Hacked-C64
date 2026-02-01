#ifndef TMEA_DATA_H
#define TMEA_DATA_H

// =============================================================================
// TMEA v4 - Lookup Tables API
// =============================================================================
//
// ROM lookup tables for items and monsters.
// Total: ~340 bytes const data
//
// =============================================================================

#include "tmea_types.h"

// =============================================================================
// LOOKUP TABLE DECLARATIONS
// =============================================================================

// Monster table (11 entries × 8 bytes = 88 bytes)
extern const MonsterDef monster_table[MON_TYPE_COUNT];

// Item tables (specialized structures)
extern const WeaponDef weapon_table[8];     // 8 × 8 bytes = 64 bytes
extern const ArmorDef armor_table[8];       // 8 × 5 bytes = 40 bytes
extern const ShieldDef shield_table[5];     // 5 × 5 bytes = 25 bytes
extern const PotionDef potion_table[6];     // 6 × 6 bytes = 36 bytes
extern const ScrollDef scroll_table[14];    // 14 × 6 bytes = 84 bytes
extern const GemDef gem_table[5];           // 5 × 3 bytes = 15 bytes

// Total ROM: ~352 bytes

// =============================================================================
// HELPER FUNCTIONS
// =============================================================================

/**
 * @brief Get weapon definition by subtype
 * @param weapon_subtype Weapon subtype (0-7)
 * @return Pointer to WeaponDef or NULL if invalid
 */
const WeaponDef* get_weapon_def(unsigned char weapon_subtype);

/**
 * @brief Get armor definition by subtype
 * @param armor_subtype Armor subtype (0-7)
 * @return Pointer to ArmorDef or NULL if invalid
 */
const ArmorDef* get_armor_def(unsigned char armor_subtype);

/**
 * @brief Get shield definition by subtype
 * @param shield_subtype Shield subtype (0-4)
 * @return Pointer to ShieldDef or NULL if invalid
 */
const ShieldDef* get_shield_def(unsigned char shield_subtype);

/**
 * @brief Get potion definition by subtype
 * @param potion_subtype Potion subtype (0-5)
 * @return Pointer to PotionDef or NULL if invalid
 */
const PotionDef* get_potion_def(unsigned char potion_subtype);

/**
 * @brief Get scroll definition by subtype
 * @param scroll_subtype Scroll subtype (0-13)
 * @return Pointer to ScrollDef or NULL if invalid
 */
const ScrollDef* get_scroll_def(unsigned char scroll_subtype);

/**
 * @brief Get gem definition by subtype
 * @param gem_subtype Gem subtype (0-4)
 * @return Pointer to GemDef or NULL if invalid
 */
const GemDef* get_gem_def(unsigned char gem_subtype);

/**
 * @brief Get monster definition by type
 * @param mon_type MonsterType enum value
 * @return Pointer to MonsterDef or NULL if invalid
 */
const MonsterDef* get_monster_def(unsigned char mon_type);

#endif // TMEA_DATA_H
