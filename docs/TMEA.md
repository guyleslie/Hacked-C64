# TMEA: Tile Metadata Extension Architecture

**Version:** 3.0
**Target Platform:** Commodore 64 (6502 @ 1MHz, 64KB RAM)
**Compiler:** Oscar64 cross-compiler
**Memory Overhead:** ~620 bytes RAM + ~200 bytes ROM (lookup tables)

---

## Table of Contents

1. [Overview](#1-overview)
2. [Architecture Philosophy](#2-architecture-philosophy)
3. [Core Concepts](#3-core-concepts)
4. [Memory Layout](#4-memory-layout)
5. [Type System](#5-type-system)
6. [Lookup Tables](#6-lookup-tables)
7. [API Reference](#7-api-reference)
8. [Usage Examples](#8-usage-examples)
9. [Performance Analysis](#9-performance-analysis)

---

## 1. Overview

### 1.1 What is TMEA?

**TMEA (Tile Metadata Extension Architecture)** is a lightweight metadata and entity system designed for the C64 dungeon crawler. It provides:

- **Tile metadata** - Extra information for walls, doors, floors (secret, locked, trapped, etc.)
- **Entity pools** - Objects (items) and monsters with minimal memory footprint
- **Lookup tables** - Static data for items/monsters stored in ROM (const)

### 1.2 Design Goals

```
✓ Minimal RAM Footprint:   ~620 bytes runtime data
✓ ROM Lookup Tables:       ~200 bytes const data (items, monsters)
✓ Fast Lookups:            ~0.31ms average
✓ Data-Oriented Design:    Static properties in ROM, dynamic state in RAM
✓ Room-Aware:              Optimized for room-based dungeon generation
✓ Sprite-Limited:          Max 6 monsters (C64 sprite constraint)
```

### 1.3 v3 Changes from v2

| Feature | v2 | v3 |
|---------|----|----|
| Monster pool | 24 slots (144 bytes) | 6 slots (48 bytes) |
| TinyMon size | 6 bytes (bitfields) | 8 bytes (clean struct) |
| TinyObj flags | 8-bit flags field | Removed (not needed) |
| Item types | Generic (OBJ_TYPE_WEAPON) | Specific (ITEM_LONG_SWORD) |
| Item encoding | Simple enum | CCCC_SSSS (category+subtype) |
| Lookup tables | None | ItemDef, MonsterDef |
| Total RAM | 765 bytes | ~620 bytes |

---

## 2. Architecture Philosophy

### 2.1 Data-Oriented Design

```
┌─────────────────────────────────────────────────────────┐
│ STATIC DATA (ROM/const)          DYNAMIC DATA (RAM)     │
│ ─────────────────────────        ──────────────────     │
│ MonsterDef table:                TinyMon pool:          │
│   - base_hp                        - x, y (position)    │
│   - damage                         - hp (current)       │
│   - xp_value                       - flags (status)     │
│   - def_flags (UNDEAD, etc.)       - state (AI)         │
│   - sprite_id                      - type (table index) │
│                                                         │
│ ItemDef tables:                  TinyObj pool:          │
│   - base_value                     - x, y (position)    │
│   - gold_price                     - type (table index) │
│   - tile_id                        - data (modifier)    │
│                                                         │
│ COST: 0 RAM (const)              COST: 6-8 bytes/entity │
└─────────────────────────────────────────────────────────┘
```

**Key Insight:** Static properties (damage, defense, XP) are stored once in lookup tables. Runtime structs only hold instance-specific data (position, current HP, status).

### 2.2 Room-First, Global-Fallback

```
┌──────────────────────────────────────────────────┐
│ TILE METADATA ROUTING                            │
├──────────────────────────────────────────────────┤
│ 1. ROOM-BASED POOL (Primary, 70% of map)         │
│    ├─ 4 slots per room × 20 rooms = 80 max       │
│    ├─ Compact: Room-local coords (4+4 bits)      │
│    └─ Fast: O(4) linear search per room          │
│                                                  │
│ 2. GLOBAL POOL (Fallback, 30% of map)            │
│    ├─ 16 slots for corridors                     │
│    ├─ Global coords (8+8 bits)                   │
│    └─ O(16) linear search                        │
│                                                  │
│ → API auto-routes to best pool                   │
└──────────────────────────────────────────────────┘
```

---

## 3. Core Concepts

### 3.1 The Three Data Layers

```
┌─────────────────────────────────────────────────┐
│ LAYER 0: Compact Map (3-bit tiles)              │
│ ├─ compact_map[2400]: Base tile types           │
│ ├─ TILE_MARKER (7): Metadata presence flag      │
│ └─ Unchanged from previous versions             │
├─────────────────────────────────────────────────┤
│ LAYER 1: Tile Metadata (~325 bytes)             │
│ ├─ Room pool: 20 rooms × 4 slots × 3 bytes      │
│ ├─ Global pool: 16 slots × 4 bytes              │
│ └─ For doors, traps, special tiles              │
├─────────────────────────────────────────────────┤
│ LAYER 2: Entity Pools (~340 bytes)              │
│ ├─ TinyObj[48]: Items on ground (6 bytes each)  │
│ ├─ TinyMon[6]: Active monsters (8 bytes each)   │
│ └─ Linked list management                       │
├─────────────────────────────────────────────────┤
│ LAYER 3: Lookup Tables (~200 bytes ROM)         │
│ ├─ monster_table[11]: Monster definitions       │
│ ├─ weapon_table[8], armor_table[8], etc.        │
│ └─ Const data, zero RAM cost                    │
└─────────────────────────────────────────────────┘
```

---

## 4. Memory Layout

### 4.1 Complete Memory Map

```
╔═══════════════════════════════════════════════════╗
║ TMEA v3 MEMORY ALLOCATION                         ║
╠═══════════════════════════════════════════════════╣
║ TILE METADATA (RAM)                               ║
║ ├─ room_metas[20][4]:                  240 bytes  ║
║ ├─ room_meta_count[20]:                 20 bytes  ║
║ ├─ global_metas[16]:                    64 bytes  ║
║ └─ global_meta_count:                    1 byte   ║
║                                        ────────   ║
║ Metadata Subtotal:                     325 bytes  ║
╠═══════════════════════════════════════════════════╣
║ ENTITY POOLS (RAM)                                ║
║ ├─ obj_pool[48] (TinyObj, 6 bytes):    288 bytes  ║
║ ├─ obj_free_list, obj_active_list:       4 bytes  ║
║ ├─ mon_pool[6] (TinyMon, 8 bytes):      48 bytes  ║
║ └─ mon_free_list, mon_active_list:       4 bytes  ║
║                                        ────────   ║
║ Entity Subtotal:                       344 bytes  ║
╠═══════════════════════════════════════════════════╣
║ TMEA RAM TOTAL:                       ~620 bytes  ║
╠═══════════════════════════════════════════════════╣
║ LOOKUP TABLES (ROM/const)                         ║
║ ├─ monster_table[11]:                   55 bytes  ║
║ ├─ weapon_table[8]:                     24 bytes  ║
║ ├─ armor_table[8]:                      24 bytes  ║
║ ├─ shield_table[5]:                     15 bytes  ║
║ ├─ potion_table[6]:                     18 bytes  ║
║ ├─ scroll_table[14]:                    42 bytes  ║
║ ├─ gem_table[5]:                        15 bytes  ║
║ ├─ key_table[4]:                        12 bytes  ║
║ └─ misc_table[4]:                       12 bytes  ║
║                                        ────────   ║
║ Lookup Subtotal:                      ~217 bytes  ║
╚═══════════════════════════════════════════════════╝
```

### 4.2 Structure Sizes

| Structure | Size | Count | Total | Purpose |
|-----------|------|-------|-------|---------|
| **RoomTileMeta** | 3 bytes | 80 | 240 bytes | Room tile metadata |
| **GlobalTileMeta** | 4 bytes | 16 | 64 bytes | Corridor metadata |
| **TinyObj** | 6 bytes | 48 | 288 bytes | Items on ground |
| **TinyMon** | 8 bytes | 6 | 48 bytes | Active monsters |
| **ItemDef** | 3 bytes | ~50 | ~150 bytes | Item lookup (ROM) |
| **MonsterDef** | 5 bytes | 11 | 55 bytes | Monster lookup (ROM) |

---

## 5. Type System

### 5.1 Item Type Encoding (CCCC_SSSS)

Items use an 8-bit type with embedded category:

```
Bit Layout: CCCCSSSS
            ││││││││
            ││││└└└└─ Subtype (4 bits, 0-15 per category)
            └└└└───── Category (4 bits, 0-15 categories)

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
#define ITEM_CAT_MISC       0x70    // 0x70-0x7F: misc items
```

### 5.3 Item Data Byte

The `TinyObj.data` byte stores instance-specific information:

| Item Type | Data Usage |
|-----------|------------|
| Weapons/Armor/Shields | Modifier: 0=normal, 1=+1, 2=+2, 3=+3, 15=cursed |
| Gold | Amount (0-255) |
| Torch | Fuel remaining (0-255) |
| Potions/Scrolls | Usually 0 |

```c
#define ITEM_MOD_NORMAL     0x00
#define ITEM_MOD_PLUS_1     0x10
#define ITEM_MOD_PLUS_2     0x20
#define ITEM_MOD_PLUS_3     0x30
#define ITEM_MOD_CURSED     0xF0
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

    MON_BOSS_DEMON  = 8,    // Fire attacks
    MON_BOSS_LICH   = 9,    // Undead mage
    MON_BOSS_DRAGON = 10,   // Final boss

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
    MSTATE_SLEEP    = 5,    // Sleeping
    MSTATE_GUARD    = 6,    // Guarding (boss)
    MSTATE_STUNNED  = 7     // Cannot act
};
```

### 5.6 Monster Runtime Flags

```c
enum MonsterRuntimeFlags {
    MFLAG_ALIVE     = 0x01,   // Is alive
    MFLAG_HOSTILE   = 0x02,   // Hostile to player
    MFLAG_POISONED  = 0x04,   // Poison DOT
    MFLAG_BURNING   = 0x08,   // Fire DOT
    MFLAG_FROZEN    = 0x10,   // Slowed
    MFLAG_CONFUSED  = 0x20,   // Random movement
    MFLAG_INVISIBLE = 0x40,   // Hidden
    MFLAG_UNDEAD_VAR= 0x80    // Undead variant
};
```

### 5.7 Monster Definition Flags (Static)

```c
#define MDEF_UNDEAD     0x01    // Affected by Turn Undead
#define MDEF_BOSS       0x02    // Boss monster
#define MDEF_FLYING     0x04    // Ignores floor traps
#define MDEF_MAGIC_RES  0x08    // Magic resistance
#define MDEF_POISON_ATK 0x10    // Attacks can poison
#define MDEF_REGEN      0x20    // Regenerates HP
#define MDEF_LIFE_DRAIN 0x40    // Steals HP on hit
```

---

## 6. Lookup Tables

### 6.1 Monster Table

```c
// { base_hp, damage, xp_value, def_flags, sprite_id }
const MonsterDef monster_table[MON_TYPE_COUNT] = {
    {  4,  1,   3, 0,                            0 },  // RAT
    {  8,  2,   8, 0,                            1 },  // GOBLIN
    { 10,  3,  12, MDEF_UNDEAD,                  2 },  // SKELETON
    { 15,  4,  18, 0,                            3 },  // ORC
    { 20,  3,  15, MDEF_UNDEAD,                  4 },  // ZOMBIE
    { 25,  5,  25, MDEF_REGEN,                   5 },  // TROLL
    { 12,  4,  20, MDEF_UNDEAD|MDEF_LIFE_DRAIN,  6 },  // GHOST
    {  8,  2,  10, MDEF_POISON_ATK,              7 },  // SPIDER
    { 40,  8,  50, MDEF_BOSS,                    8 },  // DEMON
    { 35,  6,  60, MDEF_BOSS|MDEF_UNDEAD,        9 },  // LICH
    { 60, 10, 100, MDEF_BOSS|MDEF_FLYING,       10 },  // DRAGON
};
```

### 6.2 Item Tables

```c
// { base_value, gold_price, tile_id }

const ItemDef weapon_table[8] = {
    { 2,   5, 0 },  // DAGGER
    { 4,  15, 1 },  // SHORT_SWORD
    { 6,  30, 2 },  // LONG_SWORD
    { 8,  40, 3 },  // AXE
    { 5,  25, 4 },  // MACE
    { 5,  20, 5 },  // SPEAR
    { 4,  35, 6 },  // BOW
    { 3,  10, 7 },  // STAFF
};

const ItemDef armor_table[8] = {
    { 1,   5, 8 },  // CLOTH
    { 2,  15, 9 },  // LEATHER
    { 3,  30, 10 }, // STUDDED
    { 4,  50, 11 }, // CHAIN
    { 5,  75, 12 }, // SCALE
    { 7, 120, 13 }, // PLATE
    { 1,  20, 14 }, // ROBE
    { 1,  25, 15 }, // CLOAK
};
```

### 6.3 Lookup Functions

```c
// Get item definition by type
const ItemDef* get_item_def(unsigned char item_type);

// Get monster definition by type
const MonsterDef* get_monster_def(unsigned char mon_type);
```

**Usage:**
```c
// Get weapon damage
const ItemDef* def = get_item_def(ITEM_LONG_SWORD);
unsigned char base_damage = def->base_value;  // 6

// Check if monster is undead
const MonsterDef* mdef = get_monster_def(MON_SKELETON);
if (mdef->def_flags & MDEF_UNDEAD) {
    // Apply Turn Undead effect
}
```

---

## 7. API Reference

### 7.1 Initialization

```c
void init_tmea_system(void);   // Call once at startup
void reset_tmea_data(void);    // Call before each new dungeon
```

### 7.2 Tile Metadata

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

### 7.3 Entity Functions

```c
// Objects
TinyObj* spawn_object(x, y, obj_type);
void despawn_object(TinyObj *obj);
TinyObj* get_objects_at(x, y);

// Monsters
TinyMon* spawn_monster(x, y, mon_type, hp);
void despawn_monster(TinyMon *mon);
TinyMon* get_monster_at(x, y);

// Lookup
const ItemDef* get_item_def(unsigned char item_type);
const MonsterDef* get_monster_def(unsigned char mon_type);
```

---

## 8. Usage Examples

### 8.1 Spawning Items

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

// Spawn heal potion
spawn_object(x, y, ITEM_POTION_HEAL);
```

### 8.2 Spawning Monsters

```c
// Spawn skeleton with lookup table HP
const MonsterDef* def = get_monster_def(MON_SKELETON);
TinyMon* skeleton = spawn_monster(x, y, MON_SKELETON, def->base_hp);
if (skeleton) {
    skeleton->state = MSTATE_PATROL;
}

// Spawn sleeping dragon (boss)
const MonsterDef* dragon_def = get_monster_def(MON_BOSS_DRAGON);
TinyMon* dragon = spawn_monster(x, y, MON_BOSS_DRAGON, dragon_def->base_hp);
if (dragon) {
    dragon->state = MSTATE_SLEEP;
}
```

### 8.3 Combat Using Lookup Tables

```c
void player_attack_monster(TinyMon* mon) {
    // Get weapon damage from lookup
    const ItemDef* weapon = get_item_def(player_weapon_type);
    unsigned char damage = weapon->base_value;

    // Add modifier from player's weapon data byte
    unsigned char mod = ITEM_GET_MODIFIER(player_weapon_data);
    if (mod >= 1 && mod <= 3) {
        damage += mod;  // +1, +2, or +3
    }

    // Check for mace vs undead bonus
    const MonsterDef* mdef = get_monster_def(mon->type);
    if (player_weapon_type == ITEM_MACE && (mdef->def_flags & MDEF_UNDEAD)) {
        damage += 2;  // Bonus vs undead
    }

    // Apply damage
    if (mon->hp <= damage) {
        // Monster dies
        unsigned char xp = mdef->xp_value;
        player_gain_xp(xp);
        despawn_monster(mon);
    } else {
        mon->hp -= damage;
    }
}
```

### 8.4 Turn Undead Scroll

```c
void use_turn_undead_scroll(void) {
    TinyMon* mon = mon_active_list;

    while (mon) {
        TinyMon* next = mon->next;  // Save next before potential despawn

        const MonsterDef* def = get_monster_def(mon->type);
        if (def->def_flags & MDEF_UNDEAD) {
            // Undead flees for FLEE_DURATION_TURNS
            mon->state = MSTATE_FLEE;
            mon->flags &= ~MFLAG_HOSTILE;  // Temporarily not hostile
        }

        mon = next;
    }
}
```

---

## 9. Performance Analysis

### 9.1 Cycle Counts

| Operation | Cycles | Time @ 1MHz |
|-----------|--------|-------------|
| add_tile_metadata (room) | ~240 | 0.24ms |
| add_tile_metadata (global) | ~230 | 0.23ms |
| get_tile_metadata (room) | ~260 | 0.26ms |
| get_tile_metadata (global) | ~440 | 0.44ms |
| Quick reject (no metadata) | ~50 | 0.05ms |
| spawn_object | ~90 | 0.09ms |
| spawn_monster | ~90 | 0.09ms |
| get_item_def | ~30 | 0.03ms |
| get_monster_def | ~20 | 0.02ms |

### 9.2 Weighted Average

```
70% room lookups:   0.26ms × 0.70 = 0.18ms
30% global lookups: 0.44ms × 0.30 = 0.13ms
                                   ───────
WEIGHTED AVERAGE:                  ~0.31ms
```

### 9.3 Memory Efficiency

| Component | v2 | v3 | Change |
|-----------|----|----|--------|
| Monster pool | 144 bytes | 48 bytes | -96 bytes |
| Total RAM | 765 bytes | ~620 bytes | -145 bytes |
| Lookup tables | 0 bytes | ~217 bytes (ROM) | +217 ROM |

**Net Result:** 145 bytes RAM saved, game data moved to ROM.

---

## Files

| File | Purpose |
|------|---------|
| `tmea_types.h` | Type definitions, enums, constants |
| `tmea_core.h` | API declarations |
| `tmea_core.c` | Implementation |
| `tmea_data.h` | Lookup table declarations |
| `tmea_data.c` | Lookup table data |
