#ifndef MAPGEN_TYPES_H
#define MAPGEN_TYPES_H

// Bit manipulation constants for compact tile encoding
#define BITS_PER_TILE 3             // Number of bits per tile in compact encoding
#define THREE_BIT_MASK 0x07         // 3-bit mask for tile extraction
#define MAX_BIT_POSITION_FOR_TILE 5 // Max bit position for a tile in a byte (8-3=5)
#define BITS_PER_BYTE 8             // Number of bits in a byte
#define UNDERFLOW_CHECK_VALUE 0xFF  // Used for underflow/invalid checks

// OSCAR64 Optimization: Use enum instead of #define for better range analysis
// This helps the compiler optimize 8-bit vs 16-bit operations
enum MapConstants {
    MAP_W = 72,
    MAP_H = 72,
    VIEW_W = 40,
    VIEW_H = 25,
    MAX_ROOMS = 20,
    MIN_SIZE = 4,
    MAX_SIZE = 8,
    MIN_ROOM_DISTANCE = 4,
    GRID_SIZE = 4,
    // Pre-calculated map size constants for 8-bit optimization
    COMPACT_MAP_SIZE = 3888,  // (72 * 72 * 3 + 7) / 8 = (15552 + 7) / 8 = 3888
    COMPACT_MAP_CHUNKS = 16   // COMPACT_MAP_SIZE / 256 = 3888 / 256 = 15.2 → 16
};

// Dynamic maximum connection distance calculation
// For maps with few rooms, allow longer connections to ensure connectivity
// Formula: (MAP_W + MAP_H) / (MAX_ROOMS / 2) but capped at reasonable limits
#define MAX_CONNECTION_DISTANCE_BASE 30        // Base distance for normal cases
#define MAX_CONNECTION_DISTANCE_EXTENDED 80    // Extended for sparse room layouts
#define CONNECTION_DISTANCE_THRESHOLD 8        // If fewer rooms than this, use extended distance

// Map tile characters (PETSCII)
#define EMPTY  32
#define WALL   160
#define FLOOR  46
#define DOOR   219
#define SECRET_PATH 94    // Secret paths and doors use checkerboard pattern
#define UP     60
#define DOWN   62

// C64 screen memory constants
#define SCREEN_MEMORY_BASE 0x0400

// Compact tile type encoding
#define TILE_EMPTY  0
#define TILE_WALL   1
#define TILE_FLOOR  2
#define TILE_DOOR   3
#define TILE_SECRET_PATH 6
#define TILE_UP     4
#define TILE_DOWN   5
#define TILE_MASK   7


// Tile validation bit flags
#define TILE_CHECK_EMPTY  0x01
#define TILE_CHECK_WALL   0x02
#define TILE_CHECK_FLOOR  0x04
#define TILE_CHECK_DOOR   0x08
#define CHECK_DOORS_ONLY    1
#define CHECK_FLOORS_ONLY   2
#define CHECK_FLOORS_AND_DOORS 3

// Room state flags
#define ROOM_SECRET 0x01

// Secret room system constants
#define SECRET_ROOM_PERCENTAGE 30  // Percentage of single-connection rooms to mark as secret

// Corridor and connection parameters
#define MAX_PATH_LENGTH 20

// OSCAR64 optimized packed door structure (2 bytes vs 4 bytes)
typedef struct {
    unsigned char x, y;                    // 2 bytes - door position
    unsigned char wall_side : 2;           // 0-3 wall sides (2 bits)
    unsigned char reserved : 6;            // 6 bits reserved for future use
} Door; // 2 bytes total - removed connected_room (redundant with conn_data[].room_id)

// OSCAR64 optimized packed connection structure (1 byte vs 2 bytes)  
typedef struct {
    unsigned char room_id : 5;             // 0-31 room ID (5 bits, enough for MAX_ROOMS=20)
    unsigned char corridor_type : 3;       // 0-7 corridor types (3 bits, expanded for future use)
} PackedConnection; // 1 byte total - removed 'used' flag (redundant with connections counter)

// OSCAR64 optimized Room structure (24 bytes vs 33 bytes = 27% savings)
typedef struct {
    // Most frequently accessed during generation (ordered by access frequency)
    unsigned char x, y, w, h;              // 4 bytes - room position and size
    unsigned char connections;             // 1 byte - number of active connections
    unsigned char state;                   // 1 byte - room state flags
    
    // OSCAR64 packed connection metadata (4 bytes vs 8 bytes)
    PackedConnection conn_data[4];         // 4 bytes - packed connection info
    
    // Door metadata (8 bytes vs 16 bytes)  
    Door doors[4];                         // 8 bytes - packed door positions
    
    // Less frequently accessed (moved to end for better cache behavior)
    unsigned char hub_distance;           // 1 byte - distance from hub room
    unsigned char priority;               // 1 byte - generation priority
} Room; // 20 bytes total vs 33 bytes (39% memory savings)

// Viewport structure
typedef struct {
    unsigned char x, y;
} Viewport;

#endif // MAPGEN_TYPES_H