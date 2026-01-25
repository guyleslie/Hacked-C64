# Game Architecture Plan: C64 Dungeon Crawler

**Target Platform:** Commodore 64 (6502, 64KB RAM)
**Compiler:** OSCAR64 Cross-Compiler
**Architecture:** Hybrid Overlay System (Phase-Based Loading)
**Last Updated:** 2026-01-11

---

## Executive Summary

This document defines the complete architecture for a C64 dungeon crawler game utilizing hybrid overlay loading to fit within C64 memory constraints. The system supports two game modes (Quick Game and Quest), procedural map generation, turn-based combat, and comprehensive dungeon features.

### Memory Solution

```
Total Code Required:      ~52.5 KB
Total Runtime Data:        7.5 KB
GRAND TOTAL:              60.0 KB

C64 Available RAM:        ~50 KB
Solution:                 Phase-based overlay loading with minimal resident core
Peak Active Memory:       46 KB ✅ FITS!
```

### Architecture Overview

**Hybrid Overlay System with 4 Components:**
1. **RESIDENT CORE** (~10 KB) - TMEA + game state + loader + core utilities
2. **INTRO.PRG** (~8 KB) - Title screen, music, effects - load once, unload
3. **MENU.PRG** (~3 KB) - Main menu + simplified CharGen - unload after selection
4. **GAME.PRG** (~34 KB) - Main game engine with ALL systems - stays loaded during gameplay

**Critical Design:** During gameplay (GAME.PRG loaded), level transitions take **~2 seconds** via seed-based regeneration + on-demand music loading. **Zero code reloading** during gameplay.

---

## Table of Contents

