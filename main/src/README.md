
# Oscar64/C64 Advanced Dungeon Map Generator – Source Directory Documentation

This document provides comprehensive documentation for the source code architecture, algorithms, and implementation details of the Oscar64/C64 dungeon map generator. The codebase represents a sophisticated example of C64 programming with modern software engineering principles, featuring advanced algorithms, optimal memory management, and hardware-specific optimizations.

## Project Architecture Overview

The project follows a modular, layered architecture designed specifically for C64 hardware constraints while maintaining code clarity and maintainability. All modules are written in C and optimized for Oscar64 compilation, with extensive use of static memory allocation and hardware-specific optimizations.

### Module Responsibility Matrix

| Module                  | Primary Function                   | Key Algorithms                             | C64 Optimizations                                 |
|-------------------------|------------------------------------|--------------------------------------------|---------------------------------------------------|
| **main.c**              | System initialization, main loop   | VIC-II configuration, input processing     | Direct hardware register access                   |
| **map_generation.c**    | Generation pipeline coordination   | Two-pass wall placement, stair positioning | Memory-efficient iteration patterns               |
| **connection_system.c** | Room connectivity and corridors    | Position-based corridor selection, comprehensive path validation, MST algorithm | Static memory pools, optimized distance caching   |
| **room_management.c**   | Room placement and validation      | Grid-based placement, collision detection  | Bit-packed validation, fast bounds checking       |
| **mapgen_display.c**    | Display and user interaction       | Delta refresh, viewport management         | Direct screen memory access, PETSCII optimization |
| **mapgen_utils.c**      | Mathematical and utility functions | Random number generation, coordinate math, PETSCII conversion  | Hardware entropy, optimized arithmetic, centralized tile rendering |
| **map_export.c**        | File I/O and data persistence      | Compact binary serialization               | KERNAL I/O routines, device management            |

---

## Advanced Tile Encoding System (mapgen_types.h)

The project implements a sophisticated dual-level tile encoding system with consolidated hardware constants, optimized for both memory efficiency and rendering performance on C64 hardware.

### Hardware Constants Consolidation

All C64-specific hardware addresses and system constants are now centralized in `mapgen_types.h`:

```c
// C64 screen memory constants  
#define SCREEN_MEMORY_BASE 0x0400
#define SCREEN_MEMORY_END  0x07E7
```

This eliminates redundant definitions across modules and provides a single source of truth for hardware-specific values.

### 1. Display-Level PETSCII Encoding

These constants provide direct mapping to PETSCII character codes for immediate screen rendering, chosen for optimal visual clarity and C64 hardware compatibility.

```c
// PETSCII Display Constants
#define EMPTY   32    // Space character: empty/unoccupied tiles
#define WALL    160   // Solid block: structural walls
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
                               EMPTY)
```

This dual-encoding approach provides the benefits of compact storage during generation and fast rendering during display, optimized specifically for C64 hardware constraints.

### 4. Optimized Display Function Consolidation

The `get_map_tile_fast()` function has been moved from `mapgen_display.c` to `mapgen_utils.c` to centralize all PETSCII conversion logic:

```c
// Centralized in mapgen_utils.c for optimal code reuse
unsigned char get_map_tile_fast(unsigned char map_x, unsigned char map_y);
```

This consolidation eliminates code duplication and provides a unified interface for tile rendering across all display modules.

---

## Advanced Map Generation Pipeline

The map generation system implements a sophisticated multi-stage pipeline designed for creating organic, interconnected dungeon layouts while respecting strict C64 memory and performance constraints. Each stage builds upon the previous one, with comprehensive validation and optimization at every step.

### Stage 0: Optimized Code Organization

The project implements a sophisticated modular architecture with optimized include management and variable consolidation for maximum performance and maintainability.

#### Consolidated Global Variable Management

All external variable declarations are centralized in `mapgen_internal.h` to eliminate redundancy:

```c
// =============================================================================
// CONSOLIDATED GLOBAL VARIABLE DECLARATIONS
// =============================================================================

// Core map data (defined in mapgen_utils.c)
extern unsigned char compact_map[MAP_H * MAP_W * 3 / 8];
extern Room rooms[MAX_ROOMS];
extern unsigned char room_count;
extern unsigned int rng_seed;

// Display and camera system (defined in main.c)
extern unsigned char camera_center_x, camera_center_y;
extern Viewport view;
extern unsigned char screen_buffer[VIEW_H][VIEW_W];
extern unsigned char screen_dirty;
extern unsigned char last_scroll_direction;
```

This approach eliminates 36+ lines of redundant extern declarations across modules.

#### Optimized Include Structure

All source files now follow a standardized include organization:

```c
// System headers
#include <c64/vic.h>
#include <conio.h>
// Project headers  
#include "mapgen_types.h"
#include "mapgen_utils.h"
```

Benefits include reduced compilation dependencies, eliminated circular includes, and cleaner code organization.

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

