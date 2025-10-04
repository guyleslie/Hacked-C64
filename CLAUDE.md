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
- **Display**: 40×25 character mode viewport on 72×72 map

## Commands

### Build Commands

**Development Build (with debug information):**
```bash
build-dev.bat
```
- Includes debug symbols and additional analysis files
- Larger executable size
- Easier debugging and development

**Release Build (optimized):**
```bash
build-release.bat  
```
- Optimized for size and performance
- No debug overhead
- Production-ready executable

**Interactive Build Selection:**
```bash
build.bat
```
- Choose between development and release builds at runtime

### Verification Commands
```bash
# Check build success
dir build\

# Clean build directory  
del /Q build\*

# Verify output files exist (development build)
dir build\"Hacked C64-dev.prg" build\"Hacked C64-dev.map" build\"Hacked C64-dev.asm"

# Verify output files exist (release build)
dir build\"Hacked C64.prg"
```

### Build Process Details

**Development Build Output (`build-dev.bat`):**
- `Hacked C64-dev.prg` - Debug executable
- `Hacked C64-dev.map` - Memory usage mapping  
- `Hacked C64-dev.asm` - 6502 assembly listing
- `Hacked C64-dev.lbl` - VICE debugger labels
- `Hacked C64-dev.dbj` - JSON debug data

**Release Build Output (`build-release.bat`):**
- `Hacked C64.prg` - Optimized executable (production)

### Build System Details

**Development Build Flags:**
```
-O0 -g -n -dDEBUG -d__oscar64__ -tf=prg -tm=c64 -dNOLONG -dNOFLOAT -psci
```

**Release Build Flags:**
```
-Os -Oo -tf=prg -tm=c64 -dNOLONG -dNOFLOAT -psci
```

**Key Differences:**
- **Development**: No optimization (-O0), debug symbols (-g), debug files (-n)
- **Release**: Size optimization (-Os), code outlining (-Oo), no debug overhead

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
- **Map Size**: Fixed 72×72 tile grid (3-bit packed encoding: 3888 bytes)
- **Room System**: Up to 20 rooms on 4×4 placement grid (38 bytes each, optimized structure)
- **Memory Usage**: Static allocation with optimized data structures
- **Display**: Character-mode rendering with custom tiles (40×25 viewport)
- **Connection Management**: Single source of truth prevents data inconsistency
- **Optimization**: Redundant safety checks removed (geometric impossibility leveraged)

### Generation Algorithm
1. **Room Placement**: Fisher-Yates shuffle on 4×4 grid with immediate wall construction
2. **Connection**: Minimum spanning tree for corridor generation with walls built during creation
3. **Secret Rooms**: Single-connection rooms converted to secret areas
4. **Secret Treasures**: Hidden treasure chambers placed on walls without doors (excludes secret rooms, max 1 per room)
5. **Stair Placement**: Priority-based placement in room centers

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
- **Inline optimizations** - Hot path functions optimized for performance
- **Progress batching** - Reduced update frequency for better performance

### Corridor Logic and Connection Functions
```c
// Room connection with corridor type selection
unsigned char connect_rooms_directly(unsigned char room1, unsigned char room2, unsigned char is_secret);

// Corridor type determination:
// Priority: Straight > L-shaped > Z-shaped
// - Straight: Room centers aligned AND rooms face each other (not overlapping)
// - L-shaped: Horizontal and vertical gaps between room boundaries > 0
// - Z-shaped: Default fallback for diagonal room connections

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

// Secret room system functions
// - convert_secret_rooms_doors: Converts single-connection rooms to secret with entrance-only secret doors
// - Secret room door is converted to floor, normal room door becomes TILE_SECRET_PATH
// - Validates connection constraints and marks doors with is_secret_door flag

// Secret treasure system functions
// - wall_has_doors: Checks if wall_side has any doors (prevents treasure placement)
// - place_treasure_for_room: Places treasure in room if eligible (not secret, no existing treasure)
// - place_secret_treasures: Main function placing N treasures across available rooms
unsigned char wall_has_doors(unsigned char room_idx, unsigned char wall_side);
unsigned char place_treasure_for_room(unsigned char room_idx);
void place_secret_treasures(unsigned char treasure_count);
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
// Optimized Room structure (42 bytes total, optimized layout)
typedef struct {
    // Most frequently accessed during generation
    unsigned char x, y, w, h;              // Room position and size (4 bytes)
    unsigned char connections;             // Number of active connections (1 byte)
    unsigned char state;                   // Room state flags (ROOM_SECRET=0x01, ROOM_HAS_TREASURE=0x02) (1 byte)
    
    // Packed connection metadata (4 bytes)
    PackedConnection conn_data[4];         // Connection info (room_id, corridor_type)
    
    // Door metadata (12 bytes)
    Door doors[4];                         // Door positions
    
    // Corridor breakpoint metadata (16 bytes)
    CorridorBreakpoint breakpoints[4][2];  // Corridor turn points
    
    // Secret treasure metadata (2 bytes) - wall position where treasure is accessible
    unsigned char treasure_wall_x;        // Secret wall X coordinate (255 = no treasure)
    unsigned char treasure_wall_y;        // Secret wall Y coordinate
    
    // Less frequently accessed
    unsigned char hub_distance, priority; // Generation parameters (2 bytes)
} Room; // 42 bytes total (4+1+1+4+12+16+2+2 bytes)

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

**Development Build verification:**
- Successful compilation produces `build/Hacked C64-dev.prg`
- Assembly listing in `build/Hacked C64-dev.asm` for debugging
- Memory map in `build/Hacked C64-dev.map` for optimization analysis
- VICE debugger labels in `build/Hacked C64-dev.lbl`
- JSON debug data in `build/Hacked C64-dev.dbj`

**Release Build verification:**
- Successful compilation produces `build/Hacked C64.prg` (optimized)
- Smaller file size compared to development build
- No debug overhead

**Manual testing via VICE emulator:**
- Run `run_vice.bat` to launch
- Test all functionality (generation, navigation, export)
- Verify performance and stability

## Documentation References

- **Project Specification**: `docs/project-specification.md` - Complete technical algorithms
- **OSCAR64 Reference**: `docs/oscar64-c64-development-reference.md` - C64 development guide
- **OSCAR64 Optimization**: `docs/oscar64-optimization-analysis.md` - Compiler optimization strategies
- **README.md**: User-facing documentation and controls

## Platform-Specific Notes

### Cross-Platform Development
- OSCAR64 compiler located in `oscar64/bin/oscar64.exe`
- Build directory automatically created as `build/`
- Source files in `main/src/` with mapgen modules in `main/src/mapgen/`
- All mapgen modules included in main.c (OSCAR64 pattern)

## Optimization Strategy

### Applied Optimizations

**Code-level optimizations:**
- Removed redundant safety checks (geometric impossibility leveraged)
- Eliminated redundant functions (`path_is_safe()`, etc.)
- Simplified collision detection (bounds-only checks)
- Batched progress updates (50% frequency reduction)
- Inline function optimizations for hot paths

**Compiler-level optimizations:**
- Development builds: Full debug information (`-O0 -g -n -dDEBUG`)
- Release builds: Size optimization (`-Os -Oo`) with debug overhead removal
- Separated build workflows for development vs production

**Results:**
- Substantial size reduction in release builds compared to mixed debug/optimization
- Maintained full functionality with improved performance
- Clean development workflow with proper debug capabilities

### Build Strategy

**When to use Development builds:**
- Active development and debugging
- Code analysis and optimization research
- Memory usage profiling

**When to use Release builds:**
- Final distribution
- Performance testing
- Size optimization verification