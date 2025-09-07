# C64 Procedural Dungeon Generator

Professional implementation of a real-time dungeon map generation system for the Commodore 64, utilizing OSCAR64 cross-compiler for optimized 8-bit performance.

## Project Overview

This project implements a sophisticated procedural dungeon generation algorithm designed specifically for the Commodore 64 hardware architecture. The system generates connected room networks using minimum spanning tree algorithms, features secret room mechanics, and provides real-time interactive navigation with optimized memory usage patterns.

**Target Platform:** Commodore 64 (6502 processor, 64KB RAM)  
**Compiler:** OSCAR64 cross-compiler  
**Output:** 7434-byte executable (.prg format)  
**Memory Footprint:** ~3KB for map data and room structures

## Map Generation Logic

### Phase 1: Room Creation and Placement

The room generation operates on a 4×4 grid system providing 16 potential positions across the map. The process works as follows:

**Grid-Based Placement:**
- The map is divided into 16 equal cells (4×4 grid)
- Each cell represents a potential room position
- Cell order is randomized using Fisher-Yates shuffle algorithm
- Additional shuffle passes break grid alignment patterns

**Room Sizes and Types:**
- Base size ranges from 4×4 to 8×8 tiles
- 60% probability for rectangular rooms (wider or taller bias)
- 40% probability for more square-shaped rooms
- Each room maintains minimum 4-tile distance from others

**Collision Detection System:**
- Pre-placement validation checks against existing rooms
- Safety buffer zones ensure minimum inter-room spacing
- 15 placement attempts per grid position for optimal positioning
- Boundary clamping keeps rooms within map limits

### Phase 2: Room Connectivity (MST Algorithm)

Room interconnection uses Prim's algorithm to guarantee that all rooms remain reachable:

**MST Algorithm Operation:**
- First room is automatically marked as "connected"
- Each iteration finds the closest unconnected room to the connected set
- Calculates euclidean distance between room centers
- Creates a corridor connecting the two rooms

**Corridor Types and Geometry:**
- **Straight Corridors:** Direct connection between two rooms
- **L-shaped Corridors:** Two perpendicular segments (horizontal-then-vertical or vice versa)
- **Z-shaped Corridors:** Three segments for complex navigation around obstacles

**Door Placement Logic:**
- Each connection creates two doors (one per room wall)
- Doors are automatically positioned at optimal wall points
- System stores door metadata including position, direction, and connected room index
- Maximum 4 doors per room with explicit tracking

### Phase 3: Secret Rooms and Pathways

The secret room system provides a special gameplay mechanic:

**Secret Room Criteria:**
- Only rooms with exactly 1 connection are eligible
- 15% probability of conversion to secret status
- Room `state` field receives `ROOM_SECRET` flag marking

**Secret Pathway Conversion:**
- The entire corridor leading to the secret room becomes `TILE_SECRET_PATH`
- Original corridor geometry is perfectly preserved (straight/L/Z shape)
- Both secret room door and connecting normal room door become secret passages
- Visual representation uses special character (`^` symbol)

## Data Storage System

### Compact Map Format

Map data is stored using an extremely efficient 3-bit per tile encoding:

**Bit-Level Compression:**
- Each tile type is represented by 3 bits (8 possible types)
- 64×64 map = 4096 tiles × 3 bits = 12288 bits = 1536 bytes
- Bits can span byte boundaries for maximum compression
- Direct bit manipulation provides O(1) tile access

**Tile Type Encoding:**
- `TILE_EMPTY` (0): Empty space
- `TILE_WALL` (1): Wall structure
- `TILE_FLOOR` (2): Room floor
- `TILE_DOOR` (3): Standard door
- `TILE_UP` (4): Upward staircase
- `TILE_DOWN` (5): Downward staircase
- `TILE_SECRET_PATH` (6): Secret passage

### Room Data Structure

Each room maintains comprehensive metadata:

**Core Properties:**
- `x, y`: Room top-left corner coordinates
- `w, h`: Room width and height dimensions
- `priority`: Stair placement priority (1-10 scale)
- `connections`: Number of active connections
- `state`: Secret room flag and status bits

**Connection Metadata:**
- `connected_rooms[4]`: Connected room indices (max 4 connections per room)
- `corridor_types[4]`: Corridor types for each connection (0=straight, 1=L, 2=Z)
- `doors[4]`: Door positions and directional data
- `door_count`: Active door count tracker

### Memory Optimization Strategy

**Static Allocation Design:**
- No dynamic memory allocation (malloc/free eliminated)
- All data structures use pre-allocated fixed-size arrays
- Zero page variables for critical path operations

