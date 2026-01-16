# C64 Procedural Dungeon Generator

A real-time dungeon map generation system for the Commodore 64, utilizing OSCAR64 cross-compiler for 8-bit development.

## Project Overview

This project implements a highly optimized procedural dungeon generation algorithm for the Commodore 64 hardware architecture. The system generates connected room networks using minimum spanning tree algorithms, features secret room mechanics, and provides interactive navigation with constrained memory usage.

**Target Platform:** Commodore 64 (6502 processor, 64KB RAM)
**Compiler:** OSCAR64 cross-compiler with full optimization suite
**Output:** Optimized C64 executable (.prg format)
**Memory Footprint:** Efficient allocation with 3-bit tile encoding and optimized data structures
**Optimization Level:** Full OSCAR64 optimization flags (-Os -Oo -Oi -Op -Oz) for minimal footprint

## Project Structure

```
main/src/
├── main.c                   # Entry point, VIC-II setup, DEBUG/production mode split
├── mapgen/
│   ├── mapgen_api.h         # Public interface definitions
│   ├── mapgen_types.h       # Core data structures and constants
│   ├── mapgen_internal.h    # Internal module definitions
│   ├── mapgen_config.c/.h   # Configuration system (shared by both modes)
│   ├── map_generation.c     # Generation pipeline with dynamic parameters
│   ├── room_management.c    # Room placement algorithms
│   ├── connection_system.c  # MST and corridor generation
│   ├── mapgen_utils.c/.h    # Utility functions and math operations
│   ├── tmea_types.h         # TMEA type definitions and flag enums
│   ├── tmea_core.h/.c       # TMEA implementation (metadata and entity pools)
│   │
│   │   # DEBUG-only modules (excluded from RELEASE build):
│   ├── mapgen_progress.c/.h # Progress bar system, phase display (DEBUG only)
│   ├── mapgen_display.c/.h  # Viewport, camera, PETSCII conversion (DEBUG only)
│   ├── mapgen_debug.c/.h    # Menu, navigation loop, UI helpers (DEBUG only)
│   └── map_export.c/.h      # Seed-based map save - 11 bytes (DEBUG only)
build-mapgen-test.bat        # Mapgen TEST build (DEBUG_MAPGEN enabled, ~11.8KB)
build-mapgen-release.bat     # Mapgen RELEASE build (Production API, ~7.9KB)
docs/                        # Comprehensive technical documentation
```

## User Input System

The system uses **Joystick 2** for all primary interactions via CIA1 Port A ($DC00) and Limited keyboard support for essential commands via `getchx()`:

**Map Navigation:**
- Reads joystick directions via CIA1 Port A register
- Supports diagonal movement (multiple directions simultaneously)
- Direct hardware access for responsive control
- Bit mapping: UP(0), DOWN(1), LEFT(2), RIGHT(3), FIRE(4) - active low

**Configuration Menu:**
- Debounce logic prevents repeated inputs

### Configuration System

**Pre-Generation Parameters:**
- **Map Size**: Small (48×48), Medium (64×64), Large (80×80)
- **Room Count**: Small (8), Medium (12), Large (16)
- **Secret Rooms**: 10%/25%/50% of max rooms (percentage-based)
- **Secret Treasures**: 10%/25%/50% of non-secret rooms (percentage-based, calculated post-MST)
- **False Corridors**: 10%/25%/50% of available walls (percentage-based, calculated post-MST)
- **Hidden Corridors**: 10%/25%/50% of non-branching corridors (percentage-based, calculated post-MST)

**Implementation Details:**
- Configuration stored in `MapConfig` structure with preset levels (Small/Medium/Large)
- Values validated and converted to `MapParameters` with percentage ratios
- **Post-MST Calculation**: Feature counts calculated from actual network topology using runtime counters
- **Runtime Tracking**: 6-byte counter system (total_connections, total_secret_rooms, total_treasures, total_false_corridors, total_hidden_corridors, available_walls_count)
- Dynamic parameter passing to generation pipeline
- Real-time value updates in menu display

## TMEA: Tile Metadata Extension Architecture

### Overview

**TMEA (Tile Metadata Extension Architecture)** is a lightweight metadata system that extends the base tile system with additional properties and dynamic entities. It provides a way to attach extra information to tiles (doors, walls, floors) without increasing the base tile storage footprint.

**Memory Overhead:** 765 bytes (~1.2% of C64 RAM)

### Architecture Philosophy

TMEA uses a **hybrid two-tier architecture** optimized for room-based dungeon generation:

1. **Room Metadata Pool** (Primary, ~70% of map):
   - 4 slots per room × 20 rooms = 80 max metadata entries
   - Compact room-local coordinates (4+4 bits)
   - Fast O(4) lookup per room

2. **Global Metadata Pool** (Fallback, ~30% of map):
   - 16 slots for corridors and map-wide features
   - Global coordinates (8+8 bits)
   - O(16) linear search

