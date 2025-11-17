# Percentage-Based Feature Generation Implementation Plan

**Document Version:** 2.0
**Date:** 2025-11-15
**Status:** Implementation Ready

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Codebase Analysis Findings](#codebase-analysis-findings)
3. [Design Decisions & Rationale](#design-decisions--rationale)
4. [Implementation Strategy](#implementation-strategy)
5. [Expected Behavior](#expected-behavior)
6. [Optimizations Leveraged](#optimizations-leveraged)
7. [Files Modified](#files-modified)
8. [Testing & Validation](#testing--validation)
9. [Migration & Compatibility](#migration--compatibility)
10. [Future Extensibility](#future-extensibility)

---

## Executive Summary

### Goal

Convert all dungeon generation features (secret rooms, treasures, false corridors, hidden corridors) to use consistent percentage-based configuration with three presets: **10%**, **25%**, and **50%**.

### Key Decision

**Pure Runtime Counter Strategy** - 6 runtime counters + PackedConnection bitfield optimization:
- **Memory Cost:** 6 bytes (0.009% of C64 RAM) - **NO extra memory for corridor tracking!**
- **Performance:** O(1) runtime updates - **NO post-MST iteration needed!**
- **Optimization:** Repurpose unused bit in PackedConnection (corridor_type uses only 2 bits, not 3)
- **Maintainability:** All tracking during generation, zero post-processing

### Current State

- **Secret rooms:** Already percentage-based (10%, 20%, 30%)
- **Other features:** Fixed count tables need conversion
- **Runtime data:** Partially maintained (connections, wall_door_count, is_branching)
- **PackedConnection inefficiency:** corridor_type uses 3 bits but only 3 values (0-2) exist - wastes 1 bit!
- **Missing:** Global counters + bitfield optimization for runtime tracking

### Implementation Approach

1. **Optimize PackedConnection bitfield** - corridor_type: 3→2 bits, add is_non_branching: 1 bit (0 bytes!)
2. **Add 6 global runtime counters** (6 bytes total)
3. **Update counters during runtime** at feature creation points
4. **Add corridor branching handler** - updates is_non_branching flag + counter when branching occurs
5. **Convert 3 configuration tables** to percentage-based
6. **Add 1 percentage calculator** helper function (NO post-MST iteration needed!)
7. **Post-MST calculation phase** - uses runtime counters directly (pure O(1))

---

## Codebase Analysis Findings

### 2.1 Existing Helper Functions Inventory

#### Statistical & Counting Functions (mapgen_utils.c/h)

**Distance Calculations:**
- `calculate_room_distance(room1, room2)` - Manhattan distance between room centers
- `manhattan_distance(x1, y1, x2, y2)` - Generic distance calculation
- `get_max_connection_distance()` - Dynamic distance threshold based on room count

**Boundary & Containment:**
- `coords_in_bounds(x, y)` - Map boundary checking
- `point_in_room(x, y, room_id)` - Point containment test
- `is_inside_any_room(x, y)` - Checks if point is in any room
- `point_in_any_room(x, y, *room_id)` - Returns which room contains point
- `is_on_room_edge(x, y)` - Room edge detection

**Tile Access:**
- `get_compact_tile(x, y)` - Read tile from 3-bit packed array
- `set_compact_tile(x, y, tile)` - Write tile to packed array
- `check_tile_has_types(x, y, type_flags)` - Tile type validation
- `check_adjacent_tile_types(x, y, type_flags, include_diagonals)` - Adjacency checking

**Wall & Door Utilities:**
- `get_wall_side_from_exit(room_idx, exit_x, exit_y)` - Determines wall side (0=left, 1=right, 2=top, 3=bottom)
- `place_walls_around_room(x, y, w, h)` - Room wall placement
- `place_walls_around_corridor_tile(x, y)` - Corridor wall placement
- `place_door(x, y)` - Door placement with duplicate prevention

**Progress Tracking:**
- `init_progress_weights()` - Pre-calculates phase boundaries from current_params
- `update_progress_step(phase, current, total)` - Updates progress bar

**What's Missing:**
- ❌ No percentage calculation utility
- ❌ No corridor branching update handler (for is_non_branching flag maintenance)

### 2.2 Current Feature Generation Systems

#### Secret Room System

**Location:** `connection_system.c:562-617`

**Functions:**
- `create_secret_room(room_idx)` - Static internal function
- `place_secret_rooms(room_count_target)` - Public placement controller

**Algorithm:**
1. Iterates through rooms looking for single-connection rooms
2. Validates using `is_non_branching_corridor()` helper
3. 50% random chance per eligible room
4. Converts normal door to secret door using TMEA metadata
5. Marks room with ROOM_SECRET flag

**Current Configuration:**
- Uses `secret_room_ratio[3] = {10, 20, 30}` (percentage of total rooms)
- Already percentage-based ✓

#### Secret Treasure System

**Location:** `connection_system.c:841-944`

**Functions:**
- `create_secret_treasure(room_idx)` - Static internal function
- `place_secret_treasures(treasure_count)` - Public placement controller

**Algorithm:**
1. Random room selection with retry logic
2. Checks room eligibility (not secret room, no existing treasure)
3. Finds wall without doors using `wall_door_count[wall_side]` (O(1) check)
4. Validates 3-tile boundary margin for treasure chamber
5. Places secret door in wall using TMEA metadata
6. Creates treasure chamber with floor tiles and walls

**Current Configuration:**
- Uses `treasure_table[3] = {2, 4, 6}` (fixed counts)
- Needs conversion to percentages

**Optimization Note:**
- Already leverages `wall_door_count[4]` for instant wall validation (line 852)

#### False Corridor System

**Location:** `connection_system.c:704-838`

**Functions:**
- `create_false_corridor(room_idx, wall_side)` - Static internal function
- `place_false_corridors(corridor_count)` - Public placement controller

**Algorithm:**
1. Random room + random wall selection
2. Validates wall has no doors using `wall_door_count[wall_side]` (O(1) check - line 710)
3. Calculates door position on wall center
4. Generates endpoint AWAY from wall (based on wall_side direction)
5. Creates dead-end corridor (straight/L-shaped/Z-shaped)
6. Increments `wall_door_count[wall_side]` for future validation (line 811)

**Current Configuration:**
- Uses `false_corridor_table[3] = {3, 5, 8}` (fixed counts)
- Needs conversion to percentages

**Optimization Note:**
- Already maintains `wall_door_count[]` during placement

#### Hidden Corridor System

**Location:** `connection_system.c:629-697`

**Functions:**
- `create_hidden_corridor(room1, room2)` - Static internal function
- `place_hidden_corridors(corridor_count)` - Public placement controller

**Algorithm:**
1. Pre-scans all room pairs to build candidate list (max 40 pairs)
2. Validates each pair using `is_non_branching_corridor()` helper
3. Random selection from candidate list
4. Converts both door tiles to secret doors using TMEA metadata
5. Maintains `is_branching` flag state (already 0 for non-branching)

**Current Configuration:**
- Uses `hidden_corridor_table[3] = {1, 2, 3}` (fixed counts)
- Needs conversion to percentages

**Optimization Note:**
- Leverages existing `is_branching` flag for eligibility

#### Shared Helper Function

**Location:** `connection_system.c:525-555`

**Function:** `is_non_branching_corridor(room1, room2)`

**Purpose:** Validates if corridor between two rooms is eligible for hiding

**Validation Checks:**
1. Neither room is a secret room (ROOM_SECRET flag)
2. Connection exists between rooms
3. Door is not already a secret door (TMEA metadata check)
4. Door has `is_branching == 0` flag

**Shared Usage:**
- Secret room creation (validates single-connection rooms)
- Hidden corridor creation (validates corridor eligibility)

### 2.3 Runtime Counter Discovery

#### What's ALREADY Maintained During Runtime ✓

**1. Connection Counter (`room->connections`)**

**Location:** `room_management.c:317` in `add_connection_to_room()`

**Behavior:**
- Incremented atomically when connection is added
- Each room tracks its own connection count
- Per-room field: `unsigned char connections`

**Usage:**
- Total corridors can be calculated: `SUM(room->connections) / 2`
- Each corridor counted twice (once per connected room)

**2. Wall Door Counter (`wall_door_count[4]`)**

**Locations:**
- `room_management.c:304` in `add_connection_to_room()` - during MST connections
- `connection_system.c:811` in `create_false_corridor()` - during false corridor placement

**Behavior:**
- Incremented when door/connection added to wall
- Array index: 0=left, 1=right, 2=top, 3=bottom
- Per-room field: `unsigned char wall_door_count[4]`

**Usage:**
- Available walls calculation: `4 - wall_door_count[i]` (O(1) instant check)
- Wall validation without iteration
- Used by treasure and false corridor systems

**3. Branching Flag (`is_branching`)**

**Location:** `room_management.c:306-315` in `add_connection_to_room()`

**Behavior:**
- Automatically set when `wall_door_count[wall_side] > 1`
- Marks ALL doors on wall as branching (retroactive marking)
- Per-door field: `unsigned char is_branching : 1` (1-bit flag)

**Usage:**
- Identifies non-branching corridors for hidden corridor system
- Used by `is_non_branching_corridor()` helper
- No manual detection needed

#### PackedConnection Bitfield Inefficiency 🔍

**Current Structure:** `mapgen_types.h` (Room structure)

```c
typedef struct {
    unsigned char room_id : 5;         // Connected room (0-31)
    unsigned char corridor_type : 3;   // Corridor type (0-7) ← WASTES 1 BIT!
} PackedConnection; // 1 byte
```

**Problem:**
- Only 3 corridor types exist: 0=Straight, 1=L-shaped, 2=Z-shaped
- corridor_type needs only 2 bits (0-3 range), but uses 3 bits
- **1 unused bit** per connection = wasted opportunity!

**Opportunity:**
- Repurpose 1 bit for `is_non_branching` flag
- Enables runtime non-branching corridor counting
- **0 bytes extra memory** - pure optimization!

**Optimized Structure (Proposed):**
```c
typedef struct {
    unsigned char room_id : 5;              // Connected room (0-31)
    unsigned char corridor_type : 2;        // Corridor type (0-3) ← 2 bits sufficient!
    unsigned char is_non_branching : 1;     // Non-branching flag ← NEW!
} PackedConnection; // 1 byte (same size!)
```

**Benefit:**
- Runtime tracking of non-branching corridors (free!)
- No post-MST iteration needed
- Counter update when branching occurs

#### What's MISSING (Local Variables, Lost After Function Returns) ✗

**1. MST Connection Counter**

**Location:** `connection_system.c:477` in `build_room_network()`

**Variable:** `unsigned char connections_made = 0;` (local)

**Problem:** Lost after MST completes, cannot be used for post-MST calculation

**2. Secret Room Counter**

**Location:** `connection_system.c:606` in `place_secret_rooms()`

**Variable:** `unsigned char secrets_made = 0;` (local)

**Problem:** Lost after placement, cannot inform treasure calculation

**3. Treasure Counter**

**Location:** `connection_system.c:930` in `place_secret_treasures()`

**Variable:** `unsigned char treasures_placed = 0;` (local)

**Problem:** Lost after placement, only used for progress tracking

**4. False Corridor Counter**

**Location:** `connection_system.c:822` in `place_false_corridors()`

**Variable:** `unsigned char corridors_placed = 0;` (local)

**Problem:** Lost after placement, only used for progress tracking

**5. Hidden Corridor Counter**

**Location:** `connection_system.c:684` in `place_hidden_corridors()`

**Variable:** `unsigned char hidden = 0;` (local)

**Problem:** Lost after placement, only used for progress tracking

**6. Available Walls Counter**

**Current Situation:** No tracking

**Problem:**
- Must calculate percentage of available walls for false corridor placement
- wall_door_count[4] tracks per-room walls, but no global sum
- Need runtime counter that decrements when:
  - Door added during MST → available_walls_count--
  - Door added during false corridor placement → available_walls_count--
  - Room becomes secret → available_walls_count -= (4 - used walls)

**7. Non-Branching Corridor Counter**

**Current Situation:** No tracking, requires post-MST iteration

**Problem:**
- Must calculate percentage of non-branching corridors for hidden corridor placement
- is_branching flag exists per-door, but no global count
- **Solution:** PackedConnection bitfield optimization!
  - Add is_non_branching flag to PackedConnection (0 bytes!)
  - Increment when corridor created (both rooms non-branching initially)
  - Decrement when branching occurs (update both rooms' flags)

**Why This Matters:**
- Post-MST percentage calculation needs 6 global counters
- All feature placement systems need runtime-tracked bases
- PackedConnection optimization enables free non-branching tracking

### 2.4 Configuration System Current State

#### Configuration Tables

**Location:** `mapgen_config.c:30-56`

**Current Tables:**

1. **`secret_room_ratio[3] = {10, 20, 30}`** - Already percentage-based ✓
2. **`treasure_table[3] = {2, 4, 6}`** - Fixed counts, needs conversion
3. **`hidden_corridor_table[3] = {1, 2, 3}`** - Fixed counts, needs conversion
4. **`false_corridor_table[3] = {3, 5, 8}`** - Fixed counts, needs conversion

**Target Percentages:** All tables should use `{10, 25, 50}`

#### Validation Logic

**Function:** `validate_and_adjust_config(MapConfig *config, MapParameters *params)`

**Location:** `mapgen_config.c:77-137`

**Current Validation:**

**Secret Rooms (Lines 93):**
- Calculated as percentage: `(max_rooms * secret_room_ratio[preset]) / 100`
- Already uses percentage system ✓

**Treasures (Lines 116-119):**
- Uses fixed count from `treasure_table[preset]`
- Capped by: `max_rooms - secret_room_count`
- Prevents treasures in secret rooms

**Hidden Corridors (Lines 125-128):**
- Uses fixed count from `hidden_corridor_table[preset]`
- Capped by: `(max_rooms * 2) / 3` (rough estimate of corridor count)

**Minimum Enforcement (Lines 131-136):**
- All features get minimum of 1 if preset > LEVEL_SMALL

**Problems:**
- Pre-generation caps use estimates, not actual network topology
- Hidden corridor cap is rough approximation
- False corridor has no cap validation

### 2.5 Generation Pipeline Current State

#### Generation Phases

**Location:** `map_generation.c:95-160`

**Current Phase Sequence:**

0. **Room Creation** - `create_rooms()`
1. **MST Connections** - `build_room_network()`
2. **Secret Rooms** - `place_secret_rooms()`
3. **Secret Treasures** - `place_secret_treasures()`
4. **False Corridors** - `place_false_corridors()`
5. **Hidden Corridors** - `place_hidden_corridors()`
6. **Stairs** - `add_stairs()`
7. **Finalize** - `initialize_camera()`

**Critical Gap:**
- No post-MST calculation phase
- Feature counts determined before MST completes
- Cannot use actual network topology for percentage calculation

**Required Insertion Point:**
- After **Phase 1** (MST complete)
- Before **Phase 2** (secret rooms start)
- Access to: room_count, total_connections, room network state

#### Progress Tracking System

**Functions:**
- `init_progress_weights()` - Pre-calculates phase boundaries (mapgen_utils.c:436-462)
- `update_progress_step(phase, current, total)` - Updates progress bar

**Current Behavior:**
- Uses `current_params` feature counts for weight calculation
- Dynamic phase boundaries based on actual work
- Already supports variable feature counts

---

## Design Decisions & Rationale

### 3.1 Pure Runtime Tracking Strategy

#### Core Strategy: 6 Global Counters + PackedConnection Optimization

**Approach:**
- Add 6 global unsigned char variables (1 byte each)
- Optimize PackedConnection bitfield (corridor_type: 3→2 bits, add is_non_branching flag)
- Update counters during runtime at feature creation points
- **Zero post-MST iteration** - all data tracked during generation

**Global Counters (6 bytes):**
1. `total_connections` - MST corridors created
2. `total_secret_rooms` - Secret rooms placed
3. `total_treasures` - Treasure chambers placed
4. `total_false_corridors` - False corridors placed
5. `total_hidden_corridors` - Hidden corridors placed
6. `available_walls_count` - Walls without doors (non-secret rooms)

**PackedConnection Bitfield Optimization (0 bytes):**
- **Before:** corridor_type uses 3 bits (0-7 range), only 3 values used (waste!)
- **After:** corridor_type uses 2 bits (0-3 range), add is_non_branching flag (1 bit)
- **Benefit:** Non-branching corridor tracking without extra memory

#### Memory Cost

**Total:** 6 bytes (0.009% of C64 RAM)
- 6 global counters: 6 bytes
- PackedConnection optimization: **0 bytes** (bitfield repurpose)
- **Negligible overhead**

#### Performance

**Runtime Updates:** O(1) per feature creation
- Counter increment: ~8 cycles (6502 INC instruction)
- Branching handler: ~50 cycles (only when wall becomes branching)

**Post-MST Calculation:** O(1) - uses counters directly
- No iteration needed
- Pure arithmetic: `(count * percentage + 99) / 100`

**vs. Post-Generation Iteration:**
- Available walls counting: ~400 cycles saved (20 rooms × 4 walls iteration)
- Non-branching corridor counting: ~2000 cycles saved (O(N²) room pair iteration)
- **Total savings: ~2400 cycles per generation**

#### Maintainability

**Single Source of Truth:**
- Each counter updated at exactly one point in code
- Clear ownership (feature placement function updates its counter)
- No duplicate counting logic

**Self-Documenting:**
- Counter names match feature names
- Update points match feature creation
- Easy to verify correctness

#### OSCAR64 Optimization Benefits

**8-Bit Arithmetic:**
- All counters: `unsigned char` (native 6502)
- No 16-bit overhead
- Single-byte INC instructions

**Zero-Page Candidates:**
- Frequently accessed counters can be zero-page allocated
- Faster load/store (3 cycles vs 4 cycles)
- Compiler auto-optimization with `-Oz` flag

**Bitfield Efficiency:**
- PackedConnection remains 1 byte (no bloat)
- Compiler generates optimal bit manipulation code
- No runtime penalty for is_non_branching access

#### Why This Beats Post-Generation Calculation

**Problem with Post-Generation:**
1. Available walls: Must iterate 20 rooms × 4 walls = 80 checks
2. Non-branching corridors: Must check all room pairs = 190 checks (20×19/2)
3. Redundant work if called multiple times
4. Function call overhead
5. More complex code (multiple counting functions)

**Runtime Tracking Wins:**
1. Counters updated once at creation (natural flow)
2. Zero iteration overhead
3. Always accurate (atomic updates)
4. Simpler code (increment only)
5. PackedConnection optimization is free (repurposed bit)

### 3.2 User Requirements Clarifications

#### Treasure Placement Rule

**Requirement:** Keep ROOM_SECRET exclusion

**Current Code:** `connection_system.c:858` checks `!(room->state & ROOM_SECRET)`

**Decision:** Maintain this check - treasures cannot spawn in secret rooms

**Rationale:**
- Prevents double-secret features (too obscure)
- Preserves current game balance
- Secret rooms already have reward value

#### False Corridor Wall Counting

**Requirement:** Count non-secret room walls only

**Decision:** Exclude secret room walls from available wall count

**Rationale:**
- False corridors in secret rooms would reveal secrets
- Consistent with treasure placement logic
- Better gameplay balance

#### Percentage Rounding

**Requirement:** Round up (ensure minimum features)

**Formula:** `(total * percentage + 99) / 100`

**Examples:**
- 10% of 7 = `(7 * 10 + 99) / 100 = 169 / 100 = 1` ✓
- 25% of 7 = `(7 * 25 + 99) / 100 = 274 / 100 = 2` ✓
- 50% of 7 = `(7 * 50 + 99) / 100 = 449 / 100 = 4` ✓
- 10% of 0 = `(0 * 10 + 99) / 100 = 99 / 100 = 0` (edge case)

**Rationale:**
- Guarantees at least 1 feature when total > 0 and percentage > 0
- More generous than standard rounding
- Better gameplay experience (features always present)

#### Documentation Updates

**Requirements:** Update CLAUDE.md + project-specification.md + inline comments

**Scope:**
- CLAUDE.md: Configuration tables, generation algorithm overview
- project-specification.md: Detailed algorithm specifications
- Inline comments: Clarify percentage logic where needed

---

## Implementation Strategy

### 4.1 Global Counters (6 Total - 6 Bytes)

#### Counter Declarations

**File:** `mapgen_internal.h`

**Add to Header:**
- `extern unsigned char total_connections;`
- `extern unsigned char total_secret_rooms;`
- `extern unsigned char total_treasures;`
- `extern unsigned char total_false_corridors;`
- `extern unsigned char total_hidden_corridors;`
- `extern unsigned char available_walls_count;`

**Purpose:** Expose counters to all mapgen modules

#### Counter Definitions

**File:** `map_generation.c`

**Add Global Variables:**
- `unsigned char total_connections = 0;`
- `unsigned char total_secret_rooms = 0;`
- `unsigned char total_treasures = 0;`
- `unsigned char total_false_corridors = 0;`
- `unsigned char total_hidden_corridors = 0;`
- `unsigned char available_walls_count = 0;`

**Purpose:** Define storage for counters

#### Counter Initialization

**File:** `map_generation.c`

**Function:** `reset_all_generation_data()`

**Add Reset Logic:**
- Set first 5 counters to 0 before generation starts
- Initialize `available_walls_count = room_count * 4` (all walls initially available)
- Ensures clean state for each new dungeon

**Purpose:** Initialize counters at generation start

**Special Note on available_walls_count:**
- Starts at maximum (room_count × 4 walls per room)
- Decrements during MST when doors added
- Decrements during false corridor placement
- Decrements when room becomes secret (all remaining walls excluded)

### 4.2 PackedConnection Bitfield Optimization

**File:** `mapgen_types.h`

**Current Structure:**
```c
typedef struct {
    unsigned char room_id : 5;         // Connected room (0-31)
    unsigned char corridor_type : 3;   // Corridor type (0-7)
} PackedConnection; // 1 byte
```

**Optimized Structure:**
```c
typedef struct {
    unsigned char room_id : 5;              // Connected room (0-31)
    unsigned char corridor_type : 2;        // Corridor type (0-3) ← REDUCED!
    unsigned char is_non_branching : 1;     // Non-branching flag ← NEW!
} PackedConnection; // 1 byte (same size!)
```

**Changes:**
- corridor_type: 3 bits → 2 bits (values 0-2 only used: Straight/L-shaped/Z-shaped)
- is_non_branching: new 1-bit flag (repurposed from unused corridor_type bit)

**Purpose:** Enable runtime non-branching corridor tracking without extra memory

### 4.3 Runtime Update Points

All counter updates integrated into existing functions:

#### 1. MST Connection - add_connection_to_room()

**File:** `room_management.c`

**Location:** Line ~290-320 in `add_connection_to_room()`

**Updates Required:**

**A) After setting connection data (line ~300):**
```c
// Set is_non_branching flag (initially true for new connections)
room_list[room_idx].conn_data[idx].is_non_branching = 1;
```

**B) After incrementing wall_door_count (line ~305):**
```c
// Decrement available walls (door added)
available_walls_count--;
```

**C) When marking branching (line ~310-315):**
```c
if (wall_door_count[wall_side] > 1) {
    // Mark all doors on this wall as branching
    for (i = 0; i <= idx; i++) {
        if (doors[i].wall_side == wall_side) {
            // Update is_non_branching flag in PackedConnection
            if (conn_data[i].is_non_branching == 1) {
                conn_data[i].is_non_branching = 0;
                // Call helper to update other room's flag + counter
                update_corridor_branching_status(room_idx, conn_data[i].room_id);
            }
        }
    }
}
```

**Purpose:**
- Track is_non_branching per connection (PackedConnection flag)
- Decrement available_walls_count when door added
- Update both rooms' flags when corridor becomes branching

#### 2. MST Global Counter - build_room_network()

**File:** `connection_system.c`

**Location:** Line ~506 (after successful `connect_rooms()` call)

**Update:**
```c
if (connect_rooms(best_room1, best_room2, 0)) {
    connected[best_room2] = 1;
    connections_made++;      // Local counter
    total_connections++;     // ADD THIS: Global counter
    // ... progress update
}
```

**Purpose:** Track total MST corridors created

#### 3. Secret Room Counter - place_secret_rooms()

**File:** `connection_system.c`

**Location:** Line ~612 (after successful `create_secret_room()` call)

**Update:**
```c
if (create_secret_room(i)) {
    secrets_made++;           // Local counter
    total_secret_rooms++;     // ADD THIS: Global counter

    // ADD THIS: Decrement available walls (secret room walls excluded)
    Room *room = &room_list[i];
    for (unsigned char w = 0; w < 4; w++) {
        if (room->wall_door_count[w] == 0) {
            available_walls_count--;  // Exclude unused walls in secret rooms
        }
    }
    // ... break if target reached
}
```

**Purpose:**
- Track secret rooms for treasure calculation
- Exclude secret room walls from false corridor base count

#### 4. Treasure Counter - place_secret_treasures()

**File:** `connection_system.c`

**Location:** Line ~938 (after successful `create_secret_treasure()` call)

**Update:**
```c
if (create_secret_treasure(random_room)) {
    treasures_placed++;       // Local counter
    total_treasures++;        // ADD THIS: Global counter
    available_walls_count--;  // ADD THIS: Treasure uses 1 wall
    // ... break if target reached
}
```

**Purpose:**
- Track treasure placement
- Decrement available walls (treasure chamber door uses 1 wall)

#### 5. False Corridor Counter - place_false_corridors()

**File:** `connection_system.c`

**Location:** Line ~832 (after successful `create_false_corridor()` call)

**Update:**
```c
if (create_false_corridor(random_room, random_wall)) {
    corridors_placed++;         // Local counter
    total_false_corridors++;    // ADD THIS: Global counter
    // NOTE: available_walls_count already decremented in create_false_corridor() at line ~811
    // ... break if target reached
}
```

**Purpose:** Track false corridor placement

**Note:** `available_walls_count--` already handled in `create_false_corridor()` (line ~811 after wall_door_count increment)

#### 6. Hidden Corridor Counter - place_hidden_corridors()

**File:** `connection_system.c`

**Location:** Line ~692 (after successful `create_hidden_corridor()` call)

**Update:**
```c
if (create_hidden_corridor(room1, room2)) {
    hidden++;                     // Local counter
    total_hidden_corridors++;     // ADD THIS: Global counter
    // ... break if target reached
}
```

**Purpose:** Track hidden corridor placement

#### 7. New Helper Function - update_corridor_branching_status()

**File:** `room_management.c` (or `mapgen_utils.c`)

**Purpose:** Update is_non_branching flag in both connected rooms when corridor becomes branching

**Function:**
```c
void update_corridor_branching_status(unsigned char from_room, unsigned char to_room) {
    // Find connection in to_room that points back to from_room
    Room *room = &room_list[to_room];

    for (unsigned char i = 0; i < room->connections; i++) {
        if (room->conn_data[i].room_id == from_room) {
            // Found the reciprocal connection
            if (room->conn_data[i].is_non_branching == 1) {
                room->conn_data[i].is_non_branching = 0;
                // No need to recurse - we're already in the reciprocal update
            }
            break;
        }
    }
}
```

**When Called:** From `add_connection_to_room()` when marking doors as branching (line ~695-700)

**Purpose:**
- Maintains consistency: both rooms' PackedConnection.is_non_branching flags synchronized
- Called only when corridor becomes branching (rare event)
- Simple O(N) search through connections (max 4 per room)

### 4.3 Configuration Tables Update

**File:** `mapgen_config.c:30-56`

#### Table Changes

**1. Treasure Table → Treasure Ratio**

**Old:** `const unsigned char treasure_table[3] = {2, 4, 6};`

**New:** `const unsigned char treasure_ratio[3] = {10, 25, 50};`

**2. Hidden Corridor Table → Hidden Corridor Ratio**

**Old:** `const unsigned char hidden_corridor_table[3] = {1, 2, 3};`

**New:** `const unsigned char hidden_corridor_ratio[3] = {10, 25, 50};`

**3. False Corridor Table → False Corridor Ratio**

**Old:** `const unsigned char false_corridor_table[3] = {3, 5, 8};`

**New:** `const unsigned char false_corridor_ratio[3] = {10, 25, 50};`

#### Header Declaration Updates

**File:** `mapgen_config.h`

**Update Declarations:**
- `extern const unsigned char treasure_ratio[3];` (rename from treasure_table)
- `extern const unsigned char hidden_corridor_ratio[3];` (rename from hidden_corridor_table)
- `extern const unsigned char false_corridor_ratio[3];` (rename from false_corridor_table)

### 4.4 New Helper Function (1 Function Only!)

#### calculate_percentage_count()

**File:** `mapgen_utils.c` + declaration in `mapgen_utils.h`

**Signature:** `unsigned char calculate_percentage_count(unsigned char total, unsigned char percentage)`

**Purpose:** Calculate feature count from percentage with round-up

**Algorithm:**
- Formula: `(total * percentage + 99) / 100`
- Returns calculated count (minimum 0)

**Examples:**
- `calculate_percentage_count(20, 10)` → 2 (10% of 20)
- `calculate_percentage_count(20, 25)` → 5 (25% of 20)
- `calculate_percentage_count(20, 50)` → 10 (50% of 20)
- `calculate_percentage_count(7, 10)` → 1 (rounds up from 0.7)
- `calculate_percentage_count(0, 50)` → 0 (edge case)

**OSCAR64 Optimization:**
- Pure 8-bit arithmetic (no 16-bit needed for our ranges)
- Inline candidate for compiler
- Minimal cycle overhead

**Returns:** Calculated count based on percentage (round-up)

### 4.5 Post-MST Calculation Phase

#### New Function: calculate_post_mst_feature_counts()

**File:** `map_generation.c`

**Location:** Define after `place_secret_rooms()`, call before `place_secret_treasures()`

**Purpose:** Calculate actual feature counts from percentages using runtime counters (NO iteration!)

**Algorithm:**

```c
void calculate_post_mst_feature_counts(void) {
    unsigned char preset = current_params.preset;

    // Treasure count: percentage of non-secret rooms
    unsigned char eligible_rooms = room_count - total_secret_rooms;
    current_params.treasure_count =
        calculate_percentage_count(eligible_rooms, treasure_ratio[preset]);

    // Hidden corridor count: percentage of non-branching corridors
    // Count non-branching corridors from PackedConnection flags
    unsigned char non_branching = count_non_branching_from_flags();
    current_params.hidden_corridor_count =
        calculate_percentage_count(non_branching, hidden_corridor_ratio[preset]);

    // False corridor count: percentage of available walls (runtime tracked)
    current_params.false_corridor_count =
        calculate_percentage_count(available_walls_count, false_corridor_ratio[preset]);
}
```

**Helper for Non-Branching Count:**
```c
// In mapgen_utils.c
unsigned char count_non_branching_from_flags(void) {
    unsigned char count = 0;

    // Iterate all rooms and check PackedConnection.is_non_branching flags
    for (unsigned char i = 0; i < room_count; i++) {
        Room *room = &room_list[i];
        for (unsigned char c = 0; c < room->connections; c++) {
            if (room->conn_data[c].is_non_branching == 1) {
                count++;
            }
        }
    }

    // Each corridor counted twice (once per room), divide by 2
    return count / 2;
}
```

**Dependencies:**
- Requires `total_secret_rooms` to be set (happens during secret room placement)
- Requires `available_walls_count` to be accurate (runtime tracked during MST + secret rooms)
- Requires `PackedConnection.is_non_branching` flags to be set (runtime tracked during MST)

**Insertion Point:**
- After **Phase 2** (secret rooms complete)
- Before **Phase 3** (treasures start)

**Why Post-Secret Rooms:**
- Secret room count affects treasure calculation (exclusion)
- Secret room walls already excluded from available_walls_count
- More accurate percentage bases

**Performance:**
- Treasure calculation: O(1) - uses counters directly
- False corridor calculation: O(1) - uses available_walls_count directly
- Hidden corridor calculation: O(N) - single iteration through connections (~40 checks max)
- **Total: ~50 cycles** vs. old O(N²) approach (~2000 cycles)

#### Pipeline Integration

**Updated Phase Sequence:**

0. Room Creation
1. MST Connections (`total_connections` updated)
2. Secret Rooms (`total_secret_rooms` updated)
3. **POST-MST CALCULATION** ← NEW PHASE
4. Secret Treasures (uses calculated count)
5. False Corridors (uses calculated count)
6. Hidden Corridors (uses calculated count)
7. Stairs
8. Finalize

**Progress Weight Recalculation:**
- `init_progress_weights()` called AFTER post-MST calculation
- Uses updated `current_params` counts for accurate phase boundaries

### 4.6 Validation Simplification

**File:** `mapgen_config.c`

**Function:** `validate_and_adjust_config()`

**Location:** Lines 77-137

#### Changes

**Remove Pre-Generation Caps:**
1. Treasure cap by `max_rooms - secret_room_count` (line 116-119)
   - **Reason:** Post-MST calculation handles this accurately
2. Hidden corridor cap by `(max_rooms * 2) / 3` (line 125-128)
   - **Reason:** Post-MST uses actual non-branching corridor count

**Keep:**
1. Secret room percentage calculation (line 93) - Already correct
2. Minimum enforcement (lines 131-136) - Still needed for preset validation
3. Room count validation - Still needed

**Simplification Rationale:**
- Pre-generation caps use rough estimates
- Post-MST calculation uses actual network state
- More accurate feature distribution
- Simpler configuration validation logic

---

## Expected Behavior

### 5.1 Feature Calculations

#### Secret Rooms

**Percentage:** 10% / 25% / 50% of total rooms

**Formula:** `(room_count * secret_room_ratio[preset]) / 100`

**Examples:**
- Small map (48×48), 8 rooms, Low preset (10%): 1 secret room
- Medium map (64×64), 12 rooms, Medium preset (25%): 3 secret rooms
- Large map (80×80), 20 rooms, High preset (50%): 10 secret rooms

**Status:** Already implemented correctly ✓

#### Treasures

**Percentage:** 10% / 25% / 50% of eligible rooms (non-secret rooms)

**Formula:** `calculate_percentage_count(room_count - total_secret_rooms, treasure_ratio[preset])`

**Examples:**
- 12 rooms, 3 secret rooms, Low preset (10%): `(9 * 10 + 99) / 100 = 1` treasure
- 12 rooms, 3 secret rooms, Medium preset (25%): `(9 * 25 + 99) / 100 = 3` treasures
- 12 rooms, 3 secret rooms, High preset (50%): `(9 * 50 + 99) / 100 = 5` treasures

**Constraint:** Treasures cannot spawn in secret rooms (ROOM_SECRET exclusion maintained)

#### Hidden Corridors

**Percentage:** 10% / 25% / 50% of non-branching corridors

**Formula:** `calculate_percentage_count(non_branching_count, hidden_corridor_ratio[preset])`

**Examples:**
- 15 total corridors, 10 non-branching, Low preset (10%): 1 hidden
- 15 total corridors, 10 non-branching, Medium preset (25%): 3 hidden
- 15 total corridors, 10 non-branching, High preset (50%): 5 hidden

**Constraint:** Only non-branching corridors eligible (validated by `is_non_branching_corridor()`)

#### False Corridors

**Percentage:** 10% / 25% / 50% of available walls (non-secret rooms)

**Formula:** `calculate_percentage_count(available_walls, false_corridor_ratio[preset])`

**Examples:**
- 12 rooms (non-secret), 8 walls without doors, Low preset (10%): 1 false corridor
- 12 rooms (non-secret), 8 walls without doors, Medium preset (25%): 2 false corridors
- 12 rooms (non-secret), 8 walls without doors, High preset (50%): 4 false corridors

**Constraint:** Only walls without doors in non-secret rooms

### 5.2 Edge Cases & Constraints

#### Minimum Feature Counts

**Scenario:** Percentage rounds to 0

**Examples:**
- 3 eligible rooms, 10% treasures: `(3 * 10 + 99) / 100 = 1` ✓ (round-up helps)
- 1 non-branching corridor, 10% hidden: `(1 * 10 + 99) / 100 = 1` ✓
- 0 eligible rooms, any percentage: `(0 * P + 99) / 100 = 0` (unavoidable)

**Handling:** Round-up formula ensures minimum 1 when base > 0

#### Maximum Feature Caps

**Scenario:** Percentage exceeds available slots

**Examples:**
- 5 eligible rooms, 50% treasures = 3, but only 2 have suitable walls
- 2 non-branching corridors, 50% hidden = 1, achievable

**Handling:** Placement functions already have retry logic and max attempt limits

**Results:**
- Placement stops when target reached OR max attempts exceeded
- Actual count may be less than calculated target (acceptable)
- Global counters reflect ACTUAL placed features (accurate)

#### Small Map Scenarios (48×48)

**Typical Stats:**
- 6-8 rooms
- 5-7 corridors
- Limited wall space

**Behavior:**
- Low preset (10%): 1 of each feature type
- Medium preset (25%): 2-3 of each feature type
- High preset (50%): 3-4 of each feature type

**Constraints:** Retry logic prevents infinite loops when targets unreachable

#### Large Map Scenarios (80×80)

**Typical Stats:**
- 18-20 rooms
- 17-19 corridors
- Abundant wall space

**Behavior:**
- Low preset (10%): 2-3 of each feature type
- Medium preset (25%): 5-6 of each feature type
- High preset (50%): 9-10 of each feature type

**Scaling:** Percentages scale naturally with map size

### 5.3 Validation Rules Summary

**Treasures:**
- ✓ Cannot spawn in secret rooms (ROOM_SECRET check)
- ✓ Require wall without doors
- ✓ Require 3-tile boundary margin
- ✓ Max 1 per room (ROOM_HAS_TREASURE flag)

**False Corridors:**
- ✓ Count only non-secret room walls
- ✓ Require wall without doors
- ✓ Max 1 per room (ROOM_HAS_FALSE_CORRIDOR flag)
- ✓ 2-tile margin from map edges

**Hidden Corridors:**
- ✓ Require non-branching corridor (is_branching == 0)
- ✓ Cannot hide secret room corridors
- ✓ Cannot hide already-secret doors
- ✓ Both doors converted to secret

**Secret Rooms:**
- ✓ Require exactly 1 connection
- ✓ 50% random chance per eligible room
- ✓ ROOM_SECRET flag prevents treasures/false corridors

---

## Optimizations Leveraged

### 6.1 Existing Runtime-Updated Data Structures

#### wall_door_count[4] - O(1) Wall Validation

**Purpose:** Per-room door count per wall side (left, right, top, bottom)

**Runtime Updates:**
- `room_management.c:304` - During MST connection creation
- `connection_system.c:811` - During false corridor creation

**Usage Optimization:**
- **Old Approach:** Iterate all doors to check if wall has doors → O(N) per check
- **New Approach:** Check `wall_door_count[side] == 0` → O(1) instant

**Benefit:**
- Treasure system: Instant wall validation (connection_system.c:852)
- False corridor: Instant wall validation (connection_system.c:710)
- count_available_walls(): O(4) per room instead of O(doors) iteration

**Memory Cost:** 4 bytes per room (already implemented, no additional cost)

#### is_branching Flag - Auto-Detection

**Purpose:** Marks doors on walls with multiple connections (branching corridors)

**Runtime Updates:**
- `room_management.c:306-315` - Automatically during connection creation
- Retroactive marking when second door added to wall

**Usage Optimization:**
- **Old Approach:** Manually iterate all doors on wall to detect branching → O(N²)
- **New Approach:** Check `door->is_branching` flag → O(1) instant

**Benefit:**
- `is_non_branching_corridor()`: Instant branching detection (connection_system.c:525)
- count_non_branching_corridors(): Efficient corridor classification
- Hidden corridor system: Fast eligibility checking

**Memory Cost:** 1 bit per door (already implemented, no additional cost)

#### room->connections - Connection Tracking

**Purpose:** Per-room connection count

**Runtime Updates:**
- `room_management.c:317` - Incremented during `add_connection_to_room()`

**Usage Optimization:**
- **Old Approach:** Iterate all rooms to find connections → O(N²) for total
- **New Approach:** Sum `room->connections` / 2 → O(N) for total

**Benefit:**
- Enables efficient corridor counting if needed
- Secret room validation: Instant single-connection check
- MST validation: Connection count tracking

**Memory Cost:** 1 byte per room (already implemented, no additional cost)

### 6.2 OSCAR64 Optimization Patterns

#### 8-Bit Arithmetic

**All Counters:** `unsigned char` (8-bit)

**Benefit:**
- Native 6502 operations (single-cycle register loads)
- No 16-bit arithmetic overhead
- Minimal zero-page usage

**Range:** 0-255 (sufficient for all feature counts on C64)

#### Minimal Memory Overhead

**5 Global Counters:** 5 bytes total (0.008% of C64 RAM)

**Comparison:**
- Room list: 960 bytes (20 rooms × 48 bytes)
- Map data: 2400 bytes max (80×80 × 3 bits)
- Counters: 5 bytes (negligible)

**Zero-Page Candidates:**
- Frequently accessed counters can be placed in zero-page
- Faster load/store operations (3 cycles vs 4 cycles)
- Compiler can auto-optimize with `-Oz` flag

#### Avoiding Redundant Iteration

**Traditional Approach:**
1. Generate features
2. Count features by iterating structures
3. Use counts for calculations

**Optimized Approach:**
1. Generate features + increment counters atomically
2. Use counters directly (no iteration)
3. O(1) access

**Cycle Savings:**
- Counting 20 rooms' connections: ~200 cycles saved
- Counting walls across 20 rooms: ~400 cycles saved
- Per-generation savings: ~1000 cycles total

#### Static Inline Helpers

**Candidates:**
- `calculate_percentage_count()` - Simple arithmetic, inline-worthy
- Compiler can inline with `-Oi` flag (already enabled in release build)

**Benefit:**
- Eliminates function call overhead (~20 cycles per call)
- Direct register operations
- Better code locality

---

## Files Modified

### 7.1 Complete File List (10 Files)

#### 1. mapgen_types.h

**Change Type:** PackedConnection bitfield optimization

**Changes:**
- Update `PackedConnection` structure:
  - Change `corridor_type` from 3 bits to 2 bits
  - Add `is_non_branching` 1-bit flag

**Purpose:** Enable runtime non-branching corridor tracking without extra memory

**Estimated Lines:** 2 lines modified (bitfield definition)

**Memory Impact:** 0 bytes (remains 1 byte per PackedConnection)

#### 2. mapgen_internal.h

**Change Type:** Add declarations

**Changes:**
- Add 6 global counter declarations (`extern unsigned char ...`)
  - total_connections, total_secret_rooms, total_treasures, total_false_corridors, total_hidden_corridors, available_walls_count

**Purpose:** Expose counters to all mapgen modules

**Estimated Lines:** +7 lines (6 declarations + comment header)

#### 3. map_generation.c

**Change Type:** Add definitions + new function + function call

**Changes:**
1. Define 6 global counters (after includes, before functions)
2. Initialize counters in `reset_all_generation_data()`:
   - Set 5 counters to 0
   - Initialize `available_walls_count = room_count * 4`
3. Add `calculate_post_mst_feature_counts()` function (~25 lines)
4. Call `calculate_post_mst_feature_counts()` after `place_secret_rooms()` (1 line)
5. Call `init_progress_weights()` after post-MST calculation (1 line)

**Purpose:** Counter storage, post-MST calculation, pipeline integration

**Estimated Lines:** +35 lines

**Dependencies:**
- Requires `count_non_branching_from_flags()` from mapgen_utils.c
- Requires `calculate_percentage_count()` from mapgen_utils.c
- Requires updated configuration tables from mapgen_config.c

#### 4. room_management.c

**Change Type:** Add runtime updates + new helper function

**Changes:**
1. `add_connection_to_room()` updates (line ~290-320):
   - Set `conn_data[idx].is_non_branching = 1` after connection creation
   - Add `available_walls_count--` after wall_door_count increment
   - Update `conn_data[i].is_non_branching = 0` when marking branching
   - Call `update_corridor_branching_status()` for reciprocal update
2. Add `update_corridor_branching_status()` function (~15 lines)

**Purpose:** Runtime tracking of is_non_branching flags + available walls

**Estimated Lines:** +20 lines

**Dependencies:**
- Requires `available_walls_count` global counter

#### 5. connection_system.c

**Change Type:** Add counter increments + available_walls_count updates

**Changes:**
1. `build_room_network()` line ~506: Add `total_connections++;`
2. `place_secret_rooms()` line ~612:
   - Add `total_secret_rooms++;`
   - Decrement `available_walls_count` for each unused wall in secret room (loop)
3. `place_secret_treasures()` line ~938:
   - Add `total_treasures++;`
   - Add `available_walls_count--;` (treasure uses 1 wall)
4. `place_false_corridors()` line ~832: Add `total_false_corridors++;`
   - Note: `available_walls_count--` already in `create_false_corridor()` line ~811
5. `place_hidden_corridors()` line ~692: Add `total_hidden_corridors++;`

**Purpose:** Runtime counter updates during feature generation

**Estimated Lines:** +10 lines (5 counter increments + 5 available_walls_count updates)

**Location Pattern:** Each increment added immediately after local counter increment

#### 6. mapgen_config.c

**Change Type:** Rename tables, update values, simplify validation

**Changes:**
1. Line ~30-56: Update 3 table definitions
   - `treasure_table` → `treasure_ratio = {10, 25, 50}`
   - `hidden_corridor_table` → `hidden_corridor_ratio = {10, 25, 50}`
   - `false_corridor_table` → `false_corridor_ratio = {10, 25, 50}`
2. `validate_and_adjust_config()` lines 77-137:
   - Remove treasure cap logic (lines 116-119)
   - Remove hidden corridor cap logic (lines 125-128)
   - Update table references (3 locations)

**Purpose:** Convert to percentage-based configuration

**Estimated Lines:** +3 renamed tables, -8 validation lines = -5 net lines

#### 5. mapgen_config.h

**Change Type:** Update declarations

**Changes:**
- Update 3 extern declarations to match renamed tables
  - `extern const unsigned char treasure_ratio[3];`
  - `extern const unsigned char hidden_corridor_ratio[3];`
  - `extern const unsigned char false_corridor_ratio[3];`

**Purpose:** Match configuration table renames

**Estimated Lines:** 3 lines modified

#### 7. mapgen_utils.c

**Change Type:** Add 2 new functions

**Changes:**
1. `calculate_percentage_count()` - ~5 lines (round-up percentage calculation)
2. `count_non_branching_from_flags()` - ~15 lines (iterate PackedConnection.is_non_branching flags)

**Purpose:** Helper functions for post-MST calculation

**Estimated Lines:** +25 lines (including comments)

**Dependencies:**
- Uses existing room_list data structure
- Uses `PackedConnection.is_non_branching` flag (from optimized bitfield)

#### 8. mapgen_utils.h

**Change Type:** Add function declarations

**Changes:**
- Add 2 function declarations (matching new functions in .c file)
  - `calculate_percentage_count()`
  - `count_non_branching_from_flags()`

**Purpose:** Expose helper functions to other modules

**Estimated Lines:** +3 lines (2 declarations + comment header)

#### 9. CLAUDE.md

**Change Type:** Documentation update

**Changes:**
1. Update configuration tables section (lines vary)
   - Show new percentage values (10/25/50)
   - Document runtime counter architecture (6 counters)
   - Document PackedConnection bitfield optimization
2. Update generation algorithm section
   - Add post-MST calculation phase
   - Update feature calculation formulas
3. Update expected behavior examples
4. Update Room structure documentation (PackedConnection changes)

**Purpose:** Maintain accurate AI assistant reference

**Estimated Lines:** ~40 lines modified/added

**Sections:**
- "## Architecture" - Add runtime counters + PackedConnection optimization
- "## Code Style & Conventions" - Add percentage calculation pattern
- Configuration tables - Update values
- Data Types - Update PackedConnection structure

#### 10. project-specification.md

**Change Type:** Documentation update

**Changes:**
1. Update algorithm specifications
   - Add percentage formulas
   - Document round-up behavior
   - Document runtime counter strategy
2. Update generation pipeline
   - Add post-MST calculation phase
   - Document PackedConnection optimization
3. Update feature generation sections
   - Secret rooms (already correct)
   - Treasures (percentage-based)
   - False corridors (percentage-based with available_walls_count)
   - Hidden corridors (percentage-based with is_non_branching flags)
4. Update data structure documentation
   - PackedConnection bitfield changes

**Purpose:** Maintain accurate technical specification

**Estimated Lines:** ~50 lines modified/added

**Sections:**
- Generation pipeline phases
- Feature generation algorithms
- Configuration system
- Runtime counter architecture
- PackedConnection optimization

### 7.2 Dependency Order

**Build Order (No Compilation Changes - OSCAR64 includes all in main.c):**

1. `mapgen_types.h` - **PackedConnection bitfield optimization** (CHANGED!)
2. `mapgen_internal.h` - 6 counter declarations
3. `mapgen_config.h` + `.c` - Table updates (percentage ratios)
4. `mapgen_utils.h` + `.c` - Helper functions (2 new)
5. `room_management.c` - add_connection_to_room() updates + update_corridor_branching_status()
6. `map_generation.c` - Counter definitions + post-MST function
7. `connection_system.c` - Counter increments + available_walls_count decrements
8. Documentation (CLAUDE.md, project-specification.md)

**Runtime Dependency Flow:**

1. **Counters initialized** → `reset_all_generation_data()`
   - 5 counters set to 0
   - `available_walls_count = room_count * 4`
2. **MST created** → `total_connections` updated, `available_walls_count` decremented, `is_non_branching` flags set
3. **Secret rooms placed** → `total_secret_rooms` updated, `available_walls_count` decremented for secret room walls
4. **Post-MST calculation** → Uses global counters + `count_non_branching_from_flags()` helper
5. **Feature placement** → Uses calculated counts from params, updates remaining counters

---

## Testing & Validation

### 8.1 Verification Points

#### Runtime Counter Verification

**Test:** Verify counters increment during generation

**Method:**
1. Add temporary debug output after each feature placement phase
2. Print counter values: `total_connections`, `total_secret_rooms`, etc.
3. Compare with visual map inspection

**Expected:**
- `total_connections` = number of corridors on map
- `total_secret_rooms` = number of rooms marked secret
- `total_treasures` = number of treasure chambers
- `total_false_corridors` = number of false corridors
- `total_hidden_corridors` = number of hidden corridors

#### Percentage Calculation Verification

**Test:** Verify percentage formula correctness

**Method:**
1. Test `calculate_percentage_count()` with known inputs
2. Examples:
   - `(10, 10)` should return 1
   - `(20, 25)` should return 5
   - `(7, 50)` should return 4 (round-up from 3.5)

**Expected:** All calculations match formula `(total * pct + 99) / 100`

#### Feature Count Verification

**Test:** Verify actual feature counts match calculated percentages

**Method:**
1. Generate multiple maps with each preset (Low/Medium/High)
2. Record: room_count, calculated counts, actual placed counts
3. Compare calculated vs. actual

**Expected:**
- Actual ≤ Calculated (may be less due to placement constraints)
- Low preset: ~10% of base
- Medium preset: ~25% of base
- High preset: ~50% of base

#### Map Size Scaling

**Test:** Verify percentages scale with map size

**Method:**
1. Generate Small (48×48), Medium (64×64), Large (80×80) maps
2. Compare feature counts across sizes
3. Verify proportional scaling

**Expected:**
- Large maps have more features (more rooms → higher base)
- Percentages remain consistent (10%/25%/50%)

### 8.2 Performance Benchmarks

#### Cycle Count Estimates (6502)

**Global Counter Updates:**
- Increment operation: ~8 cycles per counter
- 5 counters × 8 cycles = 40 cycles total per generation

**Helper Function Calls (Post-MST Calculation):**
- `count_available_walls()`: ~400 cycles (20 rooms × 4 walls × 5 cycles)
- `count_non_branching_corridors()`: ~2000 cycles (20×19 pairs × ~5 cycles)
- `calculate_percentage_count()`: ~20 cycles × 3 calls = 60 cycles
- Total post-MST: ~2500 cycles

**Alternative (Post-Generation Iteration):**
- Corridor counting: ~1000 cycles
- Wall counting: ~800 cycles
- Multiple calls: ~3000+ cycles (if called multiple times)

**Conclusion:** Runtime counters + post-MST calculation ≈ same cost, but more flexible

#### Memory Usage Verification

**Test:** Confirm 5-byte overhead

**Method:**
1. Compare `.map` file before/after changes
2. Check global variable section size

**Expected:** +5 bytes in global data section

### 8.3 Edge Case Testing

**Test Scenarios:**

1. **Zero Eligible Rooms:**
   - All rooms are secret rooms → treasure count = 0
   - Expected: No treasures placed, no errors

2. **No Non-Branching Corridors:**
   - All corridors branching → hidden count = 0
   - Expected: No hidden corridors, no errors

3. **All Walls Occupied:**
   - Every wall has doors → false corridor count > 0 but can't place
   - Expected: Placement stops at max attempts, counter reflects actual placements

4. **Minimum Map (6 Rooms):**
   - 10% of 6 = 1 (round-up helps)
   - Expected: At least 1 feature per type

5. **Maximum Map (20 Rooms):**
   - 50% of 20 = 10
   - Expected: Up to 10 features per type (constraint-dependent)

---

## Migration & Compatibility

### 9.1 Configuration Migration

**Old System:**
- Fixed count tables: `treasure_table[3] = {2, 4, 6}`
- Counts determined before generation starts

**New System:**
- Percentage tables: `treasure_ratio[3] = {10, 25, 50}`
- Counts calculated post-MST using actual network state

**Breaking Changes:**
- Configuration table names changed (code-level only, not user-facing)
- Function signatures unchanged (all placement functions still use `unsigned char count` parameter)

**User Impact:**
- **None** - No save files, no user-editable configs
- All changes internal to code

### 9.2 Backward Compatibility

**Map Format:**
- No changes to `.prg` export format
- No changes to tile encoding (3-bit)
- No changes to TMEA metadata structure

**Runtime Behavior:**
- Feature placement algorithms unchanged
- Placement retry logic unchanged
- TMEA integration unchanged

**Code Compatibility:**
- All existing function signatures preserved
- Module interfaces unchanged
- OSCAR64 include pattern unchanged

### 9.3 Build System

**No Changes Required:**
- Build scripts unchanged (build.bat, build-dev.bat, build-release.bat)
- Compiler flags unchanged
- Output file names unchanged

**Verification:**
- Development build should produce same file structure
- Release build should compile without errors
- Map/asm/lbl files generated normally

---

## Future Extensibility

### 10.1 Additional Percentage-Based Features

**Potential Future Features:**

**Locked Doors:**
- Percentage of total doors
- Base: total_connections (already tracked!)
- Example: 25% of corridors have locked doors

**Trapped Doors:**
- Percentage of non-secret doors
- Base: total_connections - total_hidden_corridors
- Uses TMEA metadata

**Illusory Walls:**
- Percentage of available walls
- Reuses `count_available_walls()` function
- Uses TMEA metadata

**Floor Traps:**
- Percentage of corridor tiles
- Base: total corridor length (would need tracking)

**Pattern:** All future features can use same architecture:
1. Add global counter (1 byte)
2. Add percentage table (3 bytes)
3. Calculate in post-MST phase
4. Leverage existing helpers

### 10.2 User-Configurable Percentages

**Potential Enhancement:**

**Current:** Hard-coded 10%/25%/50% presets

**Future:** User-selectable percentages via menu

**Implementation:**
- Replace fixed tables with variable arrays
- Add configuration menu (joystick input)
- Store selections in `MapConfig` structure
- No algorithm changes needed!

**Benefit:** Percentage architecture already supports arbitrary values

### 10.3 TMEA Integration Opportunities

**Current TMEA Usage:**
- Secret doors (door metadata)
- Treasure chambers (door metadata)

**Future Opportunities:**

**Locked Door System:**
- Use TMFLAG_DOOR_LOCKED
- Percentage-based placement
- Key item tracking (entity pools)

**Trapped Door System:**
- Use TMFLAG_DOOR_TRAPPED
- Percentage-based placement
- Damage state tracking

**Illusory Wall System:**
- Use TMFLAG_WALL_ILLUSORY
- Percentage-based placement
- Discovery mechanics

**Pattern:** Runtime counter architecture supports all TMEA feature types

### 10.4 Statistics & Analytics

**Potential Usage of Global Counters:**

**Post-Generation Stats Display:**
- Show feature counts on completion screen
- Display percentage distributions
- Compare preset vs. actual results

**Seed-Based Generation:**
- Use counters for map validation
- Ensure feature count consistency
- Debug tool for procedural generation

**Gameplay Metrics:**
- Track feature discovery (compare with total counts)
- Achievement system (find all secrets)
- Difficulty assessment (feature density)

**Benefit:** Counters provide foundation for future gameplay features

---

## Appendix A: Quick Reference

### A.1 Configuration Tables

**File:** `mapgen_config.c`

| Feature | Old Name | New Name | Values |
|---------|----------|----------|---------|
| Secret Rooms | `secret_room_ratio` | *(unchanged)* | `{10, 20, 30}` → `{10, 25, 50}` |
| Treasures | `treasure_table` | `treasure_ratio` | `{2, 4, 6}` → `{10, 25, 50}` |
| Hidden Corridors | `hidden_corridor_table` | `hidden_corridor_ratio` | `{1, 2, 3}` → `{10, 25, 50}` |
| False Corridors | `false_corridor_table` | `false_corridor_ratio` | `{3, 5, 8}` → `{10, 25, 50}` |

### A.2 Global Counters

**File:** `map_generation.c` (definitions) + `mapgen_internal.h` (declarations)

| Counter | Purpose | Updated In | Used By |
|---------|---------|------------|---------|
| `total_connections` | MST corridors | `build_room_network()` | Statistics/tracking |
| `total_secret_rooms` | Secret rooms | `place_secret_rooms()` | Treasure calculation |
| `total_treasures` | Treasure chambers | `place_secret_treasures()` | Statistics/tracking |
| `total_false_corridors` | False corridors | `place_false_corridors()` | Statistics/tracking |
| `total_hidden_corridors` | Hidden corridors | `place_hidden_corridors()` | Statistics/tracking |
| `available_walls_count` | Walls without doors (non-secret) | `add_connection_to_room()`, `place_secret_rooms()`, `place_secret_treasures()` | False corridor calculation |

### A.3 Helper Functions

**File:** `mapgen_utils.c` + `mapgen_utils.h`

| Function | Returns | Purpose |
|----------|---------|---------|
| `calculate_percentage_count(total, pct)` | `unsigned char` | Round-up percentage calculation |
| `count_non_branching_from_flags()` | `unsigned char` | Count corridors with is_non_branching=1 from PackedConnection |
| `update_corridor_branching_status(from, to)` | `void` | Sync is_non_branching flags between connected rooms |

### A.4 Formula Summary

**Percentage Calculation (Round-Up):**
```
result = (total * percentage + 99) / 100
```

**Feature Calculations (Post-MST Phase):**
- Secret Rooms: `(room_count * 10/25/50) / 100` (pre-MST calculation, unchanged)
- Treasures: `((room_count - total_secret_rooms) * 10/25/50 + 99) / 100`
- Hidden Corridors: `(count_non_branching_from_flags() * 10/25/50 + 99) / 100`
- False Corridors: `(available_walls_count * 10/25/50 + 99) / 100` (runtime tracked!)

### A.5 Runtime Update Locations

| Function | File | Line | Counter/Flag |
|----------|------|------|--------------|
| `add_connection_to_room()` | `room_management.c` | ~300 | `conn_data[idx].is_non_branching = 1` |
| `add_connection_to_room()` | `room_management.c` | ~305 | `available_walls_count--` |
| `add_connection_to_room()` | `room_management.c` | ~310-315 | `conn_data[i].is_non_branching = 0` (when branching) |
| `build_room_network()` | `connection_system.c` | ~506 | `total_connections++` |
| `place_secret_rooms()` | `connection_system.c` | ~612 | `total_secret_rooms++`, `available_walls_count` decrement |
| `place_secret_treasures()` | `connection_system.c` | ~938 | `total_treasures++`, `available_walls_count--` |
| `place_false_corridors()` | `connection_system.c` | ~832 | `total_false_corridors++` |
| `place_hidden_corridors()` | `connection_system.c` | ~692 | `total_hidden_corridors++` |

---

## Appendix B: Implementation Checklist

### Phase 1: PackedConnection Bitfield Optimization

- [x] Update `PackedConnection` structure in `mapgen_types.h`
- [x] Change `corridor_type` from 3 bits to 2 bits
- [x] Add `is_non_branching` 1-bit flag
- [x] Verify structure still 1 byte (bitfield packing)

### Phase 2: Core Infrastructure (6 Counters)

- [x] Add 6 counter declarations to `mapgen_internal.h`
- [x] Add 6 counter definitions to `map_generation.c`
- [x] Add counter initialization in `reset_all_generation_data()`
- [x] Set first 5 counters to 0
- [x] Initialize `available_walls_count = room_count * 4`
- [x] Verify counters accessible from all modules

### Phase 3: Configuration Updates

- [x] Rename `treasure_table` → `treasure_ratio` in `mapgen_config.c`
- [x] Rename `hidden_corridor_table` → `hidden_corridor_ratio` in `mapgen_config.c`
- [x] Rename `false_corridor_table` → `false_corridor_ratio` in `mapgen_config.c`
- [x] Update all 3 tables to `{10, 25, 50}` values
- [x] Update declarations in `mapgen_config.h`
- [x] Update references in `validate_and_adjust_config()`

### Phase 4: Helper Functions (3 Functions)

- [x] Implement `calculate_percentage_count()` in `mapgen_utils.c`
- [x] Implement `count_non_branching_from_flags()` in `mapgen_utils.c`
- [x] Implement `update_corridor_branching_status()` in `room_management.c` or `mapgen_utils.c`
- [x] Add declarations to `mapgen_utils.h` (and `room_management.h` if applicable)
- [x] Test helper functions with known inputs

### Phase 5: Runtime Updates (7 Update Points)

**add_connection_to_room() updates (room_management.c):**
- [x] Set `conn_data[idx].is_non_branching = 1` after connection creation (line ~300)
- [x] Add `available_walls_count--` after wall_door_count increment (line ~305)
- [x] Update `conn_data[i].is_non_branching = 0` when branching (line ~310-315)
- [x] Call `update_corridor_branching_status()` for reciprocal update (line ~695-700)

**Feature placement updates (connection_system.c):**
- [x] Add `total_connections++` in `build_room_network()` (line ~506)
- [x] Add `total_secret_rooms++` + available_walls_count decrement in `place_secret_rooms()` (line ~612)
- [x] Add `total_treasures++` + `available_walls_count--` in `place_secret_treasures()` (line ~938)
- [x] Add `total_false_corridors++` in `place_false_corridors()` (line ~832)
- [x] Add `total_hidden_corridors++` in `place_hidden_corridors()` (line ~692)

### Phase 6: Post-MST Calculation

- [x] Implement `calculate_post_mst_feature_counts()` in `map_generation.c`
- [x] Implement `count_non_branching_from_flags()` helper (called from post-MST function)
- [x] Call post-MST function after `place_secret_rooms()`
- [x] Move `init_progress_weights()` call after post-MST calculation
- [x] Verify feature counts calculated correctly using runtime counters

### Phase 7: Validation Cleanup

- [x] Remove treasure cap logic from `validate_and_adjust_config()`
- [x] Remove hidden corridor cap logic from `validate_and_adjust_config()`
- [x] Verify validation still prevents invalid configurations

---

## Document Revision History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2025-11-15 | Initial comprehensive implementation plan |
| 2.0 | 2025-11-15 | **Updated to pure runtime strategy:** PackedConnection bitfield optimization (corridor_type: 3→2 bits, +is_non_branching flag), 6 global counters (added available_walls_count), runtime tracking instead of post-MST iteration, count_non_branching_from_flags() helper added |

---

**End of Document**
