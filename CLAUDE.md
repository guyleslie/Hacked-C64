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
- **Map Size**: Fixed 64×64 tile grid (3-bit packed encoding: 3072 bytes)
- **Room System**: Up to 20 rooms on 4×4 placement grid (20 bytes each, 39% savings)
- **Memory Usage**: Optimized allocation with atomic metadata management
- **Display**: Character-mode rendering with custom tiles (40×25 viewport)
- **Connection Management**: Single source of truth prevents data inconsistency

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
- **Atomic metadata operations** - prevent inconsistent states during connection management

### Metadata Management Functions
```c
// Atomic connection management - single operation for all metadata
unsigned char add_connection_to_room(unsigned char room_idx, unsigned char connected_room,
                                    unsigned char door_x, unsigned char door_y, 
                                    unsigned char wall_side, unsigned char corridor_type);

// Centralized validation and queries
unsigned char room_has_connection_to(unsigned char room_idx, unsigned char target_room);
unsigned char get_connection_info(unsigned char room_idx, unsigned char target_room,
                                 unsigned char *door_x, unsigned char *door_y, 
                                 unsigned char *wall_side, unsigned char *corridor_type);

// Atomic rollback for error handling
unsigned char remove_last_connection_from_room(unsigned char room_idx);
```

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
// Optimized Room structure (20 bytes, 39% memory savings)
typedef struct {
    // Most frequently accessed during generation
    unsigned char x, y, w, h;              // Room position and size
    unsigned char connections;             // Number of active connections
    unsigned char state;                   // Room state flags (secret/normal)
    
    // Optimized packed connection metadata (4 bytes)
    PackedConnection conn_data[4];         // Connection info (room_id, corridor_type)
    Door doors[4];                         // Door positions (8 bytes)
    
    // Less frequently accessed
    unsigned char hub_distance, priority; // Generation parameters
} Room;

// Optimized connection structures
typedef struct {
    unsigned char room_id : 5;             // Connected room (0-31)
    unsigned char corridor_type : 3;       // Corridor type (0-7)
} PackedConnection; // 1 byte - no 'used' flag (redundant)

typedef struct {
    unsigned char x, y;                    // Door coordinates
    unsigned char wall_side : 2;           // Wall side (0-3)
    unsigned char reserved : 6;            // Reserved bits
} Door; // 2 bytes - no 'connected_room' (redundant)

// Map stored as 3-bit packed tile array
unsigned char compact_map[MAP_H * MAP_W * 3 / 8];
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