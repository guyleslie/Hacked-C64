# Hacked-C64

Advanced Dungeon Map Generator for Commodore 64 – Implemented with Oscar64

## Overview

This project is a sophisticated dungeon map generator written entirely in C and optimized for the Oscar64 cross-assembler. The program generates complex, interconnected dungeon layouts with rooms, corridors, walls, stairs, and doors. Features include real-time navigation, interactive map exploration, compact 3-bit tile encoding, and C64 PRG map export functionality. All code is heavily optimized for C64 hardware constraints with static memory allocation and direct screen memory access.

## Screenshots

Debug generation with progress indicators:

<img width="1205" height="909" alt="image" src="https://github.com/user-attachments/assets/32b037af-7c1c-40b3-a288-7dc1ab5a5194" />


---

Final generated dungeon map display:

<img width="1202" height="907" alt="image" src="https://github.com/user-attachments/assets/5cb118e8-648a-4723-bf12-303e6804795c" />


---

## Map Data Structure

The map is represented as a 2D grid of tiles, with each tile encoded using 3 bits for compact storage. The map dimensions are defined as 64x64 tiles (MAP_W x MAP_H). Each tile can represent different features such as empty space, wall, floor, door, or stairs.

### Tile Types and Encoding

| Tile Type      | Symbol Name | PETSCII Code | PETSCII Character  | Description         |
|----------------|-------------|--------------|--------------------|---------------------|
| Empty space    | EMPTY       | 32           | (space)            | Blank/empty tile    |
| Wall           | WALL        | 160          |' █ '               | Solid block         |
| Floor (path)   | FLOOR       | 46           |' . '               | Walkable path       |
| Door           | DOOR        | 219          |' + ' (invers char) | Door                |
| Stairs up      | UP          | 60           |' < '               | Up stairs           |
| Stairs down    | DOWN        | 62           |' > '               | Down stairs         |

*Note: The door is displayed as a solid block character, PETSCII code 219.*

## Main Directories and Files

Complete list of the main directories and files in this project:

```ascii
Hacked-C64/
├─ build.bat                                  // Oscar64 build script (Windows)
├─ CMakeLists.txt                             // CMake project file (optional, for CMake users)
├─ README.md                                  // This documentation
├─ run_c64debugger.bat                        // C64 Debugger launcher, with automatic build
├─ run_vice.bat                               // VICE emulator launcher, with automatic build
├─ SECURITY.md                                // GITHUB Security policy and notes
└─ main/
    └─ src/
        ├─ main.c                             // Entry point, initialization, VIC-II setup, main control
        ├─ README.md                          // Source folder documentation
        └─ mapgen/
            ├─ connection_system.c            // Minimum Spanning Tree, rule-based connections
            ├─ map_export.c                   // Map export to Oscar64/C64 binary format
            ├─ map_export.h                   // Map export header
            ├─ map_generation.c               // Main generation pipeline (rooms, corridors, stairs, walls)
            ├─ mapgen_api.h                   // Public API for mapgen
            ├─ mapgen_display.h               // Display helpers for mapgen
            ├─ mapgen_internal.h              // Internal helpers for mapgen
            ├─ mapgen_types.h                 // Type definitions for mapgen
            ├─ mapgen_utils.c                 // Utility functions for mapgen
            ├─ mapgen_utils.h                 // Utility functions header
            ├─ room_management.c              // Room placement, validation, priority
            └─ mapgen_display.c               // Screen handling, viewport, input, delta refresh
```

**Legend:**

- `main/` — All C source code (entry point and primary modules)
- `mapgen/` — Dedicated folder for all map/dungeon generation logic, types, and helpers
- `.github/` — CI/CD automation and workflow scripts
- Top-level batch files — Build and emulator launch automation

All core map/tree/dungeon logic is modularized within `main/src/mapgen/` for maintainability and clarity. Each file’s comment describes its precise role and public/private status, supporting both development and documentation needs.

## Key Features and Architecture

### Advanced Generation System

- **Position-Based MST**: Uses Minimum Spanning Tree algorithm with position-based corridor selection for reliable connectivity
- **Intelligent Room Placement**: Grid-based distribution with Fisher-Yates shuffle and collision avoidance
- **Position-Based Corridor System**: Straight, L-shaped, and Z-shaped corridors based on room spatial relationships (aligned vs diagonal positioning) with intelligent door reuse
- **Streamlined Wall Generation**: Single-pass algorithm with complete visual enclosure
- **Priority-Based Stair Placement**: Stairs placed in highest-priority rooms for optimal dungeon flow
- **Simplified Connection Rules**: Dynamic distance-based validation (30-80 tiles depending on room density), intelligent door reuse for all corridor types

### Memory and Performance Optimization

- **Compact Storage**: 3-bit tile encoding fits entire 64x64 map in only 1536 bytes
- **Static Memory**: No dynamic allocation - all data structures use fixed-size arrays
- **Hardware Integration**: Direct VIC-II memory access and PETSCII character display
- **Delta Refresh**: Screen buffer with dirty flags for flicker-free updates
- **Optimized Algorithms**: C64-tuned math operations and loop structures
- **Consolidated Variable Management**: All extern declarations centralized in `mapgen_internal.h`
- **Optimized Include Structure**: System/project headers separated, redundant includes eliminated
- **Shared Constants**: Common hardware addresses and values unified in `mapgen_types.h`

### Interactive Features

- **Real-Time Navigation**: WASD movement with smooth viewport scrolling
- **Live Map Generation**: Press SPACE for new dungeon layouts  
- **Map Export**: Press 'M' to save maps as C64 PRG files to disk
- **Progress Indicator**: Each major generation step prints a dot (`"."`) to the screen, showing real-time progress as rooms, corridors, stairs, and walls are created.

