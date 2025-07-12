# Hacked-C64

C64 Map Generator – Detailed Program Description

## Overview

This project is a highly optimized dungeon map generator for the Commodore 64, written in C for the OSCAR64 compiler. It generates random dungeon layouts with rooms, corridors, walls, and stairs, and features real-time navigation and display optimizations tailored for the C64’s hardware constraints.

## Project Structure

```ascii
Hacked-C64/
├── main/
│   └── src/
│       ├── common.h                   // Common macros, constants, and helpers shared project-wide
│       ├── main.c                     // Main program entry point, input loop, and high-level game logic
│       ├── oscar64_console.h          // Abstractions for Oscar64/C64-specific console I/O
│       └── mapgen/                    // All map (dungeon) generation logic in a dedicated module
│           ├── door_placement.c       // Door placement logic
│           ├── door_placement.h       // Header for door placement
│           ├── map_export.c           // Logic to export map data (for debugging or external tools)
│           ├── map_export.h           // Header for map export functions
│           ├── map_generation.c       // Main procedural map generation algorithms (room/corridor MST, placement, validation)
│           ├── mapgen_api.h           // Public API for map generation (exposed to game)
│           ├── mapgen_display.h       // Functions for rendering and visualizing the map
│           ├── mapgen_internal.h      // Internal structures and helpers (not exposed outside mapgen)
│           ├── mapgen_types.h         // Core type definitions (tiles, room, connection, etc.)
│           ├── mapgen_utility.h       // Utility functions for mapgen (random, math, helpers)
│           ├── public.c               // Implementation of the mapgen public API
│           ├── room_management.c      // Algorithms for room placement, sizing, and management
│           ├── rule_based_connection_system.c // Minimum Spanning Tree & rule-based corridor/door generation
│           ├── testdisplay.c          // Simple ASCII/char-based visual test for map output
│           └── utility.c              // General-purpose helpers (math, random, etc.) used by mapgen
├── build.bat                          // Windows build script (compiles all sources via Oscar64/CC65)
├── run_c64debugger.bat                // Launches the compiled binary in C64 Debugger
├── run_vice.bat                       // Launches the compiled binary in the VICE emulator
├── .github/
│   └── workflows/
│       └── cmake-single-platform.yml  // CI/CD workflow for GitHub Actions
└── README.md                          // Project documentation (this file)
```

**Legend:**

- `main/` — All C source code (entry point and primary modules)
- `mapgen/` — Dedicated folder for all map/dungeon generation logic, types, and helpers
- `.github/` — CI/CD automation and workflow scripts
- Top-level batch files — Build and emulator launch automation

All core map/tree/dungeon logic is modularized within `main/src/mapgen/` for maintainability and clarity. Each file’s comment describes its precise role and public/private status, supporting both development and documentation needs.

## System Architecture

### Core Components

#### 1. **Memory Management (C64 Optimized)**

- **Compact Map Storage**: Each tile is encoded using 3 bits, reducing memory usage by 62.5% compared to traditional 1-byte-per-tile storage.
  - 64×64 map = 4,096 tiles stored in only 1,536 bytes.
  - Tile types: `EMPTY`, `WALL`, `FLOOR`, `DOOR`, `UP_STAIRS`, `DOWN_STAIRS` (consistent naming throughout code and documentation).
- **Static Memory Pools**: No dynamic allocation (malloc/free) is used; all memory is statically allocated for predictable performance and C64 compatibility.
  - Maximum 20 rooms, 32 corridor segments, 24 cached connections.

#### 2. **Random Number Generation**

- **Hardware Entropy Sources**: Uses C64 hardware for true randomness.
  - CIA timers (`cia1.ta`), VIC-II raster beam position (`vic.raster`), and system clock values are combined.
- **Enhanced Seed Mixing**: Multiple entropy sources are mixed with a generation counter for improved randomness.
- **Warm-up Cycle**: The first 8 random values are discarded to ensure better distribution.

#### 3. **Room Generation System**

- **Grid-Based Placement**: A 4×4 grid is used to distribute rooms efficiently across the map.
- **Size Variation Algorithm**:
  - 60% chance for rectangular rooms (width ≠ height), 40% for square-ish rooms.
  - Room sizes range from 4 to 8 tiles in each dimension.
- **Advanced Placement Logic**:
  - Fisher-Yates shuffle is used to randomize grid positions (see `map_generation.c`).
  - Multiple validation passes ensure minimum 4-tile spacing between rooms and prevent overlap.

#### 4. **Rule-Based Connection System**

- **Minimum Spanning Tree (MST)**: Ensures all rooms are connected using the shortest valid connections.
- **Safety Rules**:
  - `MIN_ROOM_DISTANCE` (4 tiles) is enforced between rooms.
  - Buffer zones prevent overlap.
