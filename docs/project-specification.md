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
├── main.c                   # Entry point and VIC-II setup
├── mapgen/
│   ├── mapgen_api.h         # Public interface definitions
│   ├── mapgen_types.h       # Core data structures and constants
│   ├── mapgen_internal.h    # Internal module definitions
│   ├── map_generation.c     # Generation pipeline control
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

## Map Generation Logic

The generation process displays real-time progress with centered progress bar and phase indicators:

### Phase 1: Building Rooms

The room generation operates on a 4×4 grid system providing 16 potential positions across the map. The process works as follows:

**Grid-Based Placement:**
- The map is divided into 16 equal cells (4×4 grid)
- Each cell represents a potential room position
- Cell order is randomized using Fisher-Yates shuffle algorithm
- Additional shuffle passes break grid alignment patterns

**Room Sizes and Types:**
- Base size ranges from 4×4 to 8×8 tiles
- 60% probability for rectangular rooms (wider or taller bias)
- 40% probability for more square-shaped rooms
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
// Validation: connection_system.c:232-251
if (r1_cx == r2_cx) {
    // Vertical alignment - rooms must face each other (not overlap)
    return (r1_cy < r2_cy) ? (r1->y + r1->h <= r2->y) : (r2->y + r2->h <= r1->y);
}
```

### 2. **L-shaped Corridors** - Type 1

**Geometric Requirements:**
- Diagonally positioned rooms
- Pivot point must be outside both rooms
- Both segments must step "outward" from room doors

**Door Placement Logic:**
- **Vertical walls (left/right):** FIRST horizontal, THEN vertical
- **Horizontal walls (top/bottom):** FIRST vertical, THEN horizontal
- Direction determined by wall side of first room

**Corridor Path:**
- **2 segments:** door1 → pivot point → door2
- **1 break point:** right-angle turn at pivot
- **Direction:** deterministic based on wall side

```c
// Path logic: connection_system.c:82-98
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
// Segment calculation: connection_system.c:106-129
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
2. **Second Priority:** L-shaped corridor (when geometric validation passes)
3. **Third Priority:** Z-shaped corridor (default fallback)

## Wall Side Encoding

```c
// Wall side determination: connection_system.c:224-229
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

**Wall Building:** Walls are constructed around each corridor tile as it's placed
**Atomic Operations:** All corridor metadata stored atomically to prevent inconsistent states
**Geometric Validation:** Each corridor type validates path safety before construction
**System Integration:** Door metadata includes position, wall direction, and corridor type

### Phase 3: Creating Secret Areas

The secret room system provides a special gameplay mechanic:

**Secret Room Criteria:**
- Only rooms with exactly 1 connection are eligible
- Connected room must not have other doors on the same wall (prevents corridor deletion)
- 50% probability of conversion to secret status
- Room `state` field receives `ROOM_SECRET` flag marking (prevents treasure placement)

**Secret Door Conversion:**
- Only the entrance door in the normal room becomes `TILE_SECRET_PATH`
- The corridor and secret room door remain normal tiles
- This creates a hidden entrance mechanism to the secret room
- Visual representation uses special character (`░` symbol) only at entrance

### Phase 3.5: Placing Secret Treasures

The secret treasure system creates hidden treasure chambers accessible through walls:

**Secret Treasure Criteria:**
- Places 3 secret treasures randomly across available rooms
- Only places treasures on walls that have no doors
- Excludes secret rooms (rooms with `ROOM_SECRET` flag)
- Prevents duplicate treasures per room using `ROOM_HAS_TREASURE` flag
- Excludes corners to prevent placement conflicts
- Uses `wall_has_doors()` validation to ensure wall availability

**Treasure Chamber Construction:**
- Wall position becomes `TILE_SECRET_PATH` (secret passage through wall)
- Adjacent position outside room becomes `TILE_FLOOR` (treasure chamber)
- `place_walls_around_corridor_tile()` builds protective walls around chamber
- Maintains wall_side consistency with existing door system (0=Left, 1=Right, 2=Top, 3=Bottom)

**Wall Selection Algorithm:**
- Early return if room has `ROOM_SECRET` or `ROOM_HAS_TREASURE` flags
- Iterates through all 4 wall sides per room
- Skips walls containing any doors using existing helper pattern
- Randomly selects position within wall boundaries (excluding corners)
- Validates bounds before placement to prevent map edge conflicts
- Sets `ROOM_HAS_TREASURE` flag upon successful placement

### Phase 4: Placing Stairs

Stair placement system ensures optimal level navigation:

**Priority-Based Selection:**
- Up stairs placed in highest priority room
- Down stairs placed in second highest priority room
- Priority ensures stairs are placed in well-connected, accessible rooms

**Distance Validation:**
- Adaptive minimum distance requirements: 20 tiles (≤6 rooms) or 30 tiles (>6 rooms)
- Distance calculated using Manhattan distance between room centers
- Ensures reasonable separation between level entry and exit points

**Placement Strategy:**
- Stairs positioned at room centers for optimal accessibility
- Coordinate bounds checking prevents placement errors
- System guarantees valid navigation paths between levels

### Phase 5: Finalizing

Final generation step completes the map:

**Camera Initialization:**
- Viewport positioning for interactive navigation
- System preparation for player movement

## Data Storage System

### Compact Map Format

Map data is stored using a 3-bit per tile encoding:

**Bit-Level Compression:**
- Each tile type is represented by 3 bits (8 possible types)
- 72×72 map = 5184 tiles × 3 bits = efficiently packed data
- Bits can span byte boundaries for maximum compression
- Direct bit manipulation provides O(1) tile access

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
- `priority`: Stair placement priority (1-10 scale)
- `connections`: Number of active connections
- `state`: Secret room flag and status bits

**Connection Metadata (Optimized):**
- `conn_data[4]`: Packed connection structures with room ID and corridor type only
- `doors[4]`: Packed door structures with coordinates and wall side only
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
    unsigned char x, y, w, h;              // Room position and dimensions
    unsigned char connections;             // Number of active connections
    unsigned char state;                   // Room state flags (ROOM_SECRET, ROOM_HAS_TREASURE)
    
    // Optimized packed connection metadata (4 bytes)
    PackedConnection conn_data[4];         // Connection information
    Door doors[4];                         // Door positions and metadata (12 bytes)
    
    // Corridor breakpoint metadata (16 bytes) - for pathfinding and navigation
    CorridorBreakpoint breakpoints[4][2];  // Turn points (L=1, Z=2 breakpoints max)
    
    // Secret treasure metadata (2 bytes) - wall position where treasure is accessible
    unsigned char treasure_wall_x;        // Secret wall X coordinate (255 = no treasure)
    unsigned char treasure_wall_y;        // Secret wall Y coordinate
    
    // Less frequently accessed
    unsigned char hub_distance, priority; // Generation parameters
} Room; // 42 bytes total - optimized for C64 memory constraints
```

