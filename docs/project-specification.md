# C64 Procedural Dungeon Generator

A real-time dungeon map generation system for the Commodore 64, utilizing OSCAR64 cross-compiler for 8-bit development.

## Project Overview

This project implements a highly optimized procedural dungeon generation algorithm for the Commodore 64 hardware architecture. The system generates connected room networks using minimum spanning tree algorithms, features secret room mechanics, and provides interactive navigation with constrained memory usage.

**Target Platform:** Commodore 64 (6502 processor, 64KB RAM)  
**Compiler:** OSCAR64 cross-compiler with size optimization  
**Output:** Optimized C64 executable (.prg format)  
**Memory Footprint:** Efficient allocation with 3-bit tile encoding and optimized data structures  
**Optimization Level:** Substantial code and compiler optimizations applied for minimal footprint

## Project Structure

```
main/src/
├── main.c                   # Entry point, VIC-II setup, joystick 2 input
├── mapgen/
│   ├── mapgen_api.h         # Public interface definitions
│   ├── mapgen_types.h       # Core data structures and constants
│   ├── mapgen_internal.h    # Internal module definitions
│   ├── mapgen_config.c/.h   # Pre-generation configuration with joystick menu
│   ├── map_generation.c     # Generation pipeline with dynamic parameters
│   ├── room_management.c    # Room placement algorithms
│   ├── connection_system.c  # MST and corridor generation (optimized)
│   ├── mapgen_display.c/.h  # Viewport and rendering
│   ├── mapgen_utils.c/.h    # Utility functions and math (with inline optimizations)
│   └── map_export.c/.h      # File I/O operations
build-dev.bat                # Development build with debug information
build-release.bat            # Optimized production build
build.bat                    # Interactive build selection
run_vice.bat                 # VICE emulator launcher
docs/                        # Comprehensive technical documentation
```

## User Input System

### Joystick 2 Control (Primary)

The system uses **Joystick 2** for all primary interactions via CIA1 Port A ($DC00):

**Map Navigation:**
- Reads joystick directions via CIA1 Port A register
- Supports diagonal movement (multiple directions simultaneously)
- Direct hardware access for responsive control
- Bit mapping: UP(0), DOWN(1), LEFT(2), RIGHT(3), FIRE(4) - active low

**Configuration Menu:**
- Fire button opens configuration menu
- Up/Down navigates menu options
- Left/Right adjusts values (Small/Medium/Large)
- Fire button confirms and starts generation
- Debounce logic prevents repeated inputs

### Keyboard Input (Secondary)

Limited keyboard support for essential commands:
- **Q key**: Quit program (via `getchx()`)
- **M key**: Export map to disk (via `getchx()`)

### Configuration System

**Pre-Generation Parameters:**
- **Map Size**: Small (48×48), Medium (64×64), Large (80×80)
- **Room Count**: Small (8), Medium (12), Large (16)
- **Secret Rooms**: 10%/20%/30% of max rooms
- **False Corridors**: 3/5/8 dead-end passages
- **Secret Treasures**: 2/4/6 hidden chambers
- **Hidden Corridors**: 1/2/3 non-branching corridors converted to secret paths

**Implementation Details:**
- Configuration stored in `MapConfig` structure
- Values validated and converted to `MapParameters`
- Dynamic parameter passing to generation pipeline
- Real-time value updates in menu display

## Map Generation Logic

The generation process displays real-time progress with centered progress bar and phase indicators. Progress boundaries are calculated dynamically at generation start based on current parameters, ensuring accurate progress representation regardless of configuration:

### Phase 1: Building Rooms

The room generation operates on a 4×4 grid system providing 16 potential positions across the map. The process works as follows:

**Grid-Based Placement:**
- The map is divided into 16 equal cells (4×4 grid)
- Each cell represents a potential room position
- Cell order is randomized using Fisher-Yates shuffle algorithm

**Room Sizes and Types:**
- Fixed size range from 4×4 to 8×8 tiles (not user-configurable)
- Random width and height generation within range
- Room count varies based on configuration (8/12/16)
- Each room maintains minimum 4-tile distance from others

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

### Phase 2: Connecting Rooms (MST Algorithm)

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

```c
// Validation: can_use_straight_corridor() in connection_system.c
if (r1_cx == r2_cx) {
    // Vertical alignment - rooms must face each other (not overlap)
    return (r1_cy < r2_cy) ? (r1->y + r1->h <= r2->y) : (r2->y + r2->h <= r1->y);
}
```

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
- **Direction:** deterministic based on wall side

