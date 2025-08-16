
# Oscar64/C64 Advanced Dungeon Map Generator – Source Directory Documentation

This document provides comprehensive documentation for the source code architecture, algorithms, and implementation details of the Oscar64/C64 dungeon map generator. The codebase represents a sophisticated example of C64 programming with modern software engineering principles, featuring advanced algorithms, optimal memory management, and hardware-specific optimizations.

## Project Architecture Overview

The project follows a modular, layered architecture designed specifically for C64 hardware constraints while maintaining code clarity and maintainability. All modules are written in C and optimized for Oscar64 compilation, with extensive use of static memory allocation and hardware-specific optimizations.

## Current Project Structure

```ascii
main/src/
├─ main.c                             // Application entry point, VIC-II setup, main control loop, user input
├─ README.md                          // This comprehensive documentation
└─ mapgen/                           // Complete map generation system (modular architecture)
    ├─ connection_system.c            // MST algorithm, room connections, corridor generation logic
    ├─ map_export.c                   // Map export to C64 PRG format using Oscar64 KERNAL I/O
    ├─ map_export.h                   // Map export function declarations and constants
    ├─ map_generation.c               // Main generation pipeline orchestration and coordination
    ├─ mapgen_api.h                   // Public API interface for map generation system
    ├─ mapgen_display.h               // Display and rendering function declarations
    ├─ mapgen_globals.h               // Global variables and shared state management
    ├─ mapgen_internal.h              // Internal helper functions and private declarations
    ├─ mapgen_types.h                 // Core data structures, constants, and type definitions
    ├─ mapgen_utils.c                 // Mathematical utilities, random generation, helper functions
    ├─ mapgen_utils.h                 // Utility function declarations and mathematical constants
    ├─ room_management.c              // Room placement, validation, and priority systems
    └─ testdisplay.c                  // Screen handling, viewport management, user input processing
```

### Module Responsibility Matrix

| Module | Primary Function | Key Algorithms | C64 Optimizations |
|--------|------------------|----------------|-------------------|
| **main.c** | System initialization, main loop | VIC-II configuration, input processing | Direct hardware register access |
| **map_generation.c** | Generation pipeline coordination | Two-pass wall placement, stair positioning | Memory-efficient iteration patterns |
| **connection_system.c** | Room connectivity and corridors | MST algorithm, path finding | Static memory pools, optimized distance caching |
| **room_management.c** | Room placement and validation | Grid-based placement, collision detection | Bit-packed validation, fast bounds checking |
| **testdisplay.c** | Display and user interaction | Delta refresh, viewport management | Direct screen memory access, PETSCII optimization |
| **mapgen_utils.c** | Mathematical and utility functions | Random number generation, coordinate math | Hardware entropy, optimized arithmetic |
| **map_export.c** | File I/O and data persistence | Compact binary serialization | KERNAL I/O routines, device management |

---

## Advanced Tile Encoding System (mapgen_types.h)

The project implements a sophisticated dual-level tile encoding system optimized for both memory efficiency and rendering performance on C64 hardware.

### 1. Display-Level PETSCII Encoding

These constants provide direct mapping to PETSCII character codes for immediate screen rendering, chosen for optimal visual clarity and C64 hardware compatibility.

```c
// PETSCII Display Constants
#define EMPTY   32    // Space character: empty/unoccupied tiles
#define WALL    160   // Solid block: structural walls
#define CORNER  230   // Shaded block: architectural corners and junctions
#define FLOOR   46    // Period (.): walkable floor surfaces
#define DOOR    171   // Inverse plus (+): doorways and passages
#define UP      60    // Less-than (<): ascending stairs
#define DOWN    62    // Greater-than (>): descending stairs
```

**Design Rationale**: These PETSCII values are written directly to $0400 (C64 screen memory) for maximum rendering speed. The character selection ensures clear visual distinction while maintaining compatibility with C64 character ROM limitations.

### 2. Compact Internal Encoding

For algorithmic processing and memory-optimized storage, each tile uses a compact 3-bit representation, allowing efficient bit-packing and fast logical operations.

```c
// Compact Internal Representation
#define TILE_EMPTY   0 // Unused/background tile
#define TILE_WALL    1 // Structural wall tile
#define TILE_FLOOR   2 // Walkable floor surface
#define TILE_DOOR    3 // Passage/doorway tile
#define TILE_UP      4 // Upward staircase
#define TILE_DOWN    5 // Downward staircase
#define TILE_CORNER  6 // Architectural corner element
```

