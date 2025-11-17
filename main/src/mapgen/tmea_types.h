#ifndef TMEA_TYPES_H
#define TMEA_TYPES_H

// =============================================================================
// TILE METADATA EXTENSION ARCHITECTURE (TMEA) v2
// Type Definitions and Constants
// =============================================================================
//
// TMEA provides a lightweight metadata system for dungeon tiles and entities,
// optimized for C64/Oscar64 with minimal memory overhead.
//
// Metadata Marker: Uses TILE_MARKER (value 7) to flag tiles with extended metadata
// - Marked tiles trigger metadata lookup in room or global pools
// - Unmarked tiles have no metadata overhead
//
// Architecture: Hybrid Room+Global Design
// - Room-scoped metadata: Fast O(1) lookup for tiles inside rooms (70% of map)
// - Global metadata pool: Fallback for corridors and map-wide features (30%)
// - Entity pools: Global coordinate-based objects and monsters
//
// Memory Overhead: ~761 bytes total
// - Room metadata:   260 bytes (20 rooms × 4 slots × 3 bytes + counters)
// - Global metadata:  65 bytes (16 slots × 4 bytes + counter)
// - Object pool:     292 bytes (48 objects × 6 bytes + pointers)
// - Monster pool:    148 bytes (24 monsters × 6 bytes + pointers)
//
// =============================================================================

#include "mapgen_types.h"  // For Room, MAX_ROOMS, etc.

// =============================================================================
// TILE METADATA STRUCTURES
// =============================================================================

// Tile metadata flag system (8-bit packed flags)
// Upper 3 bits: Type classification
// Lower 5 bits: Type-specific flags
enum TileMetaType {
    TMTYPE_WALL     = 0x00,  // 000xxxxx - Wall features
    TMTYPE_DOOR     = 0x20,  // 001xxxxx - Door features
    TMTYPE_TRAP     = 0x40,  // 010xxxxx - Trap features
    TMTYPE_SPECIAL  = 0x60,  // 011xxxxx - Special tiles
    TMTYPE_EFFECT   = 0x80,  // 100xxxxx - Area effects
    TMTYPE_TRIGGER  = 0xA0,  // 101xxxxx - Event triggers
    TMTYPE_RESERVED1= 0xC0,  // 110xxxxx - Reserved
    TMTYPE_RESERVED2= 0xE0   // 111xxxxx - Reserved
};

#define TMTYPE_MASK 0xE0  // Mask for type bits
#define TMFLAG_MASK 0x1F  // Mask for flag bits

// Wall-specific flags (TMTYPE_WALL)
enum TileMetaWallFlags {
    TMFLAG_WALL_ILLUSORY     = 0x01,  // Illusory wall (passable)
    TMFLAG_WALL_SECRET       = 0x02,  // Secret wall (hidden)
    TMFLAG_WALL_REVEALED     = 0x04,  // Secret wall discovered
    TMFLAG_WALL_CRACKED      = 0x08,  // Cracked/weak wall
    TMFLAG_WALL_DESTRUCTIBLE = 0x10   // Destructible wall
};

// Door-specific flags (TMTYPE_DOOR)
enum TileMetaDoorFlags {
    TMFLAG_DOOR_SECRET      = 0x01,  // Secret door (hidden)
    TMFLAG_DOOR_TRAPPED     = 0x02,  // Door has trap
    TMFLAG_DOOR_LOCKED      = 0x04,  // Locked (requires lockpick or key)
    TMFLAG_DOOR_REVEALED    = 0x08,  // Secret door discovered
    TMFLAG_DOOR_OPEN        = 0x10   // Door is open (vs closed)
};

// Trap-specific flags (TMTYPE_TRAP)
enum TileMetaTrapFlags {
    TMFLAG_TRAP_HIDDEN      = 0x01,  // Trap is hidden
    TMFLAG_TRAP_TRIGGERED   = 0x02,  // Trap already triggered
    TMFLAG_TRAP_DISARMED    = 0x04,  // Trap is disarmed
    TMFLAG_TRAP_REARM       = 0x08   // Trap rearms after trigger
};

