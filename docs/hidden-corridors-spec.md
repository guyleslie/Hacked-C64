# Hidden Corridor System - Technical Specification

## Project: C64 Dungeon Map Generator (OSCAR64)
**Feature**: Hidden Corridor System
**Version**: 1.0
**Date**: 2025-10-18
**Author**: Claude Code

---

## 1. Executive Summary

### Goal
Add a new map generation phase that **randomly hides non-branching corridors** by converting both doors to `TILE_SECRET_PATH`, making navigation more challenging by obscuring the path between stairs.

### Key Features
- ✅ Flag-based branching detection during generation (proactive, O(1) lookup)
- ✅ Configurable hidden corridor count via `MapParameters`
- ✅ Preserves secret rooms and false corridors (no conflicts)
- ✅ OSCAR64-optimized implementation (~500 bytes code + 1 bit/door metadata)

---

## 2. Architecture Overview

### 2.1 Data Structure Changes

#### Door Structure (mapgen_types.h)
```c
// BEFORE:
typedef struct {
    unsigned char x, y;
    unsigned char wall_side : 2;
    unsigned char is_secret_door : 1;
    unsigned char has_treasure : 1;
    unsigned char reserved : 4;          // 4 unused bits
} Door;

// AFTER:
typedef struct {
    unsigned char x, y;
    unsigned char wall_side : 2;
    unsigned char is_secret_door : 1;
    unsigned char has_treasure : 1;
    unsigned char is_branching : 1;      // NEW: 1 = multiple corridors share this wall
    unsigned char reserved : 3;          // 3 bits remaining
} Door;
```

**Memory impact**: +0 bytes (uses existing reserved bit)

#### MapParameters Structure (mapgen_config.h)
```c
typedef struct {
    unsigned char map_width;
    unsigned char map_height;
    unsigned char max_rooms;
    unsigned char min_room_size;
    unsigned char max_room_size;
    unsigned char secret_room_count;
    unsigned char false_corridor_count;
    unsigned char treasure_count;
    unsigned char hidden_corridor_count;  // NEW: default = 3
} MapParameters;
```

**Memory impact**: +1 byte

---

## 3. Implementation Details

### 3.1 Branching Detection System

#### New Function: `mark_branching_doors_for_connection()` (connection_system.c)

```c
// Mark doors as branching if multiple doors exist on the same wall
// Called AFTER both rooms have added the connection metadata
static void mark_branching_doors_for_connection(unsigned char room1, unsigned char room2) {
    // Get wall sides for this connection
    unsigned char door1_x, door1_y, wall1_side, corridor_type;
    if (!get_connection_info(room1, room2, &door1_x, &door1_y, &wall1_side, &corridor_type)) {
        return; // Connection not found (should never happen)
    }

    unsigned char door2_x, door2_y, wall2_side, temp_type;
    if (!get_connection_info(room2, room1, &door2_x, &door2_y, &wall2_side, &temp_type)) {
        return;
    }

    // Count doors on room1's wall
    unsigned char doors_on_wall1 = 0;
    for (unsigned char i = 0; i < room_list[room1].connections; i++) {
        if (room_list[room1].doors[i].wall_side == wall1_side) {
            doors_on_wall1++;
        }
    }

    // If multiple doors on this wall, mark ALL of them as branching
    if (doors_on_wall1 > 1) {
        for (unsigned char i = 0; i < room_list[room1].connections; i++) {
            if (room_list[room1].doors[i].wall_side == wall1_side) {
                room_list[room1].doors[i].is_branching = 1;
            }
        }
    }

    // Same logic for room2
    unsigned char doors_on_wall2 = 0;
    for (unsigned char i = 0; i < room_list[room2].connections; i++) {
        if (room_list[room2].doors[i].wall_side == wall2_side) {
            doors_on_wall2++;
        }
    }

    if (doors_on_wall2 > 1) {
        for (unsigned char i = 0; i < room_list[room2].connections; i++) {
            if (room_list[room2].doors[i].wall_side == wall2_side) {
                room_list[room2].doors[i].is_branching = 1;
            }
        }
    }
}
```

**Complexity**: O(connections) per call (max 4 connections/room → O(1) effective)
**Invocation**: Called at end of `connect_rooms()` after both metadata updates

---

### 3.2 Modified Function: `connect_rooms()` (connection_system.c)

