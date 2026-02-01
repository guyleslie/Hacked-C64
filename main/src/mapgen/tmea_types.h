#ifndef TMEA_TYPES_H
#define TMEA_TYPES_H

// =============================================================================
// TILE METADATA EXTENSION ARCHITECTURE (TMEA) v4
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
// Memory Overhead: ~640 bytes RAM for runtime pools
// Lookup Tables: ~340 bytes ROM (const data)
//
// =============================================================================

#include "mapgen_types.h"

// =============================================================================
// ITEM TYPE ENCODING (CCCC_SSSS)
// =============================================================================

// Item Categories (upper 4 bits)
#define ITEM_CAT_WEAPON     0x00    // 0x00-0x07: 8 weapon types
#define ITEM_CAT_ARMOR      0x10    // 0x10-0x17: 8 armor types
#define ITEM_CAT_SHIELD     0x20    // 0x20-0x24: 5 shield types
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
#define ITEM_DAGGER         0x00    // light, fast, poison
#define ITEM_SHORT_SWORD    0x01    // balanced
#define ITEM_LONG_SWORD     0x02    // standard
#define ITEM_BATTLE_AXE     0x03    // heavy, cleave, two-handed
#define ITEM_MACE           0x04    // blunt, anti-undead, stun
#define ITEM_SPEAR          0x05    // reach, pierce armor
#define ITEM_BOW            0x06    // ranged
#define ITEM_CURSED_BLADE   0x07    // life drain, anti-demon

// -----------------------------------------------------------------------------
// Armor (ITEM_CAT_ARMOR + subtype)
// -----------------------------------------------------------------------------
#define ITEM_CLOTH_ARMOR    0x10    // light, stealth bonus
#define ITEM_LEATHER_ARMOR  0x11    // light
#define ITEM_STUDDED_ARMOR  0x12    // medium-light
#define ITEM_CHAIN_ARMOR    0x13    // medium
#define ITEM_SCALE_ARMOR    0x14    // medium-heavy, fire resist
#define ITEM_PLATE_ARMOR    0x15    // heavy, best defense
#define ITEM_ROBE           0x16    // magic resist
#define ITEM_DRAGON_SCALE   0x17    // poison immune

// -----------------------------------------------------------------------------
// Shields (ITEM_CAT_SHIELD + subtype)
// -----------------------------------------------------------------------------
#define ITEM_BUCKLER        0x20    // small, light
#define ITEM_ROUND_SHIELD   0x21    // bash
#define ITEM_KITE_SHIELD    0x22    // standard
#define ITEM_TOWER_SHIELD   0x23    // spell block
#define ITEM_MIRROR_SHIELD  0x24    // reflect arrows

// -----------------------------------------------------------------------------
// Potions (ITEM_CAT_POTION + subtype)
// -----------------------------------------------------------------------------
#define ITEM_POTION_HEAL        0x30    // restore HP
#define ITEM_POTION_FULL_HEAL   0x31    // restore to max HP
#define ITEM_POTION_BERSERK     0x32    // +50% damage, -20% AC
#define ITEM_POTION_REGEN       0x33    // heal over time
#define ITEM_POTION_CURE_POISON 0x34    // remove poison
#define ITEM_POTION_INVISIBLE   0x35    // invisibility

// -----------------------------------------------------------------------------
// Scrolls (ITEM_CAT_SCROLL + subtype)
// -----------------------------------------------------------------------------
#define ITEM_SCROLL_LIGHT           0x40    // illuminate dark rooms
#define ITEM_SCROLL_MAGIC_MAPPING   0x41    // reveal map
#define ITEM_SCROLL_DETECT_SECRET   0x42    // reveal secret doors/traps
#define ITEM_SCROLL_TELEPORT        0x43    // random teleport
#define ITEM_SCROLL_IDENTIFY        0x44    // identify items
#define ITEM_SCROLL_ENCHANT_WEAPON  0x45    // +1 weapon modifier
#define ITEM_SCROLL_ENCHANT_ARMOR   0x46    // +1 armor modifier
#define ITEM_SCROLL_REMOVE_CURSE    0x47    // remove curse
#define ITEM_SCROLL_SUMMON          0x48    // CURSED: spawn enemy
#define ITEM_SCROLL_EARTHQUAKE      0x49    // break walls 3x3
#define ITEM_SCROLL_TURN_UNDEAD     0x4A    // kill/flee undead
#define ITEM_SCROLL_FIREBALL        0x4B    // area fire damage
#define ITEM_SCROLL_HASTE           0x4C    // speed buff
#define ITEM_SCROLL_SHIELD          0x4D    // AC buff

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

