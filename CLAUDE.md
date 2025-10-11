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
- **Display**: 40×25 character mode viewport on dynamic map sizes (48×48, 64×64, or 80×80)

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
- **main/src/main.c**: Entry point, VIC-II setup, joystick 2 input handling
- **main/src/mapgen/**: Complete dungeon generation system
  - `mapgen_api.h`: Public interface for map operations (includes `mapgen_get_map_size()`)
  - `mapgen_types.h`: Core data structures and constants
  - `mapgen_internal.h`: Internal module definitions
  - `mapgen_config.c/.h`: Pre-generation configuration system with joystick 2 menu
  - `map_generation.c`: Main generation pipeline with dynamic parameters
  - `room_management.c`: Room placement algorithms
  - `connection_system.c`: Minimum spanning tree corridors
  - `mapgen_display.c/.h`: Viewport rendering and camera
  - `mapgen_utils.c/.h`: Utility functions and math operations
  - `map_export.c/.h`: File I/O operations with PRG format export

### Memory Architecture
- **Map Size**: Dynamically configurable at runtime (Small: 48×48, Medium: 64×64, Large: 80×80)
- **Map Storage**: 3-bit packed tile encoding with runtime calculated offsets (max 2400 bytes for 80×80)
- **Room System**: Up to 20 rooms on 4×4 placement grid (46 bytes each with cached center coordinates)
- **Configuration System**: Pre-generation joystick menu for dynamic parameter selection
- **Memory Usage**: Static allocation with maximum-sized buffers, runtime bounds checking
- **Display**: Character-mode rendering with custom tiles (40×25 viewport, optimized partial scrolling)
- **Connection Management**: Single source of truth prevents data inconsistency
- **String Optimization**: Packed string table with offset indexing
- **Bit Offset Calculation**: Dynamic `y * map_width * 3` formula ensures correct tile access across all map sizes

### Generation Algorithm
1. **Room Placement**: Fisher-Yates shuffle on 4×4 grid with immediate wall construction
2. **Connection**: Minimum spanning tree for corridor generation with walls built during creation
3. **Secret Rooms**: Single-connection rooms converted to secret areas
4. **Secret Treasures**: Hidden treasure chambers placed on walls without doors (excludes secret rooms, max 1 per room)
5. **False Corridors**: Dead-end corridors from room wall centers (5 per map, straight/L-shaped/Z-shaped, 2 tile margin)
6. **Stair Placement**: Distance-based optimal placement - up/down stairs placed in room centers with maximum separation

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
- 3-bit tile encoding in packed arrays with dynamic bit offset calculation
- Use `__zeropage` annotation for frequently accessed variables
- **Runtime bounds checking** - All tile access uses `current_params.map_width/height` for dynamic maps
- **Dynamic bit offsets** - `calculate_y_bit_offset()` computes `y * map_width * 3` at runtime
- **Atomic metadata operations** - prevent inconsistent states during connection management
- **Static inline optimizations** - Hot path functions use `static inline` in headers for OSCAR64 optimization
  - `get_room_center_ptr_inline()` - Room pointer center access (mapgen_utils.h)
  - `get_room_center_x_inline()`, `get_room_center_y_inline()` - Room ID center access
  - `abs_diff_inline()` - Arithmetic helpers
  - `calculate_y_bit_offset()` - Dynamic Y offset calculation for tile access
  - Header placement enables OSCAR64 `-Oo` outliner to optimize call sites
- **Dynamic progress tracking** - Runtime-calculated phase boundaries based on generation parameters

### Corridor Logic and Connection Functions
```c
// Simplified room connection system - optimized for OSCAR64
unsigned char connect_rooms(unsigned char room1, unsigned char room2, unsigned char is_secret);

// Corridor type determination (simplified logic):
// Priority: Straight > L-shaped > Z-shaped  
// - Straight: Direct path possible between room exits
// - L-shaped: Single turn required for connection
// - Z-shaped: Two turns required for complex connections

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

// Secret treasure system functions (in connection_system.c)
// - place_treasure_for_room: Places treasure in room if eligible (not secret, no existing treasure)
// - place_secret_treasures: Main function placing N treasures across available rooms
unsigned char place_treasure_for_room(unsigned char room_idx);
void place_secret_treasures(unsigned char treasure_count);

// Wall validation utilities (in mapgen_utils.c)
// - wall_has_doors: Checks if wall_side has any doors (normal + false corridor doors)
// - get_wall_side_from_exit: Determines which wall side a door/exit is on
unsigned char wall_has_doors(unsigned char room_idx, unsigned char wall_side);
unsigned char get_wall_side_from_exit(unsigned char room_idx, unsigned char exit_x, unsigned char exit_y);

// False corridor system functions (simplified and optimized)
// - calculate_false_corridor_door: Calculates door position on room wall
// - create_false_corridor: Creates dead-end corridor from door position outward
// - place_false_corridors: Places N false corridors (currently 5) across map with retry logic
// - Generates straight, L-shaped, or Z-shaped dead-ends with proper direction from doors
// - Uses simplified collision detection and existing corridor drawing functions
// - Prevents conflicts with existing doors through wall_has_doors() validation
void place_false_corridors(unsigned char corridor_count);

// Progress tracking system functions (in mapgen_utils.c)
// - init_progress_weights: Pre-calculates phase boundaries from current_params at generation start
// - update_progress_step: Updates progress bar using dynamic phase weights
// - Phase weights automatically scale to actual work done per configuration
void init_progress_weights(void);
void update_progress_step(unsigned char phase, unsigned char current, unsigned char total);

// Map export system functions (in map_export.c)
// - save_compact_map: Exports map to disk in PRG format
// - File format: [PRG header (2 bytes, auto)] + [map_size (1 byte)] + [packed tile data (3 bits/tile)]
// - Filename: "mapbin" (lowercase for proper PETSCII display on C64)
// - Uses mapgen_get_map_size() to determine actual data size
// - Only saves necessary bytes based on current map configuration
void save_compact_map(const char* filename);

// Map size query function (in map_generation.c, exposed via mapgen_api.h)
// - Returns current map width (== height) from generation parameters
// - Used by export system to calculate actual data size
unsigned char mapgen_get_map_size(void);
```

## Map Export Format (MAPBIN.PRG)

The map is exported to disk as a PRG file with the following structure:

**File Structure:**
- **Byte 0-1**: PRG load address (little-endian, added automatically by C64 KERNAL SAVE)
- **Byte 2**: Map size (single byte: 48, 64, or 80)
- **Byte 3+**: Packed tile data (3 bits per tile, bit stream crosses byte boundaries)

**File Sizes:**
- 48×48 map: 2 + 1 + 864 = **867 bytes**
- 64×64 map: 2 + 1 + 1536 = **1539 bytes**
- 80×80 map: 2 + 1 + 2400 = **2403 bytes**

**Calculation:**
```
tile_bits = map_size × map_size × 3
data_bytes = (tile_bits + 7) / 8
total_size = 2 (PRG header) + 1 (size) + data_bytes
```

**Tile Encoding (3 bits per tile):**
| Value | Tile Type    |
|-------|--------------|
| 0     | Empty        |
| 1     | Wall         |
| 2     | Floor        |
| 3     | Door         |
| 4     | Up stairs    |
| 5     | Down stairs  |
| 6     | Secret path  |
| 7     | (reserved)   |

**Export Trigger:**
- Press **'M'** key during navigation to save map to disk as "mapbin"
- File appears as "MAPBIN" in C64 directory listing

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
// Room structure (46 bytes total)
typedef struct {
    // Most frequently accessed during generation (ordered by access frequency)
    unsigned char x, y, w, h;              // Room position and size (4 bytes)
    unsigned char center_x, center_y;      // Cached room center (2 bytes) - calculated as x+(w-1)/2, y+(h-1)/2
    unsigned char connections;             // Number of active connections (1 byte)
    unsigned char state;                   // Room state flags (ROOM_SECRET=0x01, ROOM_HAS_TREASURE=0x02, ROOM_HAS_FALSE_CORRIDOR=0x04) (1 byte)

    // Packed connection metadata (4 bytes)
    PackedConnection conn_data[4];         // Connection info (room_id, corridor_type)

    // Door metadata (12 bytes)
    Door doors[4];                         // Door positions

    // Corridor breakpoint metadata (16 bytes)
    CorridorBreakpoint breakpoints[4][2];  // Corridor turn points

    // Secret treasure metadata (2 bytes) - wall entry point (target calculated on-demand)
    unsigned char treasure_wall_x;         // Secret wall X coordinate (255 = no treasure)
    unsigned char treasure_wall_y;         // Secret wall Y coordinate

    // False corridor metadata (4 bytes) - endpoints only (type calculated on-demand from coordinates)
    unsigned char false_corridor_door_x;   // False corridor door X coordinate (255 = no false corridor)
    unsigned char false_corridor_door_y;   // False corridor door Y coordinate
    unsigned char false_corridor_end_x;    // False corridor end X coordinate
    unsigned char false_corridor_end_y;    // False corridor end Y coordinate
} Room; // 46 bytes total

// Connection structures
typedef struct {
    unsigned char room_id : 5;             // Connected room (0-31)
    unsigned char corridor_type : 3;       // Corridor type (0-7)
} PackedConnection; // 1 byte

typedef struct {
    unsigned char x, y;                    // Door coordinates
    unsigned char wall_side : 2;           // Wall side (0-3)
    unsigned char reserved : 6;            // Reserved bits
} Door; // 3 bytes

// Map stored as 3-bit packed tile array (max size for 80×80)
unsigned char compact_map[COMPACT_MAP_SIZE]; // 2400 bytes = (80*80*3+7)/8
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
- Simplified false corridor logic using existing corridor drawing functions
- Maintained atomic connection management for data consistency
- Dynamic progress calculation with runtime-weighted phases based on current_params
- Inline function optimizations for hot paths
- Packed string table with 8-bit offset array (vs separate string literals)
- Index-based phase display API (`show_phase(id)` vs `show_phase_name(string)`)
- Single bounds check per tile access (no redundant validation layers)
- MST algorithm connection logic (guaranteed valid room indices)

**Compiler-level optimizations:**
- Development builds: Full debug information (`-O0 -g -n -dDEBUG`)
- Release builds: Size optimization (`-Os -Oo`) with debug overhead removal
- Separated build workflows for development vs production

**Data structure optimizations:**
- Packed Room struct with bitfields (46 bytes per room with center cache)
- 3-bit tile encoding for compact map storage with dynamic bit offset calculation
- Offset-based string table instead of pointer arrays
- Pre-calculated phase boundaries array (8 bytes) replaces static phase tables (-1 byte net)
- Runtime map size selection (48/64/80) with single 2400-byte buffer

**Display and scrolling optimizations:**
- Optimized partial screen updates (single row/column shifts)
- Eliminated edge case full screen fallbacks at map boundaries
- Scroll direction tracking only when viewport actually changes
- Dynamic viewport bounds checking using `current_params.map_width/height`

**Results:**
- Optimized release builds with no debug overhead
- Maintained full functionality with improved performance
- Clean development workflow with proper debug capabilities
- Professional code organization with efficient memory usage

### Build Strategy

**When to use Development builds:**
- Active development and debugging
- Code analysis and optimization research
- Memory usage profiling

**When to use Release builds:**
- Final distribution
- Performance testing
- Size optimization verification