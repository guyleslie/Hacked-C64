# Hacked-C64

Advanced Dungeon Map Generator for Commodore 64 – Implemented with Oscar64

## Overview

This project is a sophisticated dungeon map generator written entirely in C and optimized for the Oscar64 cross-assembler. The program generates complex, interconnected dungeon layouts with rooms, corridors, walls, stairs, and doors. Features include real-time navigation, interactive map exploration, compact 3-bit tile encoding, and C64 PRG map export functionality. All code is heavily optimized for C64 hardware constraints with static memory allocation and direct screen memory access.

## Screenshots

Debug generation with progress indicators:

<img width="1425" height="1075" alt="image" src="https://github.com/user-attachments/assets/073ae738-2326-4c22-9e0d-1ae86e55e3d7" />


---

Final generated dungeon map display:

<img width="1206" height="909" alt="image" src="https://github.com/user-attachments/assets/fd236d58-617f-42f6-a885-10a56329ea31" />


---

## Map Data Structure

The map is represented as a 2D grid of tiles, with each tile encoded using 3 bits for compact storage. The map dimensions are defined as 64x64 tiles (MAP_W x MAP_H). Each tile can represent different features such as empty space, wall, floor, door, stairs, or corner.

### Tile Types and Encoding

| Tile Type      | Symbol Name | PETSCII Code | PETSCII Character  | Description         |
|----------------|-------------|--------------|--------------------|---------------------|
| Empty space    | EMPTY       | 32           | (space)            | Blank/empty tile    |
| Wall           | WALL        | 160          |' █ '               | Solid block         |
| Corner         | CORNER      | 230          |' ▓ '               | Shaded block/corner |
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
            ├─ map_generation.c               // Main generation pipeline (rooms, corridors, walls, stairs)
            ├─ mapgen_api.h                   // Public API for mapgen
            ├─ mapgen_display.h               // Display helpers for mapgen
            ├─ mapgen_internal.h              // Internal helpers for mapgen
            ├─ mapgen_types.h                 // Type definitions for mapgen
            ├─ mapgen_utils.c                 // Utility functions for mapgen
            ├─ mapgen_utils.h                 // Utility functions header
            ├─ room_management.c              // Room placement, validation, priority
            └─ testdisplay.c                  // Screen handling, viewport, input, delta refresh
```

**Legend:**

- `main/` — All C source code (entry point and primary modules)
- `mapgen/` — Dedicated folder for all map/dungeon generation logic, types, and helpers
- `.github/` — CI/CD automation and workflow scripts
- Top-level batch files — Build and emulator launch automation

All core map/tree/dungeon logic is modularized within `main/src/mapgen/` for maintainability and clarity. Each file’s comment describes its precise role and public/private status, supporting both development and documentation needs.

## Key Features and Architecture

### Advanced Generation System

- **Advanced MST with Intelligent Fallback**: Uses Minimum Spanning Tree algorithm with multi-attempt fallback mechanism to ensure maximum room connectivity
- **Intelligent Room Placement**: Grid-based distribution with Fisher-Yates shuffle and collision avoidance
- **Position-Based Corridor System**: Straight, L-shaped, and Z-shaped corridors based on room spatial relationships (aligned vs diagonal positioning)
- **Advanced Wall Generation**: Two-pass algorithm with proper corner detection and visual enclosure
- **Priority-Based Stair Placement**: Stairs placed in highest-priority rooms for optimal dungeon flow

### Memory and Performance Optimization

- **Compact Storage**: 3-bit tile encoding fits entire 64x64 map in only 1536 bytes
- **Static Memory**: No dynamic allocation - all data structures use fixed-size arrays
- **Hardware Integration**: Direct VIC-II memory access and PETSCII character display
- **Delta Refresh**: Screen buffer with dirty flags for flicker-free updates
- **Optimized Algorithms**: C64-tuned math operations and loop structures

### Interactive Features

- **Real-Time Navigation**: WASD movement with smooth viewport scrolling
- **Live Map Generation**: Press SPACE for new dungeon layouts  
- **Map Export**: Press 'M' to save maps as C64 PRG files to disk
- **Advanced Progress Feedback**: Detailed connection progress with fallback recovery indicators
  - **Standard MST**: "." for successful connections
  - **Intelligent Fallback**: "?" (start), "f" (attempt fail), "!" (recovery), "X" (complete failure)

## Developer Pipeline and Module Responsibilities

- `main.c`: Entry point, VIC-II configuration, initialization, main control loop, user input handling
- `map_generation.c`: Main generation pipeline (rooms, corridors, walls, stairs)
- `connection_system.c`: Advanced MST with multi-attempt fallback, position-based corridor selection, comprehensive path validation
- `room_management.c`: Room placement, validation, priority systems
- `map_export.c`: Map export to C64 PRG format, using Oscar64's kernal I/O functions
- `testdisplay.c`: Screen handling, viewport management, input processing, delta refresh
- `mapgen_utils.c`: Math utilities, random number generation, helper functions
- `mapgen_api.h`: Public API definitions for map generation
- `mapgen_types.h`: Type definitions, constants, and tile encoding
- `mapgen_display.h`: Display and rendering function declarations
- `mapgen_internal.h`: Internal helper function declarations

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
- **MST Generation:** O(n²) for small room counts (optimal for C64)
- **Wall Generation:** O(map_size) two-pass algorithm
- **Rendering:** O(viewport_size) with delta optimization

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
- `RetroDebugger/**` – Downloaded Retro Debugger tool (C64 emulator and debugger)

**For developer documentation, pipeline, API, and detailed module responsibilities: see [main/src/README.MD](https://github.com/guyleslie/Hacked-C64/blob/main/main%2Fsrc%2FREADME.md)**
