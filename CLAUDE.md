# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Commodore 64 dungeon map generator built with the OSCAR64 cross-compiler. The project generates real-time procedural dungeons with room placement, corridors, secret areas, and interactive navigation on C64 hardware.

## Tech Stack

- **Platform**: Commodore 64 (6502 processor, 64KB RAM)
- **Compiler**: OSCAR64 cross-compiler
- **Language**: C with C64-specific optimizations  
- **Target**: .prg executable format
- **Memory Model**: Static allocation only, 3-bit tile encoding
- **Display**: 40×25 character mode viewport on 64×64 map

## Commands

### Build Commands
```bash
# Create build directory
mkdir -p build

# Build with OSCAR64 compiler
oscar64/bin/oscar64.exe -o="build/Hacked C64.prg" -n -tf=prg -Os -dNOLONG -dNOFLOAT -psci -tm=c64 -dDEBUG -d__oscar64__ -i=oscar64/include -i=oscar64/include/c64 -i=main/src/mapgen main/src/main.c
```

### Verification Commands
```bash
# Check build success
ls -la build/

# Clean build directory  
rm -rf build/*

# Verify output files exist
ls build/"Hacked C64.prg" build/"Hacked C64.map" build/"Hacked C64.asm"
```

### Build Process Details
The build system creates multiple output files in the `build/` directory:
- `Hacked C64.prg` - Main executable for C64
- `Hacked C64.map` - Memory usage mapping  
- `Hacked C64.asm` - 6502 assembly listing
- `Hacked C64.lbl` - VICE debugger labels
- `Hacked C64.dbj` - JSON debug data

### Build System Details
- **OSCAR64 Compiler**: Cross-compiler for C64 development
- **Output**: `build/Hacked C64.prg` (optimized C64 executable)
- **Build flags**: `-Os -dNOLONG -dNOFLOAT -psci -tm=c64 -dDEBUG -d__oscar64__`
- **Target**: C64 platform with 64KB RAM constraint
- **Include paths**: oscar64/include, oscar64/include/c64, main/src/mapgen

## Architecture

### Core Components
- **main/src/main.c**: Entry point, VIC-II setup, user input handling
- **main/src/mapgen/**: Complete dungeon generation system
  - `mapgen_api.h`: Public interface for map operations
  - `mapgen_types.h`: Core data structures and constants
  - `mapgen_internal.h`: Internal module definitions
  - `map_generation.c`: Main generation pipeline
  - `room_management.c`: Room placement algorithms
  - `connection_system.c`: Minimum spanning tree corridors
  - `mapgen_display.c/.h`: Viewport rendering and camera
  - `mapgen_utils.c/.h`: Utility functions and math operations
  - `map_export.c/.h`: File I/O operations

### Memory Architecture
- **Map Size**: Fixed 64×64 tile grid
- **Room System**: Up to 20 rooms on 4×4 placement grid
- **Memory Usage**: Efficient allocation for map data structures
- **Display**: Character-mode rendering with custom tiles

### Generation Algorithm
1. **Room Placement**: Fisher-Yates shuffle on 4×4 grid with immediate wall construction
2. **Connection**: Minimum spanning tree for corridor generation with walls built during creation
3. **Secret Rooms**: Single-connection rooms converted to secret areas
4. **Stair Placement**: Priority-based placement in room centers

## Code Style & Conventions

### C64-Specific Patterns
- Use `unsigned char` for all coordinates, counters, and tile types
- Avoid dynamic allocation - use fixed-size arrays only
- Optimize for 6502: prefer 8-bit arithmetic over 16-bit operations
- OSCAR64 requirement: include all .c files in main.c (no separate compilation)

### Function Naming
- Use snake_case: `place_walls_around_room()`, `calculate_room_distance()`
- Prefix with module: `mapgen_`, `room_`, `connection_`
- Keep function names descriptive but concise

### Memory Management
- Static allocation only - no malloc/free
- 3-bit tile encoding in packed arrays
- Use `__zeropage` annotation for frequently accessed variables

## Core Files & Architecture

### Critical Files
- **main/src/main.c**: Entry point - includes ALL mapgen modules (OSCAR64 pattern)
- **main/src/mapgen/map_generation.c**: Generation pipeline controller
- **main/src/mapgen/room_management.c**: Room placement with immediate wall building  
- **main/src/mapgen/connection_system.c**: MST corridors with incremental wall construction
- **main/src/mapgen/mapgen_utils.c**: Core utilities including `place_walls_around_room()`, `place_walls_around_corridor_tile()`

### Include Structure (OSCAR64 Requirement)
```c
#include "mapgen/mapgen_utils.c"
#include "mapgen/map_generation.c"
#include "mapgen/room_management.c"
#include "mapgen/connection_system.c"
#include "mapgen/mapgen_display.c"
#include "mapgen/map_export.c"
```

### Build Output Analysis
OSCAR64 generates detailed build information for optimization:
- **`build/Hacked C64.map`**: Memory usage analysis, function sizes, optimization opportunities
- **`build/Hacked C64.asm`**: 6502 assembly listing for performance analysis and debugging
- **`build/Hacked C64.lbl`**: VICE debugger labels for runtime debugging
- Use these files to verify optimizations and identify performance bottlenecks

### OSCAR64 Requirements
- All mapgen modules MUST be included in main.c (no separate compilation)
- Use provided compiler flags exactly as specified
- Review memory map for optimization opportunities

### Memory Constraints
- Avoid dynamic allocation (limited heap)
- Use fixed-size arrays and structures
- Optimize for 6502 processor limitations
- Functions must fit within 64KB address space

### Data Types
```c
// Core structures in mapgen_types.h
typedef struct {
    unsigned char x, y, w, h;
    unsigned char priority;
} Room;

// Map stored as tile array
unsigned char map[MAP_HEIGHT][MAP_WIDTH];
```

## Testing and Verification

Build verification:
- Successful compilation produces `build/Hacked C64.prg`
- Assembly listing in `build/Hacked C64.asm` for debugging
- Memory map in `build/Hacked C64.map` for optimization analysis
- Manual testing via VICE emulator

## Documentation References

- **Project Specification**: `docs/project-specification.md` - Complete technical algorithms
- **OSCAR64 Reference**: `docs/oscar64-c64-development-reference.md` - C64 development guide
- **README.md**: User-facing documentation and controls

## Platform-Specific Notes

### Cross-Platform Development
- OSCAR64 compiler located in `oscar64/bin/oscar64.exe`
- Build directory automatically created as `build/`
- Source files in `main/src/` with mapgen modules in `main/src/mapgen/`
- All mapgen modules included in main.c (OSCAR64 pattern)