**Memory Layout:**
- `$0400-$07E7`: VIC-II screen memory (1000 bytes)
- `$0800-$0BFF`: Compact map data (1536 bytes)
- `$0C00-$0FFF`: Room structure arrays (~400 bytes)
- `$1000-$13FF`: Display buffer (1000 bytes)
- `$1400-$17FF`: Program code (~7400 bytes)

## Algorithm Performance

### Computational Complexity
- **Room Placement**: O(n) with grid constraints
- **MST Generation**: O(n²) for complete connectivity
- **Wall Placement**: O(map_size) single pass
- **Screen Rendering**: O(viewport_size) with delta optimization

### Hardware Integration
- **VIC-II**: Direct register access ($D000-$D02E)
- **CIA**: Timer-based random seed generation
- **KERNAL**: Optimized I/O operations
- **Direct Memory**: Screen buffer manipulation at $0400

## Generation Pipeline

1. **Initialization**: Map clearing, random seed setup
2. **Room Creation**: Grid-based placement with collision detection
3. **Connection System**: MST algorithm execution
4. **Secret Rooms**: Single-connection room conversion
5. **Stair Placement**: Start/end room assignment by priority
6. **Wall Generation**: Automatic wall placement around floor areas
7. **Camera Initialization**: Viewport setup for navigation

## Technical Architecture

### System Components

| Component | Responsibility |
|-----------|---------------|
| **Core Generator** (`map_generation.c`) | Pipeline orchestration and master control |
| **Room System** (`room_management.c`) | Placement algorithms with grid distribution |
| **MST Connectivity** (`connection_system.c`) | Prim's algorithm, corridor generation, secret rooms |
| **Display Engine** (`mapgen_display.c`) | Viewport management, delta rendering, input |
| **Utility Layer** (`mapgen_utils.c`) | Bit manipulation, math operations, validation |
| **Export System** (`map_export.c`) | KERNAL-based file I/O operations |

### Build Configuration

**OSCAR64 Compiler Flags:**
```bash
oscar64.exe -o="build/Hacked C64.prg" -n -tf=prg -Os -dNOLONG -dNOFLOAT -tm=c64
```

**Flag Details:**
- `-Os`: Size optimization priority
- `-dNOLONG`: Exclude long integer support (saves ~1KB)  
- `-dNOFLOAT`: Remove floating point operations (saves ~2KB)
- `-tm=c64`: Target Commodore 64 platform
- `-tf=prg`: Generate .prg executable format

### CMake Integration
Cross-platform build system with automatic OSCAR64 detection:
```cmake
set(OSCAR64_BIN "${OSCAR64_PATH}/oscar64/bin/oscar64.exe")
add_custom_command(OUTPUT ${OUTPUT_PRG} COMMAND ${OSCAR64_BIN} ...)
```

## API Interface

### Public Functions
```c
// Core generation
unsigned char mapgen_generate_dungeon(void);

// Room queries  
unsigned char mapgen_get_room_info(unsigned char room_index, ...);
unsigned char mapgen_find_room_at_position(unsigned char x, unsigned char y);

// Statistics and validation
void mapgen_get_statistics(unsigned char *floor_tiles, ...);
unsigned char mapgen_validate_map(void);
```

### Interactive Controls
- **Arrow Keys**: Navigate viewport across generated dungeon
- **Real-time**: Immediate response with optimized screen updates
- **Bounds Checking**: Automatic viewport constraint handling

## Development Standards

### Code Quality
- **Static Analysis**: Zero dynamic memory allocation
- **Type Safety**: Explicit unsigned char usage for 8-bit optimization  
- **Documentation**: Inline comments for algorithm implementations
- **Testing**: Validation functions for map integrity verification

### Performance Metrics
- **Generation Time**: <1 second on original C64 hardware
- **Memory Usage**: 3KB total footprint with room for expansion
- **Code Size**: 7434 bytes including all functionality
- **Screen Updates**: 50Hz-compatible delta rendering

## Project Structure

```
main/src/
├── main.c                    # Entry point and VIC-II setup
├── mapgen/
│   ├── mapgen_api.h         # Public interface definitions
│   ├── mapgen_types.h       # Core data structures  
│   ├── map_generation.c     # Generation pipeline control
│   ├── room_management.c    # Room placement algorithms
│   ├── connection_system.c  # MST and corridor generation
│   ├── mapgen_display.c     # Viewport and rendering
│   ├── mapgen_utils.c       # Utility functions and math
│   └── map_export.c         # File I/O operations
CMakeLists.txt               # Cross-platform build configuration
```

This implementation demonstrates advanced 8-bit programming techniques, combining classical algorithms with hardware-specific optimizations to achieve real-time performance within strict memory constraints.