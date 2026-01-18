#ifndef TMEA_TYPES_H
#define TMEA_TYPES_H

// =============================================================================
// TILE METADATA EXTENSION ARCHITECTURE (TMEA) v3
// Type Definitions, Lookup Tables, and Constants
// =============================================================================
//
// Architecture: Data-Oriented Design with Lookup Tables
// - Static properties (damage, defense, etc.) -> const lookup tables (ROM)
// - Dynamic state (position, HP, status) -> runtime structs (RAM)
//
// Item Type Encoding: CCCC_SSSS (8 bits)
// - Upper 4 bits: Category (weapon, armor, potion, etc.)
// - Lower 4 bits: Subtype within category
//
// Memory Overhead: ~765 bytes RAM for runtime pools
// Lookup Tables: ~300-500 bytes ROM (const data)
//
// =============================================================================

#include "mapgen_types.h"

// =============================================================================
// ITEM TYPE ENCODING (CCCC_SSSS)
// =============================================================================

// Item Categories (upper 4 bits)
#define ITEM_CAT_WEAPON     0x00    // 0x00-0x07: 8 weapon types
#define ITEM_CAT_ARMOR      0x10    // 0x10-0x17: 8 armor types
#define ITEM_CAT_SHIELD     0x20    // 0x20-0x27: 8 shield types
#define ITEM_CAT_POTION     0x30    // 0x30-0x35: 6 potion types
#define ITEM_CAT_SCROLL     0x40    // 0x40-0x4D: 14 scroll types
#define ITEM_CAT_GEM        0x50    // 0x50-0x54: 5 gem types
#define ITEM_CAT_KEY        0x60    // 0x60-0x63: 4 key types
#define ITEM_CAT_MISC       0x70    // 0x70-0x7F: torch, food, gold, quest items

// Helper macros for item type encoding
#define ITEM_GET_CATEGORY(type)     ((type) & 0xF0)
#define ITEM_GET_SUBTYPE(type)      ((type) & 0x0F)
#define ITEM_MAKE_TYPE(cat, sub)    ((cat) | ((sub) & 0x0F))

// -----------------------------------------------------------------------------
// Weapons (ITEM_CAT_WEAPON + subtype)
// -----------------------------------------------------------------------------
#define ITEM_DAGGER         0x00    // light, fast
#define ITEM_SHORT_SWORD    0x01    // balanced
#define ITEM_LONG_SWORD     0x02    // standard
#define ITEM_AXE            0x03    // heavy damage
#define ITEM_MACE           0x04    // blunt, anti-undead bonus
#define ITEM_SPEAR          0x05    // reach
#define ITEM_BOW            0x06    // ranged
#define ITEM_STAFF          0x07    // magic bonus

// -----------------------------------------------------------------------------
// Armor (ITEM_CAT_ARMOR + subtype)
// -----------------------------------------------------------------------------
#define ITEM_CLOTH_ARMOR    0x10    // light, no penalty
#define ITEM_LEATHER_ARMOR  0x11    // light
#define ITEM_STUDDED_ARMOR  0x12    // medium-light
#define ITEM_CHAIN_ARMOR    0x13    // medium
#define ITEM_SCALE_ARMOR    0x14    // medium-heavy
#define ITEM_PLATE_ARMOR    0x15    // heavy, best defense
#define ITEM_ROBE           0x16    // magic bonus
#define ITEM_CLOAK          0x17    // stealth bonus

// -----------------------------------------------------------------------------
// Shields (ITEM_CAT_SHIELD + subtype)
// -----------------------------------------------------------------------------
#define ITEM_BUCKLER        0x20    // small, light
#define ITEM_WOODEN_SHIELD  0x21    // basic
#define ITEM_IRON_SHIELD    0x22    // standard
#define ITEM_STEEL_SHIELD   0x23    // good
#define ITEM_TOWER_SHIELD   0x24    // heavy, best block

