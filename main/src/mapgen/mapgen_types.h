#ifndef MAPGEN_TYPES_H
#define MAPGEN_TYPES_H

// Bit manipulation constants for compact tile encoding
#define BITS_PER_TILE 3             // Number of bits per tile in compact encoding
#define THREE_BIT_MASK 0x07         // 3-bit mask for tile extraction
#define MAX_BIT_POSITION_FOR_TILE 5 // Max bit position for a tile in a byte (8-3=5)
#define BITS_PER_BYTE 8             // Number of bits in a byte
#define UNDERFLOW_CHECK_VALUE 0xFF  // Used for underflow/invalid checks

// Map dimensions and room parameters
#define MAP_W  64
#define MAP_H  64
#define VIEW_W 40
#define VIEW_H 25
#define MAX_ROOMS 5
#define MIN_SIZE 4
#define MAX_SIZE 8
#define MIN_ROOM_DISTANCE 4
#define GRID_SIZE 4

// Dynamic maximum connection distance calculation
// For maps with few rooms, allow longer connections to ensure connectivity
// Formula: (MAP_W + MAP_H) / (MAX_ROOMS / 2) but capped at reasonable limits
#define MAX_CONNECTION_DISTANCE_BASE 30        // Base distance for normal cases
#define MAX_CONNECTION_DISTANCE_EXTENDED 80    // Extended for sparse room layouts
#define CONNECTION_DISTANCE_THRESHOLD 8        // If fewer rooms than this, use extended distance

// Map tile characters (PETSCII)
#define EMPTY  32
#define WALL   160
#define CORNER 230
#define FLOOR  46
#define DOOR   219
#define UP     60
#define DOWN   62

// Compact tile type encoding
#define TILE_EMPTY  0
#define TILE_WALL   1
#define TILE_FLOOR  2
#define TILE_DOOR   3
#define TILE_UP     4
#define TILE_DOWN   5
#define TILE_CORNER 6
#define TILE_MASK   7

// Conversion macro from compact tile to PETSCII
#define TILE_TO_PETSCII(tile) ((tile) == TILE_EMPTY ? EMPTY : \
                               (tile) == TILE_WALL ? WALL : \
                               (tile) == TILE_FLOOR ? FLOOR : \
                               (tile) == TILE_DOOR ? DOOR : \
                               (tile) == TILE_UP ? UP : \
                               (tile) == TILE_DOWN ? DOWN : \
                               (tile) == TILE_CORNER ? CORNER : EMPTY)

// Tile validation bit flags
#define TILE_CHECK_EMPTY  0x01
#define TILE_CHECK_WALL   0x02
#define TILE_CHECK_FLOOR  0x04
#define TILE_CHECK_DOOR   0x08
#define CHECK_DOORS_ONLY    1
#define CHECK_FLOORS_ONLY   2
#define CHECK_FLOORS_AND_DOORS 3

// Corridor and connection parameters
#define MAX_PATH_LENGTH 20
#define ROOM_UNCONNECTED 0
#define ROOM_CONNECTED   1
#define MAX_CORRIDOR_SEGMENTS 32
#define MAX_CONNECTION_CACHE  24

// Room structure
typedef struct {
    unsigned char x, y;
    unsigned char w, h;
    unsigned char connections;
    unsigned char state;
    unsigned char hub_distance;
    unsigned char priority;
} Room;

// Corridor segment structure
typedef struct {
    unsigned char start_x, start_y;
    unsigned char end_x, end_y;
    unsigned char room_passed;
    unsigned char active;
} CorridorSegment;

// Viewport structure
typedef struct {
    unsigned char x, y;
} Viewport;

// Corridor connections structure (bit fields for memory efficiency)
typedef struct {
    unsigned char has_north : 1;
    unsigned char has_south : 1;
    unsigned char has_east : 1;
    unsigned char has_west : 1;
} CorridorConnections;

// Memory pool structures for C64
typedef struct {
    CorridorSegment segments[MAX_CORRIDOR_SEGMENTS];
    unsigned char active_count;
    unsigned char next_free_index;
} CorridorPool;

typedef struct {
    unsigned char room1[MAX_CONNECTION_CACHE];
    unsigned char room2[MAX_CONNECTION_CACHE];
    unsigned char distance[MAX_CONNECTION_CACHE];
    unsigned char count;
} ConnectionCache;

#endif // MAPGEN_TYPES_H