## Developer Pipeline and Module Responsibilities

- `main.c`: Entry point, VIC-II configuration, initialization, main control loop, user input handling
- `map_generation.c`: Main generation pipeline (rooms, corridors, stairs, walls)
- `connection_system.c`: Position-based corridor selection, bounding box collision detection, early exit path validation, comprehensive path validation, MST algorithm
- `room_management.c`: Room placement, validation, priority systems
- `map_export.c`: Map export to C64 PRG format, using Oscar64's kernal I/O functions
- `mapgen_display.c`: Screen handling, viewport management, input processing, delta refresh
- `mapgen_utils.c`: Math utilities, random number generation, early exit adjacency checking, register-optimized room detection, helper functions, PETSCII conversion
- `mapgen_api.h`: Public API definitions for map generation
- `mapgen_types.h`: Type definitions, constants, tile encoding, and shared hardware constants
- `mapgen_display.h`: Display and rendering function declarations
- `mapgen_internal.h`: Internal helper function declarations and consolidated global variables

## Technical Data

- **Map size:** 64x64 tiles, 3 bits/tile, 1536 bytes (leaves ~62 KB of RAM free)
- **Room count:** Maximum 20 rooms with intelligent grid placement
- **Room size:** 4x4 to 8x8 tiles with randomized dimensions
- **Corridor segments:** Maximum 32 active segments with reuse logic
- **Connection cache:** Maximum 24 cached connections for MST optimization
- **Screen buffer:** 40x25 characters with delta refresh
- **Total memory usage:** ~3.6 KB including all data structures
- **Compiled PRG size:** 14,905 bytes (includes code, data, and buffers)
- **Memory efficiency:** 95.3% of C64 RAM remains available after loading

### Algorithm Complexity

- **Room Placement:** O(n) with grid constraints
- **MST Generation:** O(n²) for small room counts using Prim algorithm
- **Wall Generation:** O(map_size) single-pass algorithm
- **Rendering:** O(viewport_size) with delta optimization

### OSCAR64 Implementation Details

- **Zero Page Variables:** Critical functions use `__zeropage` variables (`mst_best_room1`, `mst_best_room2`, `mst_best_distance`, `tile_check_cache`, `adjacent_tile_temp`) for 6502 fast memory access
- **Striped Array Layout:** Advanced optimization using Oscar64's `__striped` feature for optimal 6502 indexing with connection distance cache, path validation cache, and MST edge candidates
- **Pragma Directives:** `#pragma optimize(3, speed, inline, maxinline)` applied to critical path functions including MST loops, tile checking, and room detection
- **Early Exit Optimization:** Immediate return on first match in adjacency checking and path validation
- **Register Caching:** Room coordinates cached in local variables to eliminate redundant array access
- **Bitwise Operations:** Uses `y & 7` instead of `y % 8` for modulo operations
- **Performance Optimizations:** Pure striped implementation with 64-entry cache size for maximum performance
- **Build Configuration:** Compiled with `-O0` debug flags

## Usage (Build & Run)

### Quick Start with Windows Batch Files

- **`build.bat`**: Complete Oscar64 compilation with automatic cleanup
- **`run_vice.bat`**: Build project and launch in VICE emulator automatically
- **`run_c64debugger.bat`**: Build project and launch in C64 Debugger for development

## CI/CD Workflow: Automated Build & Artifact Distribution

This project includes a GitHub Actions workflow (`cmake-single-platform.yml`) that automates the build and packaging process for developers:

- **Oscar64 Compiler & Retro Debugger Download:**  
  The workflow automatically downloads the latest Oscar64 cross-assembler and the Retro Debugger (C64 emulator and debugger) for each build.

- **CMake Configuration & Build:**  
  The workflow runs CMake to configure the project and builds all targets using the latest toolchain.

- **Artifact Upload:**  
  After a successful build, the workflow uploads the build output as a downloadable GitHub artifact. This ensures that developers always have access to the latest compiled binaries and essential debug files.

### Packaged Artifact Contents

The downloadable artifact includes:

- `build/*.prg` – Compiled C64 program files
- `build/*.map`, `build/*.lbl`, `build/*.asm` – Additional Oscar64 build files (map, label, assembly)
- `RetroDebugger/**` – Downloaded Retro Debugger tool (C64 emulator and debugger) with ROM files
- `run_retrodebugger.bat` – **Launch script for easy debugging** (see [Running the Debugger](#running-the-debugger) section)

## Running the Debugger

### Using the CI/CD Artifact

1. **Download the Build Artifact:**
   - Go to the [GitHub Actions](../../actions) page
   - Click on the latest successful build
   - Download the `build-output` artifact zip file

2. **Extract and Run:**

   ```bash
   # Extract the zip file to any directory
   unzip build-output.zip -d my_project_folder
   cd my_project_folder
   
   # Double-click or run from command line:
   run_retrodebugger.bat
   ```

3. **What the Script Does:**
   - Automatically changes to the RetroDebugger directory
   - Launches `retrodebugger-notsigned.exe` with the compiled PRG file
   - Loads symbol files (`.lbl`) automatically if available for debugging
   - Uses `-autojmp` and `-unpause` flags for immediate program execution
   - Provides detailed error messages if files are missing

**For developer documentation, pipeline, API, and detailed module responsibilities see: [main/src/README.md](https://github.com/guyleslie/Hacked-C64/blob/main/main%2Fsrc%2FREADME.md)**
