# Game Architecture Plan: C64 Dungeon Crawler

**Target Platform:** Commodore 64 (6502, 64KB RAM)
**Compiler:** OSCAR64 Cross-Compiler
**Architecture:** Hybrid Overlay System (Phase-Based Loading)
**Last Updated:** 2026-02-01

---

## Executive Summary

This document defines the complete architecture for a C64 dungeon crawler game utilizing hybrid overlay loading to fit within C64 memory constraints. The system supports two game modes (Quick Game and Quest), procedural map generation, turn-based combat with deep mechanics, and comprehensive dungeon features.

### Memory Solution

```
Total Code Required:      ~55.0 KB
Total Runtime Data:        7.5 KB
GRAND TOTAL:              62.5 KB

C64 Available RAM:        ~50 KB
Solution:                 Phase-based overlay loading with minimal resident core
Peak Active Memory:       46 KB  FITS!
```

### Architecture Overview

**Hybrid Overlay System with 4 Components:**
1. **RESIDENT CORE** (~10 KB) - TMEA + game state + loader + core utilities
2. **INTRO.PRG** (~8 KB) - Title screen, music, effects - load once, unload
3. **MENU.PRG** (~3 KB) - Main menu + simplified CharGen - unload after selection
4. **GAME.PRG** (~36.5 KB) - Main game engine with ALL systems - stays loaded during gameplay

**Critical Design:** During gameplay (GAME.PRG loaded), level transitions take **~2 seconds** via seed-based regeneration + on-demand music loading. **Zero code reloading** during gameplay.

---

## Table of Contents