1. [Complete Feature Requirements](#1-complete-feature-requirements)
2. [Sprite & Entity Constraints](#2-sprite--entity-constraints)
3. [Tile System & Screen Layout](#3-tile-system--screen-layout)
4. [Memory Budget Breakdown](#4-memory-budget-breakdown)
5. [Hybrid Overlay Architecture](#5-hybrid-overlay-architecture)
6. [Level State Persistence System](#6-level-state-persistence-system)
7. [Game Modes](#7-game-modes)
8. [Loading Flow & Timing](#8-loading-flow--timing)
9. [Module Specifications](#9-module-specifications)
10. [Implementation Roadmap](#10-implementation-roadmap)
11. [Technical Decisions](#11-technical-decisions)

---

## 1. Complete Feature Requirements

### 1.1 Current Implementation Status

**✅ Completed Modules:**

| Module | Directory | Size | Description |
|--------|-----------|------|-------------|
| **Intro** | `src/intro/` | ~8 KB | Full demo with SID music (0xa000), rasterbars, sprites, rainbow scroll |
| **CharGen** | `src/chargen/` | ~5 KB | Race/Class/Background/Skills (4d6 drop lowest) **⚠️ TO BE SIMPLIFIED** |
| **MapGen** | `src/mapgen/` | ~9 KB | 8-phase procedural generation, TMEA system, room/corridor management |
| **TMEA Core** | `src/mapgen/tmea_core.c` | ~1 KB | Metadata system for tiles/entities (814 B total: 765 B base + 49 B quest extensions) |

**CharGen Simplification Plan:** Current implementation has 5 races, 4 classes, 5 backgrounds, 8 skills. Will be simplified to stat roll (4d6 drop lowest) OR point-buy system only (human character). Reduces size from ~5 KB to ~1-2 KB.

### 1.2 Core Feature Set

| Feature | Specification | Memory Impact |
|---------|---------------|---------------|
| **Player Sprites** | 1 idle + 1 attack, LEFT/RIGHT only (UP/DOWN uses LEFT/RIGHT sprite) | 128 B |
| **Enemy Sprites** | 11 types (8 regular + 3 boss), 1 idle + 1 attack each, LEFT/RIGHT only | 1.4 KB |
| **Spell Sprites** | 4 projectile types (fireball, arrow, bolt, cloud) | 256 B |
| **Cursor Sprite** | Selection cursor (mutually exclusive with projectile) | 64 B |
| **Enemy AI** | Smart chase algorithm + boss free roaming/patrol | 3.5 KB |
| **Level System** | 12 levels with seed-based regeneration + state persistence (Quest mode: FoW saved, Quick Game: no save) | 1,135 B/level, 13.6 KB disk |
| **Persistent Data** | Items, door states, enemy positions, fog of war saved per level | Part of level state |
| **Unified Audio System** | SFX + SID music with priority handling (SFX > music), on-demand loading (3-4 tracks: intro, dungeon, boss, win/death) | 2 KB code + 2 KB active music data |
| **Charsets** | Unified charset with bright/dark tile variants (fog of war) | 2 KB |
| **Item Variety** | Weapons (8), Armor+Shield system (varied materials), Potions (6), Scrolls (14: Light, Turn Undead, etc.), Special Items (3), Gems (5), Gold, Torch | 5.35 KB |
| **Quick Game Scoring** | Enemy kills, gold/gems, deepest level, high score table (10 entries) | 500 B |
| **Quest System** | 3 boss battles with required special items, random placement | 1 KB |
| **Combat System** | Turn-based with elemental vulnerabilities, status effects, boss special attacks | 4 KB |
| **Fog of War** | Tile-swap rendering (explored tiles darkened), 80×80 max | 800 B + 1 KB code |
| **Dark Rooms & Light** | Random dark rooms (progressive in Quest), 1-tile visibility without light, Torch (fuel system ~300 turns) + Scroll of Light (50-100 turn buff) | 2 B state + 300 B code |
| **+/Cursed System** | Weapon/armor modifiers (+1, +2, +3, cursed) | 800 B |

---

## 2. Sprite & Entity Constraints

**Design Philosophy:** Deterministic visuals with NO flicker, NO sprite multiplexing, NO runtime mirroring. Simple, stable sprite management within VIC-II hardware limits.

### 2.1 Hardware Constraints

- **Platform:** Commodore 64 (VIC-II chip)
- **Sprite Limit:** 8 hardware sprites per raster stripe
- **No Multiplexing:** Fixed sprite slot allocation
- **No Runtime Modification:** Prebaked LEFT/RIGHT sprite frames only
- **No Flicker:** All rendering must be deterministic

### 2.2 Entity Limits (Hard Guarantees)

Game logic enforces these limits globally:

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

**Rules:**
- If `spell_active == true` → Sprite 1 = projectile, cursor hidden
- If `spell_active == false` → Sprite 1 = selection cursor (if needed)
- If neither needed → Sprite 1 disabled

### 2.4 Sprite Asset Policy

**Direction Handling:**
- All animated entities use **prebaked LEFT and RIGHT sprite frames**
- Direction changes handled **only by sprite pointer switching**
- **UP/DOWN movements use LEFT/RIGHT sprite** (NetHack-like visual convention)
- No sprite pixel data may be modified at runtime

**Animation Frames:**
- Player: idle + attack (L/R) = 4 frames
- Enemies (11 types): idle + attack (L/R) = 44 frames
- Spell projectiles: directional or neutral frames = 4 frames
- Selection cursor: single-frame sprite = 1 frame

### 2.5 Sprite Memory Budget

```
Player sprites (4 frames):              128 B
Enemy sprites (11 types × 4 frames):  1,408 B
Spell projectile sprites (4 frames):    256 B
Cursor sprite (1 frame):                 64 B
Animation handler:                      400 B
──────────────────────────────────────────────
TOTAL SPRITE SYSTEM:                  ~2.3 KB
```

### 2.6 Design Invariants (Must Never Be Broken)

1. Never exceed 6 enemies simultaneously
2. Never render both projectile and cursor at the same time
3. Never exceed 8 hardware sprites in total
4. Never rely on sprite multiplexing
5. Never rely on sprite flickering
6. Never modify sprite bitmap data during gameplay

---

## 3. Tile System & Screen Layout

### 3.1 Tile Coordinate System

- **Tile Size:** 3×3 characters (24×24 pixels logical tile size)
- **Sprite Size:** Standard C64 sprite: 24×21 pixels
- **Alignment:** Sprites visually aligned to **bottom of tile**
- **Vertical Difference:** 3-pixel difference between sprite and tile (intentional, accepted)
- **Entity Alignment:** All entities (player, enemies, cursor, projectile) are **tile-aligned**

### 3.2 Screen Layout

- **Total Screen:** 40 columns × 25 rows (C64 text mode)
- **Viewport:** **30 columns** (¾ of screen width) for game world
- **HUD:** **10 columns** (remaining ¼ width) for player stats and info
- **HUD Rendering:** Character mode only (NO hardware sprites consumed)

### 3.3 Viewport Rendering

- **Maximum Visible Area:** 30 columns ÷ 3 chars/tile = **10 tiles wide**
- **Vertical:** 25 rows ÷ 3 chars/tile = **8 tiles tall**
- **Camera System:** Centered on player with map scrolling
- **Map Sizes:** 50×50, 64×64, 78×78 tiles (selectable via mapgen config)

### 3.4 HUD Contents

```
┌──────────┐
│ HP: 45/50│  Health Points
│ MP: 12/20│  Magic Points
│ XP: 1250 │  Experience
│ LVL: 5   │  Dungeon Level
│ SCORE:   │  Current Score
│  12,340  │
│          │
│ STR: 16  │  Character Stats
│ DEX: 14  │
│ CON: 15  │
│ INT: 12  │
│ WIS: 10  │
│ CHA: 11  │
│          │
│ [STATUS] │  Status Effects
│          │
│ [ITEMS]  │  Quick Inventory
└──────────┘
```

---

## 4. Memory Budget Breakdown

### 4.1 Completed Modules (18 KB)

```
═══════════════════════════════════════════════════════════
COMPLETED MODULES
═══════════════════════════════════════════════════════════
├─ Intro effects code:                     8 KB    ✅
├─ CharGen system (current complex):       5 KB    ⚠️ TO BE SIMPLIFIED
│  └─ CharGen simplified (target):         1.5 KB  ⏳
├─ MapGen (8-phase pipeline):              8 KB    ✅
├─ TMEA core:                              1 KB    ✅
└─ SUBTOTAL (after CharGen simplify):     18.5 KB
```

### 4.2 New Modules - Game Engine (~33.5 KB)

```
═══════════════════════════════════════════════════════════
NEW MODULES - GAME ENGINE
═══════════════════════════════════════════════════════════
├─ Main Menu:                                1.5 KB  ⏳
├─ Game loop (main gameplay):                  6 KB  ⏳
├─ 3×3 Tile renderer:                        2.5 KB  ⏳
├─ Combat system (turn-based + bosses):        4 KB  ⏳
├─ HUD (HP/MP/XP/status):                      2 KB  ⏳
├─ Save/Load (complex state):                  3 KB  ⏳
├─ Level state manager:                        2 KB  ⏳
│
├─ Sprite System:                            2.3 KB  ⏳
│   ├─ Player sprites (idle + attack L/R):   128 B
│   ├─ Enemy sprites (11 × 4 frames):      1,408 B
│   ├─ Spell projectiles (4):                256 B
│   ├─ Cursor sprite:                         64 B
│   └─ Animation handler:                    400 B
│
├─ AI System:                                3.5 KB  ⏳
│   ├─ Regular AI (chase):                     2 KB
│   │   ├─ Line of sight:                    500 B
│   │   ├─ Chase logic:                      800 B
│   │   └─ Obstacle avoidance:               700 B
│   └─ Boss AI (free roaming):               1.5 KB
│       ├─ Patrol behavior:                  500 B
│       ├─ Extended vision:                  300 B
│       └─ Special attacks:                  700 B
│
├─ Item System:                             5.35 KB  ⏳
│   ├─ Item database:                        450 B
│   │   ├─ Weapons (8 types):                100 B
│   │   ├─ Armor (varied materials):         100 B
│   │   ├─ Shields (varied materials):        80 B
│   │   ├─ Potions (6 types):                 80 B
│   │   ├─ Scrolls (14 types, incl. Light/Turn): 170 B
│   │   ├─ Torch (light source):              20 B
│   │   ├─ Special items (3):                 50 B
│   │   ├─ Gems (5 types):                    50 B
│   │   └─ Gold (random values):              20 B
│   ├─ +/Cursed modifier system:             800 B
│   ├─ Item graphics/chars:                    1 KB
│   ├─ Inventory UI:                           2 KB
│   ├─ Pickup/use logic:                     800 B
│   └─ Dark room system:                     300 B
│       ├─ Visibility calculation:           150 B
│       └─ Torch/light buff management:      150 B
│
├─ Quest System:                               1 KB  ⏳
│   ├─ Boss randomizer:                      300 B
│   ├─ Special item placement:               300 B
│   ├─ Quest item tracking:                  200 B
│   └─ Win condition check:                  200 B
│
├─ Spell System:                            1.35 KB  ⏳
│   ├─ Scroll database (14 types):           350 B
│   ├─ Spell effects:                        650 B
│   │   ├─ Damage/healing/utility:           450 B
│   │   ├─ Light aura buff:                  100 B
│   │   └─ Turn Undead (kill/flee):          100 B
│   └─ VFX (border flash + 2-tile):          350 B
│
├─ Fog of War:                                1 KB  ⏳
│   ├─ Visibility calculation:              500 B
│   └─ Tile swap rendering:                 500 B
│
├─ Unified Audio System:                      2 KB  ⏳
│   ├─ SFX playback + priority:             800 B
│   ├─ SID music player:                    700 B
│   └─ On-demand music loader:              500 B
│
├─ Charset System:                           2 KB  ⏳
│   └─ Unified charset (bright/dark):        2 KB
│
├─ Quick Game System:                      500 B  ⏳
│   ├─ Score calculation:                  200 B
│   ├─ High score table (10 entries):      240 B
│   └─ Display/save logic:                  60 B
│
└─ SUBTOTAL:                              34.0 KB
```

### 4.3 Total Code Section

```
Completed Modules:       18.5 KB
New Game Engine:         34.0 KB
──────────────────────────────
TOTAL CODE:              52.5 KB
```

### 4.4 Runtime Data Section

```
═══════════════════════════════════════════════════════════
GLOBAL GAME STATE (8.3 KB)
═══════════════════════════════════════════════════════════
├─ Character data (stats, inventory):        200 B
├─ Current map (80×80, 3-bit encoding):    2,400 B
├─ Room list (20 rooms × 48 B):              960 B
├─ TMEA metadata pools:                      814 B
│   ├─ Base TMEA system:                     765 B
│   ├─ Boss entity pool (3):                  24 B
│   ├─ Special items (3):                     12 B
│   ├─ Phylactery data:                        3 B
│   └─ Quest tracking:                        10 B
│
├─ Current Level State:                    1,135 B
│   ├─ Level seed:                             2 B
│   ├─ Item states (50 items × 4 B):         200 B
│   ├─ Door states (20 doors × 3 B):          60 B
│   ├─ Enemy data (max 6 × 12 B):             72 B
│   ├─ Fog of war (80×80):                   800 B (saved in Quest mode)
│   └─ Visited flag:                           1 B
│       (Note: 80×80 FoW = 6400 bits = 800 B)
│
├─ Entity runtime states:                  1,000 B
├─ AI pathfind temporary data:               500 B
├─ Combat state (current battle):            300 B
├─ Quest system state:                       200 B
│
└─ TOTAL RUNTIME DATA:                       7.5 KB
═══════════════════════════════════════════════════════════
```

### 4.5 Memory Constraint Solution

```
Total Required:        60.0 KB (52.5 code + 7.5 data)
C64 Available:         ~50 KB
Overflow:              -10.0 KB  ❌

SOLUTION: Minimal-resident hybrid overlay system

Active during gameplay:
├─ Resident core (minimal):       10 KB
├─ GAME.PRG:                      34 KB
├─ SID music (on-demand):          2 KB
└─ TOTAL ACTIVE:                  46 KB ✅ FITS!

FREE RAM:                          4 KB (stack, temp buffers, safety margin)
```

**Key Optimizations:**
1. On-demand music loading saves ~6 KB (vs all tracks loaded)
2. No sprite multiplexer saves ~1 KB
3. Simplified CharGen saves ~3.5 KB
4. Armor+Shield system (vs 15-slot armor) saves ~1 KB
5. **Total savings: ~11.5 KB vs initial design**

---

## 5. Hybrid Overlay Architecture

### 5.1 Memory Layout

```
╔══════════════════════════════════════════════════════════╗
║  C64 MEMORY MAP - HYBRID OVERLAY SYSTEM                                ║
╚══════════════════════════════════════════════════════════╝

$0000 ┌────────────────────────────────────────────────────┐
      │ Zero Page (256 B)                                               │
      │ OSCAR64 runtime + fast variables                                │
$00FF └────────────────────────────────────────────────────┘

$0800 ┌────────────────────────────────────────────────────┐
      │ BASIC Stub + Module Loader (512 B)                              │
$0A00 └────────────────────────────────────────────────────┘

$0A00 ┌────────────────────────────────────────────────────┐
      │ RESIDENT CORE (10 KB) - MINIMAL                                 │
      │ ────────────────────────────────────────────────── │
      │ ALWAYS IN MEMORY - Never overwritten                            │
      │                                                                 │
      │ Components:                                                     │
      │ • TMEA system                    (1 KB)                         │
      │ • Global game state              (8.3 KB)                       │
      │ • Core utilities                 (400 B)                        │
      │ • Module loader                  (300 B)                        │
      │                                                                 │
$3200 └────────────────────────────────────────────────────┘

$3200 ┌────────────────────────────────────────────────────┐
      │ OVERLAY REGION (Dynamically loaded)                             │
      │ ────────────────────────────────────────────────── │
      │                                                    		│
      │ Active Module Options:                            		│
      │                                                    		│
      │ Phase 1: INTRO.PRG      (8 KB)                    		│
      │ Phase 2: MENU.PRG       (3 KB)                    		│
      │ Phase 3: GAME.PRG      (34 KB) ← Largest          		│
      │                                                    		│
      │ Only ONE module loaded at a time                  		│
      │                                                    		│
$D000 └────────────────────────────────────────────────────┘

$A000 ┌────────────────────────────────────────────────────┐
      │ SID Music Data (2 KB on-demand)                    		│
      │ Loaded per level during transitions               		│
$A800 └────────────────────────────────────────────────────┘

$D000 ┌────────────────────────────────────────────────────┐
      │ I/O Area (VIC-II, SID, CIA)                        		│
$E000 └────────────────────────────────────────────────────┘

$E000 ┌────────────────────────────────────────────────────┐
      │ KERNAL ROM (8 KB)                                  		│
$FFFF └────────────────────────────────────────────────────┘
```

### 5.2 Active Memory at Peak (During Gameplay)

```
When GAME.PRG is loaded:

├─ Resident Core:          10.0 KB
├─ GAME.PRG:               34.0 KB
├─ SID Music (on-demand):   2.0 KB
└─ TOTAL ACTIVE:           46.0 KB  ✅ FITS IN 50 KB!

FREE RAM:                   4.0 KB   (stack, temp buffers, safety margin)
```

---

## 6. Level State Persistence System

### 6.1 Seed-Based Regeneration

**Philosophy:** Store level **seed** + **state changes** instead of entire map data.

**Benefits:**
- Massive space savings: 2 B seed + 1,135 B state vs ~2400 B full map
- Fast regeneration: <1 sec per level
- Deterministic: Same seed always produces same map

### 6.2 Level State Structure

```c
typedef struct {
    // Regeneration data
    unsigned int level_seed;              // 2 B - RNG seed for mapgen

    // Dynamic state (changes during gameplay)
    ItemState items[50];                  // 200 B (4 B each: type, x, y, flags)
    DoorState doors[20];                  // 60 B (3 B each: x, y, state)
    EnemyState enemies[6];                // 72 B (12 B each: type, x, y, hp, flags, etc.)

    // Player interaction tracking
    unsigned char fog_of_war[800];        // 800 B (80×80 bits, 1 bit per tile)
    unsigned char visited;                // 1 B - has player visited this level?

    // Total: 1,135 B per level (2 + 200 + 60 + 72 + 800 + 1)
    // Note: Quest mode saves FoW, Quick Game does NOT save (no save system)
} LevelState;
```

### 6.3 Level Transition Flow

**Descending Stairs (Level N → N+1):**

```
1. Save current level state to disk         (~0.5 sec, 1,135 B write)
2. Check if level N+1 visited before
3. If visited:
   └─ Load level state from disk           (~0.5 sec, 1,135 B read)
      Regenerate map from seed              (~1 sec)
      Apply state changes (items, doors, enemies)
      Restore fog of war (explored tiles)
4. If new level:
   └─ Generate new seed
      Generate map from seed                (~1 sec)
      Place initial items/enemies
      Initialize empty FoW
5. Load level music if needed               (~0.5 sec, optional)

TOTAL: ~2 sec (visited) or ~1.5 sec (new)
```

**Ascending Stairs (Level N → N-1):**
Same process, but level N-1 is always visited (came from above).

### 6.4 Quest Mode Save Data

**File Structure: "QUESTSAVE"**

```
Character Data:                        200 B
Current Level:                           1 B
Quest Progress:                         10 B
Level States (12 levels × 1,135 B): 13,620 B
─────────────────────────────────────────
TOTAL SAVE FILE:                    13,831 B (~13.5 KB)
```

**Save Timing:** Automatic save on level transitions (Quest mode only).

### 6.5 Quick Game Mode

**No Save System:**
- No disk writes during gameplay
- High score table only (10 entries × 24 B = 240 B)
- High scores saved to separate "HISCORES" file
- Faster gameplay (no disk I/O delays)

### 6.6 Dark Rooms & Light System

**Concept:** NetHack-inspired dark rooms where visibility is severely limited without a light source.

**Dark Room Mechanics:**

- **Random Dark Rooms:** Some rooms are flagged as "dark" during generation
- **Quest Mode Progressive Difficulty:**
  - Level 1-3: 20% dark rooms
  - Level 4-6: 35% dark rooms
  - Level 7-9: 50% dark rooms
  - Level 10-12: 65% dark rooms
- **Quick Game:** Fixed 30% dark room chance (random)

**Visibility Rules:**

| Condition | Visibility Radius | Notes |
|-----------|-------------------|-------|
| Normal room | 5 tiles | Standard fog of war |
| Dark room + NO light | **1 tile** | Only immediate surroundings visible |
| Dark room + light source | 5 tiles | Torch or Light spell active |
| Corridors | Always 3 tiles | Never fully dark |

**Light Sources:**

**1. Torch (Fáklya)** - Equipable Item

```c
typedef struct {
    unsigned char torch_equipped;  // 0 = no, 1 = yes
    unsigned int torch_fuel;       // Turns remaining (0-500)
    // When fuel reaches 0, torch extinguishes
} TorchState;
```

- **Equip Slot:** Offhand/accessory (separate from weapon/shield)
- **Fuel System:** Slow burn (~300-500 turns per torch)
- **Effect:** While equipped and fuel > 0, provides light (5-tile visibility in dark rooms)
- **Fuel Depletion:** Decreases by 1 per turn while equipped
- **Extinguish:** Auto-unequips when fuel reaches 0
- **Multiple Torches:** Can carry multiple torches in inventory, swap when depleted

**2. Scroll of Light** - Consumable Spell

- **Type:** One of the 12 scroll types (replaces or adds to existing scroll list)
- **Effect:** Temporary light aura buff (50-100 turns, random)
- **Buff Behavior:**
  - Player-centered light source
  - Counts down per turn
  - Stacks with torch (redundant but allowed)
  - When duration expires, light disappears (if no torch)
- **Strategic Use:** Conserve torches by using scrolls in dark areas

**Implementation Details:**

```c
// Player state extension
typedef struct {
    unsigned char torch_fuel;           // 0-255 turns (max 255)
    unsigned char light_spell_duration; // 0-100 turns remaining
} LightState;

// Room metadata (TMEA)
typedef struct {
    unsigned char is_dark : 1;  // 1 bit flag per room
    // ... other room flags
} RoomMetadata;

// Visibility check (pseudocode)
bool has_light_source(Player* p) {
    return (p->light.torch_fuel > 0) ||
           (p->light.light_spell_duration > 0);
}

unsigned char get_visibility_radius(Room* room, Player* p) {
    if (!room->is_dark) {
        return 5;  // Normal visibility
    }

    if (has_light_source(p)) {
        return 5;  // Light overcomes darkness
    }

    return 1;  // Severely limited in dark without light
}
```

**Gameplay Impact:**

- **Resource Management:** Torches become valuable consumables
- **Risk/Reward:** Explore dark rooms without light (risky) or use torch (safe but limited fuel)
- **Strategic Depth:** Save torches for critical areas, use Scroll of Light for temporary relief
- **Progressive Challenge:** Quest mode escalates dark room frequency, increasing tension

**Memory Cost:**

- Room flags: 1 bit per room × 20 rooms = 3 bytes (TMEA metadata)
- Player state: 2 bytes (torch_fuel, light_spell_duration)
- Code: ~300 bytes (visibility calculation, torch/scroll logic, fuel management)
- **Total: ~305 bytes**

**Item Database Additions:**

```
Torch:
  - Type: Equipable (offhand/accessory)
  - Weight: 1
  - Fuel: 300-500 turns (random on pickup)
  - Rarity: Common (found in most levels)
  - Price: 10 gold

Scroll of Light:
  - Type: Consumable (scroll)
  - Effect: Light aura (50-100 turns)
  - Rarity: Uncommon
  - Price: 25 gold
```

**UI Indicators:**

- **HUD Display:**
  ```
  [TORCH] ███░░ (3/5)  ← Fuel bars
  [LIGHT] 47 turns      ← Spell duration (if active)
  ```
- **Status Messages:**
  - "Your torch is burning low..." (fuel < 50)
  - "Your torch has burned out!" (fuel = 0)
  - "The light spell fades..." (spell duration < 10)

**Quest vs Quick Game:**

| Feature | Quest Mode | Quick Game |
|---------|------------|------------|
| Dark Rooms | Progressive (20%-65%) | Fixed 30% |
| Torch Availability | Balanced for progression | More frequent spawns |
| Light Scrolls | Moderate | More common (compensates for no save) |

### 6.7 Turn Undead System

**Concept:** NetHack/D&D-inspired holy magic that destroys or repels undead enemies.

**Scroll of Turn Undead:**

- **Type:** One of the 14 scroll types
- **Effect:** Instant vs visible undead enemies
- **Rarity:** Uncommon (similar to Scroll of Light)
- **Price:** 30 gold (more valuable than Light)

**Undead Enemy Types:**

The game features **2 fixed undead** + **2 occasionally undead variants**:

| Enemy Type | Undead Status | Notes |
|------------|---------------|-------|
| **Skeleton** | Always undead | Classic undead enemy |
| **Ghost** | Always undead | Classic undead enemy |
| **Undead Goblin** | Variant (30% spawn chance) | Normal Goblin OR Undead Goblin |
| **Undead Troll** | Variant (20% spawn chance) | Normal Troll OR Undead Troll |

**Undead Variant System:**

```c
// Enemy spawning logic (pseudocode)
Enemy spawn_enemy(unsigned char type) {
    Enemy e;
    e.type = type;
    e.is_undead = false;

    if (type == ENEMY_SKELETON || type == ENEMY_GHOST) {
        e.is_undead = true;  // Always undead
    }
    else if (type == ENEMY_GOBLIN) {
        if (rand() % 100 < 30) {  // 30% chance
            e.is_undead = true;
            e.name = "Undead Goblin";
            e.hp += 5;  // Slightly stronger
        }
    }
    else if (type == ENEMY_TROLL) {
        if (rand() % 100 < 20) {  // 20% chance
            e.is_undead = true;
            e.name = "Undead Troll";
            e.hp += 10;  // Stronger
        }
    }

    return e;
}
```

**Turn Undead Effect:**

When Scroll of Turn Undead is used:

1. **Scan visible undead enemies** (5-tile radius, ignoring walls)
2. **For each undead enemy:**
   - If `enemy.hp < 20` (weak undead):
     - **Instant kill** (holy energy destroys them)
     - Display: "The [skeleton] is destroyed by holy light!"
   - If `enemy.hp >= 20` (strong undead):
     - Apply **flee status** (20-30 turns, random)
     - Display: "The [undead troll] flees in terror!"
3. **Flee behavior:**
   - Enemy AI switches to flee mode
   - Moves AWAY from player (opposite direction)
   - Will not attack player while fleeing
   - After flee duration expires, returns to normal AI

**Implementation Details:**

```c
// Turn Undead effect
void scroll_turn_undead(Player* p) {
    unsigned char destroyed = 0;
    unsigned char fled = 0;

    for (unsigned char i = 0; i < enemy_count; i++) {
        Enemy* e = &enemies[i];

        // Check if visible and undead
        if (!is_visible(e->x, e->y, p->x, p->y)) continue;
        if (!e->is_undead) continue;

        if (e->hp < 20) {
            // Weak undead: instant kill
            e->hp = 0;
            e->alive = false;
            destroyed++;
            show_message("The %s is destroyed!", enemy_name(e->type));
        } else {
            // Strong undead: flee
            e->flee_duration = 20 + (rand() % 11);  // 20-30 turns
            fled++;
            show_message("The %s flees in terror!", enemy_name(e->type));
        }
    }

    if (destroyed == 0 && fled == 0) {
        show_message("No undead are affected.");
    } else {
        show_message("%d undead destroyed, %d fleeing!", destroyed, fled);
    }
}
```

**Tactical Considerations:**

- **Timing:** Use when surrounded by multiple undead
- **Weak vs Strong:** Instantly kills Skeletons/Ghosts (usually HP < 20), makes Undead Trolls flee
- **Visibility:** Only affects visible enemies (dark rooms limit effectiveness without light)
- **Quest vs Quick:** More useful in deeper levels where undead variants are more common

**Item Database Entry:**

```
Scroll of Turn Undead:
  - Type: Consumable (scroll)
  - Effect: Destroy weak undead (HP<20), make strong undead flee (20-30 turns)
  - Targets: All visible undead enemies
  - Rarity: Uncommon
  - Price: 30 gold
```

**Memory Cost:**

- Enemy flags: `is_undead` (1 bit per enemy, already in entity data)
- Flee duration: `flee_duration` (1 byte per enemy, reuse existing status field)
- Turn Undead logic: ~100 bytes (visibility check, HP check, flee application)
- **Total: ~100 bytes (negligible)**

---

## 7. Game Modes

### 7.1 Quick Game

**Objective:** Survive as long as possible, maximize score.

**Features:**
- **Character:** Random stats (4d6 drop lowest) + starting equipment
- **Levels:** Infinite procedural dungeon floors (increasing difficulty)
- **Bosses:** Boss types appear as **regular enemies** (no special quest requirement)
  - Boss strength scales with level depth
  - Can encounter multiple bosses if strong enough
- **Death:** Permanent, returns to main menu
- **Scoring:**
  - Enemy kills (scaled by enemy type)
  - Gold/gems collected
  - Deepest level reached
  - Bonus: Boss kills
- **Save:** None (high score table only)
- **Music:** Dungeon track loops (no level-specific music)

### 7.2 Quest Mode

**Objective:** Reach Level 12, obtain Quest Item, return to Level 1 to win.

**Features:**
- **Character:** Full stat roll/point-buy system
- **Levels:** 12 structured levels (seed-based, consistent on reload)
- **Bosses:** 3 boss battles on specific levels (randomized at quest start)
  - Each boss guards a **Special Item** required for quest completion
  - Boss levels randomly assigned (e.g., 4, 8, 11)
  - Must defeat all 3 bosses and collect Special Items
- **Quest Item:** Spawns on Level 12 after all bosses defeated
- **Win Condition:** Return Quest Item to Level 1 entrance
- **Death:** Can reload from last save (level transition autosave)
- **Save:** Automatic on level transitions
- **Music:** Level-specific tracks (dungeon, boss, win)

### 7.3 Mode Comparison

| Feature | Quick Game | Quest Mode |
|---------|------------|------------|
| Character Creation | Random | Full chargen |
| Levels | Infinite procedural | 12 structured |
| Bosses | Regular enemies | Special quest battles |
| Special Items | Random loot | Quest requirements |
| Save/Load | No | Yes (autosave) |
| Win Condition | None (endless) | Return with Quest Item |
| Scoring | High score table | Quest completion |
| Difficulty | Escalating | Balanced progression |
| Music | Dungeon loop | Multi-track (dungeon, boss, win) |

---

## 8. Loading Flow & Timing

### 8.1 Boot Sequence

```
C64 BOOT
  ↓
Load RESIDENT CORE (instant, in main PRG)
  ↓
Load INTRO.PRG (~5 sec)
  ↓
Run intro loop (music, effects, scroll)
  ↓
User presses FIRE
  ↓
Unload INTRO.PRG
  ↓
Load MENU.PRG (~3 sec)
  ↓
Show main menu
```

### 8.2 Quick Game Start

```
User selects "Quick Game"
  ↓
Generate random character stats (instant)
  ↓
Unload MENU.PRG
  ↓
Load GAME.PRG (~6 sec)
  ↓
Initialize game state (g_game)
  ↓
Generate Level 1 from random seed (~1 sec)
  ↓
Load dungeon music (~0.5 sec)
  ↓
GAMEPLAY STARTS (GAME.PRG stays loaded)
  ↓
Level transitions:
  └─ Generate new level from seed (~1 sec)
     Load music if different (~0.5 sec, optional)
     TOTAL: ~1.5 sec, NO code reload
```

### 8.3 Quest Mode Start

```
User selects "Start New Quest"
  ↓
Run simplified chargen (stat roll/point-buy)
  ↓
User confirms character
  ↓
Randomize boss levels (3 bosses on levels 1-12)
  ↓
Unload MENU.PRG
  ↓
Load GAME.PRG (~6 sec)
  ↓
Initialize game state (g_game)
  ↓
Generate Level 1 from seed (~1 sec)
  ↓
Load dungeon music (~0.5 sec)
  ↓
GAMEPLAY STARTS (GAME.PRG stays loaded)
  ↓
Level transitions:
  └─ Save current level (~0.5 sec)
     Regenerate target level from seed (~1 sec)
     Load level state if visited (~0.5 sec)
     Load music if needed (~0.5 sec)
     TOTAL: ~2 sec, NO code reload
```

### 8.4 Quest Mode Load

```
User selects "Load Quest"
  ↓
Read save file "QUESTSAVE" (~2 sec)
  ↓
If file not found:
  └─ Show error, return to menu
  ↓
Load character data + quest progress
  ↓
Unload MENU.PRG
  ↓
Load GAME.PRG (~6 sec)
  ↓
Regenerate current level from seed (~1 sec)
  ↓
Apply level state (items, doors, enemies, FoW)
  ↓
Load appropriate music (~0.5 sec)
  ↓
GAMEPLAY RESUMES (GAME.PRG stays loaded)
```

### 8.5 Timing Summary

| Operation | Time | Notes |
|-----------|------|-------|
| **INTRO.PRG load** | ~5 sec | One-time at boot |
| **MENU.PRG load** | ~3 sec | After intro / after game ends |
| **GAME.PRG load** | ~6 sec | Largest module, one-time per game session |
| **Level generation** | ~1 sec | Seed-based mapgen |
| **Level state save** | ~0.5 sec | Quest mode only |
| **Level state load** | ~0.5 sec | Quest mode, visited levels |
| **Music load** | ~0.5 sec | On-demand, 2 KB |
| **Level transition (total)** | ~1.5-2 sec | No code reload during gameplay |

**Critical:** Once GAME.PRG is loaded, **zero code reloading** occurs during gameplay. Only level data + music loads.

---

## 9. Module Specifications

### 9.1 RESIDENT CORE (~10 KB) - Always in Memory

**Purpose:** Minimal shared systems that MUST persist across all modules.

**Components:**

```c
// global_state.h - Resident data structure

typedef struct {
    // Game flow
    unsigned char game_mode;        // QUICK_GAME / QUEST
    unsigned char current_level;    // 1-12
    unsigned int score;
    unsigned char quest_items_collected;  // Bitfield (3 special items)
    unsigned char bosses_defeated;        // Bitfield (3 bosses)

    // Character (from chargen)
    CharacterData player;           // 200 B
    // Stats: STR, DEX, CON, INT, WIS, CHA (6 B)
    // HP, HP_max, MP, MP_max, XP, Level (12 B)
    // Inventory (equipped weapon, armor, shield, 10 slots) (182 B)

    // Current map (from mapgen)
    unsigned char compact_map[2400]; // 3-bit encoding (80×80 max)
    Room room_list[20];              // 960 B
    unsigned char room_count;
    MapParameters map_params;

    // TMEA metadata
    // ... pools (~814 B, includes boss/special items/phylactery)

    // Current level state
    LevelState current_level_state;  // 1,135 B (includes fog of war)

    // Quest system
    unsigned char quest_boss_levels[3];   // Boss spawn levels (randomized)
    unsigned char quest_boss_types[3];    // Boss types (randomized)
    unsigned char special_item_levels[3]; // Special item locations

    // Runtime game state
    Entity entities[8];              // 1,000 B (player + 6 enemies + 1 temp)
    CombatState combat;              // 300 B
    QuestState quest;                // 200 B
    AITempData ai_temp;              // 500 B (pathfinding scratch space)

} GameState;

extern GameState g_game;  // Global state, 8.3 KB total
```

**Resident Functions:**
- TMEA API (get/set metadata, entity management)
- Map access functions (get_tile, set_tile, calculate_y_bit_offset)
- Math utilities (distance, RNG, srand/rand)
- Module loader (load_module, jump_to_module)

**NOT in Resident (moved to GAME.PRG):**
- SID SFX player → moved to GAME.PRG
- Sprite animation → moved to GAME.PRG
- Charset data → moved to GAME.PRG

---

### 9.2 INTRO.PRG (~8 KB) - Title Screen

**Purpose:** Attract mode, title screen, music demo.

**Contains:**
- Rasterbar effects (7 bars, animated)
- Sprite animation demo (8 sprites, sine wave movement)
- Rainbow scroll text (bottom of screen)
- SID music playback (Back_to_the_Roots @ 0xa000)
- Logo display (5-line ASCII art with colors)

**Lifecycle:**

```
Boot → Load INTRO.PRG (5 sec)
     → Run intro loop (indefinite)
     → User presses FIRE
     → Stop music
     → Unload INTRO.PRG
     → Load MENU.PRG (3 sec)
```

**Entry Point:**

```c
void intro_entry(void) {
    // Already implemented in intro.c
    // Runs until user presses FIRE
    // Returns control to loader
}
```

**Memory Usage:**
- Code: ~8 KB
- SID music: 2 KB (loaded at 0xa000)
- Sprite data: 512 B (8 sprites × 64 B)
- Sine tables: 512 B (256 × 2)

**Implementation Status:** ✅ Fully implemented (intro.c)

---

### 9.3 MENU.PRG (~3 KB) - Main Menu + CharGen

**Purpose:** Main menu navigation + simplified character creation.

**Contains:**
- Main menu code (~1.5 KB)
- CharGen code (simplified, ~1.5 KB) - stat roll/point-buy only

**Menu Options:**

1. **Quick Game**
   - Generate random character (4d6 drop lowest × 6 stats)
   - Assign basic starting equipment
   - Set game_mode = QUICK_GAME
   - Proceed to GAME.PRG

2. **Start New Quest**
   - Run simplified chargen:
     - Option A: Roll stats (4d6 drop lowest × 6)
     - Option B: Point-buy system (27 points, 8-15 range)
   - Select starting equipment (weapon, armor, shield)
   - Randomize boss levels (3 bosses on levels 1-12)
   - Set game_mode = QUEST
   - Proceed to GAME.PRG

3. **Load Quest**
   - Attempt to read "QUESTSAVE" file
   - If found: Load character + quest progress → GAME.PRG
   - If not found: Show error, return to menu

4. **Exit**
   - Return to C64 BASIC

**Lifecycle:**

```
Load MENU.PRG (3 sec)
  → Show menu (joystick navigation)
  → User selects option
  → If CharGen needed:
      └─ Run chargen
         Write to g_game.player
         If Quest: Randomize boss levels
  → Unload MENU.PRG
  → Load GAME.PRG (6 sec)
```

**Entry Point:**

```c
typedef enum {
    MENU_QUICK_GAME,
    MENU_START_QUEST,
    MENU_LOAD_QUEST,
    MENU_EXIT
} MenuChoice;

MenuChoice menu_entry(void) {
    // Show menu, handle joystick input
    // If chargen needed, run simplified version
    // Write character data to g_game.player
    // Return user choice
}
```

**CharGen Simplification:**

**Current Implementation (chargen.c):**
- 5 races (Mortal, Sylvan, Twiceblood, Little, Bloodforged)
- 4 classes (Warrior, Priest, Wizard, Rogue)
- 5 backgrounds (Commoner, Noble, Outlander, Sage, Soldier)
- 8 skills (Athletics, Stealth, Arcana, Nature, Medicine, Persuasion, Perception)
- Size: ~5 KB

**Simplified Target:**
- Human race only (no race selection)
- No class selection (classless system, items define role)
- Stats: STR, DEX, CON, INT, WIS, CHA (6 stats)
- Stat generation:
  - **Option A:** Roll 4d6 drop lowest (classic D&D)
  - **Option B:** Point-buy (27 points, 8-15 range)
- Starting equipment selection (weapon, armor, shield from basic list)
- Size: ~1.5 KB

**Implementation Status:**
- Main Menu: ⏳ To be implemented
- CharGen: ⚠️ Needs simplification (current 5 KB → target 1.5 KB)

---

### 9.4 GAME.PRG (~34 KB) - Main Game Engine

**Purpose:** Entire gameplay happens here. Stays loaded for entire game session.

**Contains ALL game systems:**

```
GAME.PRG CONTENTS
═══════════════════════════════════════════════════════════

MapGen (already implemented):              ~9 KB  ✅
  ├─ 8-phase generation pipeline
  ├─ Room placement (Fisher-Yates on 4×4 grid)
  ├─ MST corridor connections
  ├─ Secret rooms, treasures, false/hidden corridors
  ├─ Stairs placement (distance-based)
  └─ TMEA metadata management

Game Loop & Rendering:                     ~8.5 KB ⏳
  ├─ Main game loop (6 KB)
  ├─ 3×3 Tile renderer (2.5 KB)
  │   ├─ Viewport camera system
  │   ├─ Character mode tile drawing
  │   ├─ 30-column viewport (10 tiles wide × 8 tall)
  │   └─ Sprite rendering coordination
  └─ HUD rendering (2 KB)
      ├─ HP/MP/XP display
      ├─ Stats display
      ├─ Status effects
      └─ Quick inventory

Combat & AI:                               ~7.5 KB ⏳
  ├─ Combat system (4 KB)
  │   ├─ Turn-based combat resolution
  │   ├─ Damage calculation (elemental vulnerabilities)
  │   ├─ Status effects (poison, stun, etc.)
  │   └─ Boss special attacks
  ├─ Regular AI (2 KB)
  │   ├─ Line of sight (500 B)
  │   ├─ Chase logic (800 B)
  │   └─ Obstacle avoidance (700 B)
  └─ Boss AI (1.5 KB)
      ├─ Patrol behavior (500 B)
      ├─ Extended vision (300 B)
      └─ Special attack patterns (700 B)

Item & Spell Systems:                      ~6.2 KB ⏳
  ├─ Item system (5 KB)
  │   ├─ Item database (400 B)
  │   ├─ +/Cursed system (800 B)
  │   ├─ Item graphics (1 KB)
  │   ├─ Inventory UI (2 KB)
  │   └─ Pickup/use logic (800 B)
  └─ Spell system (1.2 KB)
      ├─ Scroll database (300 B)
      ├─ Spell effects (600 B)
      └─ VFX (border flash + 2-tile) (300 B)

Quest & Scoring:                           ~1.5 KB ⏳
  ├─ Quest system (1 KB)
  │   ├─ Boss randomizer (300 B)
  │   ├─ Special item placement (300 B)
  │   ├─ Quest item tracking (200 B)
  │   └─ Win condition check (200 B)
  └─ Quick Game scoring (500 B)
      ├─ Score calculation (200 B)
      ├─ High score table (240 B)
      └─ Display/save logic (60 B)

Persistence & State:                       ~5 KB ⏳
  ├─ Save/Load system (3 KB)
  │   ├─ File I/O routines
  │   ├─ State serialization
  │   └─ Error handling
  └─ Level state manager (2 KB)
      ├─ Seed-based regeneration
      ├─ State application
      └─ Transition coordination

Visual & Audio:                            ~5.3 KB ⏳
  ├─ Sprite system (2.3 KB)
  │   ├─ Player sprites (128 B)
  │   ├─ Enemy sprites (1,408 B)
  │   ├─ Spell projectiles (256 B)
  │   ├─ Cursor sprite (64 B)
  │   └─ Animation handler (400 B)
  ├─ Charset system (2 KB)
  │   └─ Unified bright/dark charset
  ├─ Fog of War (1 KB)
  │   ├─ Visibility calculation (500 B)
  │   └─ Tile swap rendering (500 B)
  └─ Unified Audio System (2 KB)
      ├─ SFX playback + priority (800 B)
      ├─ SID music player (700 B)
      └─ On-demand music loader (500 B)

──────────────────────────────────────────────────────
TOTAL GAME.PRG:                            ~34 KB
```

**Lifecycle:**

```
Load GAME.PRG (6 sec - largest module)
  ↓
Initialize game state (g_game)
  ↓
If Quick Game:
  └─ Generate Level 1 from random seed
If Quest (new):
  └─ Generate Level 1 from seed, randomize bosses
If Quest (load):
  └─ Regenerate current level, apply saved state
  ↓
Load initial music (dungeon track, ~0.5 sec)
  ↓
╔═══════════════════════════════════════════════════╗
║ MAIN GAME LOOP (runs indefinitely)		                 ║
╠═══════════════════════════════════════════════════╣
║                                                 	         ║
║ ┌─ Render viewport (3×3 tiles, 30 col × 25 row) 		 ║
║ ├─ Render HUD (10 col sidebar)                        	 ║
║ ├─ Update sprites (player, enemies, projectile)  		 ║
║ ├─ Handle input (joystick/keyboard)              		 ║
║ ├─ Process turn (player action)                  		 ║
║ ├─ Update entities (AI, movement)                		 ║
║ ├─ Check combat triggers                         		 ║
║ ├─ Process level transitions:                    		 ║
║ │   ├─ Stairs down/up?                           		 ║
║ │   │   └─► Save current level (Quest, ~0.5 sec) 		 ║
║ │   │       Regenerate target level (~1 sec)     		 ║
║ │   │       Load state if visited (~0.5 sec)     		 ║
║ │   │       Load music if changed (~0.5 sec)     		 ║
║ │   │       TOTAL: ~2 sec, NO code reload!       		 ║
║ │   │                                             		 ║
║ ├─ Check win/death conditions:                   		 ║
║ │   ├─ Quick Game: Death → High score screen     		 ║
║ │   ├─ Quest: Death → Main menu (can reload)     		 ║
║ │   └─ Quest: Win → Victory screen               		 ║
║ │                                                 		 ║
║ └─ Loop...                                        		 ║
║                                                   		 ║
╚═══════════════════════════════════════════════════╝
  ↓
On game end:
  └─ Unload GAME.PRG
     Load MENU.PRG (3 sec)
```

**Critical:** Once loaded, GAME.PRG **stays in memory** for entire gameplay session. Level transitions load only:
- Level state data (1,135 B, ~0.5 sec read if visited, Quest mode only)
- Music data (2 KB, ~0.5 sec read if changed)
- **NO CODE RELOADING**

**Input Handling:**

- **Joystick 2 (Primary):** Movement, menu navigation, attack
- **Keyboard (Secondary):**
  - `I` - Inventory
  - `C` - Character stats
  - `Q` - Quit to menu
  - `S` - Manual save (Quest mode, optional)

**Implementation Status:**
- MapGen: ✅ Fully implemented
- All other systems: ⏳ To be implemented

---

## 10. Implementation Roadmap

### Phase 1: Foundation & Simplified Modules

**Status:** Partially complete

**Completed:**
- ✅ Intro module (intro.c) - Full implementation with SID, rasterbars, sprites
- ✅ MapGen module (mapgen/) - 8-phase generation, TMEA, DEBUG mode
- ✅ TMEA Core (tmea_core.c) - Metadata system (814 B total)

**To Do:**
- ⏳ Simplify CharGen (chargen.c):
  - Remove race/class/background/skill selection
  - Implement stat roll (4d6 drop lowest) option
  - Implement point-buy option (27 points, 8-15 range)
  - Add basic equipment selection
  - **Target:** Reduce from 5 KB to 1.5 KB
- ⏳ Implement Main Menu (new file: menu.c):
  - Menu navigation (joystick)
  - Call simplified chargen for Quest mode
  - Random chargen for Quick Game
  - Save/load file detection
  - **Target:** ~1.5 KB

**Deliverable:** Bootable intro → menu → chargen flow

---

### Phase 2: Core Game Loop & Rendering

**Status:** Not started

**Tasks:**
- ⏳ Implement main game loop (game_loop.c):
  - Turn-based input handling
  - State update coordination
  - Win/death condition checks
  - **Estimate:** ~6 KB
- ⏳ Implement 3×3 tile renderer (tile_renderer.c):
  - Viewport camera system (centered on player)
  - 30-column × 25-row character mode rendering
  - Bright/dark charset switching (fog of war)
  - Tile-to-character mapping
  - **Estimate:** ~2.5 KB
- ⏳ Implement HUD rendering (hud.c):
  - 10-column sidebar layout
  - HP/MP/XP display
  - Stats display
  - Status effects
  - Quick inventory
  - **Estimate:** ~2 KB
- ⏳ Implement sprite system (sprite_system.c):
  - Sprite slot management (8 slots, fixed allocation)
  - Animation frame switching (LEFT/RIGHT prebaked)
  - Sprite positioning (tile-aligned, 3×3 tiles)
  - Mutual exclusion (projectile vs cursor)
  - **Estimate:** ~2.3 KB (includes sprite data)
- ⏳ Create sprite assets:
  - Player sprites (4 frames: idle/attack L/R)
  - Enemy sprites (11 types × 4 frames)
  - Spell projectiles (4 sprites)
  - Cursor sprite (1 frame)
  - **Total sprite data:** ~1.9 KB
- ⏳ Create unified charset:
  - Bright tile variants (walls, floors, doors, items)
  - Dark tile variants (fog of war explored areas)
  - **Size:** 2 KB

**Deliverable:** Playable prototype with movement, rendering, basic map navigation

---

### Phase 3: Combat & AI

**Status:** Not started

**Tasks:**
- ⏳ Implement combat system (combat.c):
  - Turn-based combat resolution
  - Damage calculation (base + modifiers)
  - Elemental vulnerabilities (fire, ice, lightning, poison)
  - Status effects (poison, stun, burn, freeze)
  - Boss special attacks (unique per boss type)
  - Death handling
  - **Estimate:** ~4 KB
- ⏳ Implement regular AI (ai_regular.c):
  - Line of sight calculation (raycast)
  - Chase behavior (shortest path to player)
  - Obstacle avoidance (pathfinding around walls)
  - Attack range check
  - **Estimate:** ~2 KB
- ⏳ Implement boss AI (ai_boss.c):
  - Patrol behavior (random wandering)
  - Extended vision range
  - Special attack patterns (per boss type)
  - Aggro management
  - **Estimate:** ~1.5 KB

**Deliverable:** Functional combat, enemy AI, boss battles

---

### Phase 4: Items & Spells

**Status:** Not started

**Tasks:**
- ⏳ Implement item system (item_system.c):
  - Item database (weapons, armor, shields, potions, scrolls, gems, gold)
  - +/Cursed modifier system (+1, +2, +3, cursed)
  - Item graphics/characters
  - Pickup logic
  - Use logic (potions, scrolls)
  - Equipment logic (weapon, armor, shield)
  - **Estimate:** ~5 KB
- ⏳ Implement inventory UI (inventory_ui.c):
  - Full-screen inventory display
  - Item selection (joystick)
  - Equip/unequip/drop/use actions
  - Item stats display
  - **Included in item system estimate**
- ⏳ Implement spell system (spell_system.c):
  - Scroll database (14 spell types: Light, Turn Undead, + 12 others)
  - Spell effects (damage, healing, utility, light, turn undead)
  - VFX rendering (border flash + 2-tile animation)
  - Spell projectile movement
  - **Estimate:** ~1.35 KB

**Deliverable:** Full item and spell functionality

---

### Phase 5: Quest System & Persistence

**Status:** Not started

**Tasks:**
- ⏳ Implement quest system (quest_system.c):
  - Boss level randomization (at quest start)
  - Special item placement (3 items guarded by bosses)
  - Quest item spawning (Level 12, after all bosses defeated)
  - Win condition check (Quest item returned to Level 1)
  - **Estimate:** ~1 KB
- ⏳ Implement save/load system (save_load.c):
  - File I/O routines (KERNAL or custom)
  - State serialization (character, quest progress, level states)
  - State deserialization
  - Error handling (file not found, corrupt save)
  - **Estimate:** ~3 KB
- ⏳ Implement level state manager (level_state.c):
  - Seed-based map regeneration
  - State application (items, doors, enemies, FoW)
  - Level transition coordination
  - **Estimate:** ~2 KB

**Deliverable:** Quest mode fully functional with save/load

---

### Phase 6: Fog of War & Visuals

**Status:** Not started

**Tasks:**
- ⏳ Implement fog of war (fog_of_war.c):
  - Visibility calculation (player-centered, 5-tile radius)
  - Explored tile tracking (800 B bitfield for 80×80)
  - Tile swap rendering (bright → dark charset)
  - **Estimate:** ~1 KB
- ⏳ Implement unified audio system (audio.c):
  - On-demand music loader (3-4 tracks)
  - SID music playback (init, play, stop)
  - SFX playback with priority handling (SFX pauses music)
  - Sound effects: combat, doors, items, spells
  - **Estimate:** ~2 KB
- ⏳ Create music assets:
  - Dungeon track (looping)
  - Boss track (intense)
  - Victory track (quest win)
  - Death track (optional)
  - **Total music data:** ~6-8 KB on disk (2 KB active in memory)
- ⏳ Create SFX assets:
  - Attack sounds
  - Door open/close
  - Item pickup
  - Spell cast
  - **Estimate:** ~500 B

**Deliverable:** Fog of war functional, music/SFX integrated

---

### Phase 7: Quick Game Mode & Scoring

**Status:** Not started

**Tasks:**
- ⏳ Implement Quick Game system (quickgame.c):
  - Score calculation (kills, gold, depth, bosses)
  - High score table (10 entries)
  - High score display screen
  - High score save/load ("HISCORES" file)
  - **Estimate:** ~500 B
- ⏳ Modify game loop for Quick Game:
  - Infinite level generation
  - Boss-as-regular-enemy logic
  - Death handling (show high score, return to menu)
  - **Included in game loop**

**Deliverable:** Quick Game mode fully functional

---

### Phase 8: Polish & Optimization

**Status:** Not started

**Tasks:**
- ⏳ Optimize memory usage:
  - Review all modules for size reduction opportunities
  - Compress data structures where possible
  - Remove debug code from production builds
- ⏳ Performance tuning:
  - Profile hot paths (rendering, AI, combat)
  - Optimize 6502 assembly output (OSCAR64 flags)
  - Reduce frame time for smoother gameplay
- ⏳ Bug fixing:
  - Gameplay testing (both modes)
  - Edge case handling
  - Save/load stability
- ⏳ User experience:
  - Improve HUD layout
  - Add visual feedback (damage numbers, status icons)
  - Balance difficulty (enemy stats, item spawn rates)
- ⏳ Documentation:
  - Update README with gameplay instructions
  - Create user manual (controls, game modes, items)
  - Document build process

**Deliverable:** Polished, stable, release-ready game

---

## 11. Technical Decisions

### 11.1 Why Hybrid Overlay Architecture?

**Problem:** 60.3 KB total code + data vs 50 KB available RAM.

**Solution:** Phase-based loading with minimal resident core.

**Why This Works:**
1. **Intro/Menu used once:** No need to keep in memory during gameplay
2. **GAME.PRG contains everything:** Once loaded, zero code reloading needed
3. **On-demand music:** Only 2 KB active vs 6-8 KB total on disk
4. **Seed-based levels:** 2 B seed + 1,135 B state vs 2400 B full map

**Alternative Considered: Full Monolithic PRG**
- Rejected: Would require cutting major features (sprites, AI, items)
- Rejected: Would require aggressive compression (slow, complex)

---

### 11.2 Why No Sprite Multiplexing?

**Problem:** Sprite multiplexing adds ~1 KB code + complexity.

**Solution:** Hard limit of 6 enemies per level.

**Why This Works:**
1. **Simpler code:** No IRQ management, no flicker handling
2. **Deterministic visuals:** Stable sprite rendering
3. **Sufficient for gameplay:** 6 enemies + player + projectile = engaging combat
4. **Boss battles:** 1 boss at a time is more dramatic

**Alternative Considered: Sprite Multiplexing**
- Rejected: Adds complexity and memory overhead
- Rejected: Flicker undesirable on C64

---

### 11.3 Why 3×3 Tiles?

**Problem:** C64 sprites are 24×21 pixels, need alignment with tiles.

**Solution:** 3×3 character tiles (24×24 pixels).

**Why This Works:**
1. **Sprite alignment:** 24×21 sprite fits within 24×24 tile (3-pixel bottom gap accepted)
2. **Clean division:** 40-column screen ÷ 3 = 13.33 tiles (use 30 cols = 10 tiles for viewport)
3. **Visibility:** 10×8 tile viewport is sufficient for dungeon navigation

**Alternative Considered: 2×2 Tiles**
- Rejected: Sprites would overhang tiles (16×16 px vs 24×21 px sprite)
- Rejected: Alignment issues for entity positioning

---

### 11.4 Why Simplified CharGen?

**Problem:** Current chargen.c is 5 KB (5 races, 4 classes, 5 backgrounds, 8 skills).

**Solution:** Simplified to stat roll/point-buy only (~1.5 KB).

**Why This Works:**
1. **Memory savings:** 3.5 KB freed for game engine
2. **Faster gameplay start:** Less time in menus
3. **Item-driven roles:** Equipment defines playstyle (no rigid classes)
4. **Simpler balancing:** No need to balance 5 races × 4 classes

**Alternative Considered: Keep Full CharGen**
- Rejected: 5 KB is too large for the benefit
- Rejected: Class balance complexity not worth memory cost

---

### 11.5 Why Armor+Shield System?

**Problem:** Original plan had 15 armor types (5 slots × 3 materials).

**Solution:** Armor + Shield with varied materials.

**Why This Works:**
1. **Simpler item management:** 2 equipment slots vs 5
2. **Sufficient variety:** Different materials (leather, chain, plate, etc.)
3. **Memory savings:** ~1 KB item data reduction
4. **Clearer gameplay:** Easy to understand AC calculation

**Alternative Considered: Full Slot System**
- Rejected: 5 slots (head, chest, legs, hands, feet) too complex for C64 UI
- Rejected: Memory overhead not justified by gameplay benefit

---

### 11.6 Why Quest Mode Autosave Only?

**Problem:** Manual save UI adds complexity.

**Solution:** Autosave on level transitions.

**Why This Works:**
1. **Simpler UI:** No save menu needed
2. **Natural checkpoints:** Level transitions are logical save points
3. **Fast saves:** 1,135 B × ~0.5 sec = minimal interruption
4. **Sufficient granularity:** Rarely lose more than 1 level of progress

**Alternative Considered: Manual Save + Quicksave**
- Rejected: Adds UI complexity
- Rejected: Encourages save-scumming

---

### 11.7 Why Quick Game Has No Save?

**Problem:** Quick Game is endless, save file would grow indefinitely.

**Solution:** No save/load, only high score table.

**Why This Works:**
1. **Roguelike tradition:** Permadeath, high score focus
2. **Disk space savings:** No per-session save files
3. **Faster gameplay:** No save/load delays
4. **Clear mode distinction:** Quest = save/load, Quick = high score

**Alternative Considered: Session Save**
- Rejected: Defeats roguelike permadeath design
- Rejected: Disk space management complexity

---

### 11.8 Why Bosses as Regular Enemies in Quick Game?

**Problem:** Quick Game needs boss variety without quest structure.

**Solution:** Boss types appear as stronger regular enemies.

**Why This Works:**
1. **Reuses assets:** No separate boss-only code path
2. **Scalable difficulty:** Boss stats scale with depth
3. **Exciting encounters:** Bosses provide challenge spikes
4. **Simpler logic:** No special item requirements

**Alternative Considered: No Bosses in Quick Game**
- Rejected: Reduces variety and excitement
- Rejected: Wastes boss sprites/AI assets

---

### 11.9 Why 80×80 Max Map?

**Problem:** Original plan had variable map sizes (48, 64, 80).

**Solution:** Support all 3 sizes, but FoW sized for 80×80.

**Why This Works:**
1. **Flexibility:** Mapgen can generate 48×48 for faster levels
2. **Future-proof:** FoW buffer supports largest size
3. **Memory acceptable:** 800 B for 80×80 is reasonable

**Alternative Considered: Fixed 64×64**
- Rejected: Limits mapgen variety
- Rejected: 80×80 is more impressive on later levels

---

### 11.10 Why Seed-Based Level Regeneration?

**Problem:** Saving full map data (2400 B × 12 levels = 28.8 KB) too large.

**Solution:** Save seed (2 B) + state changes (1,135 B) per level.

**Why This Works:**
1. **Massive savings:** 1,135 B vs 2400 B per level (53% reduction)
2. **Deterministic:** Same seed always produces same map
3. **Fast regeneration:** ~1 sec per level (acceptable)
4. **State tracking:** Items, doors, enemies, FoW preserved

**Alternative Considered: Full Map Save**
- Rejected: 28.8 KB save file too large
- Rejected: Load times too long

---

## Conclusion

This architecture plan provides a complete, viable design for a C64 dungeon crawler within the platform's memory constraints. The hybrid overlay system, simplified sprite management, and seed-based level persistence enable rich gameplay without exceeding 50 KB active memory.

**Key Strengths:**
- ✅ Fits in 50 KB RAM (46 KB peak usage)
- ✅ No code reloading during gameplay
- ✅ Deterministic sprite rendering (no flicker)
- ✅ Fast level transitions (~2 sec)
- ✅ Two distinct game modes (Quick Game, Quest)
- ✅ Rich feature set (combat, AI, items, spells, quests)

**Implementation Priority:**
1. Phase 1: Simplify CharGen, implement Main Menu
2. Phase 2: Game loop, rendering, sprites
3. Phase 3: Combat & AI
4. Phase 4: Items & Spells
5. Phase 5: Quest & Persistence
6. Phase 6: FoW & Audio
7. Phase 7: Quick Game
8. Phase 8: Polish

**Estimated Total Development Time:**
- Phases 1-4: Core gameplay (critical path)
- Phases 5-7: Advanced features
- Phase 8: Polish and optimization

**Next Steps:**
1. Review and approve architecture plan
2. Begin Phase 1: CharGen simplification
3. Implement Main Menu module
4. Build GAME.PRG skeleton (Phase 2)

---

**Document End**
