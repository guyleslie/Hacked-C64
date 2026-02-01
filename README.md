# Hacked C64 - Procedural Dungeon Generator

A real-time procedural dungeon generator for the Commodore 64, built with OSCAR64 cross-compiler.

## Project Overview

This program implements real-time procedural dungeon generation on Commodore 64 hardware. The system generates connected room networks using minimum spanning tree algorithms, features secret room mechanics, and provides interactive navigation with optimized memory usage.

## Preview

https://github.com/user-attachments/assets/71c162a2-0b6b-44cd-8bd1-9ca859f877c9

## Setup and Installation

### Prerequisites

⚠️ **IMPORTANT**: Both tools must be installed in the project's work directory for compilation and emulation to work properly.

**OSCAR64 Compiler** (Required for compilation)

- Download: [OSCAR64 Releases](https://github.com/drmortalwombat/oscar64/releases)
- Installation: Extract to `oscar64/` directory in the project root
- Required path: `oscar64/bin/oscar64.exe`
- Note: Build scripts expect the compiler at this exact location

**VICE C64 Emulator** (Required for testing and running)

- Download: [VICE Emulator](https://vice-emu.sourceforge.io/)
- Installation: Extract to `vice/` directory in the project root
- Required path: `vice/bin/x64sc.exe`
- Note: Program can be run on VICE emulator or real C64 hardware

### Build and Run

1. **Clone or download** the project source code

2. **Install prerequisites** in the project directory:
   - Extract OSCAR64 to `oscar64/` folder
   - Extract VICE emulator to `vice/` folder

3. **Verify directory structure**:

   ```
   Project Root/
   ├── oscar64/bin/oscar64.exe    (required for compilation)
   ├── vice/bin/x64sc.exe         (required for emulation)
   ├── main/src/                  (source code directory)
   │   ├── main.c
   │   └── mapgen/                (map generation modules)
   ├── build-mapgen-test.bat     (DEBUG mode with menu/preview)
   └── build-mapgen-release.bat  (Production API mode)
   ```

4. **Build the project**:
   - `build-mapgen-test.bat` - **TEST build**: Interactive menu, map preview, navigation, progress bar, export
   - `build-mapgen-release.bat` - **RELEASE build**: Pure API, no UI - generates map data for other modules

5. **Launch emulator**: Start VICE emulator and load the generated `.prg` file from the `build/` directory

### Build Modes

| Build | Features |
|-------|----------|
| **TEST** | Menu, progress bar, map preview, joystick navigation, export |
| **RELEASE** | Pure API only - generates map, no UI, for game engine integration |

> **Note:** All user-facing features (controls, menu, progress bar) are only available in TEST build.

## Controls

### Joystick 2 (Primary Control)

| Control | Action |
|---------|---------|
| **Joystick Directions** | Navigate map (supports diagonal movement) |
| **Fire Button** | Open configuration menu / Generate new dungeon |

### Keyboard (Secondary)

| Key | Action |
|-----|---------|
| **Q** | Quit program |
| **M** | Save map seed to disk |
| **L** | Load map seed from disk |

### Configuration Menu (Joystick 2)

| Control | Action |
|---------|---------|
| **Up/Down** | Navigate menu options (5 items including seed) |
| **Left/Right** | Adjust values |
| **Fire Button** | Start generation / Enter seed input mode |

**Menu Display Values:**
- Map Size: small (9 rooms), medium (16 rooms), large (20 rooms)
- Hidden Rooms, Niches, Deception: 10%, 25%, 50%
- Seed: 0-65535 (0 = random, press FIRE to enter number)

## Map Elements

| Symbol | Element | Description |
|--------|---------|-------------|
| (space) | Empty | Background area |
| █ | Wall | Solid barrier |
| . | Floor | Walkable room area |
| + | Door | Room entrance/exit |
| ░ | Secret Door | Hidden entrance (to hidden room, niche, or passage) |
| < | Up Stairs | Level exit up |
| > | Down Stairs | Level exit down |

## Features

- **Pre-Generation Configuration**: Customize map parameters before generation (map size with automatic room count, secret feature percentages)
- **Real-time Procedural Generation**: Grid-based room placement with MST connectivity ensures all rooms are reachable
- **Joystick Control**: Full joystick 2 support with diagonal movement and intuitive menu navigation
- **Interactive Navigation**: Explore generated dungeons with responsive joystick control and 40×25 viewport
- **Dynamic Map Sizing**: Runtime selection of map dimensions with automatic room count
- **Configurable Parameters**:
  - Map Size: Small (50×50, 9 rooms), Medium (64×64, 16 rooms), Large (78×78, 20 rooms)
  - Hidden Rooms (10%/25%/50% of single-connection rooms)
  - Niches (10%/25%/50% of non-hidden rooms)
  - Deception (10%/25%/50% - controls both decoy corridors and hidden passages)
- **Hidden Rooms**: Rooms accessible only through secret doors (converted from single-connection rooms)
- **Niches**: 1-tile hidden spaces in walls behind secret doors (can contain treasure, traps, enemies)
- **Decoy Corridors**: Dead-end passages that mislead the player
- **Hidden Passages**: Real corridors with one secret door (count matches decoy count for balance)
- **Three Corridor Types**: Straight, L-shaped, and Z-shaped connections with geometric validation
- **Map Save/Load**: Save and load map seed and configuration to/from disk (3 bytes - maps are reproducible from seed)
- **Memory Optimized**: 3-bit tile encoding and packed data structures for C64 constraints
- **Progress Display**: Real-time generation progress with phase indicators

## Technical Specifications

### Platform Requirements

- **Platform**: Commodore 64 (6502 processor, 64KB RAM)
- **Compiler**: OSCAR64 cross-compiler with C64-specific optimizations
- **Storage**: VICE emulator or real C64 with disk drive

### Map Specifications

- **Map Size**: 50×50, 64×64, or 78×78
- **Room Count**: Up to 20 rooms (4×4 to 8×8 tiles each)

### Performance

- **Generation Time**: Fast real-time generation on C64 hardware ( ~ 4 sec varies by map size and configuration)
- **Executable Size**: Release builds optimized for minimal size
- **Memory Management**: Static allocation with runtime bounds checking for efficient C64 memory usage
- **Map Storage**: 3-bit tile encoding with packed data structures for optimal memory efficiency
- **Room Data**: Compact structures with cached calculations for fast access
- **Scrolling**: Optimized viewport rendering with smooth navigation at all map boundaries

## Generation Process

### Configuration Phase (Joystick 2)

Before generation, configure map parameters using joystick 2:
- Navigate options with Up/Down
- Adjust values (Small/Medium/Large) with Left/Right
- Confirm with Fire Button

### Generation Phase

The dungeon is generated in real-time with a progress bar showing each phase:

1. **Carving Chambers**: Creates rooms of various sizes across the map
2. **Digging Corridors**: Links all rooms together with corridors so every area is reachable
3. **Hiding Rooms**: Converts some isolated rooms into hidden areas (secret door entrance)
4. **Carving Niches**: Adds 1-tile hidden spaces in walls behind secret doors
5. **Laying Traps**: Creates decoy corridors (dead-ends) to mislead the player
6. **Concealing Doors**: Hides passage doors to obscure navigation routes
7. **Placing Stairs**: Positions up and down stairs for level navigation
8. **Generation Complete!**: Map is ready for exploration

The number of rooms, hidden areas, niches, and deception features varies based on your configuration settings.

## Documentation

For detailed technical information, see:

- **[Project Specification](docs/project-specification.md)** - Complete technical specification including algorithms, data structures, and implementation details

- **[Game Architecture Plan](docs/game-architecture-plan.md)** - High-level game design and architecture overview

- **[Oscar64 Development Reference](docs/oscar64-c64-development-reference.md)** - Comprehensive guide for C64 development using Oscar64 compiler

- **[TMEA: Tile Metadata Extension Architecture](docs/TMEA.md)** - Lightweight metadata system for tile features and dynamic entities (doors, traps, objects, monsters)

- **[Debug/Production Split](docs/mapgen-debug-production-split.md)** - Documentation of DEBUG vs RELEASE build configurations

- **[Changelog](CHANGELOG.md)** - Version history and feature updates
