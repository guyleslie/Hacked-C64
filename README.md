
# Hacked-C64

Oscar64/C64 Dungeon Map Generator – Modern, Modular, and Fully Commented

## Overview

This project is an optimized, modular dungeon map generator for the Commodore 64, written entirely in C and tailored for the Oscar64 cross-assembler. The program generates random maps with rooms, corridors, walls, and stairs, featuring real-time navigation and C64-specific screen handling. All algorithms, memory usage, and display routines are optimized for C64 hardware and Oscar64 compatibility.

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
- **Rule-based connections:** Minimum Spanning Tree (MST), all connections validated, corridors and doors always at room edge, corridor reuse with strict rules.
- **Door placement:** Always on the room perimeter, symmetric, at both ends of every corridor.
- **Stairs:** Placed by priority, centered in two rooms (UP/DOWN).
- **Walls:** Only around floor/door tiles, fast algorithm (~20x faster than full map scan).
- **Screen handling:** 40x25 viewport, delta refresh, direct $0400-$07E7 memory access, Oscar64 assembly acceleration.
- **Input:** WASD movement, SPACE for new map, Q to quit, instant feedback.
- **Map export:** Oscar64/C64 binary export already implemented, but not yet integrated in the main pipeline.

## Developer Pipeline and Module Responsibilities

See details in: `main/src/README.md` (per-module pipeline, API, types, developer summary)

- `main.c`: Entry point, Oscar64 file I/O, main control, input
- `map_generation.c`: Main generation pipeline (rooms, corridors, walls, stairs)
- `rule_based_connection_system.c`: MST, rule-based connections, corridor reuse
- `room_management.c`: Room placement, validation, priority
- `door_placement.c`: Door placement, symmetric logic
- `map_export.c`: Map export to Oscar64/C64 binary format (not yet integrated in pipeline)
- `testdisplay.c`: Screen handling, viewport, input, delta refresh
- `utility.c`: Math, random, cache, helper functions

## Technical Data

- **Map size:** 64x64 tiles, 3 bits/tile, 1536 bytes
- **Room count:** max. 20
- **Room size:** 4x4 – 8x8 tiles
- **Corridor segments:** max. 32
- **Connection cache:** max. 24
- **Screen buffer:** 40x25 characters
- **Total memory usage:** ~3.6 KB (fits C64 RAM)

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

## Usage (Build & Run)

### 1. With Windows batch files

- **build.bat:** Oscar64 build (compilation, automatic clean)
- **run_vice.bat:** Build + launch VICE emulator
- **run_c64debugger.bat:** Build + launch C64 Debugger

> **Note:** The paths for the compiler, emulator, and debugger can be customized in the batch files.

### 2. Manual build

- Compile the project with Oscar64 (see build.bat for parameters)
- The .prg can be run in any C64 emulator or on real hardware

## CI/CD (GitHub Actions)

After every build, the `build/` directory is available as a downloadable artifact on the GitHub Actions page (see `.github/workflows/cmake-single-platform.yml`).

---

**For developer documentation, pipeline, API, and detailed module responsibilities: see `main/src/README.md`!**