### Packed Connection Structure
```c
typedef struct {
    unsigned char room_id : 5;             // Connected room ID (0-31)
    unsigned char corridor_type : 3;       // Corridor type (0-7, expanded for future use)
} PackedConnection; // 1 byte total - removed 'used' flag (redundant with connections counter)
```

### Optimized Door Structure
```c
typedef struct {
    unsigned char x, y;                    // Door coordinates
    unsigned char wall_side : 2;           // Wall side (0-3)
    unsigned char is_secret_door : 1;      // Secret room entrance flag
    unsigned char has_treasure : 1;        // Treasure chamber attached flag
    unsigned char reserved : 4;            // Reserved for future use
} Door; // 3 bytes total - bit-packed flags for secret tracking
```

### Corridor Breakpoint Structure
```c
typedef struct {
    unsigned char x, y;                    // Breakpoint coordinates
} CorridorBreakpoint; // 2 bytes total - compact coordinate storage
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
- State flags stored in room `state` field using bitwise operations

**Secret Treasure System:**
- `treasure_wall_x, treasure_wall_y`: Coordinates of secret wall passage
- Invalid coordinates (255, 255) indicate no treasure
- `wall_has_doors()`: Validates wall availability before treasure placement
- `place_secret_treasures()`: Places exactly 3 treasures across available rooms

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
6. **Stair Placement**: Start/end room assignment by priority
7. **Camera Initialization**: Viewport setup for navigation

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

**Compiler Flags:**
```bash
oscar64.exe -o="build/Hacked C64.prg" -n -tf=prg -Os -dNOLONG -dNOFLOAT -tm=c64
```

**Flag Details:**
- `-Os`: Size optimization priority
- `-dNOLONG`: Exclude long integer support (saves space)  
- `-dNOFLOAT`: Remove floating point operations (saves space)
- `-tm=c64`: Target Commodore 64 platform
- `-tf=prg`: Generate .prg executable format

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

// Statistics and validation
void mapgen_get_statistics(unsigned char *floor_tiles, ...);
unsigned char mapgen_validate_map(void);
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

## Development Standards

### Code Quality
- **Static Analysis**: Zero dynamic memory allocation
- **Type Safety**: Explicit unsigned char usage for 8-bit targets
- **Documentation**: Inline comments for algorithm implementations
- **Testing**: Validation functions for map integrity verification

### Performance Metrics
- **Generation Time**: ~3-4 seconds on C64 hardware
- **Executable Size**: Optimized for C64 constraints (release build significantly smaller than debug)
- **Memory Management**: Static allocation only, no dynamic memory
- **Map Storage**: 3072 bytes (3-bit packed tile encoding)
- **Room Data**: 42 bytes per room (optimized packed structures)
- **Code Quality**: Optimized for 6502 architecture with substantial size improvements

### Optimization Results
- **Code-level optimizations**: Redundant safety checks removed, inline functions for hot paths
- **Compiler optimizations**: Size optimization (`-Os`), code outlining (`-Oo`), debug overhead elimination
- **Build separation**: Development builds with full debug vs production builds with maximum optimization
- **Performance improvements**: Reduced function call overhead, batched progress updates

This implementation leverages both 8-bit programming techniques and modern compiler optimization strategies, adapted specifically for the hardware constraints of the Commodore 64.
