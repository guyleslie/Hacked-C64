# CLAUDE.md

This file provides guidance to Claude Code when working with code in this repository.

## Project Overview

This is a Commodore 64 dungeon map generator built with the OSCAR64 cross-compiler. The project generates real-time procedural dungeons with room placement, corridors, secret areas, and interactive navigation on C64 hardware.

**Tech Stack:**
- **Platform**: Commodore 64 (6502 processor, 64KB RAM)
- **Compiler**: OSCAR64 cross-compiler
- **Language**: C with C64-specific optimizations
- **Memory Model**: Static allocation only, 3-bit tile encoding
- **Display**: 40×25 character viewport on dynamic map sizes (48×48, 64×64, 80×80)

## Quick Start

**Build:**
```bash
build-dev.bat      # Development build with debug info
build-release.bat  # Optimized production build
```

**Run:**
```bash
run_vice.bat       # Launch in VICE C64 emulator
```

**Export Map:**
- Press **'M'** key during navigation to save map as "MAPBIN" file

**Build Verification:**
- Development: Check for `build/Hacked C64-dev.prg` and `.map`, `.asm`, `.lbl` files
- Release: Check for `build/Hacked C64.prg` and `.map`, `.asm`, `.lbl` files

## Module Map

All source files are in `main/src/`:

**Main Entry:**
- `main.c` - Entry point, VIC-II setup, joystick input, includes ALL mapgen modules (OSCAR64 requirement)

**Core Mapgen Modules** (`main/src/mapgen/`):
- `mapgen_api.h` - Public interface for map operations
- `mapgen_types.h` - Core data structures and constants (Room, PackedConnection, Door)
- `mapgen_internal.h` - Internal module definitions
- `mapgen_config.c/.h` - Pre-generation joystick menu, presets (SMALL/MEDIUM/LARGE)
- `map_generation.c` - Generation pipeline controller
- `room_management.c` - Room placement algorithms (Fisher-Yates on 4×4 grid)
- `connection_system.c` - MST corridors, secret rooms, treasures, false/hidden corridors
- `mapgen_display.c/.h` - Viewport rendering and camera system
- `mapgen_utils.c/.h` - Utility functions, math operations, static inline helpers
- `map_export.c/.h` - File I/O, PRG format export
- `tmea_types.h` - TMEA type definitions and flag enums
- `tmea_core.h` - TMEA API declarations
- `tmea_core.c` - TMEA implementation (metadata pools, entity management)

## Documentation Guide

For detailed information, consult these documents:

| Topic | Document | What It Contains |
|-------|----------|------------------|
| **Algorithms & Technical Spec** | `docs/project-specification.md` | Complete technical algorithms, data structures, generation pipeline details |
| **TMEA Architecture** | `docs/TMEA.md` | Full TMEA documentation (1710 lines): API reference, flag enums, performance analysis, usage examples |
| **User Guide** | `README.md` | Setup instructions, controls, screenshots, user-facing documentation |
| **Build System** | `build-dev.bat`, `build-release.bat` | Run directly - no need to memorize compiler flags |

## Code Style & Conventions

### C64-Specific Patterns
- Use `unsigned char` for all coordinates, counters, and tile types (8-bit arithmetic)
- Static allocation ONLY - no `malloc`/`free` (limited heap)
- Optimize for 6502: prefer 8-bit over 16-bit operations
- OSCAR64 requirement: include all `.c` files in `main.c` (no separate compilation)

### Function Naming
- Use `snake_case`: `place_walls_around_room()`, `calculate_room_distance()`
- Prefix with module: `mapgen_`, `room_`, `connection_`
- Keep names descriptive but concise

### Memory Management
- Static allocation with maximum-sized buffers
- 3-bit tile encoding in packed arrays (`compact_map`)
- Runtime bounds checking via `current_params.map_width/height`
- Dynamic bit offset calculation: `calculate_y_bit_offset()` computes `y * map_width * 3`
- Use `__zeropage` annotation for frequently accessed variables
- Static inline functions for hot paths (see `mapgen_utils.h`, `mapgen_internal.h`)

## Key Patterns

### TMEA-First Architecture

**TMEA (Tile Metadata Extension Architecture)** is a lightweight metadata system which provides a way to attach extra information to map tiles (walls, doors, floors) and manage dynamic entities (objects, monsters) with minimal memory overhead.
- See `docs/TMEA.md` for complete API reference and usage examples

### Configuration System

**Presets:**
- `SMALL` (10%): 48×48 map, 8-12 rooms
- `MEDIUM` (25%): 64×64 map, 12-16 rooms
- `LARGE` (50%): 80×80 map, 16-20 rooms

**Data Flow:**
1. `MapConfig` (user-facing) - Selected via joystick menu
2. `MapParameters` (computed) - Calculated from MapConfig
3. Generation pipeline uses `current_params`

See `mapgen_config.h` for structure definitions.

### Generation Pipeline

High-level algorithm (see `docs/project-specification.md` for details):

1. Room Placement - Fisher-Yates shuffle on 4×4 grid
2. MST Corridors - Minimum spanning tree connections
3. Secret Rooms - Single-connection rooms (percentage-based)
4. Secret Treasures - Hidden chambers (percentage of non-secret rooms)
5. False Corridors - Dead-end corridors (percentage of available walls)
6. Hidden Corridors - Non-branching corridors made secret
7. Stair Placement - Distance-based optimal placement

**Percentage System:** All features use 10%/25%/50% ratios for Small/Medium/Large.

### Feature Generation Pattern

All feature systems follow unified architecture:

```c
// Internal creation function (static)
static unsigned char create_FEATURE(...);

// Public placement controller
void place_FEATURES(unsigned char count);
```

Examples in `connection_system.c`:
- `create_secret_room()` / `place_secret_rooms()`
- `create_secret_treasure()` / `place_secret_treasures()`
- `create_false_corridor()` / `place_false_corridors()`
- `create_hidden_corridor()` / `place_hidden_corridors()`

## Memory Architecture

**Map Storage:**
- Dynamic sizes: 48×48 (864 bytes), 64×64 (1536 bytes), 80×80 (2400 bytes)
- 3-bit tile encoding in `compact_map` array
- Runtime bounds checking for all sizes

**Room System:**
- Up to 20 rooms, 48 bytes each
- 4×4 placement grid
- Cached center coordinates for performance

**TMEA System:**
- 765 bytes total (~1.2% of C64 RAM)
- Hybrid room/global metadata pools
- See `docs/TMEA.md` for architecture details

**Runtime Counters:**
- 6-byte tracking system for percentage calculations
- Tracks connections, secret rooms, treasures, corridors, available walls
- Enables post-MST feature calculation without iteration

## Testing & Verification

**Build Verification:**
- Development build produces `.prg`, `.map`, `.asm`, `.lbl`, `.dbj` files
- Release build produces optimized `.prg` only
- Check `build/` directory for output files

**VICE Emulator Testing:**
- Run `run_vice.bat` to launch
- Test generation, navigation, export
- Verify performance and stability

**Build Output Analysis:**
- `build/Hacked C64.map` - Memory usage analysis
- `build/Hacked C64.asm` - 6502 assembly listing
- `build/Hacked C64.lbl` - VICE debugger labels
- Use for optimization verification and debugging

## Important Notes

- **Never use dynamic allocation** - C64 has limited heap
- **All coordinates are `unsigned char`** - 8-bit values only
- **Check documentation** - Don't duplicate info from `docs/` in code
- **TMEA is critical** - Must be included first, enables all metadata features
- **Static inline helpers** - Used for hot path performance (tile access, room queries)