3. **Entity Pools** (Dynamic):
   - 48 objects (items, keys, potions) - 6 bytes each
   - 24 monsters (enemies with AI state) - 6 bytes each
   - Always use global coordinates for movement

### Door State Management (TMEA-First)

**Secret doors** are now managed exclusively via TMEA metadata instead of a dedicated tile type:

- **Base tile:** `TILE_DOOR` (3)
- **Metadata flag:** `TMFLAG_DOOR_SECRET`
- **Display:** System checks `is_door_secret()` to render appropriate symbol

**Advantages:**
- Eliminates tile type redundancy (value 6 freed for future use)
- Enables 5 door states instead of 2: secret, locked, trapped, revealed, open
- Single source of truth for door properties
- Extensible for future door mechanics

**API Functions:**
```c
// Add secret door metadata
unsigned char add_secret_door_metadata(unsigned char x, unsigned char y);

// Query door state
unsigned char is_door_secret(unsigned char x, unsigned char y);
unsigned char is_door_locked(unsigned char x, unsigned char y);
unsigned char is_door_trapped(unsigned char x, unsigned char y);

// Reveal secret door
unsigned char reveal_secret_door(unsigned char x, unsigned char y);

// Set door open/closed state
unsigned char set_door_open(unsigned char x, unsigned char y, unsigned char is_open);
```

### TMEA Type System

**8-bit Flag Encoding:** `TTTFFFFF`
- **TTT:** Type classification (3 bits, 8 types)
- **FFFFF:** Type-specific flags (5 bits, 32 flags)

**Door Flags (TMTYPE_DOOR = 0x20):**
- `TMFLAG_DOOR_SECRET` (0x01): Hidden from player
- `TMFLAG_DOOR_TRAPPED` (0x02): Triggers trap on open
- `TMFLAG_DOOR_LOCKED` (0x04): Requires key/lockpick
- `TMFLAG_DOOR_REVEALED` (0x08): Secret door discovered
- `TMFLAG_DOOR_OPEN` (0x10): Door is open

**Wall Flags (TMTYPE_WALL = 0x00):**
- `TMFLAG_WALL_ILLUSORY` (0x01): Passable fake wall
- `TMFLAG_WALL_SECRET` (0x02): Hidden wall
- `TMFLAG_WALL_REVEALED` (0x04): Discovered
- `TMFLAG_WALL_DESTRUCTIBLE` (0x10): Can be destroyed

**Trap Flags (TMTYPE_TRAP = 0x40):**
- `TMFLAG_TRAP_HIDDEN` (0x01): Not visible
- `TMFLAG_TRAP_TRIGGERED` (0x02): Already activated
- `TMFLAG_TRAP_DISARMED` (0x04): Disabled

### Performance Characteristics

| Operation | Room Pool | Global Pool | Notes |
|-----------|-----------|-------------|-------|
| **add_tile_metadata** | ~240 cycles | ~230 cycles | Automatic routing |
| **get_tile_metadata** | ~260 cycles | ~440 cycles | Quick reject: ~50 cycles |
| **Quick reject** | ~50 cycles | ~50 cycles | TILE_MARKER check |
| **spawn_object** | ~90 cycles | - | Free list alloc |
| **spawn_monster** | ~90 cycles | - | Free list alloc |

**Weighted Average:** ~0.31ms per lookup (70% room, 30% global)

### Integration with Generation

TMEA is initialized at program startup and reset before each new dungeon:

```c
// In main()
init_tmea_system();  // One-time initialization

// Before each generation
reset_tmea_data();   // Clear metadata, rebuild entity pools
```

All secret door creation now uses TMEA:
- Secret rooms: `add_secret_door_metadata()` instead of `TILE_SECRET_DOOR`
- Secret treasures: `add_secret_door_metadata()` for treasure chamber entrance
- Hidden corridors: `add_secret_door_metadata()` for both corridor doors

### Future Extensibility

TMEA provides a foundation for advanced dungeon features:
- **Locked doors** with key requirements
- **Trapped doors** with damage values
- **Illusory walls** (passable fake walls)
- **Floor traps** (hidden, pressure plates)
- **Teleport pads** with destination links
- **Objects** (gold, keys, potions, quest items)
- **Monsters** (enemies with HP and AI state)

For complete TMEA documentation, see **[docs/TMEA.md](TMEA.md)**

## Map Generation Logic

The generation process displays real-time progress with centered progress bar and phase indicators. Progress boundaries are calculated dynamically at generation start based on current parameters, ensuring accurate progress representation regardless of configuration:

### Phase 0: Building Rooms

The room generation operates on a 4×4 grid system providing 16 potential positions across the map. The process works as follows:

**Grid-Based Placement:**
- The map is divided into 16 equal cells (4×4 grid)
- Each cell represents a potential room position
- Cell order is randomized using Fisher-Yates shuffle algorithm