**Memory Efficiency**: This encoding enables 8 tiles to be packed into 3 bytes (8 * 3 bits = 24 bits), achieving 12.5% memory overhead for a 4096-tile map stored in only 1536 bytes.

### 3. Real-Time Conversion System

The conversion between internal and display representations is handled by an optimized macro that eliminates function call overhead:

```c
#define TILE_TO_PETSCII(tile) ((tile) == TILE_EMPTY ? EMPTY : \
                               (tile) == TILE_WALL ? WALL : \
                               (tile) == TILE_FLOOR ? FLOOR : \
                               (tile) == TILE_DOOR ? DOOR : \
                               (tile) == TILE_UP ? UP : \
                               (tile) == TILE_DOWN ? DOWN : \
                               (tile) == TILE_CORNER ? CORNER : EMPTY)
```

This dual-encoding approach provides the benefits of compact storage during generation and fast rendering during display, optimized specifically for C64 hardware constraints.

---

## Advanced Map Generation Pipeline

The map generation system implements a sophisticated multi-stage pipeline designed for creating organic, interconnected dungeon layouts while respecting strict C64 memory and performance constraints. Each stage builds upon the previous one, with comprehensive validation and optimization at every step.

### Stage 1: System Initialization and State Management

The initialization process establishes a clean, reproducible foundation for map generation through careful state management and hardware preparation.

#### Random Number Generator Initialization (`init_rng()`)

- **Hardware Entropy Collection**: Utilizes CIA timer registers and SID voice frequencies for true randomness
- **Seed Mixing Algorithm**: Combines multiple entropy sources with mathematical operations for unpredictable sequences
- **Oscar64 Optimization**: Custom assembly routines for maximum performance on C64 hardware
- **Automatic Invocation**: Called by `reset_all_generation_data()` ensuring fresh randomness for each map

#### Connection System Setup (`init_connection_system()`)

- **Matrix Initialization**: Zeros the room-to-room connection matrix using optimized memory operations
- **Cache Management**: Resets distance cache with 255 (invalid marker) preventing stale data corruption
- **Memory Pool Reset**: Initializes corridor segment pools and connection caches for deterministic reuse
- **Precomputation**: Builds symmetric distance cache for MST and pathfinding optimization
- **Static Allocation**: All data structures use fixed-size arrays, ensuring predictable memory usage

This dual-phase initialization guarantees consistent, reproducible state management with optimal C64 hardware utilization.

### Stage 2: Intelligent Room Placement System

Room placement uses advanced grid-based algorithms with sophisticated validation to ensure optimal distribution and collision-free placement.

#### Grid-Based Distribution Algorithm

- **Fisher-Yates Shuffle**: Randomizes 4x4 grid positions for even room distribution across the map
- **Anti-Clustering Logic**: Prevents room concentration in specific map regions
- **Size Randomization**: Dynamic room sizing (4-8 tiles) with bias toward medium sizes for optimal connectivity
- **Placement Attempts**: Multiple attempts per grid cell with fallback logic for challenging placements

#### Advanced Validation System (`can_place_room()`)

- **Edge Distance Checking**: Ensures minimum 3-tile distance from map boundaries
- **Collision Detection**: Multi-stage overlap checking with both bounding box and per-tile validation
- **Minimum Distance Enforcement**: Maintains MIN_ROOM_DISTANCE between all room pairs
- **Terrain Analysis**: Verifies all proposed tiles are empty and suitable for room placement
- **Performance Optimization**: Early termination on first validation failure

#### Room Commitment Process (`place_room()`)

- **Atomic Placement**: All-or-nothing room placement preventing partial room states
- **Floor Tile Assignment**: Sets TILE_FLOOR for all interior room positions
- **Metadata Update**: Updates global room list with position, size, and connectivity information
- **Center Calculation**: Computes and caches room centers for corridor connection optimization

### Stage 3: MST-Based Room Connection System

The connection system implements a sophisticated Minimum Spanning Tree algorithm enhanced with rule-based corridor generation and intelligent path optimization.

#### Enhanced MST Algorithm (`generate_level()`)

- **Weighted Distance Calculation**: Uses Manhattan distance with corridor complexity penalties
- **Incremental Construction**: Builds MST one connection at a time, validating each addition
- **Connectivity Verification**: Ensures all rooms are reachable through DFS traversal
- **Fallback Mechanisms**: Handles edge cases where optimal connections are impossible

#### Intelligent Corridor Generation (`draw_corridor()`)

