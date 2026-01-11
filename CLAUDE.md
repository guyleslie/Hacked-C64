# CLAUDE.md

This file provides guidance to Claude Code when working with code in this repository.

## Project Overview

This is a Commodore 64 dungeon crawler game built with the OSCAR64 cross-compiler. Currently implements a real-time procedural dungeon map generator with room placement, corridors, secret areas, and interactive navigation on C64 hardware.

**Current Phase:** Map Generation Complete → Transitioning to Full Game
**Target Platform:** Commodore 64 (6502 processor, 64KB RAM)
**Compiler:** OSCAR64 cross-compiler
**Language:** C with C64-specific optimizations
**Memory Model:** Static allocation only, 3-bit tile encoding
**Display:** 40×25 character viewport on dynamic map sizes (48×48, 64×64, 80×80)

## Quick Start

**Build:**
```bash
build-mapgen-test.bat     # Mapgen TEST build (DEBUG_MAPGEN enabled, ~12KB)
build-mapgen-release.bat  # Mapgen RELEASE build (Production API, ~8.2KB)
```

**Run:**
Load the generated `.prg` file from `build/` directory in VICE emulator or on real C64 hardware.

**Export Map (DEBUG mode only):**
- Press **'M'** key during navigation to save map as "MAPBIN" file

**Build Verification:**
- Mapgen Test: Check for `build/Hacked C64-mapgen-test.prg` (~12KB, with menu/preview/export)
- Mapgen Release: Check for `build/Hacked C64-mapgen-release.prg` (~8.2KB, API only)

## Module Map

### Current Implementation

All source files are in `main/src/`:

**Main Entry:**
- `main.c` - Entry point, VIC-II setup, DEBUG/production mode split, includes ALL mapgen modules (OSCAR64 requirement)

**Character Generation** (`main/src/chargen/`):
- `chargen.c` - Player character creation, stats assignment, inventory setup

**Map Generation Modules** (`main/src/mapgen/`):
- `mapgen_api.h` - Public interface: `mapgen_generate_dungeon()` (DEBUG), `mapgen_generate_with_params()` (Production)
- `mapgen_types.h` - Core data structures and constants (Room, PackedConnection, Door)
- `mapgen_internal.h` - Internal module definitions
- `mapgen_config.c/.h` - Shared configuration: structs, presets, validate_and_adjust_config() (BOTH modes)
- `mapgen_debug.c/.h` - DEBUG mode: menu, defaults, navigation loop, all UI helpers - **DEBUG only**
- `map_generation.c` - Generation pipeline controller (8 phases: 0-7)
- `room_management.c` - Room placement algorithms (Fisher-Yates on 4×4 grid)
- `connection_system.c` - MST corridors, secret rooms, treasures, false/hidden corridors
- `mapgen_display.c/.h` - Viewport rendering and camera system - **DEBUG only**
- `mapgen_utils.c/.h` - Utility functions, math operations, progress bar, static inline helpers
- `map_export.c/.h` - File I/O, PRG format export - **DEBUG only**
- `tmea_types.h` - TMEA type definitions and flag enums
- `tmea_core.h` - TMEA API declarations
- `tmea_core.c` - TMEA implementation (metadata pools, entity management)

### Planned Implementation

See `docs/project development plan.txt` for full roadmap. Key upcoming modules:

**Intro Module** (`src/intro/` - Phase 1):
- Title screen with C64-style scrolling credits
- SID music initialization and playback
- Logo/thematic art display
- Key press handling to proceed to main menu

**Main Menu Module** (`src/chargen/` extension - Phase 1):
- **Quick Game:** Random dungeon floors, high-score focused, no save/load
- **Start New Quest:** Full character generation, 12-level structured dungeon, save enabled
- **Load Quest:** Restore saved character/progress from disk

