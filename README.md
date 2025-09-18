# Hacked C64 - Dungeon Map Generator

A dungeon map generator for the Commodore 64, built with Oscar64.

## Description

This program generates randomized dungeon layouts on the Commodore 64. Each map contains rooms connected by corridors, with stairs, doors, walls, and secret passages.

## Screenshots

Generation progress display:

<img width="1425" height="1074" alt="image" src="https://github.com/user-attachments/assets/ac772bbf-b4da-40a8-8805-424325d687d2" />

Final dungeon map:

<img width="1196" height="911" alt="image" src="https://github.com/user-attachments/assets/8a847c59-5f79-46b2-af68-b0306b6640bf" />

## How to Run

### Quick Start (Recommended)

1. Go to GitHub Actions tab and download the latest build artifact
2. Extract the zip file
3. Run `run_vice.bat`

### Manual Build

1. Download ZIP from GitHub Code button
2. Run `build.bat` to compile
3. Run `run_vice.bat` to launch in VICE emulator

**Requirements**: Oscar64 and VICE are not included, batch file paths need to be corrected

## Controls

| Key | Action |
|-----|---------|
| **W/A/S/D** | Navigate map |
| **SPACE** | Generate new dungeon |
| **M** | Export map to disk |

## Map Elements

| Symbol | Element | Description |
|--------|---------|-------------|
| (space) | Empty | Background area |
| █ | Wall | Solid barrier |
| . | Floor | Walkable path |
| + | Door | Room entrance |
| ░ | Secret | Hidden passage |
| < | Up Stairs | Level exit up |
| > | Down Stairs | Level exit down |

## Features

- **Procedural Generation**: Grid-based room placement with MST connectivity ensures all rooms are reachable
- **Interactive Navigation**: Explore generated dungeons with WASD keys and viewport scrolling
- **Secret Rooms**: Hidden areas accessible through secret passages (15% of single-connection rooms)
- **Three Corridor Types**: Straight, L-shaped, and Z-shaped connections for varied layouts
- **Map Export**: Save generated maps to disk for later use
- **Memory Efficient**: 3-bit tile encoding optimized for C64 constraints

## Technical Specifications

### Platform Requirements

- **Platform**: Commodore 64 (6502 processor, 64KB RAM)
- **Compiler**: OSCAR64 cross-compiler with C64-specific optimizations
- **Storage**: VICE emulator or real C64 with disk drive

### Map Specifications

- **Map Size**: 64×64 tiles with 40×25 viewport
- **Room Count**: Up to 20 rooms (4×4 to 8×8 tiles each)
- **Storage**: 3-bit tile encoding in 3072 bytes

### Performance

- **Generation Time**: ~3-4 seconds on C64 hardware
- **Memory Management**: Static allocation only, no dynamic memory allocation
- **Storage**: 3-bit packed tile encoding for efficient memory usage

## Generation Process

1. **Room Placement**: 4×4 grid with Fisher-Yates shuffle prevents patterns, walls built around each room
2. **Connectivity**: Minimum Spanning Tree links all rooms optimally
3. **Corridors**: Three types (straight, L-shaped, Z-shaped) based on room positions, walls built during corridor creation
4. **Secret Areas**: Single-connection rooms become hidden (15% chance)
5. **Stairs**: Priority-based stair placement in room centers

## Documentation

For detailed technical information, see:

- **[Project Specification](docs/project-specification.md)** - Complete technical specification including algorithms, data structures, and implementation details

- **[Oscar64 Development Reference](docs/oscar64-c64-development-reference.md)** - Comprehensive guide for C64 development using Oscar64 compiler