// -----------------------------------------------------------------------------
// Potions (ITEM_CAT_POTION + subtype)
// -----------------------------------------------------------------------------
#define ITEM_POTION_HEAL    0x30    // restore HP
#define ITEM_POTION_MANA    0x31    // restore MP
#define ITEM_POTION_CURE    0x32    // cure poison/status
#define ITEM_POTION_SPEED   0x33    // temporary speed boost
#define ITEM_POTION_STRENGTH 0x34   // temporary damage boost
#define ITEM_POTION_INVISIBILITY 0x35 // temporary invisibility

// -----------------------------------------------------------------------------
// Scrolls (ITEM_CAT_SCROLL + subtype)
// -----------------------------------------------------------------------------
#define ITEM_SCROLL_LIGHT       0x40    // illuminate dark rooms
#define ITEM_SCROLL_TURN_UNDEAD 0x41    // destroy/flee undead
#define ITEM_SCROLL_FIREBALL    0x42    // area fire damage
#define ITEM_SCROLL_ICE_BOLT    0x43    // single target ice
#define ITEM_SCROLL_LIGHTNING   0x44    // chain lightning
#define ITEM_SCROLL_HEAL        0x45    // restore HP
#define ITEM_SCROLL_TELEPORT    0x46    // random teleport
#define ITEM_SCROLL_MAPPING     0x47    // reveal map
#define ITEM_SCROLL_IDENTIFY    0x48    // identify items
#define ITEM_SCROLL_ENCHANT     0x49    // upgrade weapon/armor
#define ITEM_SCROLL_REMOVE_CURSE 0x4A   // remove curse
#define ITEM_SCROLL_PROTECTION  0x4B    // temporary defense
#define ITEM_SCROLL_CONFUSION   0x4C    // confuse enemies
#define ITEM_SCROLL_SLEEP       0x4D    // sleep enemies

// -----------------------------------------------------------------------------
// Gems (ITEM_CAT_GEM + subtype)
// -----------------------------------------------------------------------------
#define ITEM_GEM_RUBY       0x50    // red, valuable
#define ITEM_GEM_SAPPHIRE   0x51    // blue
#define ITEM_GEM_EMERALD    0x52    // green
#define ITEM_GEM_DIAMOND    0x53    // most valuable
#define ITEM_GEM_AMETHYST   0x54    // purple

// -----------------------------------------------------------------------------
// Keys (ITEM_CAT_KEY + subtype)
// -----------------------------------------------------------------------------
#define ITEM_KEY_BRONZE     0x60    // common doors
#define ITEM_KEY_SILVER     0x61    // special doors
#define ITEM_KEY_GOLD       0x62    // rare doors
#define ITEM_KEY_MASTER     0x63    // opens all (rare)

// -----------------------------------------------------------------------------
// Misc Items (ITEM_CAT_MISC + subtype)
// -----------------------------------------------------------------------------
#define ITEM_GOLD           0x70    // currency (amount in data byte)
#define ITEM_TORCH          0x71    // light source (fuel in data byte)
#define ITEM_FOOD           0x72    // restore hunger
#define ITEM_LOCKPICK       0x73    // open locked doors
#define ITEM_QUEST_ITEM_1   0x7D    // quest specific
#define ITEM_QUEST_ITEM_2   0x7E    // quest specific
#define ITEM_QUEST_ITEM_3   0x7F    // quest specific

// =============================================================================
// ITEM DATA BYTE ENCODING
// =============================================================================
//
// For weapons/armor/shields: MMMM_0000
//   M = modifier: 0=normal, 1=+1, 2=+2, 3=+3, 15=cursed
//
// For gold: full 8 bits = amount (0-255)
// For torch: full 8 bits = fuel remaining (0-255)
// For potions/scrolls: usually 0 (or charges if stacking)

#define ITEM_MOD_NORMAL     0x00
#define ITEM_MOD_PLUS_1     0x10
#define ITEM_MOD_PLUS_2     0x20
#define ITEM_MOD_PLUS_3     0x30
#define ITEM_MOD_CURSED     0xF0

#define ITEM_GET_MODIFIER(data)     (((data) >> 4) & 0x0F)
#define ITEM_SET_MODIFIER(mod)      (((mod) & 0x0F) << 4)

