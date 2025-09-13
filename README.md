# Hacked C64 - Dungeon Map Generator

A dungeon map generator for the Commodore 64, built with Oscar64.

## Description

This program generates randomized dungeon layouts on the Commodore 64. Each map contains rooms connected by corridors, with stairs, doors, walls, and secret passages.

## Features

- **Real-time Generation**: Create new dungeons with SPACE key
- **Interactive Navigation**: Explore maps with WASD keys  
- **Secret Rooms**: Hidden rooms with secret passages
- **Map Export**: Save generated maps to disk

## Screenshots

Generation progress display:

<img width="1205" height="909" alt="image" src="https://github.com/user-attachments/assets/32b037af-7c1c-40b3-a288-7dc1ab5a5194" />

Final dungeon map:

<img width="1203" height="908" alt="image" src="https://github.com/user-attachments/assets/2fb6eab8-335f-4c00-909c-a2f2e453c627" />

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

## Technical Info

- **Platform**: Commodore 64
- **Map Size**: 64×64 tiles
- **Room Count**: Up to 20 rooms
- **Program Size**: 7.4KB

## How It Works

1. **Room Placement**: Randomly places rooms on a grid
2. **Connections**: Links all rooms with corridors
3. **Secret Rooms**: Some isolated rooms become secret
4. **Stairs**: Adds up/down stairs for navigation
5. **Walls**: Fills empty areas around rooms

## Documentation

For detailed technical information, see:

- **[Project Specification](docs/project-specification.md)** - Complete technical specification including algorithms, data structures, and implementation details
- **[Oscar64 Development Reference](docs/oscar64-c64-development-reference.md)** - Comprehensive guide for C64 development using Oscar64 compiler