```c
// Path logic: compute_corridor_breakpoints() in connection_system.c
if ((wall1_side & 0x02) == 0) {
    // Vertical wall -> HORIZONTAL FIRST
    pivot_x = door2_x; pivot_y = door1_y;
} else {
    // Horizontal wall -> VERTICAL FIRST  
    pivot_x = door1_x; pivot_y = door2_y;
}
```

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
- **Segment lengths:** first leg is 1/3 of total distance

```c
// Segment calculation: compute_corridor_breakpoints() in connection_system.c
if ((wall_side & 0x02) == 0) { // Vertical walls -> horizontal start
    unsigned char leg_length = dx / 3;
    seg1_end_x = (door2_x > door1_x) ? door1_x + leg_length : door1_x - leg_length;
} else { // Horizontal walls -> vertical start
    unsigned char leg_length = dy / 3;
    seg1_end_y = (door2_y > door1_y) ? door1_y + leg_length : door1_y - leg_length;
}
```

## Corridor Type Selection Priority

1. **First Priority:** Straight corridor (when rooms are aligned and facing)
2. **Second Priority:** L-shaped corridor (when both horizontal and vertical gaps > 0)
3. **Third Priority:** Z-shaped corridor (default fallback)

## Wall Side Encoding

```c
// Wall side determination: get_wall_side_from_exit() in mapgen_utils.c
if (exit_x < room->x) return 0; // Left wall
if (exit_x >= room->x + room->w) return 1; // Right wall  
if (exit_y < room->y) return 2; // Top wall
return 3; // Bottom wall
```

- **0:** Left wall
- **1:** Right wall  
- **2:** Top wall
- **3:** Bottom wall

## Corridor Construction Process

**Two-pass Walker:** `process_corridor_path()` drives both validation and drawing using shared breakpoints for straight, L, and Z paths.
**Wall Building:** Walls are constructed around each corridor tile as it's placed.
**Atomic Operations:** All corridor metadata stored atomically to prevent inconsistent states.
**Geometric Validation:** Each corridor type validates path safety before construction.
**System Integration:** Door metadata includes position, wall direction, and corridor type.

### Phase 3: Creating Secret Areas

The secret room system provides a special gameplay mechanic:

**Secret Room Criteria:**
- Only rooms with exactly 1 connection are eligible
- Connected room must not have other doors on the same wall (prevents corridor deletion)
- 50% probability of conversion to secret status
- Room `state` field receives `ROOM_SECRET` flag marking (prevents treasure placement)

**Secret Door Conversion:**
- Only the entrance door in the normal room becomes `TILE_SECRET_PATH`
- The corridor remains normal, but the secret room door is converted to `TILE_FLOOR`
- This creates a hidden entrance mechanism to the secret room
- Visual representation uses special character (`░` symbol) only at entrance

### Phase 4: Placing Secret Treasures

The secret treasure system creates hidden treasure chambers accessible through walls:

**Secret Treasure Criteria:**
- Places secret treasures randomly across available rooms (configurable: 2/4/6)
- Only places treasures on walls without doors, false corridor entrances, or treasure metadata
- Excludes secret rooms (rooms with `ROOM_SECRET` flag)
- Prevents duplicate treasures per room using `ROOM_HAS_TREASURE` flag
- Excludes corners to prevent placement conflicts
- Uses enhanced `wall_has_doors()` validation to ensure wall availability

**Treasure Chamber Construction:**
- Wall position becomes `TILE_SECRET_PATH` (secret passage through wall)
- Adjacent position outside room becomes `TILE_FLOOR` (treasure chamber)
- `place_walls_around_corridor_tile()` builds protective walls around chamber
- Maintains wall_side consistency with existing door system (0=Left, 1=Right, 2=Top, 3=Bottom)

**Wall Selection Algorithm:**
- Early return if room has `ROOM_SECRET` or `ROOM_HAS_TREASURE` flags
- Iterates through all 4 wall sides per room
- Skips walls containing any doors (normal connections + false corridors) using enhanced helper pattern
- Randomly selects position within wall boundaries (excluding corners)
- **Boundary validation**: Treasure chamber + surrounding walls must be ≥3 tiles from map edges
  - Prevents treasure structures (3×3 total) from extending beyond map boundaries
  - Validation: `treasure_x < 3 || treasure_x >= map_width - 3 || treasure_y < 3 || treasure_y >= map_height - 3`
- Sets `ROOM_HAS_TREASURE` flag upon successful placement

### Phase 5: Placing False Corridors

