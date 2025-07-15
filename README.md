**Map export:** Oscar64/C64 binary export is implemented and triggered manually by pressing the 'M' key during runtime, using the dedicated utility function `save_compact_map()`. The exported PRG file contains only the compact map data (3 bits/tile), making it efficient and directly usable on the C64.

# Hacked-C64

Oscar64/C64 Dungeon Map Generator – Modern, Modular, and Fully Commented

## Overview

This project is an optimized, modular dungeon map generator for the Commodore 64, written entirely in C and tailored for the Oscar64 cross-assembler. The program generates random maps with rooms, corridors, walls, and stairs, featuring real-time navigation and C64-specific screen handling. All algorithms, memory usage, and display routines are optimized for C64 hardware and Oscar64 compatibility.

## Screnshots

Generation debug indicators:

<img width="1192" height="902" alt="image" src="https://github.com/user-attachments/assets/9fb38995-9d2a-451d-a6cc-183752275dc5" />

---

Generated map test display:

<img width="1194" height="903" alt="image" src="https://github.com/user-attachments/assets/83f7092e-ebe4-4211-b90d-4914bf295301" />

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
| Door           | DOOR        | 171          |' + ' (invers char) | Door                |
| Stairs up      | UP          | 60           |' < '               | Up stairs           |
| Stairs down    | DOWN        | 62           |' > '               | Down stairs         |

*Note: The door is displayed as an inverse plus (+) character, PETSCII code 171.*

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
        ├─ common.h                           // Global macros, constants, shared includes
        ├─ main.c                             // Entry point, input, Oscar64 file I/O, main control
        ├─ oscar64_console.h                  // Oscar64/C64-specific screen routines
        ├─ README.md                          // Source folder documentation
        ├─ REFACTORING.md                     // Refactoring notes
        └─ mapgen/
            ├─ corridor_and_door_mechanism.md // Design notes for corridor/door logic
            ├─ door_placement.c               // Door placement, symmetric logic
            ├─ door_placement.h               // Door placement header
            ├─ map_export.c                   // Map export to Oscar64/C64 binary format
            ├─ map_export.h                   // Map export header
            ├─ map_generation.c               // Main generation pipeline (rooms, corridors, walls, stairs)
            ├─ mapgen_api.h                   // Public API for mapgen
            ├─ mapgen_display.h               // Display helpers for mapgen
            ├─ mapgen_internal.h              // Internal helpers for mapgen
            ├─ mapgen_types.h                 // Type definitions for mapgen
            ├─ mapgen_utility.h               // Utility functions for mapgen
            ├─ public.c                       // Mapgen public API implementation
            ├─ room_management.c              // Room placement, validation, priority
            ├─ rule_based_connection_system.c // Minimum Spanning Tree, rule-based connections
            ├─ testdisplay.c                  // Screen handling, viewport, input, delta refresh
            └─ utility.c                      // Math, random, cache, helper functions