```c
unsigned char connect_rooms(unsigned char room1, unsigned char room2, unsigned char is_secret) {
    // ... existing connection logic (unchanged) ...

    // Store connection metadata (existing code)
    if (!add_connection_to_room(room1, room2, exit1_x, exit1_y, wall1, corridor_type)) {
        return 0;
    }

    if (!add_connection_to_room(room2, room1, exit2_x, exit2_y, wall2, corridor_type)) {
        remove_last_connection_from_room(room1);
        return 0;
    }

    // Calculate breakpoints (existing code)
    calculate_and_store_breakpoints(room1, room_list[room1].connections - 1);
    calculate_and_store_breakpoints(room2, room_list[room2].connections - 1);

    // NEW: Mark branching doors after both connections are established
    mark_branching_doors_for_connection(room1, room2);

    return 1;
}
```

---

### 3.3 Hidden Corridor System

#### Function: `is_non_branching_corridor()` (connection_system.c)

```c
// Check if corridor between two rooms is non-branching (eligible for hiding)
static unsigned char is_non_branching_corridor(unsigned char room1, unsigned char room2) {
    // Skip secret rooms (already hidden via different mechanism)
    if (room_list[room1].state & ROOM_SECRET) return 0;
    if (room_list[room2].state & ROOM_SECRET) return 0;

    // Find room1's door to room2
    for (unsigned char i = 0; i < room_list[room1].connections; i++) {
        if (room_list[room1].conn_data[i].room_id == room2) {
            // Check room1's door flags
            if (room_list[room1].doors[i].is_secret_door) return 0;  // Already secret
            if (room_list[room1].doors[i].is_branching) return 0;    // Branches at room1

            // Find room2's door to room1
            for (unsigned char j = 0; j < room_list[room2].connections; j++) {
                if (room_list[room2].conn_data[j].room_id == room1) {
                    // Check room2's door flags
                    if (room_list[room2].doors[j].is_secret_door) return 0;
                    if (room_list[room2].doors[j].is_branching) return 0;

                    return 1; // Non-branching corridor found!
                }
            }
        }
    }

    return 0; // Connection not found or invalid
}
```

**Complexity**: O(connections²) = O(16) worst case → **O(1) effective**

---

#### Function: `hide_corridor_between_rooms()` (connection_system.c)

```c
// Hide corridor by converting both doors to TILE_SECRET_PATH
static unsigned char hide_corridor_between_rooms(unsigned char room1, unsigned char room2) {
    // Get door positions
    unsigned char door1_x, door1_y, wall1_side, corridor_type;
    if (!get_connection_info(room1, room2, &door1_x, &door1_y, &wall1_side, &corridor_type)) {
        return 0;
    }

    unsigned char door2_x, door2_y, wall2_side, temp_type;
    if (!get_connection_info(room2, room1, &door2_x, &door2_y, &wall2_side, &temp_type)) {
        return 0;
    }

    // Convert tiles to secret paths
    set_compact_tile(door1_x, door1_y, TILE_SECRET_PATH);
    set_compact_tile(door2_x, door2_y, TILE_SECRET_PATH);

    // Update metadata flags
    for (unsigned char i = 0; i < room_list[room1].connections; i++) {
        if (room_list[room1].doors[i].x == door1_x &&
            room_list[room1].doors[i].y == door1_y) {
            room_list[room1].doors[i].is_secret_door = 1;
            break;
        }
    }

    for (unsigned char i = 0; i < room_list[room2].connections; i++) {
        if (room_list[room2].doors[i].x == door2_x &&
            room_list[room2].doors[i].y == door2_y) {
            room_list[room2].doors[i].is_secret_door = 1;
            break;
        }
    }

    return 1;
}
```

---

#### Function: `place_hidden_corridors()` (connection_system.c)

```c
// Main entry point - randomly hide non-branching corridors
void place_hidden_corridors(unsigned char corridor_count) {
    if (room_count < 2 || corridor_count == 0) return;

    // Static candidate storage (max 40 pairs to limit memory)
    static unsigned char candidates_room1[40];
    static unsigned char candidates_room2[40];
    unsigned char candidate_count = 0;

    // Find all non-branching corridor candidates
    for (unsigned char i = 0; i < room_count && candidate_count < 40; i++) {
        __assume(room_count <= MAX_ROOMS);
        for (unsigned char j = i + 1; j < room_count && candidate_count < 40; j++) {
            __assume(j <= MAX_ROOMS);

            // Check if connected and eligible
            if (room_has_connection_to(i, j) && is_non_branching_corridor(i, j)) {
                candidates_room1[candidate_count] = i;
                candidates_room2[candidate_count] = j;
                candidate_count++;
            }
        }
    }

    // Early exit if no candidates
    if (candidate_count == 0) {
        update_progress_step(5, 0, corridor_count);
        return;
    }

    // Determine how many to hide (min of requested and available)
    unsigned char to_hide = (corridor_count < candidate_count) ? corridor_count : candidate_count;
    unsigned char hidden = 0;

    // Fisher-Yates shuffle (partial - only first 'to_hide' elements)
    for (unsigned char i = 0; i < to_hide; i++) {
        unsigned char j = i + rnd(candidate_count - i);

        // Swap candidates[i] and candidates[j]
        unsigned char temp_r1 = candidates_room1[i];
        unsigned char temp_r2 = candidates_room2[i];
        candidates_room1[i] = candidates_room1[j];
        candidates_room2[i] = candidates_room2[j];
        candidates_room1[j] = temp_r1;
        candidates_room2[j] = temp_r2;
    }

    // Hide selected corridors
    for (unsigned char i = 0; i < to_hide; i++) {
        if (hide_corridor_between_rooms(candidates_room1[i], candidates_room2[i])) {
            hidden++;
            update_progress_step(5, hidden, to_hide);
        }
    }
}
```

