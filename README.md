# Hacked-C64-SecretRooms

Advanced Dungeon Map Generator for Commodore 64 – Enhanced with Secret Room System

## Overview

This project is an advanced dungeon map generator written in C for the Oscar64 cross-assembler. The program generates interconnected dungeon layouts with rooms, corridors, walls, stairs, doors, and an intelligent **secret room detection system**. Features include real-time navigation, interactive map exploration, advanced secret room algorithms, hidden corridor pathfinding, compact 3-bit tile encoding, and C64 PRG map export functionality. Code uses static memory allocation and direct screen memory access.

## 🔗 Repository Versions

- **[Hacked-C64](https://github.com/guyleslie/Hacked-C64)** - Original base version without secret room functionality
- **[Hacked-C64-SecretRooms](https://github.com/guyleslie/Hacked-C64-SecretRooms)** - ⭐ **This repository** - Enhanced version with secret room system

---

## 🏛️ Secret Room System Features

This enhanced version includes an advanced **Secret Room Detection and Hidden Corridor System**:

### 🔍 **Intelligent Secret Room Detection**
- **Physical Connection Analysis**: Identifies rooms with exactly one connection (true dead-ends)
- **Hub Filtering**: Only marks rooms connected to hub nodes (2+ connections) to avoid isolated pairs
- **Configurable Percentage**: 15% of eligible single-connection rooms become secret (adjustable)
- **Game Balance**: Ensures only meaningful branch endpoints are hidden, maintaining exploration value

### 🗝️ **Secret Corridor Pathfinding**
- **Full Path Conversion**: Automatically converts entire corridor paths leading to secret rooms
- **Visual Distinction**: Secret paths use checkerboard pattern (PETSCII 94: `^` character)
- **Smart Boundary Detection**: Avoids converting tiles inside room interiors
- **Bidirectional Tracing**: Traces from secret doors to connecting room doors

### 🎮 **Enhanced Gameplay**
- **Hidden Exploration**: Secret rooms appear as normal walls until discovered
- **Progressive Discovery**: Players must find hidden passages to access secret areas
- **Strategic Placement**: Secret rooms contain the same features as normal rooms (potential stairs, etc.)
- **Visual Feedback**: Clear distinction between normal doors (PETSCII 219) and secret paths (PETSCII 94)

### 🔧 **Technical Implementation**
- **Memory Efficient**: Uses existing tile encoding system with new `TILE_SECRET_PATH` type
- **Algorithm Optimized**: O(n) secret room detection with MST-based validation
- **C64 Compatible**: Static memory allocation, no dynamic data structures
- **Debugging Support**: Real-time progress indicators during secret room creation

---

## Screenshots

Debug generation with progress indicators:

<img width="1205" height="909" alt="image" src="https://github.com/user-attachments/assets/32b037af-7c1c-40b3-a288-7dc1ab5a5194" />

---

Final generated dungeon map display:

<img width="1203" height="908" alt="image" src="https://github.com/user-attachments/assets/2fb6eab8-335f-4c00-909c-a2f2e453c627" />

---

## How to Run the Program

### Method 1: CI/CD Artifact (Recommended)

**Complete ready-to-run package with all dependencies included:**

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
   run_vice.bat
   ```

3. **Manual Build (if needed):**

   ```bash
   # Build the project manually
   build.bat
   ```

### Method 2: Manual Development

**For developers who want to modify the source code:**

1. **Download Source Code**: Download the ZIP file from the GitHub repository's "Code" button
2. **Install Dependencies**: Download and place Oscar64 and VICE in their respective folders (`oscar64/` and `vice/`) within the project directory
3. **Build and Run**:
   - **`build.bat`**: Oscar64 compilation with cleanup
   - **`run_vice.bat`**: Launch compiled PRG in VICE emulator

**Note:** Manual method requires you to download Oscar64 and VICE separately and configure paths correctly.

## Game Controls

Once the program is running in the VICE emulator:

- **WASD Keys**: Navigate around the generated dungeon map
- **SPACE**: Generate a new random dungeon layout
- **M**: Export current map as a C64 PRG file to disk
- **Progress Dots**: Watch for dots (`.`) appearing during generation to see real-time progress

## Map Data Structure

The map is represented as a 2D grid of tiles, with each tile encoded using 3 bits for compact storage. The map dimensions are defined as 64x64 tiles (MAP_W x MAP_H). Each tile can represent different features such as empty space, wall, floor, door, secret door, or stairs.

### Tile Types and Encoding

| Tile Type      | Symbol Name | PETSCII Code | PETSCII Character  | Description         |
|----------------|-------------|--------------|--------------------|---------------------|
| Empty space    | EMPTY       | 32           | (space)            | Blank/empty tile    |
| Wall           | WALL        | 160          |' █ '               | Solid block         |
| Floor (path)   | FLOOR       | 46           |' . '               | Walkable path       |
| Door           | DOOR        | 219          |' + ' (invers char) | Regular door        |
| **Secret Path**| **SECRET_PATH** | **94**   |**' ^ ' (caret)**   | **🔑 Hidden passage/secret door** |
| Stairs up      | UP          | 60           |' < '               | Up stairs           |
| Stairs down    | DOWN        | 62           |' > '               | Down stairs         |

**🏛️ Secret Room System:**
- **Secret paths** (PETSCII 94) mark hidden corridors and doors leading to secret rooms
- **Detection algorithm** identifies single-connection rooms attached to hub nodes
- **15% of eligible rooms** become secret with full corridor path conversion
- **Visual distinction** helps players identify discoverable hidden areas

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
- **Secret Room System**: Physical connection validation identifies rooms with exactly one connection, filtering for hub-connected endpoints. Configurable percentage (default: 15%) of eligible single-connection rooms marked as secret with checkerboard door markers (PETSCII 94)
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

## Developer Pipeline and Module Responsibilities

- `main.c`: Entry point, VIC-II configuration, initialization, main control loop, user input handling
- `map_generation.c`: Main generation pipeline (rooms, corridors, secret rooms, stairs, walls)
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

**For developer documentation, pipeline, API, and detailed module responsibilities see: [main/src/README.md](https://github.com/guyleslie/Hacked-C64/blob/main/main%2Fsrc%2FREADME.md)**
