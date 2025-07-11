#ifndef MAPGEN_TYPES_H
#define MAPGEN_TYPES_H

// Map dimensions (64x64 tiles)
#define MAP_W 64
#define MAP_H 64

// Maximum number of rooms
#define MAX_ROOMS 20

// Room structure definition
// Represents a rectangular room in the dungeon
typedef struct {
    unsigned char x;         // Top-left X coordinate
    unsigned char y;         // Top-left Y coordinate
    unsigned char w;         // Width
    unsigned char h;         // Height
    unsigned char priority;  // Room priority (for stairs, etc.)
    unsigned char connected; // Connection flag (for MST)
    unsigned char reserved1; // Reserved for future use
    unsigned char reserved2; // Reserved for future use
} Room;

// Tile type definitions (3 bits per tile)
#define TILE_EMPTY        0
#define TILE_WALL         1
#define TILE_FLOOR        2
#define TILE_DOOR         3
#define TILE_UP_STAIRS    4
#define TILE_DOWN_STAIRS  5

#endif // MAPGEN_TYPES_H