**Game Engine Module** (`src/game/` - Phase 2-3):
- **Level Initialization:** Load static maps, populate dynamic elements (enemies, items, traps, stairs)
- **2×2 Autotile System:** Efficient tile rendering for C64 character mode
- **HUD:** HP, MP, XP, current level, score, optional minimap
- **Mechanics:** Movement, turn-based combat, interaction (doors, items, stairs)
- **State Management:** Update game state after each player/NPC turn
- **Quest Quest:** Quest Item on Level 12, win by returning to Level 1
- **Save/Load:** Quest progress persistence

## Documentation Guide

For detailed information, consult these documents:

| Topic | Document | What It Contains |
|-------|----------|------------------|
| **Algorithms & Technical Spec** | `docs/project-specification.md` | Complete technical algorithms, data structures, 8-phase generation pipeline details |
| **DEBUG/Production Split** | `docs/MAPGEN_DEBUG_PRODUCTION_SPLIT.md` | DEBUG vs Production mode architecture, API usage, build configuration, memory persistence |
| **TMEA Architecture** | `docs/TMEA.md` | Full TMEA documentation (1710 lines): API reference, flag enums, performance analysis, usage examples |
| **Development Roadmap** | `docs/project development plan.txt` | Phase-by-phase plan for full dungeon crawler implementation (Intro, Menu, Game Engine) |
| **User Guide** | `README.md` | Setup instructions, controls, screenshots, user-facing documentation |
| **Build System** | `build-mapgen-test.bat`, `build-mapgen-release.bat` | Run directly - no need to memorize compiler flags |

## Code Style & Conventions

### C64-Specific Patterns
- Use `unsigned char` for all coordinates, counters, and tile types (8-bit arithmetic)
- Static allocation ONLY - no `malloc`/`free` (limited heap)
- Optimize for 6502: prefer 8-bit over 16-bit operations
- OSCAR64 requirement: include all `.c` files in `main.c` (no separate compilation)

### Function Naming
- Use `snake_case`: `place_walls_around_room()`, `calculate_room_distance()`
- Prefix with module: `mapgen_`, `room_`, `connection_`, `chargen_`, `game_`
- Keep names descriptive but concise

### Memory Management
- Static allocation with maximum-sized buffers
- 3-bit tile encoding in packed arrays (`compact_map`)
- Runtime bounds checking via `current_params.map_width/height`
- Dynamic bit offset calculation: `calculate_y_bit_offset()` computes `y * map_width * 3`
- Use `__zeropage` annotation for frequently accessed variables
- Static inline functions for hot paths (see `mapgen_utils.h`, `mapgen_internal.h`)

### OSCAR64 Include Pattern
All `.c` files must be included in `main.c` for linking:
```c
#include "mapgen/tmea_core.c"         // TMEA system (must be first)
#include "mapgen/mapgen_config.c"
#include "mapgen/mapgen_utils.c"
#include "mapgen/map_generation.c"
#include "mapgen/room_management.c"
#include "mapgen/connection_system.c"

#ifdef DEBUG_MAPGEN
#include "mapgen/mapgen_display.c"    // DEBUG only: viewport, navigation
#include "mapgen/map_export.c"        // DEBUG only: file export
#endif
```

## Key Patterns

### TMEA-First Architecture

**TMEA (Tile Metadata Extension Architecture)** is a lightweight metadata system providing:
- Extra information for map tiles (walls, doors, floors)
- Dynamic entity management (objects, monsters)
- 765 bytes total (~1.2% of C64 RAM)
- Hybrid room/global metadata pools
- See `docs/TMEA.md` for complete API reference and usage examples

**Critical:** TMEA must be initialized first (`init_tmea_system()`) and `tmea_core.c` must be included before other modules.

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

**Core Pipeline (8 Phases - see `docs/project-specification.md` for details):**

