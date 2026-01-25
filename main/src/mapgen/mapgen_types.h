#ifndef MAPGEN_TYPES_H
#define MAPGEN_TYPES_H

// Bit manipulation constants for compact tile encoding
#define BITS_PER_TILE 3             // Number of bits per tile in compact encoding
#define THREE_BIT_MASK 0x07         // 3-bit mask for tile extraction
#define MAX_BIT_POSITION_FOR_TILE 5 // Max bit position for a tile in a byte (8-3=5)
#define BITS_PER_BYTE 8             // Number of bits in a byte

// Use enum instead of #define for better code generation
enum MapConstants {
    MIN_MAP_SIZE = 48,
    MED_MAP_SIZE = 64,
    MAX_MAP_SIZE = 80,
    VIEW_W = 40,
    VIEW_H = 25,
    MAX_ROOMS = 20,  // Maximum for stable operation (16 grid positions + buffer)
    MAX_CONNECTIONS = 20,  // Maximum corridor connections (MST + extras)
    MIN_SIZE = 4,
    MAX_SIZE = 8,
    MIN_ROOM_DISTANCE = 4,
    // GRID_SIZE removed - now dynamic based on map size (3×3, 4×4, or 5×5)
    // Max: (80*80*3+7)/8 = 2400 bytes
    COMPACT_MAP_SIZE = 2400,  // Max: (80*80*3+7)/8
    COMPACT_MAP_CHUNKS = 10   // 2400/256
};

// Dynamic maximum connection distance calculation
// For maps with few rooms, allow longer connections to ensure connectivity
// Formula: (MAP_W + MAP_H) / (MAX_ROOMS / 2) but capped at reasonable limits
const unsigned char MAX_CONNECTION_DISTANCE_BASE = 30;        // Base distance for normal cases
const unsigned char MAX_CONNECTION_DISTANCE_EXTENDED = 80;    // Extended for sparse room layouts
const unsigned char CONNECTION_DISTANCE_THRESHOLD = 8;        // If fewer rooms than this, use extended distance

// Map tile characters (PETSCII)
const unsigned char EMPTY = 32;
const unsigned char WALL = 160;
const unsigned char FLOOR = 46;
const unsigned char DOOR = 219;
const unsigned char SECRET_DOOR = 94;    // Secret doors use checkerboard pattern (░ symbol)
const unsigned char UP = 60;
const unsigned char DOWN = 62;

// C64 screen memory constants
#define SCREEN_MEMORY_BASE 0x0400

// Compact tile type encoding
const unsigned char TILE_EMPTY = 0;
const unsigned char TILE_WALL = 1;
const unsigned char TILE_FLOOR = 2;
const unsigned char TILE_DOOR = 3;
const unsigned char TILE_UP = 4;
const unsigned char TILE_DOWN = 5;
// Value 6 reserved for future use
const unsigned char TILE_MARKER = 7;  // TMEA metadata marker (tile has extended metadata)
#define TILE_MASK   7


// Tile validation bit flags  
const unsigned char TILE_CHECK_EMPTY = 0x01;
const unsigned char TILE_CHECK_WALL = 0x02;
const unsigned char TILE_CHECK_FLOOR = 0x04;
const unsigned char TILE_CHECK_DOOR = 0x08;
const unsigned char CHECK_DOORS_ONLY = 1;
const unsigned char CHECK_FLOORS_ONLY = 2;
const unsigned char CHECK_FLOORS_AND_DOORS = 3;

// Room state flags
#define ROOM_SECRET 0x01
#define ROOM_HAS_TREASURE 0x02
#define ROOM_HAS_FALSE_CORRIDOR 0x04

// Secret room system constants
const unsigned char SECRET_ROOM_PERCENTAGE = 50;  // Percentage of single-connection rooms to mark as secret

// Corridor and connection parameters
const unsigned char MAX_PATH_LENGTH = 20;

// Packed door structure (3 bytes)
typedef struct {
    unsigned char x, y;                    // 2 bytes - door position
    unsigned char wall_side : 2;           // 0-3 wall sides (2 bits)
    unsigned char is_branching : 1;        // 1 bit - multiple corridors on this wall
    unsigned char reserved : 5;            // 5 bits reserved for future use
} Door; // 3 bytes total

// Packed connection structure (1 byte vs 2 bytes)
typedef struct {
    unsigned char room_id : 5;              // 0-31 room ID (5 bits, enough for MAX_ROOMS=20)
    unsigned char corridor_type : 2;        // 0-3 corridor types (2 bits: Straight=0, L-shaped=1, Z-shaped=2)
    unsigned char is_non_branching : 1;     // 1 bit - non-branching corridor flag (runtime tracking)
} PackedConnection; // 1 byte total - optimized bitfield (corridor_type reduced 3→2 bits)

// Corridor breakpoint structure (2 bytes per breakpoint)
typedef struct {
    unsigned char x, y;                    // 2 bytes - breakpoint coordinates
} CorridorBreakpoint; // 2 bytes total - compact coordinate storage

// Room structure (32 bytes total, optimized layout with wall counters)
typedef struct {
    // Most frequently accessed during generation (ordered by access frequency)
    unsigned char x, y, w, h;              // 4 bytes - room position and size
    unsigned char center_x, center_y;      // 2 bytes - cached room center position
    unsigned char connections;             // 1 byte - number of active connections
    unsigned char state;                   // 1 byte - room state flags

    // Wall door counters (4 bytes) - instant O(1) wall queries for optimization
    // Index: 0=left, 1=right, 2=top, 3=bottom
    unsigned char wall_door_count[4];      // 4 bytes - door count per wall (normal + false corridors)

    // Packed connection metadata (4 bytes vs 8 bytes)
    PackedConnection conn_data[4];         // 4 bytes - packed connection info

    // Door metadata (12 bytes vs 16 bytes)
    Door doors[4];                         // 12 bytes - packed door positions

    // Secret treasure metadata (1 byte) - wall side only (coordinates calculated on-demand)
    unsigned char treasure_wall_side;      // 1 byte - wall side (0-3) or 255=no treasure

    // False corridor metadata (3 bytes) - wall side + endpoint coordinates
    unsigned char false_corridor_wall_side; // 1 byte - wall side (0-3) or 255=no false corridor
    unsigned char false_corridor_end_x;     // 1 byte - false corridor end X coordinate
    unsigned char false_corridor_end_y;     // 1 byte - false corridor end Y coordinate
} Room; // 48 bytes total (+2 bytes for wall_door_count optimization, -2 bytes from coordinate removal)

// Viewport structure
typedef struct {
    unsigned char x, y;
} Viewport;

#endif // MAPGEN_TYPES_H