#define ITEM_NONE           0xFF    // no item equipped

// =============================================================================
// ITEM DATA BYTE ENCODING (Modifiers)
// =============================================================================
//
// For weapons/armor/shields: lower 4 bits = modifier
//   0 = normal, 1 = +1, 2 = +2, 3 = +3, 15 = cursed
//
// For gold: full 8 bits = amount (0-255)
// For torch: full 8 bits = fuel remaining (0-255)
// For potions/scrolls: usually 0 (unidentified flag possible)

#define ITEM_MOD_NORMAL     0x00
#define ITEM_MOD_PLUS_1     0x01
#define ITEM_MOD_PLUS_2     0x02
#define ITEM_MOD_PLUS_3     0x03
#define ITEM_MOD_CURSED     0x0F

#define ITEM_GET_MODIFIER(data)     ((data) & 0x0F)
#define ITEM_SET_MODIFIER(mod)      ((mod) & 0x0F)

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
    MON_GHOST       = 6,    // undead, incorporeal, life drain
    MON_SPIDER      = 7,    // poison attack

    // Boss enemies (8-10)
    MON_BOSS_DEMON  = 8,    // fire attacks, summons
    MON_BOSS_LICH   = 9,    // undead mage, life drain
    MON_BOSS_DRAGON = 10,   // fire breath, massive HP

    MON_TYPE_COUNT  = 11
};

// =============================================================================
// AI TYPES
// =============================================================================