**Phase 0:** Building Rooms - Fisher-Yates shuffle on 4×4 grid
**Phase 1:** Connecting Rooms - Minimum spanning tree connections
**Phase 2:** Secret Areas - Single-connection rooms (percentage-based)
**Phase 3:** Secret Treasures - Hidden chambers (percentage of non-secret rooms)
**Phase 4:** False Corridors - Dead-end corridors (percentage of available walls)
**Phase 5:** Hidden Corridors - Non-branching corridors made secret
**Phase 6:** Placing Stairs - Distance-based optimal placement
**Phase 7:** Generation Complete - All map data ready in memory

**Post-Generation (DEBUG only):**
- Camera initialization for interactive map preview
- Map viewport rendering for navigation

**Percentage System:** All features use 10%/25%/50% ratios for Small/Medium/Large.

**Production API:**
```c
unsigned char mapgen_generate_with_params(
    unsigned char map_size,        // 0=SMALL, 1=MEDIUM, 2=LARGE
    unsigned char room_count,      // 0=SMALL, 1=MEDIUM, 2=LARGE
    unsigned char room_size,       // Reserved for future use
    unsigned char secret_rooms,    // 0=10%, 1=25%, 2=50%
    unsigned char false_corridors, // 0=10%, 1=25%, 2=50%
    unsigned char secret_treasures,// 0=10%, 1=25%, 2=50%
    unsigned char hidden_corridors // 0=10%, 1=25%, 2=50%
);
// Returns: 0=success, 1=invalid params, 2=generation failed
```

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

### Input Handling Pattern

**Joystick 2 (Primary):** Direct CIA1 Port A ($DC00) access, active-low bit mapping
```c
unsigned char joy2 = cia1.pra;
// Bit 0=UP, 1=DOWN, 2=LEFT, 3=RIGHT, 4=FIRE
if (!(joy2 & 0x10)) { /* FIRE pressed */ }
```

**Keyboard (Secondary):** `getchx()` for essential commands
```c
unsigned char key = getchx();
if (key == 'Q' || key == 'q') { /* quit */ }
```

**Debouncing:** Configuration menu uses debounce logic to prevent repeated inputs.

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

## Development Roadmap

See `docs/project development plan.txt` for complete details.

**Phase 1: Foundation (Current + Intro/Menu)**
- ✓ Complete mapgen module (DONE)
- ✓ Complete chargen module (DONE)
- ⏳ Implement `src/intro` module (Title screen, music)
- ⏳ Integrate Main Menu logic (Quick Game, Quest, Load)
- ⏳ Develop Save/Load routine for Quest data

**Phase 2: Core Gameplay Loop (Game Module)**
- ⏳ Implement `src/game` module skeleton
- ⏳ Establish 2×2 Autotile rendering system
- ⏳ Basic player movement and level transitions
- ⏳ Placeholder graphics for tiles, items, enemies

**Phase 3: Features and Polish**
- ⏳ Full Quest and Quick Game logic
- ⏳ Combat Mechanics (damage, enemy AI)
- ⏳ Inventory management and item usage
- ⏳ Sound effects and music
- ⏳ Win/Game Over conditions and High Score screen

**Game Modes:**
- **Quick Game:** Procedural random floors, high-score focused, no save/load
- **Quest:** 12-level structured dungeon, Quest Item on Level 12, must return to Level 1 to win, save/load enabled

## Testing & Verification

**Build Verification:**
- Development build produces `.prg`, `.map`, `.asm`, `.lbl`, `.dbj` files
- Release build produces optimized `.prg` only
- Check `build/` directory for output files

**VICE Emulator Testing:**
- Launch VICE and load the generated `.prg` file from `build/` directory
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
- **OSCAR64 include pattern** - All `.c` files must be included in `main.c`
- **Development plan** - Follow `docs/project development plan.txt` for structured feature implementation
- **DEBUG vs Production** - Use `#ifdef DEBUG_MAPGEN` for UI components (menu, display, export)
- **8 phases** - Core generation pipeline has 8 phases (0-7), camera init is DEBUG-only post-processing
- **Memory persistence** - After generation, `compact_map[]`, `room_list[]`, `room_count`, `current_params`, and TMEA pools remain in memory