**Room Sizes and Types:**
- Room size is **fixed at 4×4 to 8×8 tiles** (not configurable by preset)
- Both width and height are independently random within this range
- Actual implementation: `min_room_size = 4`, `max_room_size = 8` (hardcoded in `mapgen_config.c`)
- Room count varies based on configuration (8/12/16)
- Each room maintains minimum spacing from others
- Note: `room_size_table[]` exists but is currently unused

**Collision Detection System:**
- Pre-placement validation checks against existing rooms
- Safety buffer zones ensure minimum inter-room spacing
- Direct range calculation for valid placement coordinates within grid cells
- 15 placement attempts per grid position for suitable positioning
- Boundary clamping keeps rooms within map limits

**Wall Construction:**
- Walls are built immediately around each room during placement
- 8-directional wall placement covers cardinal and diagonal positions
- Existing tiles are not overwritten to preserve previously placed structures

### Phase 1: Connecting Rooms

Room interconnection uses Prim's algorithm to guarantee that all rooms remain reachable:

**MST Algorithm Operation:**
- First room is automatically marked as "connected"
- Each iteration finds the closest unconnected room to the connected set
- Calculates Manhattan distance between room centers
- Creates a corridor connecting the two rooms

## Corridor Types and Geometric Logic

The connection system implements three distinct corridor types with specific geometric requirements and path algorithms:

### 1. **Straight Corridors** - Type 0

**Geometric Requirements:**
- Room centers must be perfectly aligned (horizontally or vertically)
- Rooms must "face each other" (no overlapping areas)
- Centers aligned AND walls face each other (prevents overlap)

**Door Placement Logic:**
- **Vertical alignment:** doors on top/bottom walls
- **Horizontal alignment:** doors on left/right walls
- Doors positioned at room centers on facing walls

**Corridor Path:**
- **1 segment:** direct line between two doors
- **Break points:** none
- **Direction:** straight line path between doors
- **Validation:** `can_use_straight_corridor()` ensures rooms face each other without overlap

### 2. **L-shaped Corridors** - Type 1

**Geometric Requirements:**
- Diagonally positioned rooms
- Horizontal and vertical gaps between room boundaries must both be > 0
- Used when rooms don't overlap and have sufficient space for L-corridor path

**Door Placement Logic:**
- **Vertical walls (left/right):** FIRST horizontal, THEN vertical
- **Horizontal walls (top/bottom):** FIRST vertical, THEN horizontal
- Direction determined by wall side of first room

**Corridor Path:**
- **2 segments:** door1 → pivot point → door2
- **1 break point:** right-angle turn at pivot
- **Direction:** deterministic based on wall side (vertical walls → horizontal first, horizontal walls → vertical first)

### 3. **Z-shaped Corridors** - Type 2

**Geometric Requirements:**
- Default choice for diagonally positioned rooms
- Used when L-shaped corridors cannot be safely implemented
- No specific alignment requirements

**Door Placement Logic:**
- Both rooms have doors facing toward the target room
- Doors positioned based on room center to target center direction
- Optimized for target-facing connections

**Corridor Path:**
- **3 segments:** door1 → segment1 end → segment2 end → door2
- **2 break points:** two direction changes creating Z-pattern
- **Segment lengths:** first leg is 1/3 of total distance (calculated by `compute_corridor_breakpoints()`)

## Corridor Type Selection Priority

1. **First Priority:** Straight corridor (when rooms are aligned and facing)
2. **Second Priority:** L-shaped corridor (when both horizontal and vertical gaps > 0)
3. **Third Priority:** Z-shaped corridor (default fallback)

## Wall Side Encoding

Wall side values are determined by `get_wall_side_from_exit()` based on door position relative to room boundaries:
- **0:** Left wall
- **1:** Right wall
- **2:** Top wall
- **3:** Bottom wall

## Corridor Construction Process

**Two-pass Walker:** `process_corridor_path()` drives both validation and drawing for straight, L, and Z-shaped corridors.
**Wall Building:** Walls are constructed around each corridor tile as it's placed.
**Atomic Operations:** All corridor metadata stored atomically to prevent inconsistent states.
**Geometric Validation:** Each corridor type validates path safety before construction.
**System Integration:** Door metadata includes position, wall direction, and corridor type.

**Construction Flow:**
1. `connect_rooms()` determines optimal corridor type (straight, L, or Z-shaped)
2. `draw_corridor_from_door()` initiates corridor drawing
3. `build_corridor_line()` builds corridor segments tile-by-tile
4. `process_corridor_path()` computes breakpoints and draws corridor segments
5. Success: door metadata stored in both connected rooms
6. Failure: connection metadata rolled back

### Phase 2: Secret Areas

The secret room system provides a special gameplay mechanic:

**Secret Room Criteria:**
- Only rooms with exactly 1 connection are eligible
- Connected room must not have other doors on the same wall (prevents corridor deletion)
- 50% probability of conversion to secret status
- Room `state` field receives `ROOM_SECRET` flag marking (prevents treasure placement)
- **Target count**: 10%/25%/50% of max_rooms based on preset level

**Secret Door Conversion (TMEA-First Architecture):**
- Base tile remains `TILE_DOOR`, TMEA metadata marks it as secret (`TMFLAG_DOOR_SECRET`)
- Uses `add_secret_door_metadata()` to add TMEA metadata instead of changing tile type
- Visual representation: Display system checks `is_door_secret()` and renders `░` symbol
- Implementation uses `is_non_branching_corridor()` shared validation function
- Enables 5 door states (secret, locked, trapped, revealed, open) vs previous 2 states

**Runtime Tracking:**
- Increments `total_secret_rooms` counter when secret room created
- Decrements `available_walls_count` for each unused wall in secret room (walls become unavailable for false corridors)

**Post-MST Feature Count Calculation:**

After secret rooms are placed (end of Phase 2), the system calculates actual feature counts based on network topology. This is not a separate phase, but an internal calculation step:

**Calculation Logic:**
- **Treasure count**: `calculate_percentage_count(room_count - total_secret_rooms, treasure_ratio[preset])`
- **Hidden corridor count**: `calculate_percentage_count(count_non_branching_from_flags(), hidden_corridor_ratio[preset])`
- **False corridor count**: `calculate_percentage_count(available_walls_count, false_corridor_ratio[preset])`
- Uses round-up formula: `(total * percentage + 99) / 100` to ensure minimum 1 feature when base > 0
- Progress weights recalculated with updated feature counts for accurate progress bar

### Phase 3: Secret Treasures

The secret treasure system creates hidden treasure chambers accessible through walls:

**Secret Treasure Criteria:**
- **Target count**: Calculated post-MST as percentage of non-secret rooms (10%/25%/50%)
- Only places treasures on walls without doors, false corridor entrances, or treasure metadata
- Excludes secret rooms (rooms with `ROOM_SECRET` flag)
- Prevents duplicate treasures per room using `ROOM_HAS_TREASURE` flag
- Excludes corners to prevent placement conflicts
- Validates wall availability using `wall_door_count[wall_side]` to ensure no existing doors

**Treasure Chamber Construction (TMEA-First Architecture):**
- Wall position becomes a door with TMEA secret metadata - secret entrance through wall
  - Base tile: `TILE_DOOR`, TMEA metadata: `TMFLAG_DOOR_SECRET`
  - Uses `add_secret_door_metadata()` instead of `TILE_SECRET_DOOR` tile type
- Adjacent position outside room becomes `TILE_FLOOR` (treasure chamber)
- `place_walls_around_corridor_tile()` builds protective walls around chamber
- Maintains wall_side consistency with existing door system (0=Left, 1=Right, 2=Top, 3=Bottom)
- Treasure wall_side stored in room metadata for runtime queries

**Wall Selection Algorithm:**
- Early return if room has `ROOM_SECRET` or `ROOM_HAS_TREASURE` flags
- Iterates through all 4 wall sides per room
- Skips walls containing any doors (normal connections + false corridors) using enhanced helper pattern
- Randomly selects position within wall boundaries (excluding corners)
- **Boundary validation**: Treasure chamber + surrounding walls must be ≥3 tiles from map edges
  - Prevents treasure structures (3×3 total) from extending beyond map boundaries
  - Validation: `treasure_x < 3 || treasure_x >= map_width - 3 || treasure_y < 3 || treasure_y >= map_height - 3`
- Sets `ROOM_HAS_TREASURE` flag upon successful placement

**Runtime Tracking:**
- Increments `total_treasures` counter when treasure created
- Decrements `available_walls_count` (treasure uses 1 wall)

### Phase 4: False Corridors

The false corridor system creates Nethack-style misleading dead-end passages using wall-first intelligent endpoint generation:

**Target Count:**
- **Calculated post-MST** as percentage of available walls (10%/25%/50%)
- Based on `available_walls_count` which excludes walls with doors and secret room walls

**Algorithm (Wall-First Approach):**
1. **Select Wall Side First**: Random wall_side (0=left, 1=right, 2=top, 3=bottom) where no doors exist
2. **Calculate Door Position**: Door placed at center of selected wall
3. **Generate Endpoint Intelligently**: Endpoint generated AWAY from door based on wall_side:
   - **Left wall (0)**: endpoint moves LEFT from door (negative X direction, 4-9 tiles)
   - **Right wall (1)**: endpoint moves RIGHT from door (positive X direction, 4-9 tiles)
   - **Top wall (2)**: endpoint moves UP from door (negative Y direction, 4-9 tiles)
   - **Bottom wall (3)**: endpoint moves DOWN from door (positive Y direction, 4-9 tiles)