The false corridor system creates Nethack-style misleading dead-end passages using wall-first intelligent endpoint generation:

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
- Places false corridors randomly across available rooms (configurable: 3/5/8)
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

### Phase 6: Hiding Corridors

The hidden corridor system identifies and conceals non-branching corridors to increase navigation difficulty:

**Non-Branching Detection:**
- Corridors identified as "non-branching" if both door endpoints have no other doors on the same wall
- Branching detection uses pre-computed `is_branching` flag in Door structure (set during connection creation)
- Excludes secret rooms (already hidden via different mechanism)
- Excludes doors already marked as secret

**Selection Process:**
- Candidate search iterates all room pairs with connections
- Uses `room_has_connection_to()` and `is_non_branching_corridor()` for O(1) validation
- Fisher-Yates shuffle randomizes candidate selection
- Hides up to N corridors (configurable: Small=1, Medium=2, Large=3)
- Maximum capped at 2/3 of room count to preserve navigability

**Corridor Hiding:**
- Converts both door tiles to `TILE_SECRET_PATH`
- Updates `is_secret_door` flag in door metadata
- Maintains corridor structure (only doors change, not corridor tiles)

### Phase 7: Placing Stairs

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

### Phase 7: Finalizing

Final generation step completes the map:

**Camera Initialization:**
- Viewport positioning for interactive navigation
- System preparation for player movement

## Data Storage System

### Compact Map Format

Map data is stored using a 3-bit per tile encoding:

**Bit-Level Compression:**
- Each tile type is represented by 3 bits (8 possible types)
- Dynamic map sizes (48×48, 64×64, 80×80) with runtime bit offset calculation
- Bits can span byte boundaries for maximum compression
- Direct bit manipulation provides O(1) tile access with `calculate_y_bit_offset()`

**Tile Type Encoding:**
- `TILE_EMPTY` (0): Empty space
- `TILE_WALL` (1): Wall structure
- `TILE_FLOOR` (2): Room floor
- `TILE_DOOR` (3): Standard door
- `TILE_UP` (4): Upward staircase
- `TILE_DOWN` (5): Downward staircase
- `TILE_SECRET_PATH` (6): Secret passage

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
- `breakpoints[4][2]`: Corridor turn point coordinates for pathfinding and navigation
- Connection count tracked in `connections` field (single source of truth)
- Atomic operations ensure metadata consistency

**Corridor Breakpoint System:**
- Straight corridors (type 0): No breakpoints stored
- L-shaped corridors (type 1): Single pivot point at bend location
- Z-shaped corridors (type 2): Two breakpoints at segment transition points
- Invalid breakpoints marked with coordinates (255, 255)
- Automatically calculated and stored during corridor generation

### Memory Optimization Strategy

**Static Allocation Design:**
- No dynamic memory allocation (malloc/free eliminated)
- All data structures use pre-allocated fixed-size arrays
- Zero page variables for critical path operations

**Memory Layout:**
- `$0400-$07E7`: VIC-II screen memory (1000 bytes)
- `$0800-$13FF`: Compact map data (3072 bytes, 3-bit packed encoding)
- `$1400-$17FF`: Room structure arrays (packed data structures)
- `$1800-$1BFF`: Display viewport buffer
- `$2000+`: Program code (OSCAR64 optimized executable)

## Data Structures

