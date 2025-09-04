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
#define MAX_ROOMS 20
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
#define SECRET_ROOM_PERCENTAGE 15  // Percentage of single-connection rooms to mark as secret

// Corridor and connection parameters
#define MAX_PATH_LENGTH 20

// Door metadata structure
typedef struct {
    unsigned char x, y;
    unsigned char wall_side; // 0=left, 1=right, 2=top, 3=bottom
    unsigned char connected_room; // Which room this door connects to
} Door;

// Room structure with connection and corridor data
typedef struct {
    unsigned char x, y;
    unsigned char w, h;
    unsigned char connections;
    unsigned char state;
    unsigned char hub_distance;
    unsigned char priority;
    
    // Connection data stored explicitly
    unsigned char connected_rooms[4]; // Max 4 connections per room
    unsigned char corridor_types[4]; // Corridor types for each connection (0=straight, 1=L, 2=Z)
    Door doors[4]; // Door positions and metadata
    unsigned char door_count;
} Room;

// Viewport structure
typedef struct {
    unsigned char x, y;
} Viewport;

#endif // MAPGEN_TYPES_H