4. **Add Perpendicular Offset**: Random ±1-4 tile offset perpendicular to wall direction for L-shaped corridors
5. **Use Proven Corridor Logic**: Same `determine_corridor_type()` and `process_corridor_path()` as normal room connections

**False Corridor Criteria:**
- Retry logic continues until target reached or maximum attempts exceeded
- Only places on walls with no doors, treasure entrances, or recorded false corridor metadata
- Excludes secret rooms (rooms with `ROOM_SECRET` flag)
- Maintains a 2-tile safety margin from map edges

**Key Guarantees:**
- L-shaped corridors ALWAYS move away from doors (never along walls or wrong direction)
- Higher placement success rate due to intelligent generation vs. post-hoc validation
- Consistent behavior with normal room connections (same drawing logic)
- Endpoint validation ensures no room collisions

**Placement Algorithm:**
- Random room/wall selection with early exits for secret rooms or occupied walls
- `point_in_any_room()` ensures endpoints do not overlap existing rooms
- Bounds validation keeps corridors inside the playable area
- Successful placements record entrance and endpoint metadata and set `ROOM_HAS_FALSE_CORRIDOR`

**Runtime Tracking:**
- Increments `total_false_corridors` counter when false corridor created
- `available_walls_count` already decremented in `add_connection_to_room()` when door added

### Phase 5: Hidden Corridors

The hidden corridor system identifies and conceals non-branching corridors to increase navigation difficulty:

**Target Count:**
- **Calculated post-MST** as percentage of non-branching corridors (10%/25%/50%)
- Uses `count_non_branching_from_flags()` which counts corridors with `is_non_branching=1` in PackedConnection

**Non-Branching Detection:**
- Corridors identified as "non-branching" if both door endpoints have no other doors on the same wall
- **PackedConnection bitfield optimization**: `is_non_branching` flag (1 bit) tracked during connection creation
  - Initially set to 1 when corridor created
  - Updated to 0 if wall becomes branching (multiple doors on same wall)
  - Enables O(1) queries via `count_non_branching_from_flags()` without iteration
- Branching detection uses pre-computed `is_branching` flag in Door structure (set during connection creation)
- Excludes secret rooms (already hidden via different mechanism)
- Excludes doors already marked as secret

**Selection Process:**
- Candidate search iterates all room pairs with connections
- Uses `room_has_connection_to()` and `is_non_branching_corridor()` for O(1) validation
- Random selection with retry logic from candidate pool

**Corridor Hiding (TMEA-First Architecture):**
- Converts both door tiles to secret doors using TMEA metadata
  - Base tile remains `TILE_DOOR`, adds `TMFLAG_DOOR_SECRET` metadata
  - Uses `add_secret_door_metadata()` for both doors
- Door metadata `is_branching` flag remains unchanged (already set to 0 for non-branching)
- Maintains corridor structure (only doors get secret metadata, corridor floor tiles remain normal)
- Display system checks `is_door_secret()` to render appropriate visual representation

**Runtime Tracking:**
- Increments `total_hidden_corridors` counter when corridor hidden

### Phase 6: Placing Stairs

Stair placement system ensures optimal level navigation with maximum separation:

**Distance-Based Selection:**
- Algorithm performs exhaustive search across all room pairs (O(n²))
- Calculates Manhattan distance between every room center combination
- Selects the pair with maximum distance for stair placement
- Up stairs placed in first room, down stairs in second room of optimal pair

**Performance Characteristics:**
- Brute-force search guarantees optimal placement (maximum separation)
- Typical performance: 190 comparisons for 20 rooms (~10ms on C64)
- Acceptable overhead in generation pipeline context

**Placement Strategy:**
- Stairs positioned at room centers for optimal accessibility
- Coordinate bounds checking prevents placement errors
- System guarantees maximum distance between level entry and exit points

### Phase 7: Generation Complete

The final phase marks the completion of map generation. All map data (compact_map, room_list, TMEA pools) is now ready in memory and available for use.

## Data Storage System

### Compact Map Format

Map data is stored using a 3-bit per tile encoding:

**Bit-Level Compression:**
- Each tile type is represented by 3 bits (8 possible types)
- Dynamic map sizes (48×48, 64×64, 80×80) with runtime bit offset calculation
- Bits can span byte boundaries for maximum compression
- Direct bit manipulation provides O(1) tile access with `calculate_y_bit_stride()` cached stride

**Tile Type Encoding:**
- `TILE_EMPTY` (0): Empty space
- `TILE_WALL` (1): Wall structure
- `TILE_FLOOR` (2): Room floor
- `TILE_DOOR` (3): Standard door (secret doors use TMEA metadata)
- `TILE_UP` (4): Upward staircase
- `TILE_DOWN` (5): Downward staircase
- `TILE_MARKER` (7): TMEA metadata presence flag (reserved for future tile types)

### Room Data Structure

Each room maintains metadata for:

