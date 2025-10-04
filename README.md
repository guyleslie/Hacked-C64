# Hacked C64 - Procedural Dungeon Generator

A real-time procedural dungeon generator for the Commodore 64, built with OSCAR64 cross-compiler.

## Project Overview

This program implements real-time procedural dungeon generation on Commodore 64 hardware. The system generates connected room networks using minimum spanning tree algorithms, features secret room mechanics, and provides interactive navigation with optimized memory usage.

## Screenshots

Generation progress display:

<img width="1425" height="1074" alt="image" src="https://github.com/user-attachments/assets/ac772bbf-b4da-40a8-8805-424325d687d2" />

Final dungeon map:

<img width="1423" height="1072" alt="image" src="https://github.com/user-attachments/assets/c0d031b5-9433-4ecf-9b4d-a50ddce54899" />

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

| Key | Action |
|-----|---------|
| **W/A/S/D** | Navigate map (continuous scrolling) |
| **SPACE** | Generate new dungeon |
| **M** | Export map to disk |
| **Q** | Quit program |

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

- **Real-time Procedural Generation**: Grid-based room placement with MST connectivity ensures all rooms are reachable
- **Interactive Navigation**: Explore generated dungeons with continuous WASD scrolling and 40×25 viewport
- **Secret Rooms**: Hidden areas accessible through secret passages (50% chance for single-connection rooms)
- **Secret Treasures**: Hidden treasure chambers placed on walls without doors (3 per map)
- **False Corridors**: Misleading dead-end passages from room walls (2 per map, Nethack-style)
- **Three Corridor Types**: Straight, L-shaped, and Z-shaped connections with geometric validation
- **Map Export**: Save generated maps to disk in binary format
- **Memory Optimized**: 3-bit tile encoding and packed data structures for C64 constraints
- **Progress Display**: Real-time generation progress with phase indicators
- **CIA Keyboard Matrix**: Direct hardware access for responsive continuous movement

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
- **Room Data**: 46 bytes per room (optimized packed structures with false corridor metadata)
- **Debug Information**: Development builds include .map, .asm, .lbl, .dbj files for analysis

## Generation Process

The generation process displays real-time progress with a centered progress bar and phase indicators:

1. **Building Rooms**: Grid-based placement on 4×4 layout with Fisher-Yates shuffle, immediate wall construction
2. **Connecting Rooms**: Minimum Spanning Tree algorithm ensures all rooms are reachable with optimal corridor placement
3. **Creating Secret Areas**: Single-connection rooms converted to secret areas (50% probability)
4. **Placing Secret Treasures**: Hidden treasure chambers placed on walls without doors (3 treasures per map)
5. **Placing False Corridors**: Misleading dead-end passages from room wall centers (2 per map, straight/L-shaped)
6. **Placing Stairs**: Priority-based stair placement in room centers for level navigation
7. **Finalizing**: Camera initialization and viewport setup for interactive exploration

## Documentation

For detailed technical information, see:

- **[Project Specification](docs/project-specification.md)** - Complete technical specification including algorithms, data structures, and implementation details

- **[Oscar64 Development Reference](docs/oscar64-c64-development-reference.md)** - Comprehensive guide for C64 development using Oscar64 compiler