- **Axis Alignment Analysis**: Determines optimal corridor type based on room positioning
- **Path Type Selection**:
  - **Straight Corridors**: For rooms with overlapping projections on X or Y axis
  - **L-Shaped Corridors**: For diagonal connections with medium distances
  - **Z-Shaped Corridors**: For complex long-distance connections requiring intermediate segments
- **Collision Avoidance**: Ensures corridors never intersect existing rooms or create invalid layouts
- **Exit Point Optimization**: Places corridor endpoints 2 tiles from room perimeters for clean connections

#### Advanced Pathfinding Features

- **Multi-Segment Coordination**: Manages complex corridors with multiple directional changes
- **Endpoint Override System**: Allows flexible corridor placement at room boundaries when necessary
- **Path Validation**: Comprehensive checking ensures all corridor tiles are placeable
- **Memory Pool Management**: Efficient reuse of corridor segment data structures

## Stage 4: Advanced Wall and Corner Generation

The wall generation system implements a sophisticated two-pass algorithm inspired by NetHack's architectural principles, ensuring complete visual enclosure and proper corner detection.

### Two-Pass Wall Placement Algorithm (`add_walls()`)

**Pass 1: Perimeter Wall Placement**:

- **Walkable Tile Scanning**: Iterates through all map positions identifying floor, door, and stair tiles
- **Adjacent Empty Detection**: Places wall tiles in all cardinal directions (N/S/E/W) from walkable areas
- **Enclosure Guarantee**: Ensures complete wall coverage around all accessible areas
- **Performance Optimization**: Single-pass iteration with immediate wall placement

**Pass 2: NetHack-Style Corner Detection**:

- **L-Junction Recognition**: Identifies 90-degree wall intersections for corner placement
- **T-Junction Handling**: Places corners at three-way wall intersections
- **Door Adjacent Logic**: Adds corners near doorways for visual consistency
- **Straight Wall Preservation**: Maintains clean wall runs by avoiding unnecessary corner placement

### Advanced Corner Detection Logic (`is_true_corner()`)

```c
// Sophisticated corner detection algorithm
if (wall_count == 2) {
    // L-shaped corners - perpendicular wall patterns
    if ((wall_north && wall_east) || (wall_north && wall_west) ||
        (wall_south && wall_east) || (wall_south && wall_west)) {
        return 1; // Place corner tile
    }
}
```

This approach produces visually appealing dungeons with proper architectural features while maintaining optimal C64 performance.

## Stage 5: Priority-Based Stair Placement

Stair placement uses a sophisticated priority system to ensure optimal dungeon navigation flow and logical progression.

### Priority Calculation System (`assign_room_priorities()`)

- **MST Position Analysis**: Rooms with higher connectivity receive priority bonuses
- **Distance Weighting**: Rooms farther from map center get increased priority
- **Hub Detection**: Identifies rooms that serve as connection hubs between map regions
- **Balanced Distribution**: Ensures stairs are placed in strategically important locations

### Stair Placement Logic (`add_stairs()`)

- **Dual Stair System**: Places both UP and DOWN stairs for complete level navigation
- **Highest Priority Selection**: UP stairs placed in room with maximum priority value
- **Second Highest Selection**: DOWN stairs placed in second-highest priority room
- **Center Positioning**: Stairs positioned at exact room centers for accessibility
- **Conflict Avoidance**: Ensures UP and DOWN stairs never occupy the same room

## Stage 6: Interactive Display and Navigation System

The display system implements advanced viewport management with hardware-optimized rendering for smooth, responsive user interaction.

### Viewport Management (`testdisplay.c`)

- **Camera System**: Smooth scrolling viewport with configurable center tracking
- **Boundary Protection**: Prevents viewport from moving outside map boundaries
- **Delta Refresh**: Updates only changed screen regions for flicker-free display
- **Memory Optimization**: Maintains previous screen buffer for efficient comparison

### Hardware-Optimized Rendering

- **Direct Memory Access**: Writes directly to $0400-$07E7 (C64 screen memory)
- **PETSCII Conversion**: Real-time conversion from internal tiles to display characters
- **Scroll Optimization**: Efficient screen updates during viewport movement
- **Input Processing**: Responsive WASD navigation with immediate feedback

### Map Export System (`map_export.c`)

- **Compact Binary Format**: Exports 3-bit encoded map data for minimal file size
- **KERNAL I/O Integration**: Uses Oscar64's KERNAL routines for device communication
- **Device 8 Targeting**: Saves to standard C64 disk drive for real hardware compatibility
- **PRG Format Output**: Creates loadable program files for easy map sharing

This comprehensive pipeline produces high-quality dungeon maps with optimal performance characteristics specifically tuned for C64 hardware limitations.