**Core Properties:**
- `x, y`: Room top-left corner coordinates
- `w, h`: Room width and height dimensions
- `center_x, center_y`: Cached room center coordinates
- `connections`: Number of active connections
- `state`: Secret room flag and status bits

**Connection Metadata:**
- `conn_data[4]`: Packed connection structures with room ID and corridor type
- `doors[4]`: Door structures with coordinates and wall side
- Connection count tracked in `connections` field (single source of truth)
- Atomic operations ensure metadata consistency

**Corridor Path Computation:**
- Straight corridors (type 0): Direct path between doors
- L-shaped corridors (type 1): Single bend at optimal pivot point
- Z-shaped corridors (type 2): Two bends with segment transitions
- Breakpoints computed on-demand during corridor drawing via `compute_corridor_breakpoints()`
- No storage overhead - breakpoints recalculated when needed for pathfinding or navigation

### Memory Optimization Strategy

**Static Allocation Design:**
- No dynamic memory allocation (malloc/free eliminated)
- All data structures use pre-allocated fixed-size arrays
- Zero page variables for critical path operations

**Memory Organization:**
- Static allocation for all data structures
- Compact map data: 2400 bytes max (3-bit tile encoding)
- Room structures: 960 bytes (48 bytes × 20 rooms)
- TMEA metadata pools: 765 bytes
- Display viewport buffer: 1000 bytes (DEBUG mode only)

## Data Structures

### Core Room Structure

**Room State Flags:**
```c
#define ROOM_SECRET 0x01             // Designated as a secret room
#define ROOM_HAS_TREASURE 0x02       // Room contains a secret treasure (wall placement)
#define ROOM_HAS_FALSE_CORRIDOR 0x04 // Room contains a false corridor
```

**Room Structure:**
```c
typedef struct {
    // Most frequently accessed (ordered by access frequency)
    unsigned char x, y, w, h;              // Room position and size (4 bytes)
    unsigned char center_x, center_y;      // Cached room center (2 bytes)
    unsigned char connections;             // Number of active connections (1 byte)
    unsigned char state;                   // Room state flags (1 byte)

    // Wall door counters (4 bytes) - tracks door count per wall
    // Index: 0=left, 1=right, 2=top, 3=bottom
    unsigned char wall_door_count[4];      // Door count per wall (normal + false corridors)

    // Packed connection metadata (4 bytes)
    PackedConnection conn_data[4];         // Connection info (room_id, corridor_type)

    // Door metadata (12 bytes)
    Door doors[4];                         // Door positions and metadata

    // Secret treasure metadata (1 byte) - wall side only (coordinates calculated on-demand)
    unsigned char treasure_wall_side;      // Wall side (0-3) or 255=no treasure

    // False corridor metadata (3 bytes) - wall side + endpoint coordinates
    unsigned char false_corridor_wall_side; // Wall side (0-3) or 255=no false corridor
    unsigned char false_corridor_end_x;     // False corridor end X coordinate
    unsigned char false_corridor_end_y;     // False corridor end Y coordinate
} Room;                                     // 48 bytes total
```

### Packed Connection Structure
```c
typedef struct {
    unsigned char room_id : 5;              // Connected room ID (0-31)
    unsigned char corridor_type : 2;        // Corridor type (0-3): Straight=0, L-shaped=1, Z-shaped=2
    unsigned char is_non_branching : 1;     // Non-branching corridor flag (runtime tracking for hidden corridors)
} PackedConnection;                         // 1 byte total (optimized: corridor_type reduced 3→2 bits)
```

**Optimization Notes:**
- `corridor_type` reduced from 3 bits to 2 bits (only 3 types used: 0-2)
- `is_non_branching` flag added (1 bit) for O(1) non-branching corridor queries
- Still 1 byte total with zero memory overhead
- Enables fast `count_non_branching_from_flags()` without iteration

### Door Structure
```c
typedef struct {
    unsigned char x, y;                    // Door coordinates
    unsigned char wall_side : 2;           // Wall side (0-3)
    unsigned char is_branching : 1;        // Branching corridor flag (used by hidden corridor system)
    unsigned char reserved : 5;            // Reserved for future use
} Door;                                    // 3 bytes total
```

**Note:** Secret door state is managed via TMEA metadata system (`TMFLAG_DOOR_SECRET`), not in the Door structure. This enables 5 door states (open, closed, locked, secret, trapped).

### Corridor Breakpoint Structure
```c
typedef struct {
    unsigned char x, y;                    // Breakpoint coordinates
} CorridorBreakpoint;                      // 2 bytes total
```

**Breakpoint Usage:**
- Used internally during corridor generation for path computation
- **Straight (0)**: No breakpoints needed
- **L-shaped (1)**: Single breakpoint at pivot location
- **Z-shaped (2)**: Two breakpoints at segment transition points
- Computed on-demand by `compute_corridor_breakpoints()` during corridor drawing
- Not stored permanently - recalculated when needed for pathfinding or queries

### Secret Metadata Tracking