// Special tile flags (TMTYPE_SPECIAL)
enum TileMetaSpecialFlags {
    TMFLAG_SPECIAL_TELEPORT = 0x01,  // Teleport pad
    TMFLAG_SPECIAL_PRESSURE = 0x02,  // Pressure plate
    TMFLAG_SPECIAL_RUNE     = 0x04,  // Magic rune
    TMFLAG_SPECIAL_ONEWAY   = 0x08,  // One-way passage
    TMFLAG_SPECIAL_CRUMBLE  = 0x10   // Crumbling floor
};

// Room-scoped tile metadata (3 bytes per entry)
// Used for tiles inside rooms - compact and fast
typedef struct {
    unsigned char local_pos;         // 1 byte - Room-local coords (x:4bit + y:4bit)
    unsigned char flags;             // 1 byte - Type + state flags
    unsigned char data;              // 1 byte - Extra data (key ID, damage, etc.)
} RoomTileMeta;  // 3 bytes total

// Global tile metadata (4 bytes per entry)
// Used for corridor tiles and map-wide features - fallback pool
typedef struct {
    unsigned char x;                 // 1 byte - Global X coordinate
    unsigned char y;                 // 1 byte - Global Y coordinate
    unsigned char flags;             // 1 byte - Type + state flags (same enum as room)
    unsigned char data;              // 1 byte - Extra data
} GlobalTileMeta;  // 4 bytes total

// =============================================================================
// ENTITY STRUCTURES
// =============================================================================

// Object types (7-bit type ID)
enum ObjectType {
    OBJ_TYPE_GOLD       = 0,   // Gold coins
    OBJ_TYPE_POTION_RED = 1,   // Red potion (health)
    OBJ_TYPE_POTION_BLUE= 2,   // Blue potion (mana)
    OBJ_TYPE_KEY_RED    = 3,   // Red key
    OBJ_TYPE_KEY_BLUE   = 4,   // Blue key
    OBJ_TYPE_KEY_YELLOW = 5,   // Yellow key
    OBJ_TYPE_SCROLL     = 6,   // Scroll
    OBJ_TYPE_WEAPON     = 7,   // Weapon
    OBJ_TYPE_ARMOR      = 8,   // Armor
    OBJ_TYPE_FOOD       = 9,   // Food
    OBJ_TYPE_TORCH      = 10,  // Torch/light source
    OBJ_TYPE_TREASURE   = 11   // Treasure chest
};

// Object flags (8-bit state flags)
enum ObjectFlags {
    OBJ_FLAG_VISIBLE    = 0x01,  // Visible to player
    OBJ_FLAG_COLLECTIBLE= 0x02,  // Can be picked up
    OBJ_FLAG_USABLE     = 0x04,  // Can be used
    OBJ_FLAG_EQUIPPED   = 0x08,  // Currently equipped
    OBJ_FLAG_MAGICAL    = 0x10,  // Has magical properties
    OBJ_FLAG_CURSED     = 0x20,  // Cursed item
    OBJ_FLAG_IDENTIFIED = 0x40,  // Item identified
    OBJ_FLAG_QUEST      = 0x80   // Quest item
};

// Tiny object structure (6 bytes) - linked list node
// Uses global coordinates for flexibility (rooms + corridors)
typedef struct obj {
    struct obj *next;                // 2 bytes - Next in linked list
    unsigned char x;                 // 1 byte - Global X coordinate
    unsigned char y;                 // 1 byte - Global Y coordinate
    unsigned char type : 7;          // 7 bits - Object type (0-127)
    unsigned char flags : 8;         // 8 bits - State flags
    unsigned char data : 8;          // 8 bits - Extra data (charges, durability, etc.)
} TinyObj;  // 6 bytes total

