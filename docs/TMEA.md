# TMEA: Tile Metadata Extension Architecture

**Version:** 4.0
**Target Platform:** Commodore 64 (6502 @ 1MHz, 64KB RAM)
**Compiler:** Oscar64 cross-compiler
**Memory Overhead:** ~640 bytes RAM + ~340 bytes ROM (lookup tables)

---

## Table of Contents

1. [Overview](#1-overview)
2. [Architecture Philosophy](#2-architecture-philosophy)
3. [Core Concepts](#3-core-concepts)
4. [Memory Layout](#4-memory-layout)
5. [Type System](#5-type-system)
6. [Lookup Tables](#6-lookup-tables)
7. [Combat Data Structures](#7-combat-data-structures)
8. [API Reference](#8-api-reference)
9. [Usage Examples](#9-usage-examples)
10. [Performance Analysis](#10-performance-analysis)

---

## 1. Overview

### 1.1 What is TMEA?

**TMEA (Tile Metadata Extension Architecture)** is a lightweight metadata and entity system designed for the C64 dungeon crawler. It provides:

- **Tile metadata** - Extra information for walls, doors, floors (secret, locked, trapped, etc.)
- **Entity pools** - Objects (items) and monsters with minimal memory footprint
- **Lookup tables** - Static data for items/monsters/combat stored in ROM (const)
- **Combat data** - Weapon, armor, shield, scroll, potion definitions

### 1.2 Design Goals

```
 Minimal RAM Footprint:   ~640 bytes runtime data
 ROM Lookup Tables:       ~340 bytes const data
 Fast Lookups:            ~0.31ms average
 Data-Oriented Design:    Static properties in ROM, dynamic state in RAM
 Room-Aware:              Optimized for room-based dungeon generation
 Sprite-Limited:          Max 6 monsters (C64 sprite constraint)
 Combat-Ready:            Full combat system support
```

### 1.3 v4 Changes from v3

| Feature | v3 | v4 |
|---------|----|----|
| WeaponDef size | 3 bytes | 8 bytes (full combat stats) |
| ArmorDef size | 3 bytes | 5 bytes (weight system) |
| ShieldDef size | 3 bytes | 5 bytes (block mechanics) |
| MonsterDef size | 5 bytes | 8 bytes (defense, AC, AI type) |
| ScrollDef | Basic | 6 bytes (14 types, full effects) |
| PotionDef | Basic | 6 bytes (6 types, full effects) |
| Status system | None | 16-bit flags + 10-byte timers |
| Boss AI | None | 3-byte struct per boss |
| Total ROM | ~217 bytes | ~340 bytes |
| Total RAM | ~620 bytes | ~640 bytes |

---

## 2. Architecture Philosophy

### 2.1 Data-Oriented Design

```
+-----------------------------------------------------------+
| STATIC DATA (ROM/const)          DYNAMIC DATA (RAM)       |
| ---------------------------      ------------------       |
| MonsterDef table:                TinyMon pool:            |
|   - base_hp, damage              - x, y (position)        |
|   - defense, armor_class         - hp (current)           |
|   - xp_value, def_flags          - flags (status)         |
|   - sprite_id, ai_type           - state (AI)             |
|                                  - type (table index)     |
|                                                           |
| WeaponDef table:                 Player equipment:        |
|   - damage, hit_bonus            - weapon_type            |
|   - speed, crit_chance           - weapon_data (modifier) |
|   - special, range               - armor_type, shield_type|
|   - gold_price, tile_id                                   |
|                                                           |
| ScrollDef/PotionDef tables:      StatusTimers:            |
|   - effect_type, magnitude       - poison_turns           |
|   - duration, special            - haste_turns, etc.      |
|   - price, tile_id               (10 bytes total)         |
|                                                           |
| COST: 0 RAM (const)              COST: 6-8 bytes/entity   |
+-----------------------------------------------------------+
```

**Key Insight:** Static properties (damage, defense, XP) are stored once in lookup tables. Runtime structs only hold instance-specific data (position, current HP, status).

### 2.2 Room-First, Global-Fallback

```
+--------------------------------------------------+
| TILE METADATA ROUTING                            |
+--------------------------------------------------+
| 1. ROOM-BASED POOL (Primary, 70% of map)         |
|    +-- 4 slots per room x 20 rooms = 80 max      |
|    +-- Compact: Room-local coords (4+4 bits)     |
|    +-- Fast: O(4) linear search per room         |
|                                                  |
| 2. GLOBAL POOL (Fallback, 30% of map)            |
|    +-- 16 slots for corridors                    |
|    +-- Global coords (8+8 bits)                  |
|    +-- O(16) linear search                       |
|                                                  |
| -> API auto-routes to best pool                  |
+--------------------------------------------------+
```

---

## 3. Core Concepts

### 3.1 The Four Data Layers

```
+-----------------------------------------------------+
| LAYER 0: Compact Map (3-bit tiles)                  |
| +-- compact_map[2400]: Base tile types              |
| +-- TILE_MARKER (7): Metadata presence flag         |
| +-- Unchanged from previous versions                |
+-----------------------------------------------------+
| LAYER 1: Tile Metadata (~325 bytes)                 |
| +-- Room pool: 20 rooms x 4 slots x 3 bytes         |
| +-- Global pool: 16 slots x 4 bytes                 |
| +-- For doors, traps, special tiles                 |
+-----------------------------------------------------+
| LAYER 2: Entity Pools (~340 bytes)                  |
| +-- TinyObj[48]: Items on ground (6 bytes each)     |
| +-- TinyMon[6]: Active monsters (8 bytes each)      |
| +-- Linked list management                          |
+-----------------------------------------------------+
| LAYER 3: Lookup Tables (~340 bytes ROM)             |
| +-- weapon_table[8]: Weapon definitions             |
| +-- armor_table[8]: Armor definitions               |
| +-- shield_table[5]: Shield definitions             |
| +-- scroll_table[14]: Scroll definitions            |
| +-- potion_table[6]: Potion definitions             |
| +-- monster_table[11]: Monster definitions          |
| +-- Const data, zero RAM cost                       |
+-----------------------------------------------------+
| LAYER 4: Combat State (~20 bytes RAM)               |
| +-- StatusTimers: Player status durations           |
| +-- BossAI[3]: Boss special attack cooldowns        |
+-----------------------------------------------------+
```

---

## 4. Memory Layout

### 4.1 Complete Memory Map

```
+=====================================================+
| TMEA v4 MEMORY ALLOCATION                           |
+=====================================================+
| TILE METADATA (RAM)                                 |
| +-- room_metas[20][4]:                  240 bytes   |
| +-- room_meta_count[20]:                 20 bytes   |
| +-- global_metas[16]:                    64 bytes   |
| +-- global_meta_count:                    1 byte    |
|                                        --------     |
| Metadata Subtotal:                     325 bytes    |
+=====================================================+
| ENTITY POOLS (RAM)                                  |
| +-- obj_pool[48] (TinyObj, 6 bytes):   288 bytes    |
| +-- obj_free_list, obj_active_list:      4 bytes    |
| +-- mon_pool[6] (TinyMon, 8 bytes):     48 bytes    |
| +-- mon_free_list, mon_active_list:      4 bytes    |
|                                        --------     |
| Entity Subtotal:                       344 bytes    |
+=====================================================+
| COMBAT STATE (RAM)                                  |
| +-- StatusTimers (player):              10 bytes    |
| +-- BossAI[3]:                           9 bytes    |
|                                        --------     |
| Combat Subtotal:                        19 bytes    |
+=====================================================+
| TMEA RAM TOTAL:                       ~640 bytes    |
+=====================================================+
| LOOKUP TABLES (ROM/const)                           |
| +-- weapon_table[8]:       8 x 8 B  =   64 bytes    |
| +-- armor_table[8]:        8 x 5 B  =   40 bytes    |
| +-- shield_table[5]:       5 x 5 B  =   25 bytes    |
| +-- scroll_table[14]:     14 x 6 B  =   84 bytes    |
| +-- potion_table[6]:       6 x 6 B  =   36 bytes    |
| +-- monster_table[11]:    11 x 8 B  =   88 bytes    |
|                                        --------     |
| Lookup Subtotal:                      ~340 bytes    |
+=====================================================+
```

### 4.2 Structure Sizes

| Structure | Size | Count | Total | Purpose |
|-----------|------|-------|-------|---------|
| **RoomTileMeta** | 3 bytes | 80 | 240 bytes | Room tile metadata |
| **GlobalTileMeta** | 4 bytes | 16 | 64 bytes | Corridor metadata |
| **TinyObj** | 6 bytes | 48 | 288 bytes | Items on ground |
| **TinyMon** | 8 bytes | 6 | 48 bytes | Active monsters |
| **StatusTimers** | 10 bytes | 1 | 10 bytes | Player status durations |
| **BossAI** | 3 bytes | 3 | 9 bytes | Boss attack cooldowns |
| **WeaponDef** | 8 bytes | 8 | 64 bytes | Weapon lookup (ROM) |
| **ArmorDef** | 5 bytes | 8 | 40 bytes | Armor lookup (ROM) |
| **ShieldDef** | 5 bytes | 5 | 25 bytes | Shield lookup (ROM) |
| **ScrollDef** | 6 bytes | 14 | 84 bytes | Scroll lookup (ROM) |
| **PotionDef** | 6 bytes | 6 | 36 bytes | Potion lookup (ROM) |
| **MonsterDef** | 8 bytes | 11 | 88 bytes | Monster lookup (ROM) |

---

## 5. Type System

### 5.1 Item Type Encoding (CCCC_SSSS)

Items use an 8-bit type with embedded category:

```
Bit Layout: CCCCSSSS
            ||||||||
            ||||++++-- Subtype (4 bits, 0-15 per category)
            ++++------ Category (4 bits, 0-15 categories)

Category Mask: 0xF0
Subtype Mask:  0x0F
```

### 5.2 Item Categories

```c
#define ITEM_CAT_WEAPON     0x00    // 0x00-0x07: 8 weapons
#define ITEM_CAT_ARMOR      0x10    // 0x10-0x17: 8 armor
#define ITEM_CAT_SHIELD     0x20    // 0x20-0x24: 5 shields
#define ITEM_CAT_POTION     0x30    // 0x30-0x35: 6 potions
#define ITEM_CAT_SCROLL     0x40    // 0x40-0x4D: 14 scrolls
#define ITEM_CAT_GEM        0x50    // 0x50-0x54: 5 gems
#define ITEM_CAT_KEY        0x60    // 0x60-0x63: 4 keys
#define ITEM_CAT_MISC       0x70    // 0x70-0x7F: misc items (torch, gold)
```

### 5.3 Item Data Byte (Modifiers)

The `TinyObj.data` byte stores instance-specific information:

| Item Type | Data Usage |
|-----------|------------|
| Weapons/Armor/Shields | Modifier: 0=normal, 1=+1, 2=+2, 3=+3, 0x0F=cursed |
| Gold | Amount (0-255) |
| Torch | Fuel remaining (0-255) |
| Potions/Scrolls | Usually 0 (unidentified flag possible) |

```c
// Modifier extraction macro
#define ITEM_GET_MODIFIER(data)  ((data) & 0x0F)

// Modifier constants
#define ITEM_MOD_NORMAL     0x00
#define ITEM_MOD_PLUS_1     0x01
#define ITEM_MOD_PLUS_2     0x02
#define ITEM_MOD_PLUS_3     0x03
#define ITEM_MOD_CURSED     0x0F
```

### 5.4 Monster Types

```c
enum MonsterType {
    MON_RAT         = 0,    // Weak, fast
    MON_GOBLIN      = 1,    // Basic enemy
    MON_SKELETON    = 2,    // Undead
    MON_ORC         = 3,    // Strong
    MON_ZOMBIE      = 4,    // Slow, tough undead
    MON_TROLL       = 5,    // Regenerates
    MON_GHOST       = 6,    // Undead, life drain
    MON_SPIDER      = 7,    // Poison attack

    MON_BOSS_DEMON  = 8,    // Fire attacks, summons
    MON_BOSS_LICH   = 9,    // Undead mage, life drain
    MON_BOSS_DRAGON = 10,   // Fire breath, massive HP

    MON_TYPE_COUNT  = 11
};
```

### 5.5 Monster States

```c
enum MonsterState {
    MSTATE_IDLE     = 0,    // Standing still
    MSTATE_PATROL   = 1,    // Wandering
    MSTATE_CHASE    = 2,    // Pursuing player
    MSTATE_ATTACK   = 3,    // In combat
    MSTATE_FLEE     = 4,    // Running away
    MSTATE_SLEEP    = 5,    // Sleeping (auto-hit)
    MSTATE_GUARD    = 6,    // Guarding (boss)
    MSTATE_STUNNED  = 7     // Cannot act
};
```

### 5.6 Monster Runtime Flags

```c
// Runtime flags (stored in TinyMon.flags)
#define MFLAG_ALIVE     0x01    // Is alive
#define MFLAG_HOSTILE   0x02    // Hostile to player
#define MFLAG_POISONED  0x04    // Poison DOT active
#define MFLAG_STUNNED   0x08    // Stunned (skip turn)
#define MFLAG_SLEEPING  0x10    // Sleeping (auto-hit)
#define MFLAG_FLEEING   0x20    // Fleeing (from Turn Undead)
#define MFLAG_UNDEAD_VAR 0x40   // Undead variant (Goblin/Troll)
#define MFLAG_RESERVED  0x80    // Reserved
```

### 5.7 Monster Definition Flags (Static)

```c
// Definition flags (stored in MonsterDef.def_flags)
#define MDEF_UNDEAD     0x01    // Affected by Turn Undead, Mace bonus
#define MDEF_DEMON      0x02    // Affected by Holy weapons
#define MDEF_POISON_ATK 0x04    // Attacks can poison (30% chance)
#define MDEF_LIFE_DRAIN 0x08    // Drains HP on hit (heals self)
#define MDEF_REGENERATE 0x10    // Regenerates 2 HP/turn
#define MDEF_FLYING     0x20    // Can fly over pits/traps
#define MDEF_BOSS       0x40    // Boss monster (special mechanics)
#define MDEF_RANGED     0x80    // Has ranged attack (2-3 tiles)
```

---

## 6. Lookup Tables

### 6.1 Weapon Table

```c
typedef struct {
    unsigned char damage;       // Base damage (1-15)
    unsigned char hit_bonus;    // To-hit modifier (0-5)
    unsigned char speed;        // Attack speed (1-15, affects turn order)
    unsigned char crit_chance;  // Critical hit % (0-15)
    unsigned char special;      // Special flags (bitfield)
    unsigned char range;        // Attack range (1=melee, 2-3=ranged)
    unsigned char gold_price;   // Base price
    unsigned char tile_id;      // Display sprite/tile
} WeaponDef; // 8 bytes

// Weapon special flags
#define WEAPON_SPECIAL_NONE         0x00
#define WEAPON_SPECIAL_VS_UNDEAD    0x01  // +3 damage vs undead
#define WEAPON_SPECIAL_VS_DEMON     0x02  // +3 damage vs demon
#define WEAPON_SPECIAL_CLEAVE       0x04  // 25% damage to adjacent enemies
#define WEAPON_SPECIAL_STUN         0x08  // 15% stun chance
#define WEAPON_SPECIAL_LIFE_DRAIN   0x10  // Heal 20% of damage dealt
#define WEAPON_SPECIAL_POISON       0x20  // 30% poison chance
#define WEAPON_SPECIAL_PIERCE_ARMOR 0x40  // Ignore 50% of enemy AC
#define WEAPON_SPECIAL_TWO_HANDED   0x80  // Cannot use shield

// Weapon definitions
// { damage, hit_bonus, speed, crit, special, range, price, tile }
const WeaponDef weapon_table[8] = {
    {  3,  3, 14, 10, WEAPON_SPECIAL_POISON,       1,  10, 0 }, // DAGGER
    {  5,  2, 12,  5, WEAPON_SPECIAL_NONE,         1,  25, 1 }, // SHORT_SWORD
    {  7,  1, 10,  8, WEAPON_SPECIAL_NONE,         1,  50, 2 }, // LONG_SWORD
    { 10,  0,  6, 12, WEAPON_SPECIAL_CLEAVE | WEAPON_SPECIAL_TWO_HANDED, 1, 80, 3 }, // BATTLE_AXE
    {  6,  1, 10,  5, WEAPON_SPECIAL_VS_UNDEAD | WEAPON_SPECIAL_STUN, 1, 40, 4 },    // MACE
    {  5,  2, 11,  6, WEAPON_SPECIAL_PIERCE_ARMOR, 2,  35, 5 }, // SPEAR
    {  4,  3, 12,  8, WEAPON_SPECIAL_NONE,         3,  60, 6 }, // BOW
    {  8,  2, 13, 15, WEAPON_SPECIAL_LIFE_DRAIN | WEAPON_SPECIAL_VS_DEMON, 1, 100, 7 }, // CURSED_BLADE
};
```

### 6.2 Armor Table

```c
typedef struct {
    unsigned char armor_class;  // AC bonus (1-10)
    unsigned char weight;       // Weight class (0-3, affects movement)
    unsigned char special;      // Special properties
    unsigned char gold_price;   // Base price
    unsigned char tile_id;      // Display sprite/tile
} ArmorDef; // 5 bytes

// Armor special flags
#define ARMOR_SPECIAL_NONE          0x00
#define ARMOR_SPECIAL_FIRE_RESIST   0x01  // -50% fire damage
#define ARMOR_SPECIAL_POISON_IMMUNE 0x02  // Immune to poison
#define ARMOR_SPECIAL_MAGIC_RESIST  0x04  // -25% magic damage
#define ARMOR_SPECIAL_STEALTH       0x08  // +20% stealth

// Weight system: affects movement speed
// Weight 0: No penalty
// Weight 1: -10% movement speed
// Weight 2: -20% movement speed
// Weight 3: -30% movement speed

// Armor definitions
// { AC, weight, special, price, tile }
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
```

### 6.3 Shield Table

```c
typedef struct {
    unsigned char defense;       // AC bonus (1-5)
    unsigned char block_chance;  // % chance to block (10-35%)
    unsigned char special;       // Special properties
    unsigned char gold_price;    // Base price
    unsigned char tile_id;       // Display sprite/tile
} ShieldDef; // 5 bytes

// Shield special flags
#define SHIELD_SPECIAL_NONE         0x00
#define SHIELD_SPECIAL_BASH         0x01  // Can shield bash (stun + 1 dmg)
#define SHIELD_SPECIAL_SPELL_BLOCK  0x02  // 30% chance block magic
#define SHIELD_SPECIAL_REFLECT      0x04  // 15% chance reflect arrows

// Shield definitions
// { defense, block%, special, price, tile }
const ShieldDef shield_table[5] = {
    { 1, 10, SHIELD_SPECIAL_NONE,        15, 16 }, // BUCKLER
    { 2, 15, SHIELD_SPECIAL_BASH,        30, 17 }, // ROUND_SHIELD
    { 3, 20, SHIELD_SPECIAL_NONE,        50, 18 }, // KITE_SHIELD
    { 4, 25, SHIELD_SPECIAL_SPELL_BLOCK, 80, 19 }, // TOWER_SHIELD
    { 5, 30, SHIELD_SPECIAL_REFLECT,    150, 20 }, // MIRROR_SHIELD
};
```

### 6.4 Scroll Table

```c
typedef struct {
    unsigned char effect_type;  // Effect enum
    unsigned char magnitude;    // Effect strength (damage, radius, etc.)
    unsigned char duration;     // Duration in turns (0 = instant)
    unsigned char special;      // Special flags
    unsigned char gold_price;   // Base price
    unsigned char tile_id;      // Display sprite/tile
} ScrollDef; // 6 bytes

// Scroll effect types
enum ScrollEffect {
    EFFECT_LIGHT         = 0,   // Light aura
    EFFECT_MAP_REVEAL    = 1,   // Reveal entire map
    EFFECT_DETECT_SECRET = 2,   // Reveal secret doors/traps
    EFFECT_TELEPORT      = 3,   // Random safe teleport
    EFFECT_IDENTIFY      = 4,   // Identify item
    EFFECT_ENCHANT_WEAPON= 5,   // +1 weapon modifier
    EFFECT_ENCHANT_ARMOR = 6,   // +1 armor modifier
    EFFECT_REMOVE_CURSE  = 7,   // Remove curse from item
    EFFECT_SUMMON_ENEMY  = 8,   // CURSED: spawn enemy
    EFFECT_BREAK_WALLS   = 9,   // Earthquake (3x3 area)
    EFFECT_TURN_UNDEAD   = 10,  // Kill/flee undead
    EFFECT_FIREBALL      = 11,  // Area fire damage
    EFFECT_HASTE         = 12,  // Speed buff
    EFFECT_SHIELD_BUFF   = 13,  // AC buff
};

// Scroll definitions
// { effect, magnitude, duration, special, price, tile }
const ScrollDef scroll_table[14] = {
    { EFFECT_LIGHT,          5,  50, 0,  10, 40 }, // SCROLL_LIGHT
    { EFFECT_MAP_REVEAL,     0,   0, 0,  50, 41 }, // SCROLL_MAGIC_MAPPING
    { EFFECT_DETECT_SECRET,  0,   0, 0,  30, 42 }, // SCROLL_DETECT_SECRET
    { EFFECT_TELEPORT,       0,   0, 0,  25, 43 }, // SCROLL_TELEPORT
    { EFFECT_IDENTIFY,       1,   0, 0,  40, 44 }, // SCROLL_IDENTIFY
    { EFFECT_ENCHANT_WEAPON, 1,   0, 0,  80, 45 }, // SCROLL_ENCHANT_WEAPON
    { EFFECT_ENCHANT_ARMOR,  1,   0, 0,  80, 46 }, // SCROLL_ENCHANT_ARMOR
    { EFFECT_REMOVE_CURSE,   0,   0, 0,  60, 47 }, // SCROLL_REMOVE_CURSE
    { EFFECT_SUMMON_ENEMY,   1,   0, 1,   0, 48 }, // SCROLL_SUMMON (cursed)
    { EFFECT_BREAK_WALLS,    1,   0, 0, 100, 49 }, // SCROLL_EARTHQUAKE
    { EFFECT_TURN_UNDEAD,   10,   0, 0,  70, 50 }, // SCROLL_TURN_UNDEAD
    { EFFECT_FIREBALL,      12,   0, 0,  60, 51 }, // SCROLL_FIREBALL
    { EFFECT_HASTE,          0,  10, 0,  50, 52 }, // SCROLL_HASTE
    { EFFECT_SHIELD_BUFF,    3,   5, 0,  40, 53 }, // SCROLL_SHIELD
};
```

### 6.5 Potion Table

```c
typedef struct {
    unsigned char effect_type;  // Effect enum
    unsigned char magnitude;    // Effect strength
    unsigned char duration;     // Duration in turns (0 = instant)
    unsigned char special;      // Special flags
    unsigned char gold_price;   // Base price
    unsigned char tile_id;      // Display sprite/tile
} PotionDef; // 6 bytes

// Potion effect types (reuses some scroll effects)
enum PotionEffect {
    EFFECT_HEAL         = 0,    // Restore HP
    EFFECT_FULL_HEAL    = 1,    // Restore to max HP
    EFFECT_BERSERK      = 2,    // +50% damage, -20% AC
    EFFECT_REGEN        = 3,    // Heal over time
    EFFECT_CURE_POISON  = 4,    // Remove poison
    EFFECT_INVISIBLE    = 5,    // Invisibility
};

// Potion definitions
// { effect, magnitude, duration, special, price, tile }
const PotionDef potion_table[6] = {
    { EFFECT_HEAL,        15,   0, 0, 20, 54 }, // POTION_HEAL (+15 HP)
    { EFFECT_FULL_HEAL,  255,   0, 0, 80, 55 }, // POTION_FULL_HEAL
    { EFFECT_BERSERK,      0,  10, 0, 40, 56 }, // POTION_STRENGTH
    { EFFECT_REGEN,        2,  10, 0, 40, 57 }, // POTION_DEFENSE (+2 HP/turn)
    { EFFECT_CURE_POISON,  0,   0, 0, 30, 58 }, // POTION_CURE_POISON
    { EFFECT_INVISIBLE,    0,  15, 0, 60, 59 }, // POTION_INVISIBILITY
};
```

### 6.6 Monster Table

```c
typedef struct {
    unsigned char base_hp;      // Base hit points
    unsigned char damage;       // Base damage
    unsigned char defense;      // Defense value (reduces hit chance)
    unsigned char armor_class;  // AC (reduces damage)
    unsigned char xp_value;     // XP awarded on kill
    unsigned char def_flags;    // Definition flags (MDEF_*)
    unsigned char sprite_id;    // Display sprite
    unsigned char ai_type;      // AI behavior type
} MonsterDef; // 8 bytes

// AI types
enum AIType {
    AI_SIMPLE_CHASE = 0,    // Direct chase, no pathing
    AI_SMART_CHASE  = 1,    // Chase with obstacle avoidance
    AI_SLOW_CHASE   = 2,    // Slow movement (Zombie)
    AI_BOSS         = 3,    // Boss AI with special attacks
};

// Monster definitions
// { hp, dmg, def, ac, xp, flags, sprite, ai }
const MonsterDef monster_table[11] = {
    {  4,  2, 0, 0,   5, 0,                                      0, AI_SIMPLE_CHASE }, // RAT
    {  8,  3, 1, 1,  10, 0,                                      1, AI_SIMPLE_CHASE }, // GOBLIN
    { 10,  4, 1, 2,  15, MDEF_UNDEAD,                            2, AI_SIMPLE_CHASE }, // SKELETON
    { 15,  5, 2, 3,  25, 0,                                      3, AI_SMART_CHASE  }, // ORC
    { 18,  4, 1, 2,  20, MDEF_UNDEAD | MDEF_REGENERATE,          4, AI_SLOW_CHASE   }, // ZOMBIE
    { 25,  6, 2, 4,  40, MDEF_REGENERATE,                        5, AI_SMART_CHASE  }, // TROLL
    { 12,  5, 3, 5,  30, MDEF_UNDEAD | MDEF_LIFE_DRAIN | MDEF_FLYING, 6, AI_SMART_CHASE }, // GHOST
    { 10,  3, 1, 2,  15, MDEF_POISON_ATK,                        7, AI_SIMPLE_CHASE }, // SPIDER
    { 50,  8, 3, 6, 100, MDEF_BOSS | MDEF_DEMON | MDEF_RANGED,   8, AI_BOSS         }, // DEMON
    { 40,  7, 4, 7, 120, MDEF_BOSS | MDEF_UNDEAD | MDEF_LIFE_DRAIN | MDEF_RANGED, 9, AI_BOSS }, // LICH
    { 80, 10, 3, 8, 200, MDEF_BOSS | MDEF_FLYING | MDEF_RANGED, 10, AI_BOSS         }, // DRAGON
};
```

---

## 7. Combat Data Structures

### 7.1 Player Status Effects

```c
// Status effect flags (16-bit bitfield)
#define STATUS_NONE         0x0000
#define STATUS_POISONED     0x0001  // -3 HP/turn
#define STATUS_HASTE        0x0002  // +50% speed, +10% hit
#define STATUS_SHIELD_BUFF  0x0004  // +3 AC
#define STATUS_BERSERK      0x0008  // +50% damage, -20% AC
#define STATUS_INVISIBLE    0x0010  // 50% avoid combat
#define STATUS_BLESSED      0x0020  // +2 to all rolls
#define STATUS_CURSED       0x0040  // -2 to all rolls
#define STATUS_STUNNED      0x0080  // Skip next turn
#define STATUS_BLIND        0x0100  // -20% hit chance
#define STATUS_REGENERATING 0x0200  // +2 HP/turn
#define STATUS_FIRE_SHIELD  0x0400  // Reflect 3 damage
#define STATUS_CONFUSED     0x0800  // 50% random movement
```

### 7.2 Status Duration Tracking

```c
typedef struct {
    unsigned char poison_turns;      // 0-255
    unsigned char haste_turns;       // 0-255
    unsigned char shield_turns;      // 0-255
    unsigned char berserk_turns;     // 0-255
    unsigned char invis_turns;       // 0-255
    unsigned char blessed_turns;     // 0-255
    unsigned char cursed_turns;      // 0-255
    unsigned char regen_turns;       // 0-255
    unsigned char fire_shield_turns; // 0-255
    unsigned char confused_turns;    // 0-255
} StatusTimers; // 10 bytes
```

### 7.3 Boss AI State

```c
typedef struct {
    unsigned char cooldown;          // Turns between special attacks
    unsigned char attack_type;       // Current special attack
    unsigned char current_cooldown;  // Countdown to next special
} BossAI; // 3 bytes per boss

// Boss special attack types
#define BOSS_ATK_FIREBALL      0  // 3x3 area fire damage (Dragon)
#define BOSS_ATK_SUMMON_ADDS   1  // Summon 2 minions (Demon)
#define BOSS_ATK_LIFE_DRAIN    2  // Drain 10 HP, heal self (Lich)
#define BOSS_ATK_POISON_CLOUD  3  // 5x5 poison cloud
#define BOSS_ATK_TELEPORT      4  // Teleport away + heal
```

---

## 8. API Reference

### 8.1 Initialization

```c
void init_tmea_system(void);   // Call once at startup
void reset_tmea_data(void);    // Call before each new dungeon
```

### 8.2 Tile Metadata

```c
// Add/get/remove metadata
unsigned char add_tile_metadata(x, y, flags, data);
unsigned char get_tile_metadata(x, y, *out_flags, *out_data);
unsigned char remove_tile_metadata(x, y);
unsigned char update_tile_metadata_flags(x, y, flags);
unsigned char update_tile_metadata_data(x, y, data);

// Door convenience functions
unsigned char add_secret_door_metadata(x, y);
unsigned char is_door_secret(x, y);
unsigned char is_door_locked(x, y);
unsigned char is_door_trapped(x, y);
unsigned char reveal_secret_door(x, y);
unsigned char set_door_open(x, y, is_open);
```

### 8.3 Entity Functions

```c
// Objects
TinyObj* spawn_object(x, y, obj_type);
void despawn_object(TinyObj *obj);
TinyObj* get_objects_at(x, y);

// Monsters
TinyMon* spawn_monster(x, y, mon_type, hp);
void despawn_monster(TinyMon *mon);
TinyMon* get_monster_at(x, y);
```

### 8.4 Lookup Functions

```c
// Get definitions by type
const WeaponDef* get_weapon_def(unsigned char weapon_type);
const ArmorDef* get_armor_def(unsigned char armor_type);
const ShieldDef* get_shield_def(unsigned char shield_type);
const ScrollDef* get_scroll_def(unsigned char scroll_type);
const PotionDef* get_potion_def(unsigned char potion_type);
const MonsterDef* get_monster_def(unsigned char mon_type);
```

---

## 9. Usage Examples

### 9.1 Spawning Items with Modifiers

```c
// Spawn a +1 Long Sword
TinyObj* sword = spawn_object(x, y, ITEM_LONG_SWORD);
if (sword) {
    sword->data = ITEM_MOD_PLUS_1;
}

// Spawn gold (50 pieces)
TinyObj* gold = spawn_object(x, y, ITEM_GOLD);
if (gold) {
    gold->data = 50;  // Amount
}

// Spawn cursed armor
TinyObj* armor = spawn_object(x, y, ITEM_PLATE_MAIL);
if (armor) {
    armor->data = ITEM_MOD_CURSED;
}
```

### 9.2 Spawning Monsters

```c
// Spawn skeleton with lookup table HP
const MonsterDef* def = get_monster_def(MON_SKELETON);
TinyMon* skeleton = spawn_monster(x, y, MON_SKELETON, def->base_hp);
if (skeleton) {
    skeleton->state = MSTATE_PATROL;
    skeleton->flags = MFLAG_ALIVE | MFLAG_HOSTILE;
}

// Spawn undead variant goblin (30% chance)
const MonsterDef* gdef = get_monster_def(MON_GOBLIN);
TinyMon* goblin = spawn_monster(x, y, MON_GOBLIN, gdef->base_hp);
if (goblin) {
    if (rnd(100) < 30) {
        goblin->flags |= MFLAG_UNDEAD_VAR;
        goblin->hp += 5;  // Slightly stronger
    }
}
```

### 9.3 Combat Using Lookup Tables

```c
unsigned char calculate_player_damage(Player* player, TinyMon* enemy) {
    const WeaponDef* weapon = get_weapon_def(player->weapon_type);
    const MonsterDef* mdef = get_monster_def(enemy->type);

    // Base weapon damage
    unsigned char damage = weapon->damage;

    // Add modifier (+1/+2/+3)
    unsigned char mod = ITEM_GET_MODIFIER(player->weapon_data);
    if (mod >= 1 && mod <= 3) {
        damage += mod;
    }

    // STR bonus (+1 per 2 STR above 10)
    if (player->str > 10) {
        damage += (player->str - 10) / 2;
    }

    // Weapon special vs undead
    if (weapon->special & WEAPON_SPECIAL_VS_UNDEAD) {
        if ((mdef->def_flags & MDEF_UNDEAD) || (enemy->flags & MFLAG_UNDEAD_VAR)) {
            damage += 3;
        }
    }

    // Critical hit check
    unsigned char crit_chance = 5 + weapon->crit_chance;
    if (rnd(100) < crit_chance) {
        damage *= 2;
    }

    // Minimum 1 damage
    if (damage < 1) damage = 1;

    return damage;
}
```

### 9.4 Shield Block Check

```c
unsigned char check_shield_block(Player* player) {
    if (player->shield_type == ITEM_NONE) return 0;

    const ShieldDef* shield = get_shield_def(player->shield_type);
    unsigned char block_chance = shield->block_chance;

    // DEX bonus to block (+1% per DEX above 12)
    if (player->dex > 12) {
        block_chance += (player->dex - 12);
    }

    // Shield modifier bonus (+5% per +1)
    unsigned char mod = ITEM_GET_MODIFIER(player->shield_data);
    if (mod >= 1 && mod <= 3) {
        block_chance += mod * 5;
    }

    // Roll for block
    if (rnd(100) < block_chance) {
        // Check for shield bash counter-attack
        if (shield->special & SHIELD_SPECIAL_BASH) {
            // Stun attacker, deal 1 damage
        }
        return 1;  // Blocked
    }

    return 0;  // Not blocked
}
```

### 9.5 Using Scroll of Turn Undead

```c
void use_scroll_turn_undead(void) {
    TinyMon* mon = mon_active_list;

    while (mon) {
        TinyMon* next = mon->next;

        const MonsterDef* def = get_monster_def(mon->type);
        unsigned char is_undead = (def->def_flags & MDEF_UNDEAD) ||
                                  (mon->flags & MFLAG_UNDEAD_VAR);

        if (is_undead && is_visible(mon->x, mon->y)) {
            if (mon->hp < 20) {
                // Weak undead: destroy
                despawn_monster(mon);
            } else {
                // Strong undead: flee
                mon->state = MSTATE_FLEE;
                mon->flags |= MFLAG_FLEEING;
            }
        }

        mon = next;
    }
}
```

---

## 10. Performance Analysis

### 10.1 Cycle Counts

| Operation | Cycles | Time @ 1MHz |
|-----------|--------|-------------|
| add_tile_metadata (room) | ~240 | 0.24ms |
| add_tile_metadata (global) | ~230 | 0.23ms |
| get_tile_metadata (room) | ~260 | 0.26ms |
| get_tile_metadata (global) | ~440 | 0.44ms |
| Quick reject (no metadata) | ~50 | 0.05ms |
| spawn_object | ~90 | 0.09ms |
| spawn_monster | ~90 | 0.09ms |
| get_weapon_def | ~30 | 0.03ms |
| get_monster_def | ~30 | 0.03ms |

### 10.2 Weighted Average

```
70% room lookups:   0.26ms x 0.70 = 0.18ms
30% global lookups: 0.44ms x 0.30 = 0.13ms
                                   -------
WEIGHTED AVERAGE:                  ~0.31ms
```

### 10.3 Memory Efficiency Summary

```
+=====================================================+
| TMEA v4 TOTAL MEMORY                                |
+=====================================================+
| RAM (runtime data):                                 |
| +-- Tile metadata pools:            325 bytes       |
| +-- Entity pools:                   344 bytes       |
| +-- Combat state:                    19 bytes       |
|                                   ---------         |
| RAM TOTAL:                         ~640 bytes       |
+=====================================================+
| ROM (const lookup tables):                          |
| +-- weapon_table[8]:                 64 bytes       |
| +-- armor_table[8]:                  40 bytes       |
| +-- shield_table[5]:                 25 bytes       |
| +-- scroll_table[14]:                84 bytes       |
| +-- potion_table[6]:                 36 bytes       |
| +-- monster_table[11]:               88 bytes       |
|                                   ---------         |
| ROM TOTAL:                         ~340 bytes       |
+=====================================================+
```

---

## Files

| File | Purpose |
|------|---------|
| `tmea_types.h` | Type definitions, enums, constants |
| `tmea_core.h` | API declarations |
| `tmea_core.c` | Implementation |
| `tmea_data.h` | Lookup table declarations |
| `tmea_data.c` | Lookup table data |
