# Hacked C64 - Procedural Dungeon Generator

A real-time procedural dungeon generator for the Commodore 64, built with OSCAR64 cross-compiler.

## Project Overview

This program implements real-time procedural dungeon generation on Commodore 64 hardware. The system generates connected room networks using minimum spanning tree algorithms, features secret room mechanics, and provides interactive navigation with optimized memory usage.

## Screenshots

Final dungeon map:

<img width="1422" height="1072" alt="image" src="https://github.com/user-attachments/assets/2e2f7c23-ab12-4c35-9b7f-206c04f1a4e3" />

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
- Note: Launch script `run_vice.bat` depends on this location

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
   ├── build-release.bat
   ├── build-dev.bat
   └── run_vice.bat
   ```

4. **Build the project**:
   - `build-release.bat` - Optimized production build for smaller executable size
   - `build-dev.bat` - Development build with debug information and analysis files
5. **Launch emulator**: Execute `run_vice.bat`

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
| **M** | Export map to disk |

### Configuration Menu (Joystick 2)

| Control | Action |
|---------|---------|
| **Up/Down** | Navigate menu options |
| **Left/Right** | Adjust values (Small/Medium/Large) |
| **Fire Button** | Start generation with current settings |

## Map Elements

| Symbol | Element | Description |
|--------|---------|-------------|
| (space) | Empty | Background area |
| █ | Wall | Solid barrier |
| . | Floor | Walkable room area |
| + | Door | Room entrance/exit |
| ░ | Secret Door | Secret door (hidden entrance, treasure, corridor) |
| < | Up Stairs | Level exit up |
| > | Down Stairs | Level exit down |

## Features

- **Pre-Generation Configuration**: Customize map parameters before generation (map size, room count, secret features)
- **Real-time Procedural Generation**: Grid-based room placement with MST connectivity ensures all rooms are reachable
- **Joystick Control**: Full joystick 2 support with diagonal movement and intuitive menu navigation
- **Interactive Navigation**: Explore generated dungeons with responsive joystick control and 40×25 viewport
- **Dynamic Map Sizing**: Runtime selection of map dimensions (48×48, 64×64, or 80×80) with single optimized buffer
- **Configurable Parameters**:
  - Map Size (Small: 48×48, Medium: 64×64, Large: 80×80)
  - Room Count (Small: 8, Medium: 12, Large: 16)
  - Secret Rooms (10%/20%/30% of max rooms)
  - False Corridors (3/5/8)
  - Secret Treasures (2/4/6)
  - Hidden Corridors (1/2/3) - Non-branching corridor doors converted to secret doors
- **Secret Rooms**: Hidden areas accessible through secret doors (configurable percentage of single-connection rooms)
- **Secret Treasures**: Hidden treasure chambers placed only on walls without doors or false corridor entrances
- **False Corridors**: Misleading dead-end passages validated by a two-pass corridor walker; doors are wall-specific and never share a wall with treasure alcoves
- **Hidden Corridors**: Non-branching corridor doors between rooms are randomly converted to secret doors, obscuring direct paths and increasing navigation difficulty
- **Three Corridor Types**: Straight, L-shaped, and Z-shaped connections with geometric validation
- **Map Export**: Save generated maps to disk in binary format
- **Memory Optimized**: 3-bit tile encoding and packed data structures for C64 constraints
- **Progress Display**: Real-time generation progress with phase indicators

## Technical Specifications

### Platform Requirements

- **Platform**: Commodore 64 (6502 processor, 64KB RAM)
- **Compiler**: OSCAR64 cross-compiler with C64-specific optimizations
- **Storage**: VICE emulator or real C64 with disk drive

### Map Specifications

- **Map Size**: Dynamically configurable (48×48, 64×64, or 80×80) with 40×25 viewport
- **Room Count**: Up to 20 rooms (4×4 to 8×8 tiles each)
- **Storage**: 3-bit tile encoding with runtime calculated offsets
  - 48×48 map: 864 bytes
  - 64×64 map: 1536 bytes
  - 80×80 map: 2400 bytes (max buffer size)

### Performance

- **Generation Time**: ~2-5 seconds on C64 hardware (varies by map size and configuration)
- **Executable Size**: Release build optimized for size (significantly smaller than development build)
- **Memory Management**: Static allocation with maximum-sized buffers, runtime bounds checking
- **Map Storage**: 2400 bytes max buffer (handles all map sizes: 48×48=864, 64×64=1536, 80×80=2400)
- **Room Data**: 48 bytes per room (optimized packed structures with center cache)
- **Scrolling**: Optimized partial screen updates with no slowdown at map boundaries
- **Debug Information**: Development builds include .map, .asm, .lbl, .dbj files for analysis

## Generation Process

### Configuration Phase (Joystick 2)

Before generation, configure map parameters using joystick 2:
- Navigate options with Up/Down
- Adjust values (Small/Medium/Large) with Left/Right
- Confirm with Fire Button

### Generation Phase

The dungeon is generated in real-time with a progress bar showing each phase:

1. **Building Rooms**: Creates rooms of various sizes across the map
2. **Connecting Rooms**: Links all rooms together with corridors so every area is reachable
3. **Creating Secret Areas**: Converts some isolated rooms into hidden secret areas
4. **Placing Secret Treasures**: Adds hidden treasure chambers accessible through secret doors
5. **Placing False Corridors**: Creates dead-end passages to add exploration challenge
6. **Hiding Corridors**: Randomly converts non-branching corridor doors to secret doors to obscure navigation routes
7. **Placing Stairs**: Positions up and down stairs for level navigation
8. **Finalizing**: Prepares the map for exploration

The number of rooms, secret areas, treasures, false corridors, and hidden corridors varies based on your configuration settings.

## Documentation

For detailed technical information, see:

- **[Project Specification](docs/project-specification.md)** - Complete technical specification including algorithms, data structures, and implementation details

- **[Oscar64 Development Reference](docs/oscar64-c64-development-reference.md)** - Comprehensive guide for C64 development using Oscar64 compiler

- **[Changelog](CHANGELOG.md)** - Version history and feature updates