```

**Legend:**

- `main/` — All C source code (entry point and primary modules)
- `mapgen/` — Dedicated folder for all map/dungeon generation logic, types, and helpers
- `.github/` — CI/CD automation and workflow scripts
- Top-level batch files — Build and emulator launch automation

All core map/tree/dungeon logic is modularized within `main/src/mapgen/` for maintainability and clarity. Each file’s comment describes its precise role and public/private status, supporting both development and documentation needs.

## Key Features and Architecture

- **Static memory usage:** All data structures (rooms, corridors, caches, screen buffer) are fixed-size arrays, no malloc/free, fully optimized for C64 memory constraints.
- **3-bit tile storage:** 64x64 grid, each tile uses 3 bits, entire map fits in 1536 bytes.
- **Room placement:** 4x4 grid, Fisher-Yates shuffle, validation, random size (4-8 tiles), minimum distance, collision avoidance.
- **Rule-based room connection:** Minimum Spanning Tree (MST) algorithm connects all rooms with the shortest valid corridors, always following strict rules. Corridors are only reused if all constraints are satisfied.
- **Corridor and door placement:** Corridors always start and end exactly 2 tiles away from the room perimeter, never inside the room. Doors are placed at the perimeter, at both ends of every corridor, ensuring seamless and visually consistent connections.
- **Stairs:** Placed by priority, centered in two rooms (UP/DOWN).
- **Walls:**
  - Wall generation uses a two-pass algorithm:
    - **First pass:** Places wall tiles around all walkable (floor, door, stairs) tiles, ensuring every path and room is enclosed.
    - **Second pass:** Adds corner tiles at junctions for a visually correct enclosure, using minimal checks for speed.
  - Only walkable tiles are scanned, maximizing performance for C64 hardware.
  - Walls and corners always tightly surround all rooms and corridors, with no gaps or overlaps.
  - Fully optimized for Oscar64 and C64 memory layout.
- **Screen handling:** 40x25 viewport, delta refresh, direct $0400-$07E7 memory access, Oscar64 assembly acceleration.
- **Map export:** Press 'M' during runtime to export the compact map (3 bits/tile) via `save_compact_map()`. The program saves the map as `MAPDATA.BIN` to device 8 (disk drive). The PRG file contains only map data.

## Developer Pipeline and Module Responsibilities

- `main.c`: Entry point, Oscar64 file I/O, main control, input
- `map_generation.c`: Main generation pipeline (rooms, corridors, walls, stairs)
- `rule_based_connection_system.c`: MST, rule-based connections, corridor reuse
- `room_management.c`: Room placement, validation, priority
- `door_placement.c`: Door placement, symmetric logic
- `map_export.c`: Map export to C64 PRG format, using Oscar64's knio file I/O functions.
- `testdisplay.c`: Screen handling, viewport, input, delta refresh
- `utility.c`: Math, random, cache, helper functions

## Technical Data

- **Map size:** 64x64 tiles, 3 bits/tile, 1536 bytes (leaves ~62 KB of RAM free)
- **Room count:** max. 20
- **Room size:** 4x4 – 8x8 tiles
- **Corridor segments:** max. 32
- **Connection cache:** max. 24
- **Screen buffer:** 40x25 characters
- **Total memory usage:** ~3.6 KB
- **Compiled PRG size:** 11,382 bytes (includes code, data, and buffers)

## Quality Assurance

### Validation Systems

- **Connectivity Check**: Ensures all rooms are reachable from any other room.
- **Rule Compliance**: All spacing and distance requirements are validated after generation.
- **Boundary Verification**: The generator never writes outside the map bounds.
- **Emergency Fallbacks**: Edge cases (e.g., failed room placement) are handled by the MST-based connection system, which repeatedly attempts valid connections. There are no special "force" or "emergency" connection functions; all connections follow the same rule-based logic.

### Error Handling

- **Graceful Degradation**: The program continues even if not all rooms can be placed.
- **Isolation Prevention**: The MST-based connection logic ensures all rooms are connected if possible. There are no separate isolation-prevention or force-connect routines; all rooms are connected using the same rule-based system.
- **Boundary Protection**: Comprehensive bounds checking is performed throughout the code.

## Usage (Build & Run)

### 1. With Windows batch files

- **build.bat:** Oscar64 build (compilation, automatic clean)
- **run_vice.bat:** Build + launch VICE emulator
- **run_c64debugger.bat:** Build + launch C64 Debugger

> **Note:** The paths for the compiler, emulator, and debugger can be customized in the batch files.

### 2. Manual build

- Compile the project with Oscar64 (see build.bat for parameters)
- The .prg can be run in any C64 emulator or on real hardware

## CI/CD Workflow: Automated Build, Emulator, and Artifact Packaging (GitHub Actions)

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

**For developer documentation, pipeline, API, and detailed module responsibilities: see `main/src/README.md`!**