- **Connection Patterns**:
  - Room 0 is always the initial connected node.
  - The MST expands by finding the shortest valid connections to unconnected rooms.
  - A fallback system ensures no room is left isolated.
- **Door and Corridor Placement Logic**:
  - Doors are always placed on the external edge of the room, facing the connection direction.
  - Corridors (`TILE_FLOOR`) always start immediately adjacent to the door, ensuring logical and consistent connectivity (including corridor reuse).
  - The logic is robust for both horizontal and vertical connections, and is optimized for the C64 using helper functions for placement and validation.

#### 5. **Stair Placement System**

- **Priority-Based Selection**: Room priority values are used to select stair locations.
- **Dual Stair System**:
  - UP stairs are placed in the highest priority room (usually the starting room).
  - DOWN stairs are placed in the second highest priority room (usually the ending room).
- **Center Placement**: Stairs are placed at the calculated center of the selected rooms.

#### 6. **Wall Generation**

- **Floor-First Algorithm**: Only floor and door tiles are checked (typically 80–200 tiles per map), greatly reducing the number of iterations.
- **Performance Improvement**: This approach is ~20× faster than scanning the entire map.
- **Logic**: Walls are placed around any floor or door tile that has empty space adjacent, ensuring all rooms and corridors are properly enclosed.

## Display and Navigation System

### Camera System

- **Viewport Management**: The visible area is 40×25 characters, matching the C64’s screen.
- **Smooth Scrolling**: The camera scrolls fast with delta updates for a seamless user experience.
- **Boundary Handling**: The camera is prevented from moving beyond the map edges.
- **Synchronization**: The camera position is always kept in sync with the viewport.

### Screen Optimization

- **Delta Updates**: Only changed portions of the screen are redrawn, minimizing CPU usage.
- **Screen Buffer**: The previous frame is stored for efficient comparison and update.
- **Assembly Optimization**: Inline assembly is used for fast screen clearing.
- **Direct Memory Access**: The program writes directly to C64 screen memory ($0400–$07E7) for maximum performance.

### Input System

- **WASD Navigation**: Standard movement controls (W/A/S/D for up/left/down/right).
- **SPACE**: Generates a new random map instantly.
- **Q**: Quits the program.
- **Real-time Response**: All controls provide immediate feedback and screen updates.

### Generation Pipeline

1. **Initialization and Reset**
   - Viewport, camera, and display buffers are reset to their default state.
   - All map generation data (rooms, corridors, caches) are cleared.
   - The random number generator is initialized (hardware entropy, seed mixing).

2. **Room Creation**
   - 4×4 grid-based placement, with positions randomized using the Fisher-Yates shuffle.
   - Random room size (4–8 tiles), 60% rectangular, 40% square.
   - For each position, validation: minimum distance, overlap, and boundary checks.
   - On successful validation, the room is registered and its floor tiles are placed.

3. **Room Connection (Rule-based MST)**
   - Minimum Spanning Tree (MST) logic: always seeks the shortest valid connection.
   - Every connection is strictly validated (distance, overlap, buffer).
   - Corridors and doors are only placed if all rules are satisfied.
   - Fallback: if no valid connection is found, after several attempts the process stops, but all rooms remain accessible.

4. **Wall Generation**
   - Only floor and door tiles are checked.
   - For each such tile, if there is an empty neighbor, a wall is placed.
   - Efficient: only 80–200 tiles need to be checked, and boundaries are never exceeded.

5. **Stair Placement**
   - Selection is based on room priority (most connections, position).
   - UP stairs: placed at the center of the highest priority room.
   - DOWN stairs: placed at the center of the second highest priority room.

6. **Return**
   - Returns 1 on successful generation, otherwise 0.

**All steps use static memory and fixed-size arrays; there is no dynamic allocation. Every pipeline step includes strict validation and fallback logic to ensure all rooms are accessible.**

## Performance Optimizations

### Memory Optimizations

- **Compact Map Storage**: The map is stored in a `compact_map` array using 3 bits per tile, implemented with direct bit manipulation. This allows 4096 tiles to fit in just 1536 bytes.
- **Static Memory Pools**: All major data structures (rooms, corridors, caches, buffers) are statically allocated as fixed-size arrays at compile time (e.g., `Room rooms[MAX_ROOMS]`, `CorridorPool corridor_pool`, `unsigned char room_distance_cache[MAX_ROOMS][MAX_ROOMS]`).
- **No Dynamic Allocation**: There is no use of `malloc`, `free`, or any dynamic memory; all memory is reserved at compile time for predictable usage and C64 compatibility.
- **Cache Systems**:
  - *Room Center Cache*: Stores the center coordinates of each room for fast lookup, avoiding repeated calculations.
  - *Distance Cache*: Stores pairwise room distances, with cache validation flags, to avoid redundant distance calculations.
  - *Connection Cache*: Tracks valid room connections and corridor reuse.