### Core Room Structure
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

    // Corridor breakpoint metadata (16 bytes)
    CorridorBreakpoint breakpoints[4][2];  // Corridor turn points (L=1, Z=2)

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
    unsigned char room_id : 5;             // Connected room ID (0-31)
    unsigned char corridor_type : 3;       // Corridor type (0-7, expanded for future use)
} PackedConnection;                        // 1 byte total 
```

### Door Structure
```c
typedef struct {
    unsigned char x, y;                    // Door coordinates
    unsigned char wall_side : 2;           // Wall side (0-3)
    unsigned char is_secret_door : 1;      // Secret room entrance flag
    unsigned char has_treasure : 1;        // Treasure chamber attached flag
    unsigned char reserved : 4;            // Reserved for future use
} Door;                                    // 3 bytes total
```

### Corridor Breakpoint Structure
```c
typedef struct {
    unsigned char x, y;                    // Breakpoint coordinates
} CorridorBreakpoint;                      // 2 bytes total 
```

**Breakpoint Usage by Corridor Type:**
- **Straight (0)**: No breakpoints needed
- **L-shaped (1)**: Single breakpoint at pivot location  
- **Z-shaped (2)**: Two breakpoints at segment transition points
- **Invalid marker**: Coordinates (255, 255) indicate unused breakpoint slot

### Secret Metadata Tracking

**Room State Flags:**
- `ROOM_SECRET`: Marks rooms converted to secret status (prevents treasure placement)
- `ROOM_HAS_TREASURE`: Prevents duplicate treasure placement per room
- `ROOM_HAS_FALSE_CORRIDOR`: Marks rooms with false corridor attachments
- State flags stored in room `state` field using bitwise operations

**Secret Treasure System:**
- `treasure_wall_x, treasure_wall_y`: Coordinates of secret wall passage
- Invalid coordinates (255, 255) indicate no treasure
- `wall_has_doors()` (mapgen_utils.c): Validates wall availability (normal + false corridor doors)
- `get_wall_side_from_exit()` (mapgen_utils.c): Determines wall side from door position
- `place_secret_treasures()` (connection_system.c): Places configurable number of treasures (2/4/6) across available rooms

**False Corridor System:**
- `false_corridor_door_x, false_corridor_door_y`: Coordinates of corridor entrance door
- `false_corridor_end_x, false_corridor_end_y`: Coordinates of corridor dead-end
- Invalid coordinates (255, 255) indicate no false corridor
- `place_false_corridors()`: Places configurable number of false corridors (3/5/8) with retry logic and two-pass walker validation

## Algorithm Performance

### Computational Complexity
- **Room Placement**: O(n) with grid constraints
- **MST Generation**: O(n²) for complete connectivity
- **Wall Placement**: O(room_perimeter + corridor_length) incremental during creation
- **Screen Rendering**: O(viewport_size) with delta optimization

### Hardware Integration
- **VIC-II**: Direct register access ($D000-$D02E)
- **CIA**: Timer-based random seed generation
- **KERNAL**: Optimized I/O operations
- **Direct Memory**: Screen buffer manipulation at $0400

## Generation Pipeline

1. **Initialization**: Map clearing, random seed setup
2. **Room Creation**: Grid-based placement with collision detection and immediate wall construction
3. **Connection System**: MST algorithm execution with corridor walls built during creation
4. **Secret Rooms**: Single-connection room conversion
5. **Secret Treasures**: Hidden treasure chamber placement on available walls
6. **False Corridors**: Dead-end corridor placement on available room walls
7. **Stair Placement**: Distance-based optimal placement (maximum separation)
8. **Camera Initialization**: Viewport setup for navigation

## Technical Architecture

### System Components

| Component | Responsibility |
|-----------|---------------|
| **Core Generator** (`map_generation.c`) | Pipeline orchestration and master control |
| **Room System** (`room_management.c`) | Placement algorithms with grid distribution |
| **MST Connectivity** (`connection_system.c`) | Prim's algorithm, corridor generation, secret rooms |
| **Display Engine** (`mapgen_display.c`) | Viewport management, delta rendering, input |
| **Utility Layer** (`mapgen_utils.c`) | Bit manipulation, math operations, validation |
| **Export System** (`map_export.c`) | KERNAL-based file I/O operations |

### Build Configuration

**Development Build Flags:**
```bash
oscar64.exe -O0 -g -n -dDEBUG -d__oscar64__ -tf=prg -tm=c64 -dNOLONG -dNOFLOAT -psci
```

**Release Build Flags:**
```bash
oscar64.exe -Os -Oo -tf=prg -tm=c64 -dNOLONG -dNOFLOAT -psci
```

**Flag Details:**
- `-Os`: Size optimization priority (release only)
- `-Oo`: Code outlining optimization (release only)
- `-O0`: No optimization (development only)
- `-g`: Debug symbols (development only)
- `-n`: Generate additional debug files (development only)
- `-dDEBUG`: Define DEBUG macro (development only)
- `-dNOLONG`: Exclude long integer support (saves space)
- `-dNOFLOAT`: Remove floating point operations (saves space)
- `-tm=c64`: Target Commodore 64 platform
- `-tf=prg`: Generate .prg executable format
- `-psci`: Enable SCI (Screen Character Interface) support

### CMake Integration
Cross-platform build system with automatic OSCAR64 detection:
```cmake
set(OSCAR64_BIN "${OSCAR64_PATH}/oscar64/bin/oscar64.exe")
add_custom_command(OUTPUT ${OUTPUT_PRG} COMMAND ${OSCAR64_BIN} ...)
```

## API Interface

### Public Functions
```c
// Core generation
unsigned char mapgen_generate_dungeon(void);

// Room queries
unsigned char mapgen_get_room_info(unsigned char room_index, ...);
unsigned char mapgen_find_room_at_position(unsigned char x, unsigned char y);
unsigned char mapgen_get_map_size(void);  // Returns current map width/height