**Complexity**: O(room_count²) candidate search + O(to_hide) hiding = O(400 + 3) = **O(1) for C64**

---

### 3.4 Initialization Changes

#### Modified: `init_rooms()` (room_management.c)

```c
void init_rooms(void) {
    for (unsigned char i = 0; i < MAX_ROOMS; i++) {
        // ... existing initialization ...

        for (unsigned char j = 0; j < 4; j++) {
            // ... existing door initialization ...
            room_list[i].doors[j].is_secret_door = 0;
            room_list[i].doors[j].has_treasure = 0;
            room_list[i].doors[j].is_branching = 0;  // NEW: Initialize to non-branching
            room_list[i].doors[j].reserved = 0;

            // ... rest unchanged ...
        }

        // ... rest unchanged ...
    }
}
```

---

### 3.5 Progress System Updates

#### Phase Strings (mapgen_utils.c)

```c
// OLD (8 phases):
static const char phase_strings[] =
    "Building Rooms\0"         // 0-14
    "Connecting Rooms\0"       // 15-31
    "Secret Areas\0"           // 32-44
    "Secret Treasures\0"       // 45-61
    "False Corridors\0"        // 62-77
    "Placing Stairs\0"         // 78-92
    "Finalizing\0"             // 93-103
    "Generation Complete!";    // 104-124

static const unsigned char phase_offsets[8] = {0, 15, 32, 45, 62, 78, 93, 104};

// NEW (9 phases):
static const char phase_strings[] =
    "Building Rooms\0"         // 0-14
    "Connecting Rooms\0"       // 15-31
    "Secret Areas\0"           // 32-44
    "Secret Treasures\0"       // 45-61
    "False Corridors\0"        // 62-77
    "Hidden Corridors\0"       // 78-94  ← NEW
    "Placing Stairs\0"         // 95-109
    "Finalizing\0"             // 110-120
    "Generation Complete!";    // 121-141

static const unsigned char phase_offsets[9] = {0, 15, 32, 45, 62, 78, 95, 110, 121};
```

**Memory impact**: +17 bytes string data, +1 byte offset array

---

### 3.6 Generation Pipeline

#### Modified: `generate_level()` (map_generation.c)

```c
unsigned char generate_level(void) {
    init_generation_progress();
    init_progress_weights();

    show_phase(0); // "Building Rooms"
    create_rooms();
    if (room_count == 0) {
        finish_progress_bar_simple();
        return 0;
    }

    show_phase(1); // "Connecting Rooms"
    build_room_network();

    show_phase(2); // "Secret Areas"
    convert_secret_rooms_doors();

    show_phase(3); // "Secret Treasures"
    place_secret_treasures(current_params.treasure_count);

    show_phase(4); // "False Corridors"
    place_false_corridors(current_params.false_corridor_count);

    // ========== NEW PHASE ==========
    show_phase(5); // "Hidden Corridors"
    place_hidden_corridors(current_params.hidden_corridor_count);
    // ================================

    show_phase(6); // "Placing Stairs" (was phase 5)
    add_stairs();

    show_phase(7); // "Finalizing" (was phase 6)
    update_progress_step(7, 0, 1);
    initialize_camera();
    update_progress_step(7, 1, 1);

    finish_progress_bar_simple();
    show_phase(8); // "Generation Complete!" (was phase 7)

    // VIC-II delay...
    render_map_viewport(1);
    return 1;
}
```

---

### 3.7 Configuration System

#### Default Parameters (map_generation.c)

