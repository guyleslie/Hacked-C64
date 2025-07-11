# Hacked-C64

C64 Map Generator – Detailed Program Description

## Overview

This project is a highly optimized dungeon map generator for the Commodore 64, written in C for the OSCAR64 compiler. It generates random dungeon layouts with rooms, corridors, walls, and stairs, and features real-time navigation and display optimizations tailored for the C64’s hardware constraints.

## Project Structure

The project is organized as follows:

```ascii
main/
├── src/
│   ├── common.h                           // Common macros, constants, and utility functions
│   ├── main.c                             // Main program entry point and game loop
│   ├── oscar64_console.h                  // Console I/O routines for Oscar64/C64
│   └── mapgen/
│   ├── oscar64_console.h                  // Console I/O routines for Oscar64/C64
│   └── mapgen/
│       ├── mapgen_api.h                   // Public API for map generation
│       ├── mapgen_display.h               // Map display and rendering functions
│       ├── mapgen_internal.h              // Internal map generation logic and helpers
│       ├── mapgen_types.h                 // Type definitions for map structures and tiles
│       ├── mapgen_utility.h               // Utility functions for map generation
│       ├── map_export.c                   // Exports map data for external use or debugging
│       ├── map_export.h                   // Header for map export functions
│       ├── map_generation.c               // Core dungeon map generation algorithms
│       ├── public.c                       // Public interface implementations for mapgen
│       ├── room_management.c              // Room placement and management logic
│       ├── rule_based_connection_system.c // Room connection and corridor logic (MST, rules)
│       ├── testdisplay.c                  // Simple character based test display for the map 
│       └── utility.c                      // General-purpose utility functions
├── build.bat                              // Batch file to build the project
├── run_c64debugger.bat                    // Batch file to run in C64 Debugger
├── run_vice.bat                           // Batch file to run in VICE emulator
└── README.md                              // Project documentation
```

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

## Generation Pipeline

### Phase 1: Initialization

1. **Reset Systems**: All generation data and display buffers are cleared.
2. **RNG Initialization**: The random number generator is seeded using hardware entropy sources.
3. **Memory Setup**: Static memory pools and caches are initialized.

### Phase 2: Room Creation

1. **Grid Generation**: A 4×4 grid of potential room positions is created.
2. **Position Shuffling**: Grid positions are randomized using the Fisher-Yates algorithm.
3. **Size Calculation**: Room dimensions are generated randomly, with a bias toward rectangles.
4. **Placement Validation**: Spacing rules and boundary constraints are checked for each room.
5. **Room Registration**: Valid rooms are stored in the room array.

### Phase 3: Room Connection

1. **MST Initialization**: Room 0 is marked as connected.
2. **Connection Search**: The shortest valid connections between connected and unconnected rooms are found.
3. **Rule Validation**: All connections are validated for distance and spacing rules.
4. **Corridor Drawing**: L-shaped corridors are created, with doors placed at room boundaries.
5. **Fallback System**: An emergency connection system ensures no room is left isolated.

### Phase 4: Wall Generation

1. **Floor Scanning**: All floor and door tiles are iterated over.
2. **Adjacent Checking**: Each tile’s four neighbors are checked for empty space.
3. **Wall Placement**: Walls are placed around floor/door tiles as needed.
4. **Boundary Respect**: Walls are never placed outside the map boundaries.

### Phase 5: Stair Placement

1. **Priority Analysis**: Room priorities are calculated based on position and connections.
2. **Stair Assignment**: UP stairs are placed in the highest priority room, DOWN stairs in the second highest.
3. **Center Calculation**: Cached room center positions are used for precise stair placement.

## Performance Optimizations

### Memory Optimizations

- **Compact Encoding**: 3-bit tile storage saves 62.5% memory compared to byte-per-tile approaches.
- **Static Allocation**: All memory is statically allocated; no dynamic allocation overhead.
- **Cache Systems**: Room center cache, distance cache, and connection cache are used to avoid redundant calculations.

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

- **Dimensions**: 64×64 tiles (4,096 total tiles).
- **Viewport**: 40×25 characters (visible area).
- **Room Count**: 1–20 rooms per map.
- **Room Sizes**: 4×4 to 8×8 tiles each.

### Memory Usage

- **Map Storage**: 1,536 bytes (compact encoding).
- **Room Data**: 160 bytes (20 rooms × 8 bytes each).
- **Screen Buffer**: 1,000 bytes (40×25 characters).
- **Working Memory**: ~500 bytes (caches, temporary variables).
- **Total**: ~3,200 bytes (comfortably fits in the C64’s 64KB RAM).

### Performance Metrics

- **Generation Time**: ~2–3 seconds on a real C64.
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