- **Buffer Reuse**: Buffers (such as the screen buffer and generation data) are cleared and reused between generations, never reallocated.
- **Constants and Limits**: All array sizes and memory pools are defined by constants (e.g., `MAX_ROOMS`, `MAP_W`, `MAP_H`), ensuring no accidental overruns and easy tuning for memory constraints.

### CPU Optimizations

- **Inline Functions**: Critical path functions are inlined for speed.
- **Assembly Blocks**: Screen operations use optimized inline assembly for maximum performance.
- **Reduced Iterations**: The floor-first wall algorithm and grid-based placement minimize unnecessary loops.
- **Cached Calculations**: Frequently used values are cached to avoid recomputation.

### Display Optimizations

- **Delta Updates**: Only changed screen portions are redrawn.
- **Perfect Scrolling**: Scroll direction is tracked and optimized for fast refresh.
- **Direct Memory Access**: Screen updates bypass OS routines for speed.
- **Buffer Management**: Efficient screen buffer comparison reduces unnecessary redraws.

## Technical Specifications

### Map Properties

- **Map Dimensions**: 64×64 tiles (4096 tiles), each tile encoded in 3 bits (compact encoding).
- **Viewport**: 40×25 characters (C64 screen size).
- **Room Count**: Up to 20 rooms per map (`MAX_ROOMS`).
- **Room Sizes**: Each room is 4×4 to 8×8 tiles.
- **Corridor Segments**: Up to 32 segments per map (`MAX_CORRIDOR_SEGMENTS`).
- **Connection Cache**: Up to 24 cached connections (`MAX_CONNECTION_CACHE`).

### Memory Usage

- **Map Storage**: 1536 bytes (`compact_map[1536]`, 4096 tiles × 3 bits).
- **Room Data**: 160 bytes (`Room rooms[20]`, each 8 bytes).
- **Corridor Data**: 224 bytes (`CorridorSegment segments[32]`, each 7 bytes).
- **Connection Cache**: 73 bytes (`room1[24]`, `room2[24]`, `distance[24]`, `count`).
- **Room Center Cache**: 40 bytes (`room_center_cache[20][2]`).
- **Room Distance Cache**: 400 bytes (`room_distance_cache[20][20]`).
- **Screen Buffer**: 1000 bytes (`40×25`).
- **Other Working Memory**: ~150 bytes (temporary variables, flags, counters, etc.).
- **Total Memory Usage**: ~3583 bytes (rounded, ~3.6 KB; well within the C64's 64KB RAM).

### Performance Metrics

- **Map Generation Time**: ~3–8 seconds on a real C64 (depending on map complexity and number of rooms).
- **Wall Generation**: ~20× faster than naive approaches.
- **Screen Updates**: Fast scrolling at full frame rate.
- **Memory Efficiency**: 62.5% savings vs. traditional tile storage.

## Quality Assurance

### Validation Systems

- **Connectivity Check**: Ensures all rooms are reachable from any other room.
- **Rule Compliance**: All spacing and distance requirements are validated after generation.
- **Boundary Verification**: The generator never writes outside the map bounds.
- **Emergency Fallbacks**: Edge cases (e.g., failed room placement) are handled gracefully with fallback logic.

### Error Handling

- **Graceful Degradation**: The program continues even if not all rooms can be placed.
- **Isolation Prevention**: Multiple fallback systems ensure no room is left isolated.
- **Boundary Protection**: Comprehensive bounds checking is performed throughout the code.

## Usage Instructions

### Running the Program

#### 1. Using Batch Files

- **build.bat**: Compiles the project using the configured assembler/compiler (e.g., Oscar64 or CC65).
- **run_vice.bat**: Runs the compiled binary in the VICE emulator.
- **run_c64debugger.bat**: Runs the compiled binary in the C64 Debugger.

> **Note:**  
> The paths to the Oscar64 compiler, VICE emulator, and C64 Debugger are customizable. Edit the batch files to set the correct paths for your system.

#### 2. Manual Execution

- Compile the project using the OSCAR64 compiler.
- Run the resulting binary on a real C64 or a compatible emulator (such as VICE or C64Debugger).

---

## CI Build Artifacts (GitHub Actions)

When the project is built by GitHub Actions (see `.github/workflows/cmake-single-platform.yml`), the entire `build/` directory is uploaded as a downloadable artifact at the end of each workflow run.

- **How to download:**
  1. Go to the [Actions](../../actions) tab on GitHub.
  2. Select the latest workflow run for your branch.
  3. Scroll down to the "Artifacts" section and download the `build-output.zip` file.
  4. Extract it to access the compiled binaries (e.g., `Hacked C64.prg`).

> **Note:** The build output is not committed to the repository, but is always available as an artifact after each CI run.
