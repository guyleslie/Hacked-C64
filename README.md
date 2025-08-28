# Hacked-C64

Dungeon Map Generator for Commodore 64 – Implemented with Oscar64

## Overview

This project is a dungeon map generator written in C for the Oscar64 cross-assembler. The program generates interconnected dungeon layouts with rooms, corridors, walls, stairs, and doors. Features include real-time navigation, interactive map exploration, compact 3-bit tile encoding, and C64 PRG map export functionality. Code uses static memory allocation and direct screen memory access.

## Screenshots

Debug generation with progress indicators:

<img width="1205" height="909" alt="image" src="https://github.com/user-attachments/assets/32b037af-7c1c-40b3-a288-7dc1ab5a5194" />


---

Final generated dungeon map display:

<img width="1203" height="908" alt="image" src="https://github.com/user-attachments/assets/2fb6eab8-335f-4c00-909c-a2f2e453c627" />



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
├─ run_vice.bat                               // VICE emulator launcher
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

### Generation System

- **MST Algorithm**: Minimum Spanning Tree connects rooms with optimal corridors
- **Room Placement**: Grid-based distribution with Fisher-Yates shuffle and collision avoidance
- **Corridor System**: Straight, L-shaped, and Z-shaped corridors based on room spatial relationships with geometry-aware door reuse
- **Wall Generation**: Single-pass algorithm with complete visual enclosure
- **Stair Placement**: Stairs placed in highest-priority rooms
- **Connection Rules**: Distance-based validation (30-80 tiles depending on room density), geometry-aware door reuse maintains corridor directional consistency

### Memory and Performance

- **Compact Storage**: 3-bit tile encoding fits entire 64x64 map in 1536 bytes
- **Static Memory**: No dynamic allocation - all data structures use arrays
- **Hardware Integration**: Direct VIC-II memory access and PETSCII character display
- **Delta Refresh**: Screen buffer with dirty flags for updates
- **Algorithms**: C64-tuned math operations and loop structures
- **Variable Management**: All extern declarations centralized in `mapgen_internal.h`
- **Include Structure**: System/project headers separated
- **Shared Constants**: Common hardware addresses and values in `mapgen_types.h`

### Interactive Features

- **Real-Time Navigation**: WASD movement with smooth viewport scrolling
- **Live Map Generation**: Press SPACE for new dungeon layouts  
- **Map Export**: Press 'M' to save maps as C64 PRG files to disk
- **Progress Indicator**: Each major generation step prints a dot (`"."`) to the screen, showing real-time progress as rooms, corridors, stairs, and walls are created.

## Developer Pipeline and Module Responsibilities

- `main.c`: Entry point, VIC-II configuration, initialization, main control loop, user input handling
- `map_generation.c`: Main generation pipeline (rooms, corridors, stairs, walls)
- `connection_system.c`: MST room connections, corridor drawing, door placement
- `room_management.c`: Room placement, validation, priority systems
- `map_export.c`: Map export to C64 PRG format, using Oscar64's kernal I/O functions
- `mapgen_display.c`: Screen handling, viewport management, input processing, delta refresh
- `mapgen_utils.c`: Math utilities, random number generation, adjacency checking, room detection, helper functions, PETSCII conversion
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

## Usage (Build & Run)

### Quick Start with Windows Batch Files

For manual development (download source code from GitHub):

1. **Download Source Code**: Download the ZIP file from the GitHub repository's "Code" button
2. **Install Dependencies**: Place Oscar64 and VICE in their respective folders (`oscar64/` and `vice/`) within the project directory
3. **Build and Run**:
   - **`build.bat`**: Oscar64 compilation with cleanup (requires `oscar64/` folder in project directory)
   - **`run_vice.bat`**: Launch compiled PRG in VICE emulator (requires `vice/` folder in project directory)

**Note:** These batch files expect Oscar64 and VICE to be located in their respective folders within the project directory. If you have them installed elsewhere, you'll need to modify the paths in the batch files to match your system configuration.

## CI/CD Workflow: Automated Build & Artifact Distribution

This project includes a GitHub Actions workflow (`cmake-single-platform.yml`) that automates the build and packaging process for developers:

- **Oscar64 Compiler & VICE Emulator Download:**  
  The workflow automatically downloads the latest Oscar64 cross-assembler and the VICE emulator for each build.

- **CMake Configuration & Build:**  
  The workflow runs CMake to configure the project and builds all targets using the latest toolchain.

- **Artifact Upload:**  
  After a successful build, the workflow uploads the build output as a downloadable GitHub artifact. This ensures that developers always have access to the latest compiled binaries and essential debug files.

### Packaged Artifact Contents

The downloadable artifact includes:

- `build/*.prg` – Compiled C64 program files
- `build/*.map`, `build/*.lbl`, `build/*.asm` – Additional Oscar64 build files (map, label, assembly)
- `main/**/*.c`, `main/**/*.h` – Complete source code for manual compilation
- `oscar64/**` – Complete Oscar64 toolchain for building
- `vice/**` – VICE emulator for running programs
- `build.bat` – Build script for manual compilation
- `run_vice.bat` – Launch script for running in VICE emulator

## Running with VICE Emulator

### Using the CI/CD Artifact

1. **Download the Build Artifact:**
   - Go to the [GitHub Actions](../../actions) page
   - Click on the latest successful build
   - Download the `build-output` artifact zip file

2. **Manual Build (if needed):**

   ```bash
   # Build the project manually
   build.bat
   ```

3. **Extract and Run:**

   ```bash
   # Extract the zip file to any directory
   unzip build-output.zip -d my_project_folder
   cd my_project_folder
   
   # Double-click or run from command line:
   run_vice.bat
   ```

**For developer documentation, pipeline, API, and detailed module responsibilities see: [main/src/README.md](https://github.com/guyleslie/Hacked-C64/blob/main/main%2Fsrc%2FREADME.md)**
