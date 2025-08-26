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
- Traditional array layout for room distance cache using 2D matrix
- Speed pragma: `#pragma optimize(speed)` on nested loops
- Bitwise operations for modulo: `y & 7` instead of `y % 8`
- Early exit with immediate return on first match
- Register caching for room coordinates
- MST edge candidate cache with 32-entry traditional structure

**MST Process**:

- Start with room 0 as connected
- Uses MST edge candidates cache
- Find shortest valid connection using cached edge candidates first, traditional MST as fallback
- Skip already attempted connections (infinite loop prevention)
- Use traditional room distance cache for Manhattan distance calculations
- Build exactly (room_count - 1) connections

**Connection Features**:

- **Duplicate Prevention**: Reachability check using DFS to avoid redundant connections
- **Path Validation**: Bounding box pre-filtering with detailed intersection checking
- **Dynamic Distance Limits**: Adaptive max distance based on room count (≤8 rooms: 80 tiles, >8 rooms: 30 tiles)
- **Door Reuse**: Existing doors are detected and reused when possible
- **Fallback Recovery**: Systematic evaluation of unconnected rooms with override capability

**Corridor Types**:

- **Straight Corridors**: Direct single-segment connection
  - Used for rooms with axis alignment (horizontal/vertical overlap)
  - Exit points placed at center of overlapping region
  - Simple pathfinding with single validation check

- **L-Shaped Corridors**: Two perpendicular segments meeting at intersection
  - Used for diagonal room positioning (no axis overlap)
  - Exit points on complementary sides for natural L-formation
  - Both segments validated independently for room avoidance
  - Supports both X-first and Y-first path routing

- **Z-Shaped Corridors**: Three-segment complex routing
  - Used for both aligned and diagonal rooms as alternative
  - Exit points on facing (opposite) sides of rooms
  - First leg extends perpendicular from exit wall direction
  - Three-segment validation ensures complete path clearance

**Corridor Selection Logic**:

- **Aligned Rooms** (horizontal/vertical overlap detected):
  - 70% chance: Straight corridor (direct connection)
  - 30% chance: Z-shaped corridor (alternative routing)

- **Diagonal Rooms** (no axis overlap):
  - 50% chance: L-shaped corridor (perpendicular wall connections)
  - 50% chance: Z-shaped corridor (complex routing)

**Door Placement System**:

- Doors placed directly at optimal positions (1 tile from room perimeter)
- Exit points and door positions are unified - corridors connect door to door
- Automatic alignment with existing doors to prevent redundant placements
- Eliminates redundant offset calculations for improved performance

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
