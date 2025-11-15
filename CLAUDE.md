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
-Os -Oo -Oi -Op -Oz -tf=prg -tm=c64 -dNOLONG -dNOFLOAT -psci
```

**Key Differences:**
- **Development**: No optimization (-O0), debug symbols (-g), debug files (-n)
- **Release**: Full optimization (-Os -Oo -Oi -Op -Oz), no debug overhead

**Optimization Flags Explained:**
- **-Os**: Optimize for size (primary goal)
- **-Oo**: Code outlining (extract repeated code sequences)
- **-Oi**: Auto inline small functions
- **-Op**: Optimize constant parameters
- **-Oz**: Auto zero page placement for global variables

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
- **Room System**: Up to 20 rooms on 4×4 placement grid (48 bytes each with cached center coordinates and wall counters)
- **Configuration System**: Pre-generation joystick menu for dynamic parameter selection
- **Memory Usage**: Static allocation with maximum-sized buffers, runtime bounds checking
- **Display**: Character-mode rendering with custom tiles (40×25 viewport, optimized partial scrolling)
- **Connection Management**: Single source of truth prevents data inconsistency
  - `wall_door_count[4]` provides instant O(1) wall state queries (replaces iterative checks)
  - Automatic branching flag updates during connection creation
  - Optimized metadata: wall_side storage instead of redundant coordinates
- **String Optimization**: Packed string table with offset indexing
- **Bit Offset Calculation**: Dynamic `y * map_width * 3` formula ensures correct tile access across all map sizes

### Generation Algorithm
1. **Room Placement**: Fisher-Yates shuffle on 4×4 grid with immediate wall construction
2. **Connection**: Minimum spanning tree for corridor generation with walls built during creation
3. **Secret Rooms**: Single-connection rooms converted to secret areas
4. **Secret Treasures**: Hidden treasure chambers placed on walls without doors (excludes secret rooms, max 1 per room)
5. **False Corridors**: Dead-end corridors from room wall centers (configurable count, straight/L-shaped/Z-shaped, 2 tile margin)
6. **Hidden Corridors**: Non-branching corridor doors randomly converted to secret doors (configurable count, identified via branching flags)
7. **Stair Placement**: Distance-based optimal placement - up/down stairs placed in room centers with maximum separation

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
- **Static inline optimizations** - Hot path functions use `static inline` in headers
  - `get_room_center_ptr_inline()` - Room pointer center access
  - `get_room_center_x_inline()`, `get_room_center_y_inline()` - Room ID center access
  - `get_grid_cell_width()`, `get_grid_cell_height()` - Grid cell calculation
  - `abs_diff_inline()` - Arithmetic helpers
  - `calculate_y_bit_offset()` - Dynamic Y offset calculation for tile access
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

// =============================================================================
// FEATURE GENERATION SYSTEMS (Unified Architecture)
// =============================================================================
// All feature systems follow the same pattern:
// - create_FEATURE(): Creates single instance (static, internal)
// - place_FEATURES(): Placement controller (public API)

// Shared helper functions (in connection_system.c)
// - is_non_branching_corridor: Checks if corridor between two rooms has no branches
//   - Used by both secret rooms and hidden corridors for eligibility checking
//   - Validates: not secret room, not already secret door, not branching (is_branching flag)
unsigned char is_non_branching_corridor(unsigned char room1, unsigned char room2);

// Wall validation utilities (in mapgen_utils.c)
// - get_wall_side_from_exit: Determines which wall side a door/exit is on
unsigned char get_wall_side_from_exit(unsigned char room_idx, unsigned char exit_x, unsigned char exit_y);

// Secret Room System (in connection_system.c)
// - create_secret_room: Creates single secret room from single-connection room (static)
//   - Eligibility: exactly 1 connection, non-branching, 50% random chance
//   - Reuses is_non_branching_corridor() for validation
//   - Converts normal room door to secret door (TILE_SECRET_DOOR), marks as secret
// - place_secret_rooms: Main placement controller
//   - Iterates through rooms, attempts to create N secret rooms
void place_secret_rooms(unsigned char room_count_target);

// Secret Treasure System (in connection_system.c)
// - create_secret_treasure: Creates single treasure chamber for a room (static)
//   - Eligibility: not secret room, no existing treasure, wall without doors
//   - Validates treasure chamber + walls stay ≥3 tiles from map edges (3×3 boundary check)
//   - Places secret door (TILE_SECRET_DOOR) in wall, TILE_FLOOR in chamber, surrounds with walls
// - place_secret_treasures: Main placement controller
//   - Random room selection with retry logic, creates N treasures
void place_secret_treasures(unsigned char treasure_count);

// False Corridor System (in connection_system.c)
// - create_false_corridor: Creates single dead-end corridor from room wall (static)
//   - Algorithm (wall-first approach):
//     1. Select wall_side (0=left, 1=right, 2=top, 3=bottom) without doors
//     2. Calculate door position on wall center
//     3. Generate endpoint AWAY from door based on wall_side:
//        - Left wall (0): endpoint LEFT of door (negative X direction)
//        - Right wall (1): endpoint RIGHT of door (positive X direction)
//        - Top wall (2): endpoint UP from door (negative Y direction)
//        - Bottom wall (3): endpoint DOWN from door (positive Y direction)
//     4. Add perpendicular random offset for L-shaped corridors
//     5. Use same corridor drawing logic as normal connections
//   - Guarantees corridors move away from walls, never along them
// - place_false_corridors: Main placement controller
//   - Random room/wall selection with retry logic, creates N false corridors
void place_false_corridors(unsigned char corridor_count);

// Hidden Corridor System (in connection_system.c)
// - create_hidden_corridor: Creates single hidden corridor between two rooms (static)
//   - Eligibility: uses is_non_branching_corridor() validation
//   - Converts both door tiles to secret doors (TILE_SECRET_DOOR), marks metadata as secret
// - place_hidden_corridors: Main placement controller
//   - Builds candidate list of all non-branching corridors
//   - Random selection from candidates with retry logic, hides N corridors
void place_hidden_corridors(unsigned char corridor_count);

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
// Room structure (48 bytes total, optimized with wall counters)
typedef struct {
    // Most frequently accessed during generation (ordered by access frequency)
    unsigned char x, y, w, h;              // Room position and size (4 bytes)
    unsigned char center_x, center_y;      // Cached room center (2 bytes) - calculated as x+(w-1)/2, y+(h-1)/2
    unsigned char connections;             // Number of active connections (1 byte)
    unsigned char state;                   // Room state flags (ROOM_SECRET=0x01, ROOM_HAS_TREASURE=0x02, ROOM_HAS_FALSE_CORRIDOR=0x04) (1 byte)

    // Wall door counters (4 bytes) - instant O(1) wall queries for optimization
    // Index: 0=left, 1=right, 2=top, 3=bottom
    unsigned char wall_door_count[4];      // Door count per wall (normal + false corridors)

    // Packed connection metadata (4 bytes)
    PackedConnection conn_data[4];         // Connection info (room_id, corridor_type)

    // Door metadata (12 bytes)
    Door doors[4];                         // Door positions

    // Corridor breakpoint metadata (16 bytes)
    CorridorBreakpoint breakpoints[4][2];  // Corridor turn points

    // Secret treasure metadata (1 byte) - wall side only (coordinates calculated on-demand)
    unsigned char treasure_wall_side;      // Wall side (0-3) or 255=no treasure

    // False corridor metadata (3 bytes) - wall side + endpoint coordinates
    unsigned char false_corridor_wall_side; // Wall side (0-3) or 255=no false corridor
    unsigned char false_corridor_end_x;     // False corridor end X coordinate
    unsigned char false_corridor_end_y;     // False corridor end Y coordinate
} Room; // 48 bytes total (+2 bytes for wall_door_count optimization, -2 bytes from coordinate removal)

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