```c
MapParameters current_params = {
    72,  // map_width (MEDIUM default)
    72,  // map_height
    20,  // max_rooms
    4,   // min_room_size
    8,   // max_room_size
    4,   // secret_room_count
    5,   // false_corridor_count
    4,   // treasure_count
    3    // hidden_corridor_count ← NEW (default: 3)
};
```

#### Config Menu Presets (mapgen_config.c)

```c
// Preset values for hidden_corridor_count
switch (config->hidden_corridors) {
    case LEVEL_SMALL:  params->hidden_corridor_count = 1; break;
    case LEVEL_MEDIUM: params->hidden_corridor_count = 2; break;
    case LEVEL_LARGE:  params->hidden_corridor_count = 3; break;
}
```

#### Validation (mapgen_config.c)

```c
void validate_and_adjust_config(MapConfig *config, MapParameters *params) {
    // ... existing validations ...

    // NEW: Limit hidden corridors to reasonable maximum
    // Max = 2/3 of room count (leave some visible corridors for navigation)
    unsigned char max_hidden = (params->max_rooms * 2) / 3;
    if (params->hidden_corridor_count > max_hidden) {
        params->hidden_corridor_count = max_hidden;
    }
}
```

---

## 4. File Modifications Summary

| File | Changes | Lines Changed |
|------|---------|---------------|
| `mapgen_types.h` | Door struct: `reserved:4` → `is_branching:1, reserved:3`<br>MapParameters: +`hidden_corridor_count` field | ~5 lines |
| `room_management.c` | `init_rooms()`: Initialize `is_branching = 0` | ~1 line |
| `connection_system.c` | New: `mark_branching_doors_for_connection()`<br>New: `is_non_branching_corridor()`<br>New: `hide_corridor_between_rooms()`<br>New: `place_hidden_corridors()`<br>Modified: `connect_rooms()` - add marker call | ~150 lines |
| `mapgen_internal.h` | Declare `place_hidden_corridors()` | ~1 line |
| `mapgen_utils.c` | Phase strings: +1 phase<br>Phase offsets: 8→9 elements | ~3 lines |
| `mapgen_utils.h` | (No changes - phase count auto-derived) | 0 lines |
| `map_generation.c` | `generate_level()`: Insert phase 5<br>`current_params`: +`hidden_corridor_count = 3` | ~5 lines |
| `mapgen_config.h` | MapParameters struct: +field | ~1 line |
| `mapgen_config.c` | Preset values + validation logic | ~10 lines |

**Total**: ~176 lines added/modified across 8 files

---

## 5. Memory & Performance Analysis

### 5.1 Memory Footprint

| Component | Size | Notes |
|-----------|------|-------|
| Door.is_branching | 0 bytes | Uses existing reserved bit (20 rooms × 4 doors = 0 bytes) |
| MapParameters.hidden_corridor_count | 1 byte | New config field |
| Phase strings | +17 bytes | "Hidden Corridors\0" |
| Phase offsets | +1 byte | 9th offset entry |
| Candidate arrays | 80 bytes | Static: `candidates_room1[40]` + `candidates_room2[40]` |
| Code (4 functions) | ~400 bytes | Estimated compiled size |
| **TOTAL** | **~499 bytes** | **0.76% of 64KB** |

### 5.2 Performance Impact

| Operation | Complexity | Actual Cost (20 rooms) |
|-----------|------------|------------------------|
| `mark_branching_doors_for_connection()` | O(connections) | ~8 ops per call (4×2) |
| `is_non_branching_corridor()` | O(connections²) | ~16 ops (4×4) |
| Candidate search (phase 5) | O(room_count²) | ~400 iterations |
| Fisher-Yates shuffle | O(to_hide) | ~3 swaps |
| Door hiding | O(connections) | ~8 ops per corridor |
| **Total overhead** | **O(room_count²)** | **~500 operations** |

**C64 impact**: < 1 frame at 1 MHz (500 ops ≈ 500 μs) - **negligible**

---

## 6. Testing Strategy

### 6.1 Unit Tests

1. **Branching detection**:
   - ✅ Single connection per wall → `is_branching = 0`
   - ✅ Multiple connections per wall → `is_branching = 1` for all doors on that wall
   - ✅ Different walls → Independent branching flags

2. **Candidate selection**:
   - ✅ Non-branching corridors detected correctly
   - ✅ Secret rooms excluded
   - ✅ Already-secret doors excluded
   - ✅ Branching corridors excluded

3. **Hiding mechanism**:
   - ✅ Both doors converted to `TILE_SECRET_PATH`
   - ✅ Metadata flags updated (`is_secret_door = 1`)
   - ✅ No crashes on edge cases (0 candidates, max candidates)

