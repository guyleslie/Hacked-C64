#ifndef TMEA_DATA_H
#define TMEA_DATA_H

// =============================================================================
// TMEA v3 - Lookup Tables API
// =============================================================================

#include "tmea_types.h"

// =============================================================================
// LOOKUP TABLE DECLARATIONS
// =============================================================================

extern const MonsterDef monster_table[MON_TYPE_COUNT];

extern const ItemDef weapon_table[8];
extern const ItemDef armor_table[8];
extern const ItemDef shield_table[5];
extern const ItemDef potion_table[6];
extern const ItemDef scroll_table[14];
extern const ItemDef gem_table[5];
extern const ItemDef key_table[4];
extern const ItemDef misc_table[4];

// =============================================================================
// HELPER FUNCTIONS
// =============================================================================

/**
 * @brief Get item definition by CCCC_SSSS type
 * @param item_type Encoded item type
 * @return Pointer to ItemDef or NULL
 */
const ItemDef* get_item_def(unsigned char item_type);

/**
 * @brief Get monster definition by type
 * @param mon_type MonsterType enum value
 * @return Pointer to MonsterDef or NULL
 */
const MonsterDef* get_monster_def(unsigned char mon_type);

#endif // TMEA_DATA_H
