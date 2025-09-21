# C64 Procedural Dungeon Generator

A real-time dungeon map generation system for the Commodore 64, utilizing OSCAR64 cross-compiler for 8-bit development.

## Project Overview

This project implements a procedural dungeon generation algorithm for the Commodore 64 hardware architecture. The system generates connected room networks using minimum spanning tree algorithms, features secret room mechanics, and provides interactive navigation with constrained memory usage.

**Target Platform:** Commodore 64 (6502 processor, 64KB RAM)  
**Compiler:** OSCAR64 cross-compiler  
**Output:** Optimized C64 executable (.prg format)  
**Memory Footprint:** Efficient allocation for map data and room structures

## Project Structure

```
main/src/
├── main.c                   # Entry point and VIC-II setup
├── mapgen/
│   ├── mapgen_api.h         # Public interface definitions
│   ├── mapgen_types.h       # Core data structures and constants
│   ├── mapgen_internal.h    # Internal module definitions
│   ├── map_generation.c     # Generation pipeline control
│   ├── room_management.c    # Room placement algorithms
│   ├── connection_system.c  # MST and corridor generation
│   ├── mapgen_display.c/.h  # Viewport and rendering
│   ├── mapgen_utils.c/.h    # Utility functions and math
│   └── map_export.c/.h      # File I/O operations
CMakeLists.txt               # Cross-platform build configuration
```

## Map Generation Logic

The generation process displays real-time progress with centered progress bar and phase indicators:

### Phase 1: Building Rooms

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
- 15 placement attempts per grid position for suitable positioning
- Boundary clamping keeps rooms within map limits

**Wall Construction:**
- Walls are built immediately around each room during placement
- 8-directional wall placement covers cardinal and diagonal positions
- Existing tiles are not overwritten to preserve previously placed structures

### Phase 2: Connecting Rooms (MST Algorithm)

Room interconnection uses Prim's algorithm to guarantee that all rooms remain reachable:

**MST Algorithm Operation:**
- First room is automatically marked as "connected"
- Each iteration finds the closest unconnected room to the connected set
- Calculates Manhattan distance between room centers
- Creates a corridor connecting the two rooms

**Corridor Types and Geometry:**
- **Straight Corridors:** Direct connection between two rooms
- **L-shaped Corridors:** Two perpendicular segments (horizontal-then-vertical or vice versa)
- **Z-shaped Corridors:** Three segments for complex navigation around obstacles
- **Wall Building:** Walls are constructed around each corridor tile as it's placed

**Door Placement Logic:**
- Each connection creates two doors (one per room wall)
- Doors are automatically positioned at optimal wall points
- System stores door metadata including position, direction, and connected room index
- Maximum 4 doors per room with explicit tracking

### Phase 3: Creating Secret Areas

The secret room system provides a special gameplay mechanic:

**Secret Room Criteria:**
- Only rooms with exactly 1 connection are eligible
- 15% probability of conversion to secret status
- Room `state` field receives `ROOM_SECRET` flag marking

**Secret Pathway Conversion:**
- The entire corridor leading to the secret room becomes `TILE_SECRET_PATH`
- Original corridor geometry is preserved (straight/L/Z shape)
- Both secret room door and connecting normal room door become secret passages
- Visual representation uses special character (`░` symbol)

### Phase 4: Placing Stairs

Stair placement system ensures optimal level navigation:

**Priority-Based Selection:**
- Up stairs placed in highest priority room
- Down stairs placed in second highest priority room
- Priority ensures stairs are placed in well-connected, accessible rooms

**Distance Validation:**
- Adaptive minimum distance requirements: 20 tiles (≤6 rooms) or 30 tiles (>6 rooms)
- Distance calculated using Manhattan distance between room centers
- Ensures reasonable separation between level entry and exit points

**Placement Strategy:**
- Stairs positioned at room centers for optimal accessibility
- Coordinate bounds checking prevents placement errors
- System guarantees valid navigation paths between levels

### Phase 5: Finalizing

Final generation step completes the map:

**Camera Initialization:**
- Viewport positioning for interactive navigation
- System preparation for player movement

## Data Storage System

### Compact Map Format

Map data is stored using a 3-bit per tile encoding:

**Bit-Level Compression:**
- Each tile type is represented by 3 bits (8 possible types)
- 64×64 map = 4096 tiles × 3 bits = efficiently packed data
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

Each room maintains metadata for:

**Core Properties:**
- `x, y`: Room top-left corner coordinates
- `w, h`: Room width and height dimensions
- `priority`: Stair placement priority (1-10 scale)
- `connections`: Number of active connections
- `state`: Secret room flag and status bits

