# C64 Dungeon Map Generator - Source Code Documentation

Oscar64 C compiler implementation for Commodore 64 hardware.

## Architecture Overview

### Module Structure

| Module | Function | Algorithms |
|--------|----------|------------|
| **main.c** | System initialization, main loop | VIC-II setup, input handling |
| **map_generation.c** | Generation pipeline | Room placement, MST connectivity, wall generation |
| **connection_system.c** | Room connectivity | MST algorithm, corridor pathfinding, bounding box collision detection, path validation |
| **room_management.c** | Room placement | Grid-based placement, collision detection |
| **mapgen_display.c** | Display system | Viewport management, screen rendering |
| **mapgen_utils.c** | Utility functions | Math, random generation, tile conversion, adjacency checking, room detection |
| **map_export.c** | File I/O | Binary serialization, KERNAL routines |

## Tile Encoding System

### Internal Representation (3-bit)

```c
#define TILE_EMPTY   0  // Background
#define TILE_WALL    1  // Solid wall
#define TILE_FLOOR   2  // Walkable floor
#define TILE_DOOR    3  // Door/passage
#define TILE_UP      4  // Up stairs
#define TILE_DOWN    5  // Down stairs
```

### PETSCII Display Constants

```c
#define EMPTY   32   // Space character
#define WALL    160  // Solid block
#define FLOOR   46   // Period (.)
#define DOOR    171  // Inverse plus (+)
#define UP      60   // Less-than (<)
#define DOWN    62   // Greater-than (>)
```

**Memory Efficiency**: 64x64 map stored in 1536 bytes (3 bits per tile)

## Map Generation Pipeline

### 1. System Initialization

- Random seed generation using CIA timers
- Connection matrix initialization
- Memory pool setup

### 2. Room Placement

**Algorithm**: Grid-based placement with collision detection

- 4x4 grid cell distribution
- Room sizes: 4x4 to 8x8 tiles
- Buffer zones prevent room overlap
- Validation ensures map boundary compliance

**Placement Process** (`can_place_room()`):

- Calculate buffer zone boundaries
- Check for tile collisions in buffer area
- Enforce minimum distance between rooms
- Update room metadata upon successful placement

### 3. Room Connection System

**Algorithm**: Prim MST (Minimum Spanning Tree)

**OSCAR64 Optimizations**:

- Zero page variables: `mst_best_room1`, `mst_best_room2`, `mst_best_distance`, `tile_check_cache`, `adjacent_tile_temp`
- Striped array layout: `__striped` arrays for 6502 addressing with connection distance cache, path validation cache, and MST edge candidates
- Speed pragma: `#pragma optimize(speed)` on nested loops
- Bitwise operations for modulo: `y & 7` instead of `y % 8`
- Early exit with immediate return on first match
- Register caching for room coordinates
- Striped implementation with 64-entry cache size

**MST Process**:

- Start with room 0 as connected
- Uses striped MST edge candidates
- Find shortest valid connection using striped cache first, traditional MST as fallback
- Skip already attempted connections (infinite loop prevention)
- Use distance cache with striped layout for Manhattan distance calculations
- Build exactly (room_count - 1) connections

**Corridor Types**:

- **Straight**: Single line segment for aligned rooms
- **L-shaped**: Two perpendicular segments for diagonal rooms
- **Z-shaped**: Three segments for complex routing

**Corridor Selection Logic**:

- Aligned rooms (axis overlap): 70% straight, 30% Z-shaped
- Diagonal rooms (no axis overlap): 50% L-shaped, 50% Z-shaped

### 4. Stair Placement

- Priority calculation based on room connectivity
- UP stairs: highest priority room
- DOWN stairs: second highest priority room
- Positioned at room centers

### 5. Wall Generation

**Single-pass algorithm**:

- Scan all walkable tiles (floor, door, stairs)
- Place walls in 8 directions around each walkable tile
- Only place walls on empty tiles

### 6. Display System

**Viewport Management**:

- 40x25 character display window
- Camera tracking with boundary protection
- Delta refresh (update only changed tiles)
- Direct screen memory access ($0400-$07E7)

**Input System**:

- WASD movement
- SPACE: generate new map  
- M: export map to PRG file

## Memory Layout

**Data Structures**:

- Map data: 1536 bytes (3-bit packed)
- Room array: 20 rooms maximum
- Connection matrices: room connectivity tracking
- Screen buffer: 40x25 characters

**Total Memory Usage**: ~3.6 KB including all data structures

## File Export System

**Format**: C64 PRG file

- Binary encoded map data
- KERNAL I/O routines for disk access
- Device 8 (disk drive) output
- Loadable program format

## Technical Specifications

**Algorithms Complexity**:

- Room placement: O(n)
- MST generation: O(n²)
- Wall generation: O(map_size)
- Rendering: O(viewport_size)

**C64 Hardware Integration**:

- Direct VIC-II register access
- CIA timer entropy collection  
- Screen memory manipulation
- KERNAL I/O integration

**Compiler**: Oscar64 with -O0 debug flags
