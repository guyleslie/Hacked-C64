# Source Code Documentation

Technical documentation for C64 Dungeon Map Generator implementation.

## Architecture

### Core Modules

| Module | Lines | Function | Key Algorithms |
|--------|-------|----------|----------------|
| **main.c** | ~150 | Entry point | VIC-II initialization, main loop, input processing |
| **map_generation.c** | ~180 | Generation pipeline | Stair placement, wall generation, master control |
| **connection_system.c** | ~600 | Room connectivity | Prim MST, corridor pathfinding, secret room marking |
| **room_management.c** | ~300 | Room placement | Grid distribution, collision detection, validation |
| **mapgen_display.c** | ~400 | Display system | Viewport management, delta refresh, camera tracking |
| **mapgen_utils.c** | ~490 | Utilities | Tile access, math functions, bounds checking |
| **map_export.c** | ~120 | File I/O | PRG export, KERNAL routines |

### Header Files

| Header | Purpose | Exports |
|--------|---------|---------|
| **mapgen_api.h** | Public API | Generator functions, initialization |
| **mapgen_types.h** | Type definitions | Room struct, tile constants, hardware addresses |
| **mapgen_internal.h** | Internal helpers | Global variables, private functions |
| **mapgen_display.h** | Display functions | Viewport, rendering, input handling |
| **mapgen_utils.h** | Utility functions | Math, random, tile operations |

## Data Structures

### Room Structure
```c
typedef struct {
    unsigned char x, y;          // Position
    unsigned char w, h;          // Dimensions  
    unsigned char priority;      // Stair placement priority
    unsigned char connections;   // Connection count
    unsigned char state;         // Secret room flag
} Room;
```

### Map Storage
```c
// 3-bit per tile encoding
unsigned char compact_map[MAP_H * MAP_W * 3 / 8];  // 1536 bytes

// 64x64 map = 4096 tiles × 3 bits = 12288 bits = 1536 bytes
```

### Global Arrays
```c
Room rooms[MAX_ROOMS];                    // 20 rooms maximum
unsigned char screen_buffer[VIEW_H][VIEW_W];  // 40×25 display buffer
```

## Algorithms

### 1. Room Placement Algorithm
```
1. Initialize 4×4 grid positions (16 cells)
2. Shuffle grid positions randomly
3. For each position:
   - Calculate room size (4×4 to 8×8)
   - Check collision with buffer zones
   - Place room if safe
   - Update room metadata
```

### 2. MST Connection Algorithm
```
1. Mark room 0 as connected
2. While unconnected rooms exist:
   - Find closest unconnected room to connected set
   - Calculate corridor path (straight/L/Z-shaped)
   - Draw corridor and place doors
   - Mark room as connected
   - Store connection metadata
```

### 3. Tile Access System
```
1. Each tile uses 3 bits (8 tile types possible)
2. Map stored in packed format: 1536 bytes for 64×64 tiles
3. Tiles can span across byte boundaries
4. Direct bit manipulation for fast access
```

### 4. Secret Room System
```
1. Identify rooms with exactly 1 connection
2. Apply 15% probability filter
3. Mark selected rooms as secret
4. Convert corridor tiles to secret paths
5. Preserve exact corridor geometry
```

## Memory Management

### Static Allocation
- **No malloc/free**: All memory pre-allocated
- **Fixed arrays**: Room, connection, display buffers
- **Stack usage**: Minimal local variables

### Memory Map
```
$0400-$07E7  Screen memory (1000 bytes)
$0800-$0BFF  Map data (1536 bytes)  
$0C00-$0FFF  Room arrays (~400 bytes)
$1000-$13FF  Display buffer (1000 bytes)
$1400-$17FF  Program code (~7400 bytes)
```

### Zero Page Optimization
```c
__zeropage unsigned char mst_best_room1;
__zeropage unsigned char mst_best_room2; 
__zeropage unsigned char mst_best_distance;
__zeropage unsigned char adjacent_tile_temp;
```

## Optimization Techniques

### Compiler Flags
- **-Os**: Size optimization
- **-dNOLONG**: Remove long integer support
- **-dNOFLOAT**: Remove floating point support
- **-n**: No runtime checks

### Code Optimizations
- **Inline functions**: Critical path functions
- **Bit operations**: Fast tile encoding/decoding
- **Loop unrolling**: Adjacency checking
- **Delta updates**: Only refresh changed screen areas

## File Structure

```
main/src/
├─ main.c                    // Entry point (150 lines)
├─ mapgen/                   
│  ├─ map_generation.c       // Pipeline control (180 lines)
│  ├─ connection_system.c    // MST & corridors (600 lines)
│  ├─ room_management.c      // Room placement (300 lines)
│  ├─ mapgen_display.c       // Display & input (400 lines)
│  ├─ mapgen_utils.c         // Utilities (490 lines)
│  ├─ map_export.c           // File export (120 lines)
│  ├─ mapgen_api.h           // Public API
│  ├─ mapgen_types.h         // Data structures
│  ├─ mapgen_internal.h      // Internal helpers
│  ├─ mapgen_display.h       // Display functions
│  ├─ mapgen_utils.h         // Utility functions
│  └─ map_export.h           // Export functions
```

## Build Process

### Compilation
```bash
oscar64.exe -o="build\Hacked C64.prg" -n -tf=prg -Os -dNOLONG -dNOFLOAT -tm=c64 main\src\main.c
```

### Output Files
- **Hacked C64.prg**: Main executable (7434 bytes)
- **Hacked C64.map**: Memory usage map
- **Hacked C64.asm**: Assembly listing
- **Hacked C64.lbl**: Debug symbols

## Performance Characteristics

### Algorithm Complexity
- **Room Placement**: O(n) with grid constraints
- **MST Generation**: O(n²) for room connections  
- **Wall Placement**: O(map_size) single pass
- **Screen Rendering**: O(viewport_size) with delta optimization

### Hardware Integration
- **VIC-II**: Direct register access for display control
- **CIA**: Timer-based random seed generation
- **KERNAL**: File I/O operations for map export
- **Memory**: Direct screen buffer manipulation at $0400

## Implementation Notes

### Key Optimizations
- **Custom print_text**: KERNAL $FFD2 calls instead of printf for size reduction
- **Unified tile access**: Single get_compact_tile() function
- **Direct calculations**: calculate_room_distance() without caching
- **Compiler flags**: -Os -dNOLONG -dNOFLOAT for minimal binary size

### Secret Room System
- Targets rooms with exactly 1 connection
- 15% probability for secret room conversion
- Secret passages use "." character in debug output