// =============================================================================
// MONSTER TYPES
// =============================================================================

enum MonsterType {
    // Regular enemies (0-7)
    MON_RAT         = 0,    // weak, fast
    MON_GOBLIN      = 1,    // basic enemy
    MON_SKELETON    = 2,    // undead
    MON_ORC         = 3,    // strong
    MON_ZOMBIE      = 4,    // slow, tough undead
    MON_TROLL       = 5,    // regenerates
    MON_GHOST       = 6,    // undead, incorporeal
    MON_SPIDER      = 7,    // poison attack

    // Boss enemies (8-10)
    MON_BOSS_DEMON  = 8,    // fire attacks
    MON_BOSS_LICH   = 9,    // undead mage
    MON_BOSS_DRAGON = 10,   // final boss

    MON_TYPE_COUNT  = 11
};

// =============================================================================
// MONSTER AI STATES
// =============================================================================

enum MonsterState {
    MSTATE_IDLE     = 0,    // standing still, unaware
    MSTATE_PATROL   = 1,    // wandering randomly
    MSTATE_CHASE    = 2,    // pursuing player
    MSTATE_ATTACK   = 3,    // in combat range, attacking
    MSTATE_FLEE     = 4,    // running away (Turn Undead, low HP)
    MSTATE_SLEEP    = 5,    // sleeping until disturbed
    MSTATE_GUARD    = 6,    // guarding position (boss)
    MSTATE_STUNNED  = 7     // cannot act this turn
};

// Fixed flee duration (in turns)
#define FLEE_DURATION_TURNS 20

// =============================================================================
// MONSTER RUNTIME FLAGS
// =============================================================================

enum MonsterRuntimeFlags {
    MFLAG_ALIVE     = 0x01,   // monster is alive
    MFLAG_HOSTILE   = 0x02,   // hostile to player
    MFLAG_POISONED  = 0x04,   // taking poison DOT
    MFLAG_BURNING   = 0x08,   // taking fire DOT
    MFLAG_FROZEN    = 0x10,   // slowed, ice effect
    MFLAG_CONFUSED  = 0x20,   // moves randomly
    MFLAG_INVISIBLE = 0x40,   // hidden from player
    MFLAG_UNDEAD_VAR= 0x80    // undead variant (Undead Goblin, etc.)
};

// =============================================================================
// LOOKUP TABLE STRUCTURES (const/ROM data)
// =============================================================================

// Item definition (3 bytes each)
typedef struct {
    unsigned char base_value;   // damage/defense/heal amount/gold value
    unsigned char gold_price;   // selling price in gold
    unsigned char tile_id;      // 3x3 char tile pattern ID
} ItemDef;

// Monster definition (5 bytes each)
typedef struct {
    unsigned char base_hp;      // starting HP
    unsigned char damage;       // attack damage
    unsigned char xp_value;     // XP reward on kill
    unsigned char def_flags;    // MDEF_* flags (static properties)
    unsigned char sprite_id;    // sprite frame ID
} MonsterDef;

// Monster definition flags (static, in lookup table)
#define MDEF_UNDEAD     0x01    // affected by Turn Undead
#define MDEF_BOSS       0x02    // boss monster
#define MDEF_FLYING     0x04    // ignores floor traps
#define MDEF_MAGIC_RES  0x08    // magic resistance
#define MDEF_POISON_ATK 0x10    // attacks can poison
#define MDEF_REGEN      0x20    // regenerates HP each turn
#define MDEF_LIFE_DRAIN 0x40    // steals HP on hit, heals self

// =============================================================================
// TILE METADATA STRUCTURES (unchanged from v2)
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

#define TMTYPE_MASK 0xE0
#define TMFLAG_MASK 0x1F

// Wall-specific flags (TMTYPE_WALL)
enum TileMetaWallFlags {
    TMFLAG_WALL_ILLUSORY     = 0x01,
    TMFLAG_WALL_SECRET       = 0x02,
    TMFLAG_WALL_REVEALED     = 0x04,
    TMFLAG_WALL_CRACKED      = 0x08,
    TMFLAG_WALL_DESTRUCTIBLE = 0x10
};

