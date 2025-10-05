# Hacked C64 - Procedural Dungeon Generator

A real-time procedural dungeon generator for the Commodore 64, built with OSCAR64 cross-compiler.

## Project Overview

This program implements real-time procedural dungeon generation on Commodore 64 hardware. The system generates connected room networks using minimum spanning tree algorithms, features secret room mechanics, and provides interactive navigation with optimized memory usage.

## Screenshots

Generation progress display:

<img width="1425" height="1074" alt="image" src="https://github.com/user-attachments/assets/ac772bbf-b4da-40a8-8805-424325d687d2" />

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
| ░ | Secret Path | Hidden passage/treasure chamber |
| < | Up Stairs | Level exit up |
| > | Down Stairs | Level exit down |

## Features

- **Pre-Generation Configuration**: Customize map parameters before generation (map size, room count, secret features)
- **Real-time Procedural Generation**: Grid-based room placement with MST connectivity ensures all rooms are reachable
- **Joystick Control**: Full joystick 2 support with diagonal movement and intuitive menu navigation
- **Interactive Navigation**: Explore generated dungeons with responsive joystick control and 40×25 viewport
- **Configurable Parameters**:
  - Map Size (Small: 48×48, Medium: 72×72, Large: 96×96)
  - Room Count (Small: 8, Medium: 12, Large: 16)
  - Secret Rooms (10%/20%/30% of max rooms)
  - False Corridors (3/5/8)
  - Secret Treasures (2/4/6)
- **Secret Rooms**: Hidden areas accessible through secret passages (configurable percentage of single-connection rooms)
- **Secret Treasures**: Hidden treasure chambers placed only on walls without doors or false corridor entrances
- **False Corridors**: Misleading dead-end passages validated by a two-pass corridor walker; doors are wall-specific and never share a wall with treasure alcoves
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

- **Map Size**: 72×72 tiles with 40×25 viewport
- **Room Count**: Up to 20 rooms (4×4 to 8×8 tiles each)
- **Storage**: 3-bit tile encoding in 3888 bytes

### Performance

- **Generation Time**: ~3-4 seconds on C64 hardware
- **Executable Size**: Release build optimized for size (significantly smaller than development build)
- **Memory Management**: Static allocation only, no dynamic memory allocation
- **Map Storage**: 3888 bytes (3-bit packed tile encoding for 72×72 map)
- **Room Data**: 48 bytes per room (optimized packed structures with center cache)
- **Debug Information**: Development builds include .map, .asm, .lbl, .dbj files for analysis

## Generation Process

### Configuration Phase (Joystick 2)

Before generation, configure map parameters using joystick 2:
- Navigate options with Up/Down
- Adjust values (Small/Medium/Large) with Left/Right
- Confirm with Fire Button

### Generation Phase

The generation process displays real-time progress with a centered progress bar and phase indicators. Progress calculation is dynamic, automatically scaling to the actual work done based on configuration parameters (room count, secret rooms, treasures, etc.):

1. **Building Rooms**: Grid-based placement on 4×4 layout with Fisher-Yates shuffle, immediate wall construction (count varies by configuration)
2. **Connecting Rooms**: Minimum Spanning Tree algorithm ensures all rooms are reachable with optimal corridor placement
3. **Creating Secret Areas**: Single-connection rooms converted to secret areas (percentage based on configuration)
4. **Placing Secret Treasures**: Hidden treasure chambers placed only on walls without doors or false corridor entrances (count varies by configuration)
5. **Placing False Corridors**: Walker-driven straight/L/Z paths with per-wall door selection; treasure-bearing walls and existing doors are skipped (count varies by configuration)
6. **Placing Stairs**: Priority-based stair placement in room centers for level navigation
7. **Finalizing**: Camera initialization and viewport setup for interactive exploration

## Documentation

For detailed technical information, see:

- **[Project Specification](docs/project-specification.md)** - Complete technical specification including algorithms, data structures, and implementation details

- **[Oscar64 Development Reference](docs/oscar64-c64-development-reference.md)** - Comprehensive guide for C64 development using Oscar64 compiler