// Statistics and validation
void mapgen_get_statistics(unsigned char *floor_tiles, ...);
unsigned char mapgen_validate_map(void);

// Map export
void save_compact_map(const char* filename);  // Export map to PRG format
```

### Atomic Metadata Management Functions
```c
// Atomic connection management - adds connection and door metadata in single operation
unsigned char add_connection_to_room(unsigned char room_idx, unsigned char connected_room,
                                    unsigned char door_x, unsigned char door_y, 
                                    unsigned char wall_side, unsigned char corridor_type);

// Centralized connection validation - checks if rooms are already connected
unsigned char room_has_connection_to(unsigned char room_idx, unsigned char target_room);

// Get connection info for specific connected room
unsigned char get_connection_info(unsigned char room_idx, unsigned char target_room,
                                 unsigned char *door_x, unsigned char *door_y, 
                                 unsigned char *wall_side, unsigned char *corridor_type);

// Atomic rollback - removes last connection from room safely
unsigned char remove_last_connection_from_room(unsigned char room_idx);
```

## Map Export System

### File Format (MAPBIN.PRG)

The map export system saves generated dungeons to disk in a compact PRG format compatible with C64 KERNAL routines.

**File Structure:**
```
Byte 0-1:   PRG load address (little-endian, added automatically by C64 KERNAL SAVE)
Byte 2:     Map size (single byte: 48, 64, or 80)
Byte 3+:    Packed tile data (3 bits per tile, bit stream crosses byte boundaries)
```

**File Size Calculation:**
```c
tile_bits = map_size × map_size × 3
data_bytes = (tile_bits + 7) / 8
total_size = 2 (PRG header) + 1 (size byte) + data_bytes
```

**Example File Sizes:**
- 48×48 map: 2 + 1 + 864 = **867 bytes**
- 64×64 map: 2 + 1 + 1536 = **1539 bytes**
- 80×80 map: 2 + 1 + 2400 = **2403 bytes**

### Tile Encoding (3 bits per tile)

| Value | Tile Type    | PETSCII Display |
|-------|--------------|-----------------|
| 0     | Empty        | Space (32)      |
| 1     | Wall         | Block (160)     |
| 2     | Floor        | Period (46)     |
| 3     | Door         | Plus (219)      |
| 4     | Up stairs    | Less-than (60)  |
| 5     | Down stairs  | Greater (62)    |
| 6     | Secret path  | Caret (94)      |
| 7     | (reserved)   | -               |

### Implementation Details

**Export Function:**
```c
void save_compact_map(const char* filename);
```

**Trigger:**
- User presses 'M' key during map navigation
- File saved as "mapbin" (lowercase for proper PETSCII display)
- Appears as "MAPBIN" in C64 directory listing

**Technical Implementation:**
1. Query current map size using `mapgen_get_map_size()`
2. Calculate actual data bytes needed: `(size² × 3 + 7) / 8`
3. Create export buffer: `[size (1 byte)] + [compact_map data]`
4. Use KERNAL SAVE routine via `krnio_save()` which automatically adds PRG header
5. Only save necessary bytes (not full 2400-byte buffer)

**Memory Optimization:**
- Static buffer allocation (max size 2400 bytes for 80×80)
- Dynamic size calculation prevents unnecessary disk I/O
- Runtime bit offset calculation: `y * map_width * 3` ensures correct tile access
- Efficient 3-bit packing maintains compact file sizes

## Development Standards

### Code Quality
- **Static Analysis**: Zero dynamic memory allocation
- **Type Safety**: Explicit unsigned char usage for 8-bit targets
- **Documentation**: Inline comments for algorithm implementations
- **Testing**: Validation functions for map integrity verification

### Performance Metrics
- **Generation Time**: ~2-5 seconds on C64 hardware (varies by map size and configuration)
- **Executable Size**: C64 constraints (release build significantly smaller than debug)
- **Memory Management**: Static allocation with maximum-sized buffers, runtime bounds checking
- **Map Storage**: 2400 bytes max buffer (handles 48×48=864, 64×64=1536, 80×80=2400)
- **Room Data**: 48 bytes per room with packed structures, cached center coordinates, and wall door counters
- **Scrolling**: Partial screen updates with no slowdown at map boundaries
- **Code Quality**: 6502 architecture optimizations with efficient metadata management

This implementation leverages both 8-bit programming techniques and modern compiler optimization strategies, adapted specifically for the hardware constraints of the Commodore 64.