1. [Complete Feature Requirements](#1-complete-feature-requirements)
2. [Sprite & Entity Constraints](#2-sprite--entity-constraints)
3. [Tile System & Screen Layout](#3-tile-system--screen-layout)
4. [Memory Budget Breakdown](#4-memory-budget-breakdown)
5. [Hybrid Overlay Architecture](#5-hybrid-overlay-architecture)
6. [Combat System](#6-combat-system)
7. [Level State Persistence System](#7-level-state-persistence-system)
8. [Game Modes](#8-game-modes)
9. [Loading Flow & Timing](#9-loading-flow--timing)
10. [Module Specifications](#10-module-specifications)
11. [Implementation Roadmap](#11-implementation-roadmap)
12. [Technical Decisions](#12-technical-decisions)

---

## 1. Complete Feature Requirements

### 1.1 Current Implementation Status

** Completed Modules:**

| Module | Directory | Size | Description |
|--------|-----------|------|-------------|
| **Intro** | `src/intro/` | ~8 KB | Full demo with SID music (0xa000), rasterbars, sprites, rainbow scroll |
| **CharGen** | `src/chargen/` | ~5 KB | Race/Class/Background/Skills (4d6 drop lowest) ** TO BE SIMPLIFIED** |
| **MapGen** | `src/mapgen/` | ~9 KB | 8-phase procedural generation, TMEA system, room/corridor management |
| **TMEA Core** | `src/mapgen/tmea_core.c` | ~1 KB | Metadata system for tiles/entities (~640 B RAM + ~340 B ROM) |

**CharGen Simplification Plan:** Current implementation has 5 races, 4 classes, 5 backgrounds, 8 skills. Will be simplified to stat roll (4d6 drop lowest) OR point-buy system only (human character). Reduces size from ~5 KB to ~1-2 KB.

### 1.2 Core Feature Set

| Feature | Specification | Memory Impact |
|---------|---------------|---------------|
| **Player Sprites** | 1 idle + 1 attack, LEFT/RIGHT only | 128 B |
| **Enemy Sprites** | 11 types (8 regular + 3 boss), 1 idle + 1 attack each | 1.4 KB |
| **Spell Sprites** | 4 projectile types (fireball, arrow, bolt, cloud) | 256 B |
| **Cursor Sprite** | Selection cursor (mutually exclusive with projectile) | 64 B |
| **Enemy AI** | Smart chase + boss patrol + special attacks | 4 KB |
| **Combat System** | Full formulas: hit chance, damage, AC, shield block, criticals, status effects | 2.5 KB |
| **Level System** | 12 levels with seed-based regeneration + state persistence | 1,135 B/level |
| **Unified Audio System** | SFX + SID music with priority handling | 2 KB code + 2 KB music |
| **Charsets** | Unified charset with bright/dark tile variants (fog of war) | 2 KB |
| **Item Variety** | Weapons (8), Armor (8), Shields (5), Potions (6), Scrolls (14), Gems (5), Gold, Torch | ~340 B ROM |
| **Status Effects** | 12 effects with duration tracking | 10 B RAM + 600 B code |
| **Boss Special Attacks** | 3 bosses with unique abilities | 9 B RAM + 500 B code |

---

## 2. Sprite & Entity Constraints

**Design Philosophy:** Deterministic visuals with NO flicker, NO sprite multiplexing, NO runtime mirroring.

### 2.1 Hardware Constraints

- **Platform:** Commodore 64 (VIC-II chip)
- **Sprite Limit:** 8 hardware sprites per raster stripe
- **No Multiplexing:** Fixed sprite slot allocation
- **No Runtime Modification:** Prebaked LEFT/RIGHT sprite frames only
- **No Flicker:** All rendering must be deterministic

### 2.2 Entity Limits (Hard Guarantees)

- **Player:** 1
- **Enemies:** **Maximum 6 active per level** (enforced by game logic)
- **Spell Projectile:** Maximum 1 active at any time
- **Selection Cursor:** 1, mutually exclusive with spell projectile

**Total:** Never exceeds 8 sprites simultaneously (1 player + 1 cursor/projectile + 6 enemies)

### 2.3 Sprite Slot Allocation (Fixed, Non-Dynamic)

| Sprite Slot | Usage |
|-------------|-------|
| Sprite 0 | Player |
| Sprite 1 | Spell Projectile **OR** Selection Cursor |
| Sprite 2 | Enemy 0 |
| Sprite 3 | Enemy 1 |
| Sprite 4 | Enemy 2 |
| Sprite 5 | Enemy 3 |
| Sprite 6 | Enemy 4 |
| Sprite 7 | Enemy 5 |

### 2.4 Sprite Memory Budget

```
Player sprites (4 frames):              128 B
Enemy sprites (11 types x 4 frames):  1,408 B
Spell projectile sprites (4 frames):    256 B
Cursor sprite (1 frame):                 64 B
Animation handler:                      400 B
----------------------------------------------
TOTAL SPRITE SYSTEM:                  ~2.3 KB
```

---

## 3. Tile System & Screen Layout

### 3.1 Tile Coordinate System

- **Tile Size:** 3x3 characters (24x24 pixels logical tile size)
- **Sprite Size:** Standard C64 sprite: 24x21 pixels
- **Alignment:** Sprites visually aligned to **bottom of tile**
- **Entity Alignment:** All entities are **tile-aligned**

### 3.2 Screen Layout

- **Total Screen:** 40 columns x 25 rows (C64 text mode)
- **Viewport:** **30 columns** (3/4 of screen width) for game world
- **HUD:** **10 columns** (remaining 1/4 width) for player stats and info

### 3.3 Viewport Rendering

- **Maximum Visible Area:** 30 columns / 3 chars/tile = **10 tiles wide**
- **Vertical:** 25 rows / 3 chars/tile = **8 tiles tall**
- **Camera System:** Centered on player with map scrolling
- **Map Sizes:** 50x50, 64x64, 78x78 tiles (selectable via mapgen config)

### 3.4 HUD Contents

```
+----------+
| HP: 45/50|  Health Points
| AC: 15   |  Armor Class
| XP: 1250 |  Experience
| LVL: 5   |  Dungeon Level
|          |
| STR: 16  |  Character Stats
| DEX: 14  |
| CON: 15  |
|          |
| [STATUS] |  Active Effects
| [WEAPON] |  Equipped Weapon
| [ARMOR]  |  Equipped Armor
+----------+
```

---

## 4. Memory Budget Breakdown

### 4.1 Completed Modules (18 KB)

```
===============================================================
COMPLETED MODULES
===============================================================
+-- Intro effects code:                     8 KB
+-- CharGen system (current complex):       5 KB     TO BE SIMPLIFIED
|   +-- CharGen simplified (target):        1.5 KB
+-- MapGen (8-phase pipeline):              8 KB
+-- TMEA core:                              1 KB
+-- SUBTOTAL (after CharGen simplify):     18.5 KB
```

### 4.2 New Modules - Game Engine (~36.5 KB)

```
===============================================================
NEW MODULES - GAME ENGINE
===============================================================
+-- Main Menu:                              1.5 KB
+-- Game loop (main gameplay):              6 KB
+-- 3x3 Tile renderer:                      2.5 KB
+-- HUD (HP/AC/XP/status):                  2 KB
+-- Save/Load (complex state):              3 KB
+-- Level state manager:                    2 KB
|
+-- Combat System:                          2.5 KB
|   +-- Hit chance calculation:            300 B
|   +-- Damage calculation:                400 B
|   +-- AC calculation:                    200 B
|   +-- Shield block logic:                300 B
|   +-- Critical hit system:               200 B
|   +-- Status effect processing:          600 B
|   +-- Boss special attacks:              500 B
|
+-- Sprite System:                          2.3 KB
|   +-- Player sprites (idle + attack L/R): 128 B
|   +-- Enemy sprites (11 x 4 frames):    1,408 B
|   +-- Spell projectiles (4):              256 B
|   +-- Cursor sprite:                       64 B
|   +-- Animation handler:                  400 B
|
+-- AI System:                              4 KB
|   +-- Regular AI (chase):                 2 KB
|   |   +-- Line of sight:                 500 B
|   |   +-- Chase logic:                   800 B
|   |   +-- Obstacle avoidance:            700 B
|   +-- Boss AI (patrol + specials):        2 KB
|       +-- Patrol behavior:               500 B
|       +-- Extended vision:               300 B
|       +-- Special attack logic:          700 B
|       +-- Cooldown management:           500 B
|
+-- Item System:                            5 KB
|   +-- Lookup tables (ROM):               340 B
|   +-- +/Cursed modifier system:          400 B
|   +-- Item graphics/chars:                 1 KB
|   +-- Inventory UI:                        2 KB
|   +-- Pickup/use logic:                  800 B
|   +-- Dark room system:                  300 B
|
+-- Quest System:                           1 KB
+-- Spell System:                           1.35 KB
+-- Fog of War:                             1 KB
+-- Unified Audio System:                   2 KB
+-- Charset System:                         2 KB
+-- Quick Game System:                      500 B
|
+-- SUBTOTAL:                              36.5 KB
```

### 4.3 Total Code Section

```
Completed Modules:       18.5 KB
New Game Engine:         36.5 KB
------------------------------
TOTAL CODE:              55.0 KB
```

### 4.4 Runtime Data Section

```
===============================================================
GLOBAL GAME STATE (~7.7 KB)
===============================================================
+-- Character data (stats, inventory):        200 B
+-- Current map (80x80, 3-bit encoding):    2,400 B
+-- Room list (20 rooms x 48 B):              960 B
+-- TMEA metadata pools:                      640 B
|   +-- Tile metadata:                       325 B
|   +-- Entity pools:                        296 B
|   +-- Combat state (StatusTimers, BossAI):  19 B
|
+-- Current Level State:                    1,135 B
|   +-- Level seed:                            2 B
|   +-- Item states (50 items x 4 B):        200 B
|   +-- Door states (20 doors x 3 B):         60 B
|   +-- Enemy data (max 6 x 12 B):            72 B
|   +-- Fog of war (80x80):                  800 B
|   +-- Visited flag:                          1 B
|
+-- Entity runtime states:                  1,000 B
+-- AI pathfind temporary data:               500 B
+-- Combat state (current battle):            300 B
+-- Quest system state:                       200 B
|
+-- TOTAL RUNTIME DATA:                      7.7 KB
===============================================================
```

### 4.5 Memory Constraint Solution

```
Total Required:        62.7 KB (55 code + 7.7 data)
C64 Available:         ~50 KB
Overflow:              -12.7 KB

SOLUTION: Minimal-resident hybrid overlay system

Active during gameplay:
+-- Resident core (minimal):       10 KB
+-- GAME.PRG:                      36.5 KB
+-- SID music (on-demand):          2 KB
+-- TOTAL ACTIVE:                  48.5 KB  FITS!

FREE RAM:                          1.5 KB (stack, temp buffers)
```

---

## 5. Hybrid Overlay Architecture

### 5.1 Memory Layout

```
+============================================================+
|  C64 MEMORY MAP - HYBRID OVERLAY SYSTEM                    |
+============================================================+

$0000 +------------------------------------------------------+
      | Zero Page (256 B)                                    |
      | OSCAR64 runtime + fast variables                     |
$00FF +------------------------------------------------------+

$0800 +------------------------------------------------------+
      | BASIC Stub + Module Loader (512 B)                   |
$0A00 +------------------------------------------------------+

$0A00 +------------------------------------------------------+
      | RESIDENT CORE (10 KB) - MINIMAL                      |
      | ---------------------------------------------------- |
      | ALWAYS IN MEMORY - Never overwritten                 |
      |                                                      |
      | Components:                                          |
      | - TMEA system                    (1 KB)              |
      | - Global game state              (8.3 KB)            |
      | - Core utilities                 (400 B)             |
      | - Module loader                  (300 B)             |
      |                                                      |
$3200 +------------------------------------------------------+

$3200 +------------------------------------------------------+
      | OVERLAY REGION (Dynamically loaded)                  |
      | ---------------------------------------------------- |
      |                                                      |
      | Active Module Options:                               |
      |                                                      |
      | Phase 1: INTRO.PRG      (8 KB)                       |
      | Phase 2: MENU.PRG       (3 KB)                       |
      | Phase 3: GAME.PRG      (36.5 KB) <-- Largest         |
      |                                                      |
      | Only ONE module loaded at a time                     |
      |                                                      |
$D000 +------------------------------------------------------+

$A000 +------------------------------------------------------+
      | SID Music Data (2 KB on-demand)                      |
      | Loaded per level during transitions                  |
$A800 +------------------------------------------------------+

$D000 +------------------------------------------------------+
      | I/O Area (VIC-II, SID, CIA)                          |
$E000 +------------------------------------------------------+

$E000 +------------------------------------------------------+
      | KERNAL ROM (8 KB)                                    |
$FFFF +------------------------------------------------------+
```

### 5.2 Active Memory at Peak (During Gameplay)

```
When GAME.PRG is loaded:

+-- Resident Core:          10.0 KB
+-- GAME.PRG:               36.5 KB
+-- SID Music (on-demand):   2.0 KB
+-- TOTAL ACTIVE:           48.5 KB   FITS IN 50 KB!

FREE RAM:                    1.5 KB   (stack, temp buffers)
```

---

## 6. Combat System

### 6.1 Hit Chance Calculation

```c
unsigned char calculate_hit_chance(Player* player, TinyMon* enemy) {
    const WeaponDef* weapon = get_weapon_def(player->weapon_type);
    const MonsterDef* mdef = get_monster_def(enemy->type);

    // Base hit chance: 70%
    unsigned char hit_chance = 70;

    // Weapon accuracy bonus (+5% per point)
    hit_chance += weapon->hit_bonus * 5;

    // Player DEX bonus (+2% per point above 10)
    if (player->dex > 10) {
        hit_chance += (player->dex - 10) * 2;
    } else if (player->dex < 10) {
        hit_chance -= (10 - player->dex) * 2;
    }

    // Enemy defense penalty (-3% per defense point)
    hit_chance -= mdef->defense * 3;

    // Enemy AC penalty (-2% per AC point)
    if (mdef->armor_class > 0) {
        hit_chance -= mdef->armor_class * 2;
    }

    // Status effects
    if (player->status & STATUS_BLIND) hit_chance -= 20;
    if (player->status & STATUS_HASTE) hit_chance += 10;
    if (player->status & STATUS_BLESSED) hit_chance += 10;
    if (enemy->flags & MFLAG_SLEEPING) hit_chance = 95;  // Auto-hit sleeping

    // Clamp to valid range (5% - 95%)
    if (hit_chance > 95) hit_chance = 95;
    if (hit_chance < 5) hit_chance = 5;

    return hit_chance;
}
```

### 6.2 Damage Calculation

```c
unsigned char calculate_player_damage(Player* player, TinyMon* enemy) {
    const WeaponDef* weapon = get_weapon_def(player->weapon_type);
    const MonsterDef* mdef = get_monster_def(enemy->type);

    // Base weapon damage
    unsigned char damage = weapon->damage;

    // Player STR bonus (+1 damage per 2 STR above 10)
    if (player->str > 10) {
        damage += (player->str - 10) / 2;
    }

    // Weapon modifier (+1/+2/+3 enchantment)
    unsigned char mod = ITEM_GET_MODIFIER(player->weapon_data);
    if (mod >= 1 && mod <= 3) {
        damage += mod;
    }

    // Special weapon bonuses vs enemy types
    if (weapon->special & WEAPON_SPECIAL_VS_UNDEAD) {
        if ((mdef->def_flags & MDEF_UNDEAD) || (enemy->flags & MFLAG_UNDEAD_VAR)) {
            damage += 3;  // Mace vs Skeleton/Ghost/Zombie
        }
    }

    if (weapon->special & WEAPON_SPECIAL_VS_DEMON) {
        if (mdef->def_flags & MDEF_DEMON) {
            damage += 3;  // Holy weapon vs Demon
        }
    }

    // Critical hit check (5% base + weapon crit bonus)
    unsigned char crit_chance = 5 + weapon->crit_chance;
    if (rnd(100) < crit_chance) {
        damage *= 2;  // Double damage on crit
    }

    // Status effects
    if (player->status & STATUS_BERSERK) {
        damage += damage / 2;  // +50% damage when berserk
    }

    // Minimum damage = 1
    if (damage < 1) damage = 1;

    return damage;
}
```

### 6.3 Player Armor Class Calculation

```c
unsigned char calculate_player_ac(Player* player) {
    unsigned char ac = 10;  // Base AC

    // Armor contribution
    const ArmorDef* armor = get_armor_def(player->armor_type);
    ac += armor->armor_class;

    // Shield contribution
    if (player->shield_type != ITEM_NONE) {
        const ShieldDef* shield = get_shield_def(player->shield_type);
        ac += shield->defense;
    }

    // DEX bonus (+1 AC per 2 DEX above 10, max +5)
    if (player->dex > 10) {
        unsigned char dex_bonus = (player->dex - 10) / 2;
        if (dex_bonus > 5) dex_bonus = 5;
        ac += dex_bonus;
    }

    // Armor modifier (+1/+2/+3 enchantment)
    unsigned char mod = ITEM_GET_MODIFIER(player->armor_data);
    if (mod >= 1 && mod <= 3) {
        ac += mod;
    }

    // Status effects
    if (player->status & STATUS_SHIELD_BUFF) {
        ac += 3;  // Scroll of Shield effect
    }

    return ac;
}
```

### 6.4 Shield Block System

```c
unsigned char check_shield_block(Player* player) {
    if (player->shield_type == ITEM_NONE) return 0;

    // Two-handed weapons cannot use shields
    const WeaponDef* weapon = get_weapon_def(player->weapon_type);
    if (weapon->special & WEAPON_SPECIAL_TWO_HANDED) return 0;

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
            // Counter-attack: stun enemy, deal 1 damage
            return 2;  // Blocked + bash
        }
        return 1;  // Attack blocked
    }

    return 0;  // Attack not blocked
}
```

### 6.5 Armor Weight and Movement Speed

```c
// Weight affects movement speed and turn order
// Weight 0: No penalty (cloth, leather, robe)
// Weight 1: -10% speed (studded leather, dragon scale)
// Weight 2: -20% speed (chain mail, scale mail)
// Weight 3: -30% speed (plate mail)

unsigned char get_movement_speed(Player* player) {
    const ArmorDef* armor = get_armor_def(player->armor_type);
    unsigned char speed = 10;  // Base speed

    // Armor weight penalty
    speed -= armor->weight;

    // DEX bonus (+1 speed per 3 DEX above 12)
    if (player->dex > 12) {
        speed += (player->dex - 12) / 3;
    }

    // Haste buff
    if (player->status & STATUS_HASTE) {
        speed += 5;  // +50% speed
    }

    return speed;
}
```

### 6.6 Status Effect System

```c
// Status flags (16-bit bitfield in Player.status)
#define STATUS_NONE         0x0000
#define STATUS_POISONED     0x0001  // -3 HP/turn for duration
#define STATUS_HASTE        0x0002  // +50% speed, +10% hit
#define STATUS_SHIELD_BUFF  0x0004  // +3 AC
#define STATUS_BERSERK      0x0008  // +50% damage, -20% AC
#define STATUS_INVISIBLE    0x0010  // 50% avoid combat initiation
#define STATUS_BLESSED      0x0020  // +2 to all rolls
#define STATUS_CURSED       0x0040  // -2 to all rolls
#define STATUS_STUNNED      0x0080  // Skip next turn
#define STATUS_BLIND        0x0100  // -20% hit chance
#define STATUS_REGENERATING 0x0200  // +2 HP/turn
#define STATUS_FIRE_SHIELD  0x0400  // Reflect 3 damage to attacker
#define STATUS_CONFUSED     0x0800  // 50% random movement

// Duration tracking (10 bytes)
typedef struct {
    unsigned char poison_turns;
    unsigned char haste_turns;
    unsigned char shield_turns;
    unsigned char berserk_turns;
    unsigned char invis_turns;
    unsigned char blessed_turns;
    unsigned char cursed_turns;
    unsigned char regen_turns;
    unsigned char fire_shield_turns;
    unsigned char confused_turns;
} StatusTimers;

// Process status effects each turn
void process_status_effects(Player* player, StatusTimers* timers) {
    // Poison damage
    if (player->status & STATUS_POISONED) {
        player->hp -= 3;
        if (--timers->poison_turns == 0) {
            player->status &= ~STATUS_POISONED;
        }
    }

    // Regeneration healing
    if (player->status & STATUS_REGENERATING) {
        if (player->hp < player->hp_max) {
            player->hp += 2;
            if (player->hp > player->hp_max) player->hp = player->hp_max;
        }
        if (--timers->regen_turns == 0) {
            player->status &= ~STATUS_REGENERATING;
        }
    }

    // Decrement all other timers and clear expired effects
    // ... (similar pattern for each status)
}
```

### 6.7 Weapon Special Effects

```c
void apply_weapon_special_effects(Player* player, TinyMon* enemy,
                                   unsigned char damage) {
    const WeaponDef* weapon = get_weapon_def(player->weapon_type);

    // Life Drain (Cursed Blade)
    if (weapon->special & WEAPON_SPECIAL_LIFE_DRAIN) {
        unsigned char heal = damage / 5;  // 20% lifesteal
        player->hp += heal;
        if (player->hp > player->hp_max) player->hp = player->hp_max;
    }

    // Poison (Dagger)
    if (weapon->special & WEAPON_SPECIAL_POISON) {
        if (rnd(100) < 30) {  // 30% poison chance
            enemy->flags |= MFLAG_POISONED;
        }
    }

    // Stun (Mace)
    if (weapon->special & WEAPON_SPECIAL_STUN) {
        if (rnd(100) < 15) {  // 15% stun chance
            enemy->flags |= MFLAG_STUNNED;
        }
    }

    // Cleave (Battle Axe) - damage adjacent enemies
    if (weapon->special & WEAPON_SPECIAL_CLEAVE) {
        TinyMon* adjacent = find_adjacent_monster(enemy->x, enemy->y);
        if (adjacent) {
            unsigned char cleave_dmg = damage / 4;  // 25% damage
            if (cleave_dmg < 1) cleave_dmg = 1;
            adjacent->hp -= cleave_dmg;
        }
    }

    // Pierce Armor (Spear) - applied in damage calc
    // Range attacks (Bow, Spear) - handled in targeting
}
```

### 6.8 Boss Special Attacks

```c
// Boss AI state (3 bytes per boss, 9 bytes total for 3 bosses)
typedef struct {
    unsigned char cooldown;          // Base cooldown between specials
    unsigned char attack_type;       // Current special attack type
    unsigned char current_cooldown;  // Turns until next special
} BossAI;

// Boss attack types
#define BOSS_ATK_FIREBALL      0  // Dragon: 3x3 area, 12 fire damage
#define BOSS_ATK_SUMMON_ADDS   1  // Demon: Summon 2 minion enemies
#define BOSS_ATK_LIFE_DRAIN    2  // Lich: Drain 10 HP, heal self
#define BOSS_ATK_POISON_CLOUD  3  // Dragon alt: 5x5 poison cloud
#define BOSS_ATK_TELEPORT      4  // Lich alt: Teleport away + heal 10

void boss_special_attack(TinyMon* boss, Player* player, BossAI* ai) {
    if (ai->current_cooldown > 0) {
        ai->current_cooldown--;
        return;  // Regular attack instead
    }

    const MonsterDef* mdef = get_monster_def(boss->type);

    switch (boss->type) {
        case MON_BOSS_DRAGON:
            // Fire breath: 3x3 area damage
            if (manhattan_distance(boss->x, boss->y, player->x, player->y) <= 3) {
                unsigned char damage = 12;

                // Fire resistance halves damage
                const ArmorDef* armor = get_armor_def(player->armor_type);
                if (armor->special & ARMOR_SPECIAL_FIRE_RESIST) {
                    damage /= 2;
                }

                player->hp -= damage;
            }
            ai->current_cooldown = 5;  // Every 5 turns
            break;

        case MON_BOSS_DEMON:
            // Summon 2 minions (Goblins or Orcs)
            spawn_minion_near(boss->x, boss->y, MON_GOBLIN);
            spawn_minion_near(boss->x, boss->y, MON_ORC);
            ai->current_cooldown = 8;  // Every 8 turns
            break;

        case MON_BOSS_LICH:
            // Life drain: steal 10 HP
            if (manhattan_distance(boss->x, boss->y, player->x, player->y) <= 2) {
                player->hp -= 10;
                boss->hp += 10;
                if (boss->hp > mdef->base_hp) boss->hp = mdef->base_hp;
            }
            ai->current_cooldown = 4;  // Every 4 turns
            break;
    }
}
```

### 6.9 Combat Turn Sequence

```c
void player_turn(Player* player, TinyMon* enemy) {
    // 1. Check if stunned
    if (player->status & STATUS_STUNNED) {
        player->status &= ~STATUS_STUNNED;
        return;  // Skip turn
    }

    // 2. Calculate hit chance
    unsigned char hit_chance = calculate_hit_chance(player, enemy);

    // 3. Roll to hit
    if (rnd(100) < hit_chance) {
        // 4. Calculate and apply damage
        unsigned char damage = calculate_player_damage(player, enemy);
        enemy->hp -= damage;

        // 5. Apply weapon special effects
        apply_weapon_special_effects(player, enemy, damage);

        // 6. Check for enemy death
        if (enemy->hp == 0 || enemy->hp > 200) {  // Underflow check
            const MonsterDef* mdef = get_monster_def(enemy->type);
            player->xp += mdef->xp_value;
            despawn_monster(enemy);
        }
    }
}

void enemy_turn(TinyMon* enemy, Player* player) {
    // 1. Check if stunned
    if (enemy->flags & MFLAG_STUNNED) {
        enemy->flags &= ~MFLAG_STUNNED;
        return;  // Skip turn
    }

    // 2. Check if fleeing (Turn Undead effect)
    if (enemy->flags & MFLAG_FLEEING) {
        move_away_from_player(enemy, player);
        return;
    }

    const MonsterDef* mdef = get_monster_def(enemy->type);

    // 3. Boss special attack check
    if (mdef->def_flags & MDEF_BOSS) {
        // Try special attack first
        // ... boss_special_attack()
    }

    // 4. Check shield block
    unsigned char block_result = check_shield_block(player);
    if (block_result == 1) {
        return;  // Attack blocked
    } else if (block_result == 2) {
        // Shield bash: enemy takes 1 damage, gets stunned
        enemy->hp -= 1;
        enemy->flags |= MFLAG_STUNNED;
        return;
    }

    // 5. Calculate and apply damage
    unsigned char damage = mdef->damage;
    unsigned char player_ac = calculate_player_ac(player);

    // AC reduces damage (1 AC = -1 damage, min 1)
    if (damage > player_ac / 2) {
        damage -= player_ac / 2;
    } else {
        damage = 1;
    }

    player->hp -= damage;

    // 6. Apply monster special abilities
    if (mdef->def_flags & MDEF_LIFE_DRAIN) {
        unsigned char drain = damage / 2;
        enemy->hp += drain;
    }

    if (mdef->def_flags & MDEF_POISON_ATK) {
        if (rnd(100) < 30) {
            player->status |= STATUS_POISONED;
            // Set poison_turns = 5
        }
    }

    // 7. Fire shield reflection
    if (player->status & STATUS_FIRE_SHIELD) {
        enemy->hp -= 3;
    }
}
```

### 6.10 Combat Memory Cost

```
+================================================+
| COMBAT SYSTEM MEMORY BUDGET                    |
+================================================+
| ROM (const lookup tables):                     |
| +-- weapon_table[8]:        8 x 8 B =  64 B    |
| +-- armor_table[8]:         8 x 5 B =  40 B    |
| +-- shield_table[5]:        5 x 5 B =  25 B    |
| +-- scroll_table[14]:      14 x 6 B =  84 B    |
| +-- potion_table[6]:        6 x 6 B =  36 B    |
| +-- monster_table[11]:     11 x 8 B =  88 B    |
|                                     --------   |
| ROM Subtotal:                        337 B     |
+================================================+
| CODE (functions):                              |
| +-- Hit chance calculation:          300 B     |
| +-- Damage calculation:              400 B     |
| +-- AC calculation:                  200 B     |
| +-- Shield block logic:              300 B     |
| +-- Status effect system:            600 B     |
| +-- Boss AI special attacks:         500 B     |
| +-- Weapon special handlers:         400 B     |
|                                     --------   |
| CODE Subtotal:                     2,500 B     |
+================================================+
| RAM (runtime data):                            |
| +-- StatusTimers (player):            10 B     |
| +-- BossAI[3]:              3 x 3 B =  9 B     |
|                                     --------   |
| RAM Subtotal:                         19 B     |
+================================================+
| GRAND TOTAL:       337 + 2,500 + 19 = 2,856 B  |
+================================================+
```

---

## 7. Level State Persistence System

### 7.1 Seed-Based Regeneration

**Philosophy:** Store level **seed** + **state changes** instead of entire map data.

**Benefits:**
- Massive space savings: 2 B seed + 1,135 B state vs ~2400 B full map
- Fast regeneration: <1 sec per level
- Deterministic: Same seed always produces same map

### 7.2 Level State Structure

```c
typedef struct {
    // Regeneration data
    unsigned int level_seed;              // 2 B - RNG seed for mapgen

    // Dynamic state (changes during gameplay)
    ItemState items[50];                  // 200 B (4 B each)
    DoorState doors[20];                  // 60 B (3 B each)
    EnemyState enemies[6];                // 72 B (12 B each)

    // Player interaction tracking
    unsigned char fog_of_war[800];        // 800 B (80x80 bits)
    unsigned char visited;                // 1 B

    // Total: 1,135 B per level
} LevelState;
```

### 7.3 Dark Rooms & Light System

**Dark Room Mechanics:**
- Some rooms flagged as "dark" during generation
- Quest Mode: Progressive difficulty (20% -> 65% dark rooms)
- Quick Game: Fixed 30% dark room chance

**Visibility Rules:**

| Condition | Visibility Radius |
|-----------|-------------------|
| Normal room | 5 tiles |
| Dark room + NO light | **1 tile** |
| Dark room + light source | 5 tiles |
| Corridors | Always 3 tiles |

**Light Sources:**
1. **Torch** - Equipable item, fuel system (~300-500 turns)
2. **Scroll of Light** - Temporary buff (50-100 turns)

### 7.4 Turn Undead System

**Scroll of Turn Undead:**
- Scans visible undead enemies
- Weak undead (HP < 20): Instant kill
- Strong undead (HP >= 20): Flee for 20-30 turns

**Undead Types:**
- Always undead: Skeleton, Ghost
- Variant (30% spawn chance): Undead Goblin
- Variant (20% spawn chance): Undead Troll

---

## 8. Game Modes

### 8.1 Quick Game

**Objective:** Survive as long as possible, maximize score.

- **Character:** Random stats (4d6 drop lowest) + starting equipment
- **Levels:** Infinite procedural dungeon floors
- **Bosses:** Appear as regular enemies (scaled with depth)
- **Death:** Permanent, returns to main menu
- **Save:** None (high score table only)

### 8.2 Quest Mode

**Objective:** Reach Level 12, obtain Quest Item, return to Level 1 to win.

- **Character:** Full stat roll/point-buy system
- **Levels:** 12 structured levels
- **Bosses:** 3 boss battles on specific levels (randomized)
- **Death:** Can reload from last save (autosave on level transitions)
- **Save:** Automatic on level transitions

---

## 9. Loading Flow & Timing

### 9.1 Boot Sequence

```
C64 BOOT
  |
Load RESIDENT CORE (instant, in main PRG)
  |
Load INTRO.PRG (~5 sec)
  |
Run intro loop (music, effects, scroll)
  |
User presses FIRE
  |
Unload INTRO.PRG
  |
Load MENU.PRG (~3 sec)
  |
Show main menu
```

### 9.2 Game Start Flow

```
User selects game mode
  |
If CharGen needed: Run simplified version
  |
Unload MENU.PRG
  |
Load GAME.PRG (~6 sec)
  |
Initialize game state
  |
Generate Level 1 from seed (~1 sec)
  |
Load dungeon music (~0.5 sec)
  |
GAMEPLAY STARTS (GAME.PRG stays loaded)
  |
Level transitions:
  +-- Save current level (~0.5 sec, Quest only)
      Regenerate target level (~1 sec)
      Load state if visited (~0.5 sec)
      Load music if changed (~0.5 sec)
      TOTAL: ~2 sec, NO code reload
```

---

## 10. Module Specifications

### 10.1 RESIDENT CORE (~10 KB)

**Purpose:** Minimal shared systems that MUST persist across all modules.

**Components:**
- TMEA API (get/set metadata, entity management)
- Map access functions (get_tile, set_tile)
- Math utilities (distance, RNG)
- Module loader

### 10.2 GAME.PRG (~36.5 KB)

**Purpose:** Entire gameplay happens here. Stays loaded for entire game session.

**Contains:**
- MapGen (8-phase pipeline): ~9 KB
- Game Loop & Rendering: ~8.5 KB
- Combat System: ~2.5 KB
- AI System: ~4 KB
- Item System: ~5 KB
- Quest System: ~1 KB
- Spell System: ~1.35 KB
- Fog of War: ~1 KB
- Audio System: ~2 KB
- Charset System: ~2 KB
- Quick Game System: ~500 B

---

## 11. Implementation Roadmap

### Phase 1: Foundation (Completed)
-  Intro module
-  MapGen module
-  TMEA Core

### Phase 2: Core Game Loop
- Main game loop
- 3x3 Tile renderer
- HUD rendering
- Sprite system

### Phase 3: Combat & AI
- Combat system (formulas, status effects)
- Regular AI (chase, line of sight)
- Boss AI (patrol, special attacks)

### Phase 4: Items & Spells
- Item system with lookup tables
- Inventory UI
- Spell effects

### Phase 5: Quest & Persistence
- Quest system
- Save/Load system
- Level state manager

### Phase 6: Polish
- Fog of War
- Audio system
- Quick Game scoring

---

## 12. Technical Decisions

### 12.1 Why Data-Oriented Combat?

**Problem:** Complex combat formulas need to be memory-efficient.

**Solution:** Lookup tables in ROM + minimal runtime state.

**Benefits:**
- Static data costs 0 RAM (const)
- Runtime state only 19 bytes (StatusTimers + BossAI)
- ~2.5 KB code for full combat depth
- Easy to balance (change table values)

### 12.2 Why Status Effect Bitfield?

**Problem:** Track multiple simultaneous effects efficiently.

**Solution:** 16-bit bitfield + 10-byte duration array.

**Benefits:**
- O(1) status checks via bitmask
- Separate duration tracking
- Easy to add/remove effects
- Minimal RAM overhead

### 12.3 Why Boss AI Cooldowns?

**Problem:** Boss special attacks need pacing.

**Solution:** Per-boss cooldown tracking (3 bytes each).

**Benefits:**
- Predictable attack patterns
- Strategic counterplay possible
- Prevents spam of powerful abilities
- Different bosses feel distinct

---

**Document End**
