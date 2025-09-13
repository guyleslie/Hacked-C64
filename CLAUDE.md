# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Commodore 64 dungeon map generator built with the OSCAR64 cross-compiler. The project generates real-time procedural dungeons with room placement, corridors, secret areas, and interactive navigation on C64 hardware.

## Build Commands

### Primary Build Method
```bash
# Build the project using batch script (Windows)
build.bat

# Run in VICE emulator
run_vice.bat

# Build using CMake (cross-platform)
cmake -B build
cmake --build build
```

### Build System Details
- **OSCAR64 Compiler**: Cross-compiler for C64 development
- **Output**: `build/Hacked C64.prg` (optimized C64 executable)
- **Build flags**: `-Os -dNOLONG -dNOFLOAT -psci -tm=c64 -dDEBUG`
- **Target**: C64 platform with 64KB RAM constraint

## Architecture

### Core Components
- **main.c**: Entry point, VIC-II setup, user input handling
- **mapgen/**: Complete dungeon generation system
  - `mapgen_api.h`: Public interface for map operations
  - `map_generation.c`: Main generation pipeline
  - `room_management.c`: Room placement algorithms
  - `connection_system.c`: Minimum spanning tree corridors
  - `mapgen_display.c`: Viewport rendering and camera
  - `map_export.c`: File I/O operations

### Memory Architecture
- **Map Size**: Fixed 64×64 tile grid
- **Room System**: Up to 20 rooms on 4×4 placement grid
- **Memory Usage**: Efficient allocation for map data structures
- **Display**: Character-mode rendering with custom tiles

### Generation Algorithm
1. **Room Placement**: Fisher-Yates shuffle on 4×4 grid
2. **Connection**: Minimum spanning tree for corridor generation
3. **Secret Rooms**: Isolated rooms become secret areas
4. **Wall Filling**: Flood-fill algorithm for solid barriers

## Key Development Patterns

### Include Structure
OSCAR64 uses C file inclusion rather than separate compilation:
```c
#include "mapgen/mapgen_utils.c"
#include "mapgen/map_generation.c"
// All .c files included in main.c
```

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

The project includes validation systems:
- `mapgen_validate_map()`: Checks map integrity
- `mapgen_get_statistics()`: Analyzes generation results
- Manual testing via VICE emulator

## Documentation References

- **Project Specification**: `docs/project-specification.md` - Complete technical algorithms
- **OSCAR64 Reference**: `docs/oscar64-c64-development-reference.md` - C64 development guide
- **README.md**: User-facing documentation and controls

## Platform-Specific Notes

### Windows Development
- Uses batch scripts for build automation
- VICE emulator integration via `run_vice.bat`
- Requires OSCAR64 compiler in project structure

### Cross-Platform Support
- CMake configuration supports multiple platforms
- Environment variable detection for CI/CD
- Automatic path resolution for compiler location