### 6.2 Integration Tests

1. **Small map (48×48, 10 rooms)**:
   - Generate 100 maps, verify 0-3 hidden corridors per map
   - Check navigation still possible (stairs reachable)

2. **Medium map (64×64, 15 rooms)**:
   - Generate 100 maps, verify 1-3 hidden corridors
   - Verify no conflicts with secret rooms/treasures

3. **Large map (80×80, 20 rooms)**:
   - Generate 100 maps, verify 2-4 hidden corridors
   - Performance check: generation time < 5 seconds

### 6.3 Edge Cases

- ✅ **0 hidden corridors requested**: Skip phase gracefully
- ✅ **All corridors branching**: 0 candidates → early exit
- ✅ **More requested than available**: Hide all available
- ✅ **Secret room + hidden corridor**: No double-hiding

---

## 7. OSCAR64 Optimization Notes

### 7.1 Compiler Hints
```c
__assume(room_count <= MAX_ROOMS);  // Range analysis for loops
__assume(j <= MAX_ROOMS);           // Eliminate redundant bounds checks
```

### 7.2 Static Allocation
```c
static unsigned char candidates_room1[40];  // BSS segment (fast access)
static unsigned char candidates_room2[40];  // No heap fragmentation
```

### 7.3 Bit Fields
- Door struct uses bit fields → compact representation (3 bytes vs 5 bytes)
- OSCAR64 generates efficient bit manipulation code for 6502

### 7.4 Early Returns
- Skip phase if `corridor_count == 0` or `candidate_count == 0`
- Avoid unnecessary computation on maps with few rooms

---

## 8. Future Enhancements

### 8.1 Possible Extensions
- **Difficulty scaling**: Higher difficulty → more hidden corridors
- **Visual feedback**: Special wall tile for hidden corridor entrances
- **Discovery mechanic**: Player action to reveal hidden corridors
- **Statistics tracking**: Count hidden corridors in exported map metadata

### 8.2 Potential Optimizations
- **Lazy branching detection**: Only compute when needed (trade-off: O(1) lookup vs one-time O(N) setup)
- **Corridor complexity metric**: Prefer hiding longer/more complex corridors

---

## 9. Implementation Checklist

### Phase 1: Data Structures
- [ ] Edit `mapgen_types.h` - Door struct bit field
- [ ] Edit `mapgen_config.h` - MapParameters field
- [ ] Edit `map_generation.c` - Default value

### Phase 2: Branching Detection
- [ ] Edit `room_management.c` - Initialize `is_branching = 0`
- [ ] Add `mark_branching_doors_for_connection()` to `connection_system.c`
- [ ] Modify `connect_rooms()` - Call marker function

### Phase 3: Hidden Corridor System
- [ ] Add `is_non_branching_corridor()` to `connection_system.c`
- [ ] Add `hide_corridor_between_rooms()` to `connection_system.c`
- [ ] Add `place_hidden_corridors()` to `connection_system.c`
- [ ] Edit `mapgen_internal.h` - Declare public function

### Phase 4: Progress & Pipeline
- [ ] Edit `mapgen_utils.c` - Phase strings + offsets
- [ ] Edit `map_generation.c` - Insert phase 5, renumber phases 6-8

### Phase 5: Configuration
- [ ] Edit `mapgen_config.c` - Presets + validation

### Phase 6: Build & Test
- [ ] Run `build-dev.bat` - Check for compilation errors
- [ ] Test generation with various settings
- [ ] Verify memory usage in `.map` file
- [ ] Performance test on VICE emulator

---

## 10. Appendix: Code Snippets

### A. Complete Door Structure
```c
typedef struct {
    unsigned char x, y;                    // Door coordinates
    unsigned char wall_side : 2;           // Wall side (0-3)
    unsigned char is_secret_door : 1;      // Secret room entrance
    unsigned char has_treasure : 1;        // Treasure chamber attached
    unsigned char is_branching : 1;        // Multiple corridors on this wall
    unsigned char reserved : 3;            // Reserved for future use
} Door; // 3 bytes total
```

### B. Phase ID Mapping
```c
// Phase IDs (0-8):
// 0: Building Rooms
// 1: Connecting Rooms
// 2: Secret Areas
// 3: Secret Treasures
// 4: False Corridors
// 5: Hidden Corridors      ← NEW
// 6: Placing Stairs        ← Renumbered (was 5)
// 7: Finalizing            ← Renumbered (was 6)
// 8: Generation Complete!  ← Renumbered (was 7)
```

---

**End of Specification**