// Door-specific flags (TMTYPE_DOOR)
enum TileMetaDoorFlags {
    TMFLAG_DOOR_SECRET      = 0x01,
    TMFLAG_DOOR_TRAPPED     = 0x02,
    TMFLAG_DOOR_LOCKED      = 0x04,
    TMFLAG_DOOR_REVEALED    = 0x08,
    TMFLAG_DOOR_OPEN        = 0x10
};

// Trap-specific flags (TMTYPE_TRAP)
enum TileMetaTrapFlags {
    TMFLAG_TRAP_HIDDEN      = 0x01,
    TMFLAG_TRAP_TRIGGERED   = 0x02,
    TMFLAG_TRAP_DISARMED    = 0x04,
    TMFLAG_TRAP_REARM       = 0x08
};

// Special tile flags (TMTYPE_SPECIAL)
enum TileMetaSpecialFlags {
    TMFLAG_SPECIAL_TELEPORT = 0x01,
    TMFLAG_SPECIAL_PRESSURE = 0x02,
    TMFLAG_SPECIAL_RUNE     = 0x04,
    TMFLAG_SPECIAL_ONEWAY   = 0x08,
    TMFLAG_SPECIAL_CRUMBLE  = 0x10
};

// =============================================================================
// RUNTIME ENTITY STRUCTURES
// =============================================================================

// Room-scoped tile metadata (3 bytes per entry)
typedef struct {
    unsigned char local_pos;    // Room-local coords (x:4bit + y:4bit)
    unsigned char flags;        // Type + state flags
    unsigned char data;         // Extra data (trap damage, key ID, etc.)
} RoomTileMeta;

// Global tile metadata (4 bytes per entry)
typedef struct {
    unsigned char x;            // Global X coordinate
    unsigned char y;            // Global Y coordinate
    unsigned char flags;        // Type + state flags
    unsigned char data;         // Extra data
} GlobalTileMeta;

// Runtime object instance (6 bytes)
typedef struct obj {
    struct obj *next;           // 2 bytes - linked list
    unsigned char x;            // 1 byte - position
    unsigned char y;            // 1 byte - position
    unsigned char type;         // 1 byte - CCCC_SSSS item type
    unsigned char data;         // 1 byte - modifier/amount/fuel
} TinyObj;

// Runtime monster instance (6 bytes)
typedef struct mon {
    struct mon *next;           // 2 bytes - linked list
    unsigned char x;            // 1 byte - position
    unsigned char y;            // 1 byte - position
    unsigned char type;         // 1 byte - MonsterType enum
    unsigned char hp;           // 1 byte - current HP
    unsigned char flags;        // 1 byte - runtime MFLAG_* flags
    unsigned char state;        // 1 byte - MonsterState enum
} TinyMon;  // Note: Actually 8 bytes with this layout

// =============================================================================
// POOL SIZE CONFIGURATION
// =============================================================================

#define META_PER_ROOM           4       // metadata slots per room
#define GLOBAL_META_POOL_SIZE   16      // global metadata slots
#define MAX_TINY_OBJECTS        48      // max active items
#define MAX_TINY_MONSTERS       6       // max active monsters (sprite limit!)

// =============================================================================
// HELPER MACROS
// =============================================================================

#define GET_META_TYPE(flags)            ((flags) & TMTYPE_MASK)
#define GET_META_FLAGS(flags)           ((flags) & TMFLAG_MASK)
#define IS_META_TYPE(flags, type)       (GET_META_TYPE(flags) == (type))

#define PACK_LOCAL_POS(x, y)            (((x) << 4) | ((y) & 0x0F))
#define UNPACK_LOCAL_X(packed)          ((packed) >> 4)
#define UNPACK_LOCAL_Y(packed)          ((packed) & 0x0F)

#define META_SENTINEL                   0xFF

#endif // TMEA_TYPES_H