**Connection Metadata (Optimized):**
- `conn_data[4]`: Packed connection structures with room ID and corridor type only
- `doors[4]`: Packed door structures with coordinates and wall side only
- Connection count tracked in `connections` field (single source of truth)
- Atomic operations ensure metadata consistency

### Memory Optimization Strategy

**Static Allocation Design:**
- No dynamic memory allocation (malloc/free eliminated)
- All data structures use pre-allocated fixed-size arrays
- Zero page variables for critical path operations

**Memory Layout:**
- `$0400-$07E7`: VIC-II screen memory (1000 bytes)
- `$0800-$13FF`: Compact map data (3072 bytes, 3-bit packed encoding)
- `$1400-$17FF`: Room structure arrays (packed data structures)
- `$1800-$1BFF`: Display viewport buffer
- `$2000+`: Program code (OSCAR64 optimized executable)

## Data Structures

### Core Room Structure
```c
typedef struct {
    // Most frequently accessed (ordered by access frequency)
    unsigned char x, y, w, h;              // Room position and dimensions
    unsigned char connections;             // Number of active connections
    unsigned char state;                   // Room state flags (normal/secret)
    
    // Optimized packed connection metadata (4 bytes vs 8 bytes)
    PackedConnection conn_data[4];         // Connection information
    Door doors[4];                         // Door positions and metadata (8 bytes vs 16 bytes)
    
    // Less frequently accessed
    unsigned char hub_distance, priority; // Generation parameters
} Room; // 20 bytes total vs 33 bytes (39% memory savings)
```

### Packed Connection Structure
```c
typedef struct {
    unsigned char room_id : 5;             // Connected room ID (0-31)
    unsigned char corridor_type : 3;       // Corridor type (0-7, expanded for future use)
} PackedConnection; // 1 byte total - removed 'used' flag (redundant with connections counter)
```

### Optimized Door Structure
```c
typedef struct {
    unsigned char x, y;                    // Door coordinates
    unsigned char wall_side : 2;           // Wall side (0-3)
    unsigned char reserved : 6;            // Reserved for future use
} Door; // 2 bytes total - removed connected_room (redundant with conn_data[].room_id)
```

## Algorithm Performance

### Computational Complexity
- **Room Placement**: O(n) with grid constraints
- **MST Generation**: O(n²) for complete connectivity
- **Wall Placement**: O(room_perimeter + corridor_length) incremental during creation
- **Screen Rendering**: O(viewport_size) with delta optimization

### Hardware Integration
- **VIC-II**: Direct register access ($D000-$D02E)
- **CIA**: Timer-based random seed generation
- **KERNAL**: Optimized I/O operations
- **Direct Memory**: Screen buffer manipulation at $0400

## Generation Pipeline

1. **Initialization**: Map clearing, random seed setup
2. **Room Creation**: Grid-based placement with collision detection and immediate wall construction
3. **Connection System**: MST algorithm execution with corridor walls built during creation
4. **Secret Rooms**: Single-connection room conversion
5. **Stair Placement**: Start/end room assignment by priority
6. **Camera Initialization**: Viewport setup for navigation

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
- `-dNOLONG`: Exclude long integer support (saves space)  
- `-dNOFLOAT`: Remove floating point operations (saves space)
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

### Atomic Metadata Management Functions
```c
// Atomic connection management - adds connection and door metadata in single operation
unsigned char add_connection_to_room(unsigned char room_idx, unsigned char connected_room,
                                    unsigned char door_x, unsigned char door_y, 
                                    unsigned char wall_side, unsigned char corridor_type);

// Centralized connection validation - checks if rooms are already connected
unsigned char room_has_connection_to(unsigned char room_idx, unsigned char target_room);

// Get connection info for specific connected room
unsigned char get_connection_info(unsigned char room_idx, unsigned char target_room,
                                 unsigned char *door_x, unsigned char *door_y, 
                                 unsigned char *wall_side, unsigned char *corridor_type);

// Atomic rollback - removes last connection from room safely
unsigned char remove_last_connection_from_room(unsigned char room_idx);
```

## Development Standards

### Code Quality
- **Static Analysis**: Zero dynamic memory allocation
- **Type Safety**: Explicit unsigned char usage for 8-bit targets
- **Documentation**: Inline comments for algorithm implementations
- **Testing**: Validation functions for map integrity verification

### Performance Metrics
- **Generation Time**: ~3-4 seconds on C64 hardware
- **Memory Management**: Static allocation only, no dynamic memory
- **Map Storage**: 3072 bytes (3-bit packed tile encoding)
- **Room Data**: Packed structures for efficient memory usage
- **Code Quality**: OSCAR64 optimized for 6502 architecture

This implementation uses 8-bit programming techniques and classical algorithms adapted for the hardware constraints of the Commodore 64.