**Secret Treasure System:**
- `treasure_wall_side`: Wall side index (0-3) or 255 for no treasure
- Wall availability checked via `wall_door_count[wall_side]` array
- `get_wall_side_from_exit()` (mapgen_utils.c): Determines wall side from door position
- `place_secret_treasures()` (connection_system.c): Places percentage-based treasures (10%/25%/50% of non-secret rooms)

**False Corridor System:**
- `false_corridor_wall_side`: Wall side index (0-3) or 255 for no false corridor
- `false_corridor_end_x, false_corridor_end_y`: Coordinates of corridor dead-end
- Invalid wall_side (255) indicates no false corridor
- `place_false_corridors()`: Places percentage-based false corridors (10%/25%/50% of available walls)

## Algorithm Performance

### Computational Complexity
- **Room Placement**: O(n) with grid constraints
- **MST Generation**: O(n²) for complete connectivity
- **Wall Placement**: O(room_perimeter + corridor_length) incremental during creation
- **Screen Rendering**: O(viewport_size) with delta optimization

### Hardware Integration
- **VIC-II**: Direct register access ($D000-$D02E), raster position for seed entropy
- **CIA**: Timer A/B for 16-bit seed generation via `get_random_seed()`
- **KERNAL**: Optimized I/O operations
- **Direct Memory**: Screen buffer manipulation at $0400

## Generation Pipeline

0. **Building Rooms**: Grid-based placement with collision detection and immediate wall construction. Map clearing and runtime counter initialization happen before this phase.
1. **Connecting Rooms**: MST algorithm execution with corridor walls built during creation (updates `total_connections`, `available_walls_count`)
2. **Secret Areas**: Single-connection room conversion using `place_secret_rooms()` (updates `total_secret_rooms`, `available_walls_count`). Post-MST calculation (`calculate_post_mst_feature_counts()`) runs after this phase to compute feature counts from percentages.
3. **Secret Treasures**: Hidden treasure chamber placement using `place_secret_treasures()` (updates `total_treasures`, `available_walls_count`)
4. **False Corridors**: Dead-end corridor placement using `place_false_corridors()` (updates `total_false_corridors`)
5. **Hidden Corridors**: Non-branching corridor concealment using `place_hidden_corridors()` (updates `total_hidden_corridors`)
6. **Placing Stairs**: Distance-based optimal placement (maximum separation)
7. **Complete**: Generation finished, all map data ready in memory

## Technical Architecture

### System Components

| Component | Responsibility |
|-----------|---------------|
| **Core Generator** (`map_generation.c`) | Pipeline orchestration and master control |
| **Room System** (`room_management.c`) | Placement algorithms with grid distribution |
| **MST Connectivity** (`connection_system.c`) | Prim's algorithm, corridor generation, feature systems (secret rooms, treasures, false/hidden corridors) |
| **Utility Layer** (`mapgen_utils.c`) | Bit manipulation, math operations, validation, RNG |
| **Progress System** (`mapgen_progress.c`) | Progress bar, phase display, console output (DEBUG only) |
| **Display Engine** (`mapgen_display.c`) | Viewport management, camera, PETSCII conversion, delta rendering (DEBUG only) |
| **Export System** (`map_export.c`) | Seed-based save system - 11 bytes (DEBUG only) |

### Build System

The project uses batch scripts for building:
- `build-mapgen-test.bat` - DEBUG build with interactive features (~11.8KB)
- `build-mapgen-release.bat` - Production API build (~7.9KB)

See the batch files for current compiler flags and optimization settings.

## API Interface

The mapgen module provides a clean public API for map generation. All functions are declared in `mapgen_api.h`.

### Public API Functions
```c
// Initialization and seed management
void mapgen_init(unsigned int seed);           // Set explicit 16-bit seed
unsigned int mapgen_get_seed(void);            // Query current seed value
void mapgen_reset_seed_flag(void);             // Reset to random seed on next generation
void mapgen_set_parameters(const MapParameters *params);

// DEBUG mode API - generates dungeon using current parameters
unsigned char mapgen_generate_dungeon(void);

// Production mode API - direct parameter generation
unsigned char mapgen_generate_with_params(
    unsigned char map_size,        // 0=SMALL(48x48), 1=MEDIUM(64x64), 2=LARGE(80x80)
    unsigned char room_count,      // 0=SMALL(8), 1=MEDIUM(12), 2=LARGE(16)
    unsigned char room_size,       // Currently unused (fixed 4-8), reserved for future
    unsigned char secret_rooms,    // 0=10%, 1=25%, 2=50%
    unsigned char false_corridors, // 0=10%, 1=25%, 2=50%
    unsigned char secret_treasures,// 0=10%, 1=25%, 2=50%
    unsigned char hidden_corridors // 0=10%, 1=25%, 2=50%
);
// Returns: 0=success, 1=invalid params, 2=generation failed

// Query functions
unsigned char mapgen_get_map_size(void);  // Returns current map width
```