enum AIType {
    AI_SIMPLE_CHASE = 0,    // Direct chase, no pathing
    AI_SMART_CHASE  = 1,    // Chase with obstacle avoidance
    AI_SLOW_CHASE   = 2,    // Slow movement (Zombie)
    AI_BOSS         = 3     // Boss AI with special attacks
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
// MONSTER RUNTIME FLAGS (stored in TinyMon.flags)
// =============================================================================

#define MFLAG_ALIVE         0x01    // monster is alive
#define MFLAG_HOSTILE       0x02    // hostile to player
#define MFLAG_POISONED      0x04    // taking poison DOT
#define MFLAG_STUNNED       0x08    // stunned (skip turn)
#define MFLAG_SLEEPING      0x10    // sleeping (auto-hit)
#define MFLAG_FLEEING       0x20    // fleeing (from Turn Undead)
#define MFLAG_UNDEAD_VAR    0x40    // undead variant (Undead Goblin/Troll)
#define MFLAG_RESERVED      0x80    // reserved for future use

// =============================================================================
// MONSTER DEFINITION FLAGS (static, in lookup table)
// =============================================================================

#define MDEF_UNDEAD         0x01    // affected by Turn Undead, Mace bonus
#define MDEF_DEMON          0x02    // affected by Holy weapons
#define MDEF_POISON_ATK     0x04    // attacks can poison (30% chance)
#define MDEF_LIFE_DRAIN     0x08    // drains HP on hit (heals self)
#define MDEF_REGENERATE     0x10    // regenerates 2 HP/turn
#define MDEF_FLYING         0x20    // can fly over pits/traps
#define MDEF_BOSS           0x40    // boss monster (special mechanics)
#define MDEF_RANGED         0x80    // has ranged attack (2-3 tiles)

// =============================================================================
// WEAPON SPECIAL FLAGS
// =============================================================================

#define WEAPON_SPECIAL_NONE         0x00
#define WEAPON_SPECIAL_VS_UNDEAD    0x01    // +3 damage vs undead
#define WEAPON_SPECIAL_VS_DEMON     0x02    // +3 damage vs demon
#define WEAPON_SPECIAL_CLEAVE       0x04    // 25% damage to adjacent enemies
#define WEAPON_SPECIAL_STUN         0x08    // 15% stun chance
#define WEAPON_SPECIAL_LIFE_DRAIN   0x10    // heal 20% of damage dealt
#define WEAPON_SPECIAL_POISON       0x20    // 30% poison chance
#define WEAPON_SPECIAL_PIERCE_ARMOR 0x40    // ignore 50% of enemy AC
#define WEAPON_SPECIAL_TWO_HANDED   0x80    // cannot use shield

// =============================================================================
// ARMOR SPECIAL FLAGS
// =============================================================================

#define ARMOR_SPECIAL_NONE          0x00
#define ARMOR_SPECIAL_FIRE_RESIST   0x01    // -50% fire damage
#define ARMOR_SPECIAL_POISON_IMMUNE 0x02    // immune to poison
#define ARMOR_SPECIAL_MAGIC_RESIST  0x04    // -25% magic damage
#define ARMOR_SPECIAL_STEALTH       0x08    // +20% stealth

// =============================================================================
// SHIELD SPECIAL FLAGS
// =============================================================================

#define SHIELD_SPECIAL_NONE         0x00
#define SHIELD_SPECIAL_BASH         0x01    // can shield bash (stun + 1 dmg)
#define SHIELD_SPECIAL_SPELL_BLOCK  0x02    // 30% chance block magic
#define SHIELD_SPECIAL_REFLECT      0x04    // 15% chance reflect arrows

// =============================================================================
// SCROLL/POTION EFFECT TYPES
// =============================================================================

enum ScrollEffect {
    EFFECT_LIGHT            = 0,    // light aura
    EFFECT_MAP_REVEAL       = 1,    // reveal entire map
    EFFECT_DETECT_SECRET    = 2,    // reveal secret doors/traps
    EFFECT_TELEPORT         = 3,    // random safe teleport
    EFFECT_IDENTIFY         = 4,    // identify item
    EFFECT_ENCHANT_WEAPON   = 5,    // +1 weapon modifier
    EFFECT_ENCHANT_ARMOR    = 6,    // +1 armor modifier
    EFFECT_REMOVE_CURSE     = 7,    // remove curse from item
    EFFECT_SUMMON_ENEMY     = 8,    // CURSED: spawn enemy
    EFFECT_BREAK_WALLS      = 9,    // earthquake (3x3 area)
    EFFECT_TURN_UNDEAD      = 10,   // kill/flee undead
    EFFECT_FIREBALL         = 11,   // area fire damage
    EFFECT_HASTE            = 12,   // speed buff
    EFFECT_SHIELD_BUFF      = 13    // AC buff
};

enum PotionEffect {
    EFFECT_HEAL         = 0,    // restore HP
    EFFECT_FULL_HEAL    = 1,    // restore to max HP
    EFFECT_BERSERK      = 2,    // +50% damage, -20% AC
    EFFECT_REGEN        = 3,    // heal over time
    EFFECT_CURE_POISON  = 4,    // remove poison
    EFFECT_INVISIBLE    = 5     // invisibility
};

// =============================================================================
// BOSS SPECIAL ATTACK TYPES
// =============================================================================

#define BOSS_ATK_FIREBALL       0   // 3x3 area fire damage (Dragon)
#define BOSS_ATK_SUMMON_ADDS    1   // summon 2 minions (Demon)
#define BOSS_ATK_LIFE_DRAIN     2   // drain 10 HP, heal self (Lich)
#define BOSS_ATK_POISON_CLOUD   3   // 5x5 poison cloud
#define BOSS_ATK_TELEPORT       4   // teleport away + heal

// =============================================================================
// PLAYER STATUS EFFECT FLAGS (16-bit bitfield)
// =============================================================================

#define STATUS_NONE         0x0000
#define STATUS_POISONED     0x0001  // -3 HP/turn
#define STATUS_HASTE        0x0002  // +50% speed, +10% hit
#define STATUS_SHIELD_BUFF  0x0004  // +3 AC
#define STATUS_BERSERK      0x0008  // +50% damage, -20% AC
#define STATUS_INVISIBLE    0x0010  // 50% avoid combat
#define STATUS_BLESSED      0x0020  // +2 to all rolls
#define STATUS_CURSED       0x0040  // -2 to all rolls
#define STATUS_STUNNED      0x0080  // skip next turn
#define STATUS_BLIND        0x0100  // -20% hit chance
#define STATUS_REGENERATING 0x0200  // +2 HP/turn
#define STATUS_FIRE_SHIELD  0x0400  // reflect 3 damage
#define STATUS_CONFUSED     0x0800  // 50% random movement

// =============================================================================
// LOOKUP TABLE STRUCTURES (const/ROM data)
// =============================================================================

// Weapon definition (8 bytes each)
typedef struct {
    unsigned char damage;       // base damage (1-15)
    unsigned char hit_bonus;    // to-hit modifier (0-5)
    unsigned char speed;        // attack speed (1-15, affects turn order)
    unsigned char crit_chance;  // critical hit % (0-15)
    unsigned char special;      // special flags (WEAPON_SPECIAL_*)
    unsigned char range;        // attack range (1=melee, 2-3=ranged)
    unsigned char gold_price;   // base price
    unsigned char tile_id;      // display sprite/tile
} WeaponDef;

// Armor definition (5 bytes each)
typedef struct {
    unsigned char armor_class;  // AC bonus (1-10)
    unsigned char weight;       // weight class (0-3, affects movement)
    unsigned char special;      // special properties (ARMOR_SPECIAL_*)
    unsigned char gold_price;   // base price
    unsigned char tile_id;      // display sprite/tile
} ArmorDef;

// Shield definition (5 bytes each)
typedef struct {
    unsigned char defense;      // AC bonus (1-5)
    unsigned char block_chance; // % chance to block (10-35%)
    unsigned char special;      // special properties (SHIELD_SPECIAL_*)
    unsigned char gold_price;   // base price
    unsigned char tile_id;      // display sprite/tile
} ShieldDef;

// Scroll definition (6 bytes each)
typedef struct {
    unsigned char effect_type;  // ScrollEffect enum
    unsigned char magnitude;    // effect strength (damage, radius, etc.)
    unsigned char duration;     // duration in turns (0 = instant)
    unsigned char special;      // special flags (1 = cursed)
    unsigned char gold_price;   // base price
    unsigned char tile_id;      // display sprite/tile
} ScrollDef;

// Potion definition (6 bytes each)
typedef struct {
    unsigned char effect_type;  // PotionEffect enum
    unsigned char magnitude;    // effect strength
    unsigned char duration;     // duration in turns (0 = instant)
    unsigned char special;      // special flags
    unsigned char gold_price;   // base price
    unsigned char tile_id;      // display sprite/tile
} PotionDef;

// Gem definition (3 bytes each) - simple value items
typedef struct {
    unsigned char gold_value;   // selling price
    unsigned char rarity;       // spawn weight (lower = rarer)
    unsigned char tile_id;      // display sprite/tile
} GemDef;

// Monster definition (8 bytes each)
typedef struct {
    unsigned char base_hp;      // base hit points
    unsigned char damage;       // base damage
    unsigned char defense;      // defense value (reduces hit chance)
    unsigned char armor_class;  // AC (reduces damage taken)
    unsigned char xp_value;     // XP awarded on kill
    unsigned char def_flags;    // definition flags (MDEF_*)
    unsigned char sprite_id;    // display sprite
    unsigned char ai_type;      // AI behavior type (AIType enum)
} MonsterDef;

// =============================================================================
// COMBAT STATE STRUCTURES (RAM)
// =============================================================================

// Player status duration tracking (10 bytes)
typedef struct {
    unsigned char poison_turns;         // 0-255
    unsigned char haste_turns;          // 0-255
    unsigned char shield_turns;         // 0-255
    unsigned char berserk_turns;        // 0-255
    unsigned char invis_turns;          // 0-255
    unsigned char blessed_turns;        // 0-255
    unsigned char cursed_turns;         // 0-255
    unsigned char regen_turns;          // 0-255
    unsigned char fire_shield_turns;    // 0-255
    unsigned char confused_turns;       // 0-255
} StatusTimers;

// Boss AI state (3 bytes per boss)
typedef struct {
    unsigned char cooldown;             // turns between special attacks
    unsigned char attack_type;          // current special attack type
    unsigned char current_cooldown;     // countdown to next special
} BossAI;

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

// Runtime monster instance (8 bytes)
typedef struct mon {
    struct mon *next;           // 2 bytes - linked list
    unsigned char x;            // 1 byte - position
    unsigned char y;            // 1 byte - position
    unsigned char type;         // 1 byte - MonsterType enum
    unsigned char hp;           // 1 byte - current HP
    unsigned char flags;        // 1 byte - runtime MFLAG_* flags
    unsigned char state;        // 1 byte - MonsterState enum
} TinyMon;

// =============================================================================
// POOL SIZE CONFIGURATION
// =============================================================================

#define META_PER_ROOM           4       // metadata slots per room
#define GLOBAL_META_POOL_SIZE   16      // global metadata slots
#define MAX_TINY_OBJECTS        48      // max active items
#define MAX_TINY_MONSTERS       6       // max active monsters (sprite limit!)
#define MAX_BOSSES              3       // max boss AI states

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