#### Optimized MST Algorithm with Position-Based Selection (`generate_level()`)

- **Weighted Distance Calculation**: Uses Manhattan distance with corridor complexity penalties
- **Incremental Construction**: Builds MST one connection at a time, validating each addition
- **Attempted Connection Filtering**: Prevents infinite loops by skipping previously attempted connections
- **Position-Based Corridor Logic**: Sophisticated spatial analysis and probabilistic corridor selection ensures reliable connectivity

#### Position-Based Corridor Generation (`draw_corridor()`)

- **Spatial Relationship Analysis**: Determines corridor type based on room alignment (not distance)
- **Position-Based Path Selection**:
  - **Aligned Rooms** (horizontal/vertical overlap): 70% straight corridors, 30% Z-shaped, never L-shaped
  - **Diagonal Rooms** (no axis overlap): 50% L-shaped, 50% Z-shaped, never straight
- **Comprehensive Path Validation**: All corridor types validate against room intersections before drawing
  - **Straight**: Single-segment validation using `path_intersects_other_rooms()`
  - **L-Shaped**: Two-segment validation using `l_path_avoids_rooms()`
  - **Z-Shaped**: Three-segment validation using `z_path_avoids_rooms()`
- **Intelligent Door Reuse**: All corridor types check for existing doors and align connections
  - **Straight & Z-Shaped**: Uses `find_existing_door_on_room_side()` for aligned room connections
  - **L-Shaped**: Enhanced with door detection on both perpendicular wall sides
- **Architectural Consistency**: Ensures perpendicular wall connections and natural corridor flow
- **Exit Point Optimization**: Places corridor endpoints 2 tiles from room perimeters, or 1 tile from existing doors
- **Door Integration Logic**: Automatically detects and reuses existing doors on appropriate room sides

#### Advanced Pathfinding Features

- **Multi-Segment Coordination**: Manages complex corridors with multiple directional changes
- **Three-Tier Validation System**: Comprehensive intersection checking for all corridor types
- **Buffer Zone Protection**: Maintains 1-tile buffer around rooms preventing invalid path intersections
- **Memory Pool Management**: Efficient reuse of corridor segment data structures
- **Architectural Logic**: Perpendicular wall connections ensure natural corridor flow patterns

### Position-Based Corridor Selection Logic (Issue #18 Resolution)

The corridor generation system uses sophisticated spatial analysis to determine the most appropriate corridor type based on room positioning rather than distance, ensuring architecturally consistent and visually natural connections.

#### Room Relationship Detection

**Aligned Room Detection** (`check_room_axis_alignment()`):

- **Horizontal Overlap**: Rooms share Y-axis projection ranges
- **Vertical Overlap**: Rooms share X-axis projection ranges
- **Spatial Logic**: Rooms are considered "aligned" if they can connect with a single straight line

**Diagonal Room Detection**:

- **No Axis Overlap**: Rooms have no shared projection on either axis
- **True Diagonal**: Requires multi-segment connection paths
- **Perpendicular Connections**: Exit points placed on complementary wall sides

#### Probabilistic Corridor Assignment

**For Aligned Rooms** (horizontal/vertical overlap):

```c
unsigned char use_straight = (rng_seed % 100) < 70; // 70% probability
// Result: 70% straight, 30% Z-shaped, 0% L-shaped
```

**For Diagonal Rooms** (no axis overlap):

```c
unsigned char use_l_shaped = (rng_seed % 100) < 50; // 50% probability  
// Result: 50% L-shaped, 50% Z-shaped, 0% straight
```

#### Architectural Rationale

- **Straight Corridors**: Natural for aligned rooms, provide direct efficient paths
- **L-Shaped Corridors**: Optimal for diagonal rooms, create perpendicular wall connections with door reuse on both segments
- **Z-Shaped Corridors**: Versatile for both scenarios, handle complex routing requirements
- **Forbidden Combinations**: Prevents architecturally inconsistent corridor types (straight for diagonal, L-shaped for aligned)

This position-based approach ensures that corridor selection matches the spatial relationship between rooms, creating more natural and architecturally sound dungeon layouts.

## Stage 4: Wall Generation System

The wall generation system implements a streamlined algorithm ensuring complete visual enclosure around all walkable areas.

### Wall Placement Algorithm (`add_walls()`)

**Perimeter Wall Placement**:

- **Walkable Tile Scanning**: Iterates through all map positions identifying floor, door, and stair tiles
- **Adjacent Empty Detection**: Places wall tiles in all cardinal directions (N/S/E/W) from walkable areas
- **Diagonal Wall Coverage**: Places walls at diagonal positions for complete enclosure
- **Enclosure Guarantee**: Ensures complete wall coverage around all accessible areas
- **Performance Optimization**: Single-pass iteration with immediate wall placement

This streamlined approach produces clean, functional dungeon walls while maintaining optimal C64 performance.

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

### Viewport Management (`mapgen_display.c`)

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
