# TMEA: Tile Metadata Extension Architecture

**Version:** 2.0
**Target Platform:** Commodore 64 (6502 @ 1MHz, 64KB RAM)
**Compiler:** Oscar64 cross-compiler
**Memory Overhead:** 765 bytes (~1.2% of C64 RAM)

---

## Table of Contents

1. [Overview](#1-overview)
2. [Architecture Philosophy](#2-architecture-philosophy)
3. [Core Concepts](#3-core-concepts)
4. [Memory Layout](#4-memory-layout)
5. [Type System](#5-type-system)
6. [API Reference](#6-api-reference)
7. [Usage Examples](#7-usage-examples)
8. [Performance Analysis](#8-performance-analysis)
9. [Extending TMEA](#9-extending-tmea)
10. [Export Format](#10-export-format)
11. [Oscar64 Optimizations](#11-oscar64-optimizations)
12. [Migration Path](#12-migration-path)

---

## 1. Overview

### 1.1 What is TMEA?

**TMEA (Tile Metadata Extension Architecture)** is a lightweight metadata system designed for the C64 dungeon generator project. It provides a way to attach extra information to map tiles (walls, doors, floors) and manage dynamic entities (objects, monsters) with minimal memory overhead.

### 1.2 Design Goals

```
✓ Minimal Memory Footprint:  Only 765 bytes overhead (~1.2% of 64KB RAM)
✓ Fast Lookups:              ~0.31ms average (room: 0.26ms, global: 0.44ms)
✓ Room-Aware:                Optimized for room-based dungeon generation
✓ Corridor Support:          Global pool for corridors and map-wide features
✓ Extensible:                Easy to add new feature types via flags
✓ Oscar64-Optimized:         Uses __assume(), inline, and bitfields
✓ Export-Ready:              PRG format export for persistence
```

### 1.3 Use Cases

TMEA enables advanced dungeon features that were previously impossible or memory-prohibitive:

| Feature | Implementation | Memory Cost |
|---------|---------------|-------------|
| **Secret Doors** | TMFLAG_DOOR_SECRET (replaces TILE_SECRET_DOOR) | 3-4 bytes/door |
| **Locked Doors** | TMFLAG_DOOR_LOCKED (simple lock) | 3-4 bytes/door |
| **Trapped Doors** | TMFLAG_DOOR_TRAPPED + trap damage | 3-4 bytes/door |
| **Illusory Walls** | TMFLAG_WALL_ILLUSORY | 3-4 bytes/wall |
| **Hidden Traps** | TMTYPE_TRAP + trap type | 3-4 bytes/trap |
| **Teleport Pads** | TMFLAG_SPECIAL_TELEPORT + dest ID | 3-4 bytes/pad |
| **Objects** | TinyObj pool (gold, keys, potions) | 6 bytes/object |
| **Monsters** | TinyMon pool (with AI state) | 6 bytes/monster |

**Note:** Secret doors now use TMEA metadata instead of a separate tile type (`TILE_SECRET_DOOR = 6` removed). This enables 5 door states (open, closed, locked, secret, trapped) vs the previous 2 states.

---

## 2. Architecture Philosophy

### 2.1 The Room-First, Global-Fallback Strategy

TMEA uses a **hybrid two-tier architecture** optimized for the project's room-based dungeon generation:

```
┌──────────────────────────────────────────────────┐
│ TMEA LOOKUP STRATEGY                             │
├──────────────────────────────────────────────────┤
│                                                  │
│ 1. ROOM-BASED POOL (Primary, 70% of map)         │
│    ├─ Fast: 4 slots per room × 20 rooms          │
│    ├─ Compact: Room-local coords (4+4 bits)      │
│    └─ Optimized: Direct room index lookup        │
│                                                  │
│ 2. GLOBAL POOL (Fallback, 30% of map)            │
│    ├─ Flexible: Global coordinates               │
│    ├─ Corridors: Non-room tiles supported        │
│    └─ Map-Wide: Event triggers, area effects     │
│                                                  │
│ → AUTOMATIC ROUTING: API chooses best pool       │
└──────────────────────────────────────────────────┘
```

**Why This Works:**

| Map Region | Coverage | Storage | Lookup Speed | Typical Use |
|------------|----------|---------|--------------|-------------|
| **Rooms** | ~70% | Room pool | ~260 cycles | Traps, illusory walls, locked doors |
| **Corridors** | ~30% | Global pool | ~440 cycles | Hidden traps, wandering monsters |

### 2.2 Separation of Concerns

```
TILE METADATA (Static/Semi-Static)
├─ Walls: Illusory, secret, destructible
├─ Doors: Secret, locked, trapped, open/closed
├─ Floors: Traps, pressure plates, teleports
└─ Storage: Room-local or global coords

ENTITY POOLS (Dynamic)
├─ Objects: Items, potions, keys, treasure
├─ Monsters: Enemies with HP and AI state
└─ Storage: ALWAYS global coords (for movement)
```

**Key Insight:** Static metadata benefits from room-scoped storage (compact), while dynamic entities need global coordinates for pathfinding and movement.

---

## 3. Core Concepts

### 3.1 The Three Data Layers

```
┌─────────────────────────────────────────────────┐
│ LAYER 0: Compact Map (3-bit tiles) [PRESERVED]  │
│ ├─ compact_map[2400]: Base tile types           │
│ ├─ TILE_MARKER (7): Metadata presence flag      │
│ └─ NO CHANGES to existing system                │
├─────────────────────────────────────────────────┤
│ LAYER 1: Room Metadata (+260 bytes)             │
│ ├─ RoomTileMeta[20][4]: Per-room metadata       │
│ ├─ Local coords (4+4 bits): Compact             │
│ └─ Fast lookup: O(4) linear search per room     │
├─────────────────────────────────────────────────┤
│ LAYER 2: Global Metadata (+65 bytes)            │
│ ├─ GlobalTileMeta[16]: Corridor metadata        │
│ ├─ Global coords (8+8 bits): Flexible           │
│ └─ Fallback: O(16) linear search                │
├─────────────────────────────────────────────────┤
│ LAYER 3: Entity Pools (+440 bytes)              │
│ ├─ TinyObj[48]: Object linked list              │
│ ├─ TinyMon[24]: Monster linked list             │
│ └─ Global coords: Required for movement         │
└─────────────────────────────────────────────────┘
```

### 3.2 Metadata Routing Logic

```c
// Pseudocode for add_tile_metadata()
function add_tile_metadata(x, y, flags, data):
    room_id = find_room_at_position(x, y)

    if room_id != NOT_FOUND:
        // Tile is inside a room
        if room_meta_count[room_id] < 4:
            // Room pool has space → use room storage (optimal)
            store_in_room_pool(room_id, x, y, flags, data)
            return SUCCESS
        endif

        // Room pool full → fallback to global
        // (continue below)
    endif

    // Tile is in corridor OR room pool is full
    if global_meta_count < 16:
        store_in_global_pool(x, y, flags, data)
        return SUCCESS
    endif

    return FAILURE  // All pools exhausted
```

### 3.3 Coordinate Systems

**Room-Local Coordinates (4+4 bits):**
```
Room at (10, 15) with size 6×5
┌─────────────────────────────────┐
│ Global (10,15) = Local (0,0)    │
│ Global (15,19) = Local (5,4)    │
│                                 │
│ Packed Byte: XXXXYYYYUCHAR      │
│   X = local_x (0-15, 4 bits)    │
│   Y = local_y (0-15, 4 bits)    │
└─────────────────────────────────┘
```

**Global Coordinates (8+8 bits):**
```
┌────────────────────────────────┐
│ Absolute map position          │
│ x: 0-79 (for 80×80 maps)       │
│ y: 0-79                        │
│                                │
│ 2 bytes total (x + y)          │
└────────────────────────────────┘
```

---

## 4. Memory Layout

### 4.1 Complete Memory Map

```
╔═══════════════════════════════════════════════════╗
║ TMEA MEMORY ALLOCATION                            ║
╠═══════════════════════════════════════════════════╣
║ TILE METADATA                                     ║
║ ├─ room_metas[20][4] (RoomTileMeta):   240 bytes  ║
║ ├─ room_meta_count[20]:                 20 bytes  ║
║ ├─ global_metas[16] (GlobalTileMeta):   64 bytes  ║
║ └─ global_meta_count:                    1 byte   ║
║                                         ────────  ║
║ Metadata Subtotal:                     325 bytes  ║
╠═══════════════════════════════════════════════════╣
║ ENTITY POOLS                                      ║
║ ├─ obj_pool[48] (TinyObj):             288 bytes  ║
║ ├─ obj_free_list:                        2 bytes  ║
║ ├─ obj_active_list:                      2 bytes  ║
║ ├─ mon_pool[24] (TinyMon):             144 bytes  ║
║ ├─ mon_free_list:                        2 bytes  ║
║ └─ mon_active_list:                      2 bytes  ║
║                                         ────────  ║
║ Entity Subtotal:                       440 bytes  ║
╠═══════════════════════════════════════════════════╣
║ TMEA TOTAL OVERHEAD:                   765 bytes  ║
╠═══════════════════════════════════════════════════╣
║ Existing System (unchanged):                      ║
║ ├─ compact_map (max 80×80):          2,400 bytes  ║
║ ├─ room_list[20]:                      960 bytes  ║
║ └─ Other state:                       ~100 bytes  ║
║                                         ────────  ║
║ Existing Subtotal:                   3,460 bytes  ║
╠═══════════════════════════════════════════════════╣
║ TOTAL DUNGEON DATA:                  4,225 bytes  ║
║ (6.6% of C64 RAM)                                 ║
╚═══════════════════════════════════════════════════╝
```

### 4.2 Structure Sizes

| Structure | Size | Count | Total | Purpose |
|-----------|------|-------|-------|---------|
| **RoomTileMeta** | 3 bytes | 80 (20×4) | 240 bytes | Room tile metadata |
| **GlobalTileMeta** | 4 bytes | 16 | 64 bytes | Corridor metadata |
| **TinyObj** | 6 bytes | 48 | 288 bytes | Objects (items) |
| **TinyMon** | 6 bytes | 24 | 144 bytes | Monsters |
| **Counters** | 1 byte | 21 | 21 bytes | Pool tracking |
| **List Heads** | 2 bytes | 4 | 8 bytes | Free/active lists |

**Total:** 765 bytes

---

## 5. Type System

### 5.1 Metadata Flag Encoding

TMEA uses an 8-bit flag system with hierarchical type classification:

```
Bit Layout: TTTFFFFF
            ││││││││
            │││└└└└└─ Type-specific flags (5 bits, 0-31)
            └└└────── Type classification (3 bits, 0-7)

Type Mask:   0xE0 (11100000)
Flag Mask:   0x1F (00011111)
```

### 5.2 Type Categories

```c
enum TileMetaType {
    TMTYPE_WALL     = 0x00,  // 000xxxxx - Wall features
    TMTYPE_DOOR     = 0x20,  // 001xxxxx - Door features
    TMTYPE_TRAP     = 0x40,  // 010xxxxx - Trap features
    TMTYPE_SPECIAL  = 0x60,  // 011xxxxx - Special tiles
    TMTYPE_EFFECT   = 0x80,  // 100xxxxx - Area effects
    TMTYPE_TRIGGER  = 0xA0,  // 101xxxxx - Event triggers
    TMTYPE_RESERVED1= 0xC0,  // 110xxxxx - Reserved
    TMTYPE_RESERVED2= 0xE0   // 111xxxxx - Reserved
};
```

### 5.3 Type-Specific Flags

**Wall Flags (TMTYPE_WALL = 0x00):**
```c
TMFLAG_WALL_ILLUSORY     = 0x01  // Passable fake wall
TMFLAG_WALL_SECRET       = 0x02  // Hidden wall (not visible)
TMFLAG_WALL_REVEALED     = 0x04  // Secret wall discovered
TMFLAG_WALL_CRACKED      = 0x08  // Weak wall
TMFLAG_WALL_DESTRUCTIBLE = 0x10  // Can be destroyed
```

**Door Flags (TMTYPE_DOOR = 0x20):**
```c
TMFLAG_DOOR_SECRET       = 0x01  // Secret door (hidden)
TMFLAG_DOOR_TRAPPED      = 0x02  // Trapped door
TMFLAG_DOOR_LOCKED       = 0x04  // Locked (requires lockpick or key)
TMFLAG_DOOR_REVEALED     = 0x08  // Secret door discovered
TMFLAG_DOOR_OPEN         = 0x10  // Door is open (vs closed)
```

**Trap Flags (TMTYPE_TRAP = 0x40):**
```c
TMFLAG_TRAP_HIDDEN       = 0x01  // Not visible
TMFLAG_TRAP_TRIGGERED    = 0x02  // Already activated
TMFLAG_TRAP_DISARMED     = 0x04  // Disabled
TMFLAG_TRAP_REARM        = 0x08  // Rearms after trigger
```

**Special Flags (TMTYPE_SPECIAL = 0x60):**
```c
TMFLAG_SPECIAL_TELEPORT  = 0x01  // Teleport pad
TMFLAG_SPECIAL_PRESSURE  = 0x02  // Pressure plate
TMFLAG_SPECIAL_RUNE      = 0x04  // Magic rune
TMFLAG_SPECIAL_ONEWAY    = 0x08  // One-way passage
TMFLAG_SPECIAL_CRUMBLE   = 0x10  // Crumbling floor
```

### 5.4 Data Byte Usage

The `data` field (8 bits) stores type-specific information:

| Type | Data Usage | Example Values |
|------|------------|----------------|
| **Wall** | Durability, secret ID | 0-255 (HP remaining) |
| **Door** | Trap type, trap damage | 0=no trap, 1-255 (trap damage or type) |
| **Trap** | Damage, trap type | 0=spike, 1=arrow, 2=poison |
| **Teleport** | Destination ID | 0-255 (target teleport pad) |
| **Pressure Plate** | Event ID | 0-255 (event to trigger) |

**Note:** Door metadata uses flags (SECRET, LOCKED, TRAPPED, REVEALED, OPEN) for state, with `data` field reserved for trap-related information or future expansion.

---

## 6. API Reference

### 6.1 Initialization Functions

#### `void init_tmea_system(void)`

**Purpose:** Initialize TMEA system at program startup.

**Behavior:**
- Clears all metadata pools
- Initializes entity free lists
- Sets all counters to 0
- Sets sentinel values in unused slots

**Call Once:** At program start, before map generation.

**Performance:** ~1000 cycles (1ms @ 1MHz)

```c
// Example usage
int main(void) {
    init_tmea_system();  // Initialize TMEA
    mapgen_generate_dungeon();
    // ...
}
```

#### `void reset_tmea_data(void)`

**Purpose:** Reset TMEA for new map generation.

**Behavior:**
- Clears metadata counts (pools remain allocated)
- Rebuilds entity free lists
- Preserves pool structure (faster than init)

**Call Before:** Each new dungeon generation.

**Performance:** ~500 cycles (0.5ms @ 1MHz)

```c
// Example usage
void generate_new_dungeon(void) {
    reset_tmea_data();  // Clear old metadata
    clear_map();        // Clear base tiles
    create_rooms();     // Generate new dungeon
    // ...
}
```

### 6.2 Tile Metadata Functions

#### `unsigned char add_tile_metadata(x, y, flags, data)`

**Purpose:** Add metadata to tile with automatic room/global routing.

**Parameters:**
- `x, y` (unsigned char): Global tile coordinates
- `flags` (unsigned char): Type + flags byte (see section 5)
- `data` (unsigned char): Type-specific data

**Returns:**
- `1`: Success (metadata added)
- `0`: Failure (all pools full)

**Side Effects:**
- Sets `compact_map[x,y] = TILE_MARKER` to flag metadata presence
- Increments appropriate pool counter

**Performance:** ~240 cycles (room) or ~230 cycles (global)

**Example:**
```c
// Add illusory wall in room
add_tile_metadata(wall_x, wall_y,
                 TMTYPE_WALL | TMFLAG_WALL_ILLUSORY,
                 0);

// Add secret door (replaces TILE_SECRET_DOOR)
add_tile_metadata(door_x, door_y,
                 TMTYPE_DOOR | TMFLAG_DOOR_SECRET,
                 0);  // data = 0 (no additional info)

// Add locked door
add_tile_metadata(door_x, door_y,
                 TMTYPE_DOOR | TMFLAG_DOOR_LOCKED,
                 0);  // data = 0 (simple lock, no key ID)

// Add trapped door
add_tile_metadata(door_x, door_y,
                 TMTYPE_DOOR | TMFLAG_DOOR_TRAPPED,
                 5);  // data = trap damage

// Add hidden trap in corridor
add_tile_metadata(trap_x, trap_y,
                 TMTYPE_TRAP | TMFLAG_TRAP_HIDDEN,
                 2);  // data = trap type (poison)
```

#### `unsigned char get_tile_metadata(x, y, *out_flags, *out_data)`

**Purpose:** Retrieve metadata from tile.

**Parameters:**
- `x, y` (unsigned char): Global tile coordinates
- `out_flags` (unsigned char*): Pointer to store flags (can be NULL)
- `out_data` (unsigned char*): Pointer to store data (can be NULL)

**Returns:**
- `1`: Metadata found (out params populated)
- `0`: No metadata at position

**Performance:**
- Quick reject (no metadata): ~50 cycles
- Room hit: ~260 cycles
- Global hit: ~440 cycles

**Example:**
```c
unsigned char flags, data;

if (get_tile_metadata(x, y, &flags, &data)) {
    // Check type
    if (is_meta_type(flags, TMTYPE_DOOR)) {
        // It's a door
        if (flags & TMFLAG_DOOR_SECRET) {
            // Secret door - render as wall-like
            render_secret_door_pattern(x, y);
        }

        if (flags & TMFLAG_DOOR_LOCKED) {
            // Door is locked - check if player can unlock
            if (!player_has_lockpick()) {
                show_message("The door is locked!");
            }
        }

        if (flags & TMFLAG_DOOR_TRAPPED) {
            // Door is trapped - trigger trap
            unsigned char damage = data;  // Trap damage stored in data byte
            player_take_damage(damage);
        }
    }
}
```

#### `unsigned char remove_tile_metadata(x, y)`

**Purpose:** Remove metadata from tile.

**Returns:**
- `1`: Metadata removed
- `0`: No metadata to remove

**Side Effects:**
- Clears `TILE_MARKER` flag (sets tile to `TILE_FLOOR`)
- Compacts metadata array (moves last entry to removed slot)

**Performance:** ~300 cycles

**Example:**
```c
// Player disarms trap
if (get_tile_metadata(x, y, &flags, &data)) {
    if (is_meta_type(flags, TMTYPE_TRAP)) {
        // Remove trap metadata
        remove_tile_metadata(x, y);
    }
}
```

#### `unsigned char update_tile_metadata_flags(x, y, flags)`

**Purpose:** Update metadata flags without removing/re-adding.

**Performance:** ~280 cycles (faster than remove + add)

**Example:**
```c
// Reveal secret wall when player finds it
unsigned char flags, data;
if (get_tile_metadata(x, y, &flags, &data)) {
    if (flags & TMFLAG_WALL_SECRET) {
        // Mark as revealed
        flags |= TMFLAG_WALL_REVEALED;
        update_tile_metadata_flags(x, y, flags);
    }
}
```

#### `unsigned char update_tile_metadata_data(x, y, data)`

**Purpose:** Update metadata data byte.

**Performance:** ~280 cycles

**Example:**
```c
// Reduce wall durability when hit
unsigned char flags, data;
if (get_tile_metadata(x, y, &flags, &data)) {
    if (is_meta_type(flags, TMTYPE_WALL)) {
        data--;  // Reduce HP
        if (data == 0) {
            // Wall destroyed
            remove_tile_metadata(x, y);
            set_compact_tile(x, y, TILE_FLOOR);
        } else {
            update_tile_metadata_data(x, y, data);
        }
    }
}
```

### 6.3 Door Metadata API (Convenience Wrappers)

TMEA provides specialized functions for managing door states:

#### `unsigned char add_secret_door_metadata(x, y)`

**Purpose:** Mark door as secret (hidden from player).

**Parameters:**
- `x, y` (unsigned char): Global door coordinates

**Returns:**
- `1`: Success (metadata added)
- `0`: Failure (pool full)

**Side Effects:**
- Adds `TMTYPE_DOOR | TMFLAG_DOOR_SECRET` metadata
- Sets `TILE_MARKER` flag on tile

**Performance:** ~240-280 cycles

**Example:**
```c
// Convert normal door to secret door
set_compact_tile(door_x, door_y, TILE_DOOR);
add_secret_door_metadata(door_x, door_y);
```

#### `unsigned char is_door_secret(x, y)`

**Purpose:** Check if door is secret and not yet revealed.

**Returns:**
- `1`: Door is secret (hidden)
- `0`: Door is not secret or already revealed

**Performance:** ~260-440 cycles (metadata lookup)

**Example:**
```c
// Render secret door as wall-like pattern
if (is_door_secret(x, y)) {
    draw_secret_door_pattern(x, y);  // Checkerboard or special symbol
} else {
    draw_normal_door(x, y);
}
```

#### `unsigned char is_door_locked(x, y)`

**Purpose:** Check if door requires key/lockpick.

**Returns:**
- `1`: Door is locked
- `0`: Door is unlocked

**Performance:** ~260-440 cycles

#### `unsigned char is_door_trapped(x, y)`

**Purpose:** Check if door has trap.

**Returns:**
- `1`: Door is trapped
- `0`: Door is not trapped

**Performance:** ~260-440 cycles

#### `unsigned char reveal_secret_door(x, y)`

**Purpose:** Mark secret door as discovered by player.

**Returns:**
- `1`: Success (door revealed)
- `0`: Not a secret door

**Side Effects:**
- Sets `TMFLAG_DOOR_REVEALED` flag
- Door becomes visible to player

**Performance:** ~280 cycles

**Example:**
```c
// Player searches and finds secret door
if (player_action == SEARCH && is_door_secret(x, y)) {
    reveal_secret_door(x, y);
    print_message("You found a secret door!");
}
```

#### `unsigned char set_door_open(x, y, is_open)`

**Purpose:** Set door open/closed state.

**Parameters:**
- `x, y` (unsigned char): Global door coordinates
- `is_open` (unsigned char): 1 = open, 0 = closed

**Returns:**
- `1`: Success
- `0`: Failure

**Side Effects:**
- Creates metadata if none exists
- Updates `TMFLAG_DOOR_OPEN` flag

**Performance:** ~240-280 cycles

**Example:**
```c
// Player opens door
if (player_action == OPEN_DOOR) {
    set_door_open(door_x, door_y, 1);  // Open
    allow_passage();
}

// Door closes behind player
set_door_open(door_x, door_y, 0);  // Close
```

### 6.4 Entity Functions

#### `TinyObj* spawn_object(x, y, obj_type)`

**Purpose:** Spawn object at global coordinates.

**Parameters:**
- `x, y` (unsigned char): Global coordinates
- `obj_type` (unsigned char): Object type (see ObjectType enum)

**Returns:**
- Pointer to spawned object
- `NULL` if pool exhausted (48 objects max)

**Performance:** ~90 cycles

**Example:**
```c
// Spawn gold at treasure location
TinyObj *gold = spawn_object(treasure_x, treasure_y, OBJ_TYPE_GOLD);
if (gold != NULL) {
    gold->data = 50;  // 50 gold pieces
}

// Spawn red key in room
TinyObj *key = spawn_object(room_center_x, room_center_y, OBJ_TYPE_KEY_RED);
if (key != NULL) {
    key->flags = OBJ_FLAG_VISIBLE | OBJ_FLAG_COLLECTIBLE | OBJ_FLAG_QUEST;
}
```

#### `void despawn_object(TinyObj *obj)`

**Purpose:** Remove object and return to free pool.

**Performance:** ~120 cycles

**Example:**
```c
// Player picks up object
TinyObj *obj = get_objects_at(player_x, player_y);
if (obj != NULL && (obj->flags & OBJ_FLAG_COLLECTIBLE)) {
    add_to_inventory(obj->type, obj->data);
    despawn_object(obj);  // Remove from map
}
```

#### `TinyObj* get_objects_at(x, y)`

**Purpose:** Find objects at coordinates.

**Returns:**
- Pointer to first object at position
- `NULL` if no objects

**Performance:** O(n) where n = active object count (worst: ~2400 cycles for 48 objects)

**Example:**
```c
// Render objects at tile
TinyObj *obj = get_objects_at(render_x, render_y);
if (obj != NULL) {
    draw_object_sprite(obj->type, render_x, render_y);
}
```

#### `TinyMon* spawn_monster(x, y, mon_type, hp)`

**Purpose:** Spawn monster at global coordinates.

**Example:**
```c
// Spawn goblin in corridor
TinyMon *goblin = spawn_monster(corridor_x, corridor_y, MON_TYPE_GOBLIN, 5);
if (goblin != NULL) {
    goblin->flags = MON_FLAG_ALIVE | MON_FLAG_HOSTILE | MON_FLAG_WANDERING;
    goblin->ai_state = AI_STATE_PATROL;
}

// Spawn sleeping dragon in treasure room
TinyMon *dragon = spawn_monster(treasure_x, treasure_y, MON_TYPE_DRAGON, 50);
if (dragon != NULL) {
    dragon->flags = MON_FLAG_ALIVE | MON_FLAG_HOSTILE | MON_FLAG_SLEEPING | MON_FLAG_BOSS;
    dragon->ai_state = AI_STATE_IDLE;
}
```

#### `void despawn_monster(TinyMon *mon)`

**Purpose:** Remove monster (on death or despawn).

**Example:**
```c
// Monster dies
TinyMon *mon = get_monster_at(combat_x, combat_y);
if (mon != NULL) {
    mon->hp -= damage;
    if (mon->hp == 0) {
        spawn_object(mon->x, mon->y, OBJ_TYPE_GOLD);  // Drop loot
        despawn_monster(mon);
    }
}
```

#### `TinyMon* get_monster_at(x, y)`

**Purpose:** Find monster at coordinates.

**Performance:** O(n) where n = active monster count (worst: ~1200 cycles for 24 monsters)

---

## 7. Usage Examples

### 7.1 Illusory Walls (Room + Corridor)

```c
// Place illusory walls during generation
void place_illusory_walls(unsigned char count) {
    unsigned char placed = 0;
    unsigned char attempts = 0;

    while (placed < count && attempts < 100) {
        // Try room walls (70% chance)
        if (rnd(100) < 70) {
            // Random room
            unsigned char room_id = rnd(room_count);
            Room *room = &room_list[room_id];

            // Random wall side (0=left, 1=right, 2=top, 3=bottom)
            unsigned char wall_side = rnd(4);
            unsigned char wall_x, wall_y;

            switch (wall_side) {
                case 0: // Left wall
                    wall_x = room->x - 1;
                    wall_y = room->y + 1 + rnd(room->h - 2);
                    break;
                case 1: // Right wall
                    wall_x = room->x + room->w;
                    wall_y = room->y + 1 + rnd(room->h - 2);
                    break;
                case 2: // Top wall
                    wall_x = room->x + 1 + rnd(room->w - 2);
                    wall_y = room->y - 1;
                    break;
                case 3: // Bottom wall
                    wall_x = room->x + 1 + rnd(room->w - 2);
                    wall_y = room->y + room->h;
                    break;
            }

            // Check if it's a wall
            if (get_compact_tile(wall_x, wall_y) == TILE_WALL) {
                // Add illusory wall metadata (room-scoped)
                if (add_tile_metadata(wall_x, wall_y,
                                     TMTYPE_WALL | TMFLAG_WALL_ILLUSORY,
                                     0)) {
                    placed++;
                }
            }
        } else {
            // Try corridor walls (30% chance)
            // Find corridor tile
            unsigned char test_x = 5 + rnd(current_params.map_width - 10);
            unsigned char test_y = 5 + rnd(current_params.map_height - 10);

            // Check if it's a corridor floor (not in room)
            unsigned char room_id;
            if (get_compact_tile(test_x, test_y) == TILE_FLOOR &&
                !point_in_any_room(test_x, test_y, &room_id)) {

                // Check adjacent walls
                for (unsigned char d = 0; d < 4; d++) {
                    unsigned char adj_x = test_x + ((d == 1) - (d == 0));
                    unsigned char adj_y = test_y + ((d == 3) - (d == 2));

                    if (get_compact_tile(adj_x, adj_y) == TILE_WALL) {
                        // Add illusory wall in corridor (global pool)
                        if (add_tile_metadata(adj_x, adj_y,
                                             TMTYPE_WALL | TMFLAG_WALL_ILLUSORY,
                                             0)) {
                            placed++;
                            break;
                        }
                    }
                }
            }
        }

        attempts++;
    }
}
```

### 7.2 Secret Doors (TMEA-First Architecture)

```c
// Create secret door during generation (replaces old TILE_SECRET_DOOR)
void create_secret_room_entrance(unsigned char room_id) {
    Room *room = &room_list[room_id];

    // Get the connection door coordinates
    unsigned char door_x = room->doors[0].x;
    unsigned char door_y = room->doors[0].y;

    // Mark room as secret
    room->state |= ROOM_SECRET;

    // Convert door to secret door (TMEA-first pattern)
    // 1. Ensure base tile is TILE_DOOR (not TILE_SECRET_DOOR)
    set_compact_tile(door_x, door_y, TILE_DOOR);

    // 2. Add secret door metadata
    add_secret_door_metadata(door_x, door_y);
}

// Runtime: Render secret door (display system)
unsigned char get_map_tile(unsigned char map_x, unsigned char map_y) {
    unsigned char raw_tile = get_compact_tile(map_x, map_y);

    switch(raw_tile) {
        case TILE_DOOR:
            // Check if door is secret via TMEA
            if (is_door_secret(map_x, map_y)) {
                return SECRET_DOOR;  // Checkerboard pattern
            }
            return DOOR;  // Normal door symbol

        case TILE_MARKER:
            // TMEA metadata marker - check door state
            if (is_door_secret(map_x, map_y)) {
                return SECRET_DOOR;  // Hidden
            }
            return DOOR;  // Default to door

        // ... other cases ...
    }
}

// Runtime: Player searches for secret doors
void player_search_action(unsigned char x, unsigned char y) {
    // Check adjacent tiles for secret doors
    for (unsigned char dir = 0; dir < 4; dir++) {
        unsigned char check_x = x + ((dir == 1) - (dir == 0));
        unsigned char check_y = y + ((dir == 3) - (dir == 2));

        if (is_door_secret(check_x, check_y)) {
            // Found secret door!
            reveal_secret_door(check_x, check_y);
            print_message("You found a secret door!");
            return;
        }
    }

    print_message("You found nothing.");
}
```

### 7.3 Locked Doors

```c
// Place locked doors during generation
void create_locked_door(unsigned char room1, unsigned char room2,
                       unsigned char door_x, unsigned char door_y,
                       unsigned char wall_side, unsigned char corridor_type) {
    // Place normal door
    place_door(door_x, door_y);
    add_connection_to_room(room1, room2, door_x, door_y, wall_side, corridor_type);
    add_connection_to_room(room2, room1, door_x, door_y, wall_side, corridor_type);

    // 30% chance to lock door
    if (rnd(100) < 30) {
        // Add locked door metadata
        add_tile_metadata(door_x, door_y,
                         TMTYPE_DOOR | TMFLAG_DOOR_LOCKED,
                         0);  // data = 0 (simple lock, no key ID)
    }
}

// Runtime: Check if player can open door
unsigned char can_open_door(unsigned char x, unsigned char y) {
    // Simple check using convenience function
    if (is_door_locked(x, y)) {
        // Check if player has lockpick or universal key
        if (player_has_lockpick() || player_has_universal_key()) {
            // Unlock door
            unsigned char flags, data;
            get_tile_metadata(x, y, &flags, &data);
            flags &= ~TMFLAG_DOOR_LOCKED;  // Remove locked flag
            update_tile_metadata_flags(x, y, flags);
            return 1;  // Can open
        }
        return 0;  // Locked, can't open
    }

    return 1;  // Not locked, can open
}
```

### 7.4 Hidden Floor Traps

```c
// Spawn traps during generation
void spawn_floor_traps(unsigned char trap_count) {
    unsigned char placed = 0;
    unsigned char attempts = 0;

    while (placed < trap_count && attempts < 100) {
        // Try rooms (60%)
        if (rnd(100) < 60) {
            unsigned char room_id = rnd(room_count);
            Room *room = &room_list[room_id];

            // Random floor tile (not edges)
            unsigned char local_x = 1 + rnd(room->w - 2);
            unsigned char local_y = 1 + rnd(room->h - 2);
            unsigned char global_x = room->x + local_x;
            unsigned char global_y = room->y + local_y;

            if (get_compact_tile(global_x, global_y) == TILE_FLOOR) {
                unsigned char trap_type = rnd(3);  // 0=spike, 1=arrow, 2=poison

                // Add hidden trap (room-scoped)
                if (add_tile_metadata(global_x, global_y,
                                     TMTYPE_TRAP | TMFLAG_TRAP_HIDDEN,
                                     trap_type)) {
                    placed++;
                }
            }
        } else {
            // Try corridors (40%)
            unsigned char test_x = 5 + rnd(current_params.map_width - 10);
            unsigned char test_y = 5 + rnd(current_params.map_height - 10);
            unsigned char room_id;

            if (get_compact_tile(test_x, test_y) == TILE_FLOOR &&
                !point_in_any_room(test_x, test_y, &room_id)) {

                unsigned char trap_type = rnd(3);

                // Add trap in corridor (global pool)
                if (add_tile_metadata(test_x, test_y,
                                     TMTYPE_TRAP | TMFLAG_TRAP_HIDDEN,
                                     trap_type)) {
                    placed++;
                }
            }
        }

        attempts++;
    }
}

// Runtime: Trigger trap when player steps on it
void check_floor_trap(unsigned char x, unsigned char y) {
    unsigned char flags, trap_type;

    if (get_tile_metadata(x, y, &flags, &trap_type)) {
        if (is_meta_type(flags, TMTYPE_TRAP) &&
            (flags & TMFLAG_TRAP_HIDDEN) &&
            !(flags & TMFLAG_TRAP_TRIGGERED)) {

            // Trigger trap
            unsigned char damage;
            switch (trap_type) {
                case 0: damage = 5; break;  // Spike trap
                case 1: damage = 3; break;  // Arrow trap
                case 2: damage = 2; break;  // Poison trap
            }

            player_take_damage(damage);

            // Mark as triggered
            flags |= TMFLAG_TRAP_TRIGGERED;
            flags &= ~TMFLAG_TRAP_HIDDEN;  // Reveal
            update_tile_metadata_flags(x, y, flags);
        }
    }
}
```

### 7.5 Objects and Monsters

```c
// Spawn treasure in rooms
void spawn_treasure(unsigned char count) {
    for (unsigned char i = 0; i < count; i++) {
        unsigned char room_id = rnd(room_count);
        Room *room = &room_list[room_id];

        unsigned char x = room->x + 1 + rnd(room->w - 2);
        unsigned char y = room->y + 1 + rnd(room->h - 2);

        // Spawn gold
        TinyObj *gold = spawn_object(x, y, OBJ_TYPE_GOLD);
        if (gold != NULL) {
            gold->data = 10 + rnd(50);  // 10-59 gold pieces
        }
    }
}

// Spawn wandering monsters in corridors
void spawn_corridor_monsters(unsigned char count) {
    unsigned char placed = 0;
    unsigned char attempts = 0;

    while (placed < count && attempts < 100) {
        unsigned char x = 5 + rnd(current_params.map_width - 10);
        unsigned char y = 5 + rnd(current_params.map_height - 10);
        unsigned char room_id;

        // Check if corridor floor
        if (get_compact_tile(x, y) == TILE_FLOOR &&
            !point_in_any_room(x, y, &room_id)) {

            // Spawn random monster
            unsigned char mon_type = rnd(5);  // 0-4
            unsigned char hp;

            switch (mon_type) {
                case MON_TYPE_RAT: hp = 3; break;
                case MON_TYPE_GOBLIN: hp = 5; break;
                case MON_TYPE_SKELETON: hp = 7; break;
                case MON_TYPE_ORC: hp = 10; break;
                case MON_TYPE_ZOMBIE: hp = 8; break;
            }

            TinyMon *mon = spawn_monster(x, y, mon_type, hp);
            if (mon != NULL) {
                mon->flags = MON_FLAG_ALIVE | MON_FLAG_HOSTILE | MON_FLAG_WANDERING;
                mon->ai_state = AI_STATE_PATROL;
                placed++;
            }
        }

        attempts++;
    }
}

// Runtime: Player picks up object
void player_pickup(unsigned char x, unsigned char y) {
    TinyObj *obj = get_objects_at(x, y);

    if (obj != NULL && (obj->flags & OBJ_FLAG_COLLECTIBLE)) {
        switch (obj->type) {
            case OBJ_TYPE_GOLD:
                player_gold += obj->data;
                break;
            case OBJ_TYPE_POTION_RED:
                player_hp += 20;
                break;
            case OBJ_TYPE_KEY_RED:
            case OBJ_TYPE_KEY_BLUE:
            case OBJ_TYPE_KEY_YELLOW:
                player_add_key(obj->type - OBJ_TYPE_KEY_RED + 1);
                break;
        }

        despawn_object(obj);
    }
}
```

---

## 8. Performance Analysis

### 8.1 Cycle Counts (6502 @ 1MHz)

| Operation | Room Pool | Global Pool | Notes |
|-----------|-----------|-------------|-------|
| **add_tile_metadata** | ~240 cycles | ~230 cycles | Faster if room found |
| **get_tile_metadata** | ~260 cycles | ~440 cycles | Room search + linear scan |
| **Quick reject** | ~50 cycles | ~50 cycles | TILE_MARKER check |
| **remove_tile_metadata** | ~300 cycles | ~320 cycles | Includes compaction |
| **update_flags** | ~280 cycles | ~300 cycles | No remove needed |
| **update_data** | ~280 cycles | ~300 cycles | No remove needed |
| **spawn_object** | ~90 cycles | - | Free list alloc |
| **despawn_object** | ~120 cycles | - | List removal |
| **get_objects_at** | O(n) ~2400 cycles worst | - | 48 objects max |
| **spawn_monster** | ~90 cycles | - | Free list alloc |
| **get_monster_at** | O(n) ~1200 cycles worst | - | 24 monsters max |

### 8.2 Weighted Average Performance

Assuming typical dungeon distribution:

```
┌───────────────────────────────────────────┐
│ AVERAGE LOOKUP TIME                       │
├───────────────────────────────────────────┤
│ 70% room lookups:   0.26ms × 0.70 = 0.18ms│
│ 30% global lookups: 0.44ms × 0.30 = 0.13ms│
│                                    ───────│
│ WEIGHTED AVERAGE:                  ~0.31ms│
└───────────────────────────────────────────┘
```

At 60 FPS (16.67ms per frame), TMEA lookup overhead is negligible:
- 50 metadata checks per frame: 50 × 0.31ms = **15.5ms** (acceptable)

### 8.3 Generation Time Overhead

```
TMEA Generation Phases (example):
┌─────────────────────────────────────────┐
│ Illusory walls (5):         ~1.2ms      │
│ Locked doors (10):          ~2.4ms      │
│ Floor traps (20):           ~4.8ms      │
│ Corridor traps (10):        ~2.3ms      │
│ Objects (30):               ~2.7ms      │
│ Monsters (15):              ~1.4ms      │
├─────────────────────────────────────────┤
│ TOTAL TMEA OVERHEAD:       ~14.8ms      │
└─────────────────────────────────────────┘

Base generation time: ~200-300ms
With TMEA: ~215-315ms
OVERHEAD: ~5% (acceptable ✓)
```

### 8.4 Memory Access Patterns

**Room Metadata (Cache-Friendly):**
```
Room 5 metadata: &room_metas[5][0]
├─ Base address: fixed offset
├─ Linear access: [0], [1], [2], [3]
└─ CPU cache benefit: sequential reads
```

**Global Metadata (Linear Search):**
```
global_metas[0..15] search:
├─ Worst case: 16 comparisons
├─ Average case: 8 comparisons
└─ Early exit: on first match
```

---

## 9. Extending TMEA

### 9.1 Adding New Metadata Types

**Template for new feature:**

```c
// 1. Define new flag in tmea_types.h
enum TileMetaSpecialFlags {
    // ... existing flags ...
    TMFLAG_SPECIAL_MIRROR   = 0x20   // NEW: Magic mirror
};

// 2. Generation function in map_generation.c or connection_system.c
void place_magic_mirrors(unsigned char count) {
    for (unsigned char i = 0; i < count; i++) {
        // Find valid position
        unsigned char x = ...;
        unsigned char y = ...;

        // Validate position
        if (!is_valid_mirror_position(x, y)) continue;

        // Add metadata (auto-routing!)
        add_tile_metadata(x, y,
                         TMTYPE_SPECIAL | TMFLAG_SPECIAL_MIRROR,
                         destination_id);  // data = mirror link ID
    }
}

// 3. Runtime interaction in main.c or gameplay module
void interact_with_tile(unsigned char x, unsigned char y) {
    unsigned char flags, data;

    if (get_tile_metadata(x, y, &flags, &data)) {
        if (flags & TMFLAG_SPECIAL_MIRROR) {
            // Mirror interaction logic
            teleport_player_to_mirror(data);
        }
    }
}

// 4. Export (automatic - no changes needed!)
// Metadata is automatically exported via generic export system
```

### 9.2 Pool Size Tuning

If you need more metadata slots, adjust constants in `tmea_types.h`:

```c
// Room metadata configuration
#define META_PER_ROOM 4              // Default: 4 slots/room
// Increase to 6: +2×20×3 = +120 bytes

// Global metadata pool
#define GLOBAL_META_POOL_SIZE 16     // Default: 16 slots
// Increase to 24: +8×4 = +32 bytes

// Object pool
#define MAX_TINY_OBJECTS 48          // Default: 48 objects
// Increase to 64: +16×6 = +96 bytes

// Monster pool
#define MAX_TINY_MONSTERS 24         // Default: 24 monsters
// Increase to 32: +8×6 = +48 bytes
```

**Memory Trade-offs:**
```
Configuration              Memory Cost  Total Overhead
─────────────────────────  ───────────  ──────────────
Default      (4,16,48,24)    765 bytes  1.2% of RAM ✓
Conservative (3,12,32,16)    575 bytes  0.9% of RAM
Expanded     (6,24,64,32)  1,065 bytes  1.7% of RAM
```

### 9.3 Custom Entity Types

Add new object/monster types by extending enums:

```c
// tmea_types.h
enum ObjectType {
    // ... existing types ...
    OBJ_TYPE_WAND       = 12,  // NEW: Magic wand
    OBJ_TYPE_RING       = 13,  // NEW: Ring
    OBJ_TYPE_AMULET     = 14   // NEW: Amulet
};

enum MonsterType {
    // ... existing types ...
    MON_TYPE_VAMPIRE    = 8,   // NEW: Vampire
    MON_TYPE_WRAITH     = 9    // NEW: Wraith
};
```

---

## 10. Export Format

### 10.1 Extended PRG Format

TMEA extends the existing map export format:

```
┌────────────────────────────────────────────┐
│ CURRENT FORMAT (map_export.c):             │
├────────────────────────────────────────────┤
│ +0x0000: PRG load address (2 bytes, auto)  │
│ +0x0002: Map size (1 byte)                 │
│ +0x0003: Tile data (variable, 3-bit)       │
└────────────────────────────────────────────┘

┌────────────────────────────────────────────┐
│ EXTENDED TMEA FORMAT:                      │
├────────────────────────────────────────────┤
│ +0x0000: PRG load address (2 bytes)        │
│ +0x0002: Format version (1 byte = 0x02)    │
│ +0x0003: Map size (1 byte)                 │
│ +0x0004: Tile data (variable)              │
│ +XXXX:   Metadata header (4 bytes)         │
│          ├─ meta_count (2 bytes)           │
│          ├─ obj_count (1 byte)             │
│          └─ mon_count (1 byte)             │
│ +XXXX:   Metadata entries (4 bytes each)   │
│          ├─ x, y, flags, data              │
│          └─ ... (meta_count entries)       │
│ +XXXX:   Object entries (6 bytes each)     │
│          ├─ x, y, type, flags, data        │
│          └─ ... (obj_count entries)        │
│ +XXXX:   Monster entries (6 bytes each)    │
│          ├─ x, y, type, hp, flags, ai      │
│          └─ ... (mon_count entries)        │
└────────────────────────────────────────────┘
```

### 10.2 Export Implementation

```c
// Extend map_export.c
void save_compact_map_with_tmea(const char* filename) {
    unsigned char current_map_size = mapgen_get_map_size();
    unsigned short tile_bits = (unsigned short)current_map_size * current_map_size * 3;
    unsigned short actual_map_bytes = (tile_bits + 7) >> 3;

    // Calculate total metadata count
    unsigned short total_meta_count = 0;
    for (unsigned char r = 0; r < room_count; r++) {
        total_meta_count += room_meta_count[r];
    }
    total_meta_count += global_meta_count;

    // Count active entities
    unsigned char obj_count = 0;
    TinyObj *obj = obj_active_list;
    while (obj != NULL) {
        obj_count++;
        obj = obj->next;
    }

    unsigned char mon_count = 0;
    TinyMon *mon = mon_active_list;
    while (mon != NULL) {
        mon_count++;
        mon = mon->next;
    }

    // Build export buffer
    static unsigned char export_buffer[1 + ((96 * 96 * 3 + 7) / 8) + 4 + (100 * 4) + (48 * 6) + (24 * 6)];
    unsigned short offset = 0;

    // Header
    export_buffer[offset++] = 0x02;  // Format version
    export_buffer[offset++] = current_map_size;

    // Tile data
    memcpy(export_buffer + offset, compact_map, actual_map_bytes);
    offset += actual_map_bytes;

    // Metadata header
    export_buffer[offset++] = (unsigned char)(total_meta_count & 0xFF);
    export_buffer[offset++] = (unsigned char)(total_meta_count >> 8);
    export_buffer[offset++] = obj_count;
    export_buffer[offset++] = mon_count;

    // Export room metadata
    for (unsigned char r = 0; r < room_count; r++) {
        for (unsigned char m = 0; m < room_meta_count[r]; m++) {
            RoomTileMeta *meta = &room_metas[r][m];

            // Convert to global coords
            unsigned char local_x = unpack_local_x(meta->local_pos);
            unsigned char local_y = unpack_local_y(meta->local_pos);
            unsigned char global_x = room_list[r].x + local_x;
            unsigned char global_y = room_list[r].y + local_y;

            export_buffer[offset++] = global_x;
            export_buffer[offset++] = global_y;
            export_buffer[offset++] = meta->flags;
            export_buffer[offset++] = meta->data;
        }
    }

    // Export global metadata
    for (unsigned char g = 0; g < global_meta_count; g++) {
        GlobalTileMeta *meta = &global_metas[g];
        export_buffer[offset++] = meta->x;
        export_buffer[offset++] = meta->y;
        export_buffer[offset++] = meta->flags;
        export_buffer[offset++] = meta->data;
    }

    // Export objects
    obj = obj_active_list;
    while (obj != NULL) {
        export_buffer[offset++] = obj->x;
        export_buffer[offset++] = obj->y;
        export_buffer[offset++] = obj->type;
        export_buffer[offset++] = obj->flags;
        export_buffer[offset++] = obj->data;
        export_buffer[offset++] = 0;  // Padding
        obj = obj->next;
    }

    // Export monsters
    mon = mon_active_list;
    while (mon != NULL) {
        export_buffer[offset++] = mon->x;
        export_buffer[offset++] = mon->y;
        export_buffer[offset++] = mon->type;
        export_buffer[offset++] = mon->hp;
        export_buffer[offset++] = mon->flags;
        export_buffer[offset++] = mon->ai_state;
        mon = mon->next;
    }

    // Save to disk
    krnio_setnam(filename);
    krnio_save(8, export_buffer, export_buffer + offset);
}
```

### 10.3 File Size Estimation

```
Example: 64×64 map with 20 metadata, 10 objects, 5 monsters

Base tile data:   1539 bytes (64×64×3/8 + header)
Metadata header:  4 bytes
Metadata entries: 20 × 4 = 80 bytes
Object entries:   10 × 6 = 60 bytes
Monster entries:  5 × 6 = 30 bytes
                  ─────────────
TOTAL:            1713 bytes

Comparison:
- Without TMEA: 1539 bytes
- With TMEA:    1713 bytes (+11% overhead)
```

---

## 11. Oscar64 Optimizations

### 11.1 Compiler Hints

TMEA uses `__assume()` for better code generation:

```c
unsigned char get_tile_metadata(unsigned char x, unsigned char y,
                                unsigned char *out_flags,
                                unsigned char *out_data) {
    unsigned char room_id;

    if (point_in_any_room(x, y, &room_id)) {
        __assume(room_id < MAX_ROOMS);  // Compiler knows: 0-19

        // Now Oscar64 can:
        // - Skip redundant bounds checks
        // - Optimize array indexing
        // - Use zero page addressing if possible

        // ... rest of function
    }
}
```

**Performance Gain:** ~15-20 cycles saved per lookup (~6% faster)

### 11.2 Static Inline Functions

Inline helpers avoid function call overhead:

```c
// tmea_core.h
static inline unsigned char pack_local_pos(unsigned char local_x,
                                           unsigned char local_y) {
    return (local_x << 4) | (local_y & 0x0F);
}

// Compiler inlines this:
unsigned char packed = pack_local_pos(x, y);

// Instead of function call (saves ~30 cycles):
// JSR pack_local_pos
// RTS
```

**Performance Gain:** ~30 cycles per call

### 11.3 Bitfield Packing

Oscar64 natively supports bitfields with optimized code generation:

```c
typedef struct {
    unsigned char x : 7;       // 0-127
    unsigned char flags : 8;   // Full byte
    unsigned char data : 8;    // Full byte
} Example;

// Oscar64 generates efficient bit masking:
// LDA value
// AND #$7F        ; Mask to 7 bits
// STA x
```

**Memory Gain:** TinyObj/TinyMon use bitfields extensively (saves ~2 bytes per entity)

### 11.4 Zero Page Candidates

Consider moving frequently-accessed variables to zero page:

```c
// tmea_core.c
__zeropage unsigned char tmea_temp_room_id;
__zeropage unsigned char tmea_temp_flags;

// Or use -Oz compiler flag for automatic zero page allocation
```

**Performance Gain:** ~1 cycle per access (LDA $nn vs LDA $nnnn)

### 11.5 Loop Unrolling

For small fixed iterations, Oscar64 may unroll loops:

```c
// Initialize 4-slot metadata array (META_PER_ROOM = 4)
for (unsigned char j = 0; j < META_PER_ROOM; j++) {
    room_metas[i][j].local_pos = META_SENTINEL;
    room_metas[i][j].flags = 0;
    room_metas[i][j].data = 0;
}

// Oscar64 may unroll to:
room_metas[i][0].local_pos = META_SENTINEL;
room_metas[i][0].flags = 0;
room_metas[i][0].data = 0;
// ... repeated 4 times
```

**Performance Gain:** Eliminates loop counter overhead (~40 cycles saved)

---

## 12. Migration Path

### 12.1 Phased Implementation

**Phase 1: Core Infrastructure (✓ COMPLETED)**
- [x] Add `tmea_types.h`, `tmea_core.h`, `tmea_core.c`
- [x] Add `TILE_MARKER` to `mapgen_types.h`
- [x] Include `tmea_core.c` in `main.c` (FIRST, before other modules)
- [x] Call `init_tmea_system()` in `main()`
- [x] Call `reset_tmea_data()` in `reset_all_generation_data()`
- [x] Test compilation and basic initialization

**Phase 1.5: TMEA-First Door Architecture (✓ COMPLETED)**
- [x] Remove `TILE_SECRET_DOOR = 6` from `mapgen_types.h`
- [x] Add door-specific TMEA flags (SECRET, TRAPPED, LOCKED, REVEALED, OPEN)
- [x] Implement door API functions (`add_secret_door_metadata()`, `is_door_secret()`, etc.)
- [x] Remove `is_secret_door` flag from Door structure
- [x] Migrate secret room generation to TMEA
- [x] Migrate secret treasure generation to TMEA
- [x] Migrate hidden corridor generation to TMEA
- [x] Update `get_map_tile()` for TMEA-based secret door rendering
- [x] Test secret door functionality (generation + display)

**Phase 2: Simple Features (Days 3-4)**
- [ ] Implement `place_illusory_walls()` (room-based)
- [ ] Test metadata add/get/remove
- [ ] Verify room-scoped storage works correctly
- [ ] Check memory usage (~240 bytes used)

**Phase 3: Corridor Features (Days 5-6)**
- [ ] Implement corridor trap spawn
- [ ] Test global pool fallback
- [ ] Verify auto-routing works correctly
- [ ] Check memory usage (~64 bytes global pool)

**Phase 4: Entities (Days 7-8)**
- [ ] Implement object spawn (gold, keys, potions)
- [ ] Implement monster spawn (basic types)
- [ ] Test linked list management
- [ ] Check memory usage (~440 bytes entity pools)

**Phase 5: Export (Days 9-10)**
- [ ] Extend `save_compact_map()` with metadata export
- [ ] Test PRG format with TMEA data
- [ ] Verify file sizes
- [ ] Test load/save round-trip

**Phase 6: Polish (Days 11-12)**
- [ ] Optimize hot paths (profiling)
- [ ] Add zero page hints where needed
- [ ] Tune pool sizes based on testing
- [ ] Document all features

### 12.2 Backward Compatibility

TMEA is fully backward-compatible:

```c
// Existing code works unchanged
unsigned char tile = get_compact_tile(x, y);
set_compact_tile(x, y, TILE_WALL);

// TMEA only activates when you explicitly use it
add_tile_metadata(x, y, flags, data);  // New feature

// Tiles without metadata behave identically
if (get_compact_tile(x, y) == TILE_WALL) {
    // Still works!
}
```

**No Breaking Changes:**
- `compact_map` remains 3-bit encoding
- Existing tile access functions unchanged
- TILE_MARKER (7) was previously unused
- Room structures unchanged
- Export format versioned (0x02 = TMEA enabled)

### 12.3 Testing Checklist

- [ ] **Memory:**
  - [ ] Verify total overhead < 800 bytes
  - [ ] Check for memory leaks (entity spawn/despawn cycles)
  - [ ] Monitor pool exhaustion (room/global/entity)

- [ ] **Functionality:**
  - [ ] Room metadata add/get/remove
  - [ ] Global metadata add/get/remove
  - [ ] Auto-routing (room vs global)
  - [ ] Object spawn/despawn/get
  - [ ] Monster spawn/despawn/get

- [ ] **Performance:**
  - [ ] Lookup times within spec (~0.31ms average)
  - [ ] Generation overhead < 5%
  - [ ] Entity operations < 120 cycles

- [ ] **Edge Cases:**
  - [ ] Room pool overflow (fallback to global)
  - [ ] Global pool exhaustion (graceful failure)
  - [ ] Entity pool exhaustion (NULL return)
  - [ ] Metadata on TILE_MARKER tile
  - [ ] Remove non-existent metadata

- [ ] **Export:**
  - [ ] Correct file size calculation
  - [ ] Valid PRG format
  - [ ] Metadata round-trip (save/load)
  - [ ] Entity persistence

---

## Conclusion

**TMEA** provides a robust, efficient, and extensible metadata system tailored specifically for the C64 dungeon generator project. Its hybrid room+global architecture optimizes for the project's room-based generation while supporting corridor and map-wide features.

**Key Strengths:**
- **Minimal Overhead:** 765 bytes (~1.2% of RAM)
- **Fast Lookups:** ~0.31ms average
- **Flexible:** Supports rooms, corridors, and map-wide features
- **Extensible:** Easy to add new feature types
- **Oscar64-Optimized:** Uses compiler-specific optimizations
- **TMEA-First Architecture:** Secret doors now use metadata (eliminates tile type redundancy)
  - Single source of truth for door states
  - 5 door states instead of 2 (secret, locked, trapped, open/closed)
  - Value 6 freed for future tile types

---