// Monster types (6-bit type ID)
enum MonsterType {
    MON_TYPE_RAT        = 0,   // Giant rat
    MON_TYPE_GOBLIN     = 1,   // Goblin
    MON_TYPE_SKELETON   = 2,   // Skeleton
    MON_TYPE_ORC        = 3,   // Orc
    MON_TYPE_ZOMBIE     = 4,   // Zombie
    MON_TYPE_TROLL      = 5,   // Troll
    MON_TYPE_GHOST      = 6,   // Ghost
    MON_TYPE_DRAGON     = 7    // Dragon
};

// Monster flags (8-bit state flags)
enum MonsterFlags {
    MON_FLAG_ALIVE      = 0x01,  // Monster is alive
    MON_FLAG_HOSTILE    = 0x02,  // Hostile to player
    MON_FLAG_WANDERING  = 0x04,  // Wandering behavior
    MON_FLAG_SLEEPING   = 0x08,  // Sleeping (can be awakened)
    MON_FLAG_POISONED   = 0x10,  // Poisoned status
    MON_FLAG_STUNNED    = 0x20,  // Stunned status
    MON_FLAG_FLEEING    = 0x40,  // Fleeing from player
    MON_FLAG_BOSS       = 0x80   // Boss monster
};

// AI states (4-bit state)
enum MonsterAIState {
    AI_STATE_IDLE       = 0,   // Standing still
    AI_STATE_PATROL     = 1,   // Patrolling area
    AI_STATE_CHASE      = 2,   // Chasing player
    AI_STATE_ATTACK     = 3,   // Attacking player
    AI_STATE_FLEE       = 4    // Fleeing
};

// Tiny monster structure (6 bytes) - linked list node
typedef struct mon {
    struct mon *next;                // 2 bytes - Next in linked list
    unsigned char x;                 // 1 byte - Global X coordinate
    unsigned char y;                 // 1 byte - Global Y coordinate
    unsigned char type : 6;          // 6 bits - Monster type (0-63)
    unsigned char hp : 8;            // 8 bits - Hit points (0-255)
    unsigned char flags : 8;         // 8 bits - State flags
    unsigned char ai_state : 4;      // 4 bits - AI state (0-15)
} TinyMon;  // 6 bytes total

// =============================================================================
// POOL SIZE CONFIGURATION
// =============================================================================

// Room-scoped metadata configuration
// Each room can have up to META_PER_ROOM metadata entries
#define META_PER_ROOM 4              // 4 metadata slots per room
// Total room metadata: 20 rooms × 4 slots × 3 bytes = 240 bytes

// Global metadata pool configuration
// Used for corridors and map-wide features (fallback)
#define GLOBAL_META_POOL_SIZE 16     // 16 global metadata slots
// Total global metadata: 16 × 4 bytes = 64 bytes

// Entity pool configuration
// Objects and monsters use global coordinates
#define MAX_TINY_OBJECTS 48          // 48 object pool slots
// Total objects: 48 × 6 bytes = 288 bytes

#define MAX_TINY_MONSTERS 24         // 24 monster pool slots
// Total monsters: 24 × 6 bytes = 144 bytes

// =============================================================================
// HELPER MACROS
// =============================================================================

// Extract type from flags byte
#define GET_META_TYPE(flags) ((flags) & TMTYPE_MASK)

// Extract type-specific flags
#define GET_META_FLAGS(flags) ((flags) & TMFLAG_MASK)

// Check if flags match specific type
#define IS_META_TYPE(flags, type) (GET_META_TYPE(flags) == (type))

// Pack local coordinates (4-bit x, 4-bit y) into single byte
#define PACK_LOCAL_POS(x, y) (((x) << 4) | ((y) & 0x0F))

// Unpack local X coordinate from packed byte
#define UNPACK_LOCAL_X(packed) ((packed) >> 4)

// Unpack local Y coordinate from packed byte
#define UNPACK_LOCAL_Y(packed) ((packed) & 0x0F)

// Sentinel value for "no metadata"
#define META_SENTINEL 0xFF

#endif // TMEA_TYPES_H