### DEBUG-Only Functions

```c
// Map export (DEBUG mode only, defined in map_export.h)
void save_map_seed(const char* filename);  // Export seed + config (11 bytes)
```

### Data Access

After successful generation, the following global data structures are available:
- `compact_map[]` - 3-bit packed tile data (access via `get_compact_tile(x, y)`)
- `room_list[]` - Room structure array (20 rooms maximum)
- `room_count` - Number of generated rooms
- `current_params` - Current generation parameters
- TMEA pools - Metadata and entity data (access via TMEA API)

## Map Export System

### Seed-Based Save Format (MAPBIN.PRG)

The map export system uses **seed-based saving** instead of raw map data. Since maps are deterministically generated from a 16-bit seed, only the seed and configuration parameters need to be saved. This reduces file size from 800-2400+ bytes to just **11 bytes**.

**File Structure:**
```
Byte 0-1:   PRG load address (little-endian, added automatically by C64 KERNAL SAVE)
Byte 2-3:   Seed (16-bit, little-endian)
Byte 4:     Map size preset (0=SMALL, 1=MEDIUM, 2=LARGE)
Byte 5:     Room count preset (0=SMALL, 1=MEDIUM, 2=LARGE)
Byte 6:     Room size preset (reserved for future use)
Byte 7:     Secret rooms preset (0=10%, 1=25%, 2=50%)
Byte 8:     False corridors preset
Byte 9:     Secret treasures preset
Byte 10:    Hidden corridors preset
```

**File Size:**
- **11 bytes total** (2 byte PRG header + 9 bytes data)
- Compare to old format: 867-2403 bytes depending on map size
- **~99.5% size reduction** for large maps

### Reproducible Generation

The seed-based system enables exact map reproduction:

```c
// Save: capture seed and config
unsigned int seed = mapgen_get_seed();
// ... save seed + presets to file ...

// Load: regenerate identical map
mapgen_init(seed);
mapgen_generate_with_params(presets...);
// Produces identical map every time
```

### Tile Encoding (3 bits per tile - in memory)

| Value | Tile Type    | PETSCII Display | Notes |
|-------|--------------|-----------------|-------|
| 0     | Empty        | Space (32)      | Background |
| 1     | Wall         | Block (160)     | Solid barrier |
| 2     | Floor        | Period (46)     | Walkable area |
| 3     | Door         | Plus (219) / Checkerboard (176) | Normal or secret (via TMEA) |
| 4     | Up stairs    | Less-than (60)  | Level exit up |
| 5     | Down stairs  | Greater (62)    | Level exit down |
| 7     | TILE_MARKER  | -               | TMEA metadata flag |

**Note:** Value 6 is freed for future tile types. Secret doors use `TILE_DOOR` (3) with TMEA metadata (`TMFLAG_DOOR_SECRET`). Display system queries TMEA to determine rendering.

### Implementation Details

**Export Function:**
```c
void save_map_seed(const char* filename);  // Seed-based save (11 bytes)
```

**Trigger:**
- User presses 'M' key during map navigation
- File saved as "MAPBIN" to device 8 (disk drive)

**Technical Implementation:**
1. Query current seed using `mapgen_get_seed()`
2. Store seed as little-endian (2 bytes)
3. Store preset value from `current_params.preset` for all config fields (7 bytes)
4. Use KERNAL SAVE routine via `krnio_save()` which automatically adds PRG header
5. Total: 9 bytes of data + 2 byte PRG header = 11 bytes

**Advantages:**
- Minimal disk space usage (11 bytes vs 800-2400+ bytes)
- Fast save/load operations
- Perfect reproducibility via deterministic RNG
- Future-proof: adding new generation features doesn't increase save size

## Development Standards

### Code Quality
- **Static Analysis**: Zero dynamic memory allocation
- **Type Safety**: Explicit unsigned char usage for 8-bit targets
- **Documentation**: Inline comments for algorithm implementations
- **Testing**: Validation functions for map integrity verification

### Performance Metrics
- **Generation Time**: ~2-5 seconds on C64 hardware (varies by map size and configuration)
- **Executable Size**: ~7.9KB release build, ~11.8KB test build (with full optimization)
- **Memory Management**: Static allocation with maximum-sized buffers, runtime bounds checking
- **Map Storage**: 2400 bytes max buffer (handles 48×48=864, 64×64=1536, 80×80=2400)
- **Room Data**: 48 bytes per room with packed structures, cached center coordinates, and wall door counters
- **Total Room Storage**: 960 bytes (48 bytes × 20 rooms maximum)
- **Scrolling**: Partial screen updates with no slowdown at map boundaries
- **Code Quality**: 6502 architecture optimizations with efficient metadata management

This implementation leverages both 8-bit programming techniques and modern compiler optimization strategies, adapted specifically for the hardware constraints of the Commodore 64.
