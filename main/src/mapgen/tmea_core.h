#ifndef TMEA_CORE_H
#define TMEA_CORE_H

// =============================================================================
// TILE METADATA EXTENSION ARCHITECTURE (TMEA) v3
// Core API and Global State
// =============================================================================
//
// TMEA provides a two-tier metadata system:
// 1. Room-scoped metadata: Fast lookup for tiles inside rooms (70% of cases)
// 2. Global metadata pool: Fallback for corridors and map-wide features (30%)
//
// API Design:
// - Unified interface: add_tile_metadata() / get_tile_metadata()
// - Automatic routing: System chooses room vs global storage transparently
// - Zero-copy lookups: Returns pointers to metadata structures
//
// Performance:
// - Room metadata lookup: ~260 cycles (0.26ms @ 1MHz)
// - Global metadata lookup: ~440 cycles (0.44ms @ 1MHz)
// - Average (weighted): ~310 cycles (0.31ms @ 1MHz)
//
// =============================================================================

#include "tmea_types.h"
#include "mapgen_types.h"
#include "mapgen_internal.h"

// =============================================================================
// GLOBAL STATE DECLARATIONS
// =============================================================================

// Room-scoped tile metadata storage
// Array indexed by: [room_id][meta_slot_index]
// Each room has META_PER_ROOM (4) metadata slots
extern RoomTileMeta room_metas[MAX_ROOMS][META_PER_ROOM];  // 240 bytes
extern unsigned char room_meta_count[MAX_ROOMS];           // 20 bytes

// Global tile metadata storage (for corridors and map-wide features)
// Linear array with sequential allocation
extern GlobalTileMeta global_metas[GLOBAL_META_POOL_SIZE]; // 64 bytes
extern unsigned char global_meta_count;                     // 1 byte

// Entity pool storage (objects and monsters)
// Implemented as linked lists with free/active list heads
extern TinyObj obj_pool[MAX_TINY_OBJECTS];                 // 288 bytes
extern TinyObj *obj_free_list;                             // 2 bytes
extern TinyObj *obj_active_list;                           // 2 bytes

extern TinyMon mon_pool[MAX_TINY_MONSTERS];                // 48 bytes (6 monsters × 8 bytes)
extern TinyMon *mon_free_list;                             // 2 bytes
extern TinyMon *mon_active_list;                           // 2 bytes

// Total TMEA overhead: ~620 bytes (reduced monster pool)

// =============================================================================
// INITIALIZATION FUNCTIONS
// =============================================================================

/**
 * @brief Initialize TMEA system (call once at startup)
 *
 * Initializes all metadata pools and entity pools to empty state.
 * Must be called before any other TMEA functions.
 *
 * Resets:
 * - Room metadata counts to 0
 * - Global metadata count to 0
 * - Object/monster free lists
 * - All metadata to sentinel values
 *
 * Performance: ~1000 cycles (1ms @ 1MHz)
 */
void init_tmea_system(void);

/**
 * @brief Reset TMEA system for new map generation
 *
 * Clears all metadata and entities while preserving pool structures.
 * Called at start of each new dungeon generation.
 *
 * Performance: ~500 cycles (0.5ms @ 1MHz)
 */
void reset_tmea_data(void);

// =============================================================================
// TILE METADATA API (Unified Room+Global Interface)
// =============================================================================

/**
 * @brief Add metadata to tile with automatic room/global routing
 *
 * @param x Global X coordinate
 * @param y Global Y coordinate
 * @param flags Type and state flags (TileMetaType + type-specific flags)
 * @param data Extra data byte (key ID, damage, etc.)
 * @return 1 if successful, 0 if all pools are full
 *
 * Routing Logic:
 * 1. Check if tile is inside a room -> use room pool (fast)
 * 2. If room pool is full -> fallback to global pool
 * 3. If not in room -> use global pool (corridors)
 * 4. If all pools full -> return 0 (failure)
 *
 * Side Effects:
 * - Sets compact_map[x,y] to TILE_MARKER to flag metadata presence
 * - Increments appropriate pool counter
 *
 * Performance:
 * - Room metadata: ~240 cycles (0.24ms)
 * - Global metadata: ~230 cycles (0.23ms)
 */
unsigned char add_tile_metadata(unsigned char x, unsigned char y,
                                unsigned char flags,
                                unsigned char data);

/**
 * @brief Get metadata from tile with automatic room/global routing
 *
 * @param x Global X coordinate
 * @param y Global Y coordinate
 * @param out_flags Pointer to store flags byte (can be NULL)
 * @param out_data Pointer to store data byte (can be NULL)
 * @return 1 if metadata found, 0 if no metadata at position
 *
 * Lookup Strategy:
 * 1. Quick check: Is tile marked as TILE_MARKER?
 * 2. If yes, search room pool first (70% hit rate)
 * 3. If not found, search global pool (30% hit rate)
 * 4. Return 0 if not found in either pool
 *
 * Performance:
 * - Room hit: ~260 cycles (0.26ms)
 * - Global hit: ~440 cycles (0.44ms)
 * - Miss: ~50 cycles (0.05ms - quick reject)
 */
unsigned char get_tile_metadata(unsigned char x, unsigned char y,
                                unsigned char *out_flags,
                                unsigned char *out_data);

/**
 * @brief Remove metadata from tile
 *
 * @param x Global X coordinate
 * @param y Global Y coordinate
 * @return 1 if metadata was found and removed, 0 if no metadata existed
 *
 * Removes metadata from room or global pool and clears TILE_MARKER flag.
 * Note: Creates a "hole" in the metadata array - compaction not performed.
 *
 * Performance: ~300 cycles (0.3ms)
 */
unsigned char remove_tile_metadata(unsigned char x, unsigned char y);

/**
 * @brief Update existing metadata flags
 *
 * @param x Global X coordinate
 * @param y Global Y coordinate
 * @param flags New flags value
 * @return 1 if successful, 0 if no metadata at position
 *
 * Faster than remove + add for flag updates.
 *
 * Performance: ~280 cycles (0.28ms)
 */
unsigned char update_tile_metadata_flags(unsigned char x, unsigned char y,
                                        unsigned char flags);

/**
 * @brief Update existing metadata data byte
 *
 * @param x Global X coordinate
 * @param y Global Y coordinate
 * @param data New data value
 * @return 1 if successful, 0 if no metadata at position
 *
 * Performance: ~280 cycles (0.28ms)
 */
unsigned char update_tile_metadata_data(unsigned char x, unsigned char y,
                                       unsigned char data);

// =============================================================================
// DOOR METADATA API (Convenience Wrappers for TILE_DOOR)
// =============================================================================

/**
 * @brief Add secret door metadata to tile
 *
 * @param x Global X coordinate
 * @param y Global Y coordinate
 * @return 1 if successful, 0 if metadata pool is full
 *
 * Marks door as secret (hidden from player until discovered).
 * Must be called on a tile that contains TILE_DOOR.
 *
 * Performance: ~240-280 cycles
 */
unsigned char add_secret_door_metadata(unsigned char x, unsigned char y);

/**
 * @brief Check if door is secret (hidden)
 *
 * @param x Global X coordinate
 * @param y Global Y coordinate
 * @return 1 if door is secret and not revealed, 0 otherwise
 *
 * Performance: ~260-440 cycles (metadata lookup)
 */
unsigned char is_door_secret(unsigned char x, unsigned char y);

/**
 * @brief Check if door is locked
 *
 * @param x Global X coordinate
 * @param y Global Y coordinate
 * @return 1 if door is locked, 0 otherwise
 *
 * Performance: ~260-440 cycles
 */
unsigned char is_door_locked(unsigned char x, unsigned char y);

/**
 * @brief Check if door is trapped
 *
 * @param x Global X coordinate
 * @param y Global Y coordinate
 * @return 1 if door has trap, 0 otherwise
 *
 * Performance: ~260-440 cycles
 */
unsigned char is_door_trapped(unsigned char x, unsigned char y);

/**
 * @brief Reveal secret door (discovered by player)
 *
 * @param x Global X coordinate
 * @param y Global Y coordinate
 * @return 1 if successful, 0 if not a secret door
 *
 * Sets TMFLAG_DOOR_REVEALED flag on secret door metadata.
 *
 * Performance: ~280 cycles
 */
unsigned char reveal_secret_door(unsigned char x, unsigned char y);

/**
 * @brief Set door open/closed state
 *
 * @param x Global X coordinate
 * @param y Global Y coordinate
 * @param is_open 1 to open, 0 to close
 * @return 1 if successful, 0 if failed
 *
 * Updates TMFLAG_DOOR_OPEN flag. If door has no metadata yet,
 * creates metadata entry for the door.
 *
 * Performance: ~240-280 cycles
 */
unsigned char set_door_open(unsigned char x, unsigned char y,
                            unsigned char is_open);

// =============================================================================
// ENTITY POOL API (Objects and Monsters)
// =============================================================================

/**
 * @brief Spawn object at global coordinates
 *
 * @param x Global X coordinate
 * @param y Global Y coordinate
 * @param obj_type Object type (ObjectType enum)
 * @return Pointer to spawned object, or NULL if pool is full
 *
 * Allocates object from free list and adds to active list.
 * Initializes all fields to default values.
 *
 * Performance: ~90 cycles (0.09ms)
 */
TinyObj* spawn_object(unsigned char x, unsigned char y,
                      unsigned char obj_type);

/**
 * @brief Despawn object and return to free list
 *
 * @param obj Pointer to object to despawn
 *
 * Removes object from active list and returns to free list.
 * Object pointer becomes invalid after this call.
 *
 * Performance: ~120 cycles (0.12ms)
 */
void despawn_object(TinyObj *obj);

/**
 * @brief Get list of all objects at coordinates
 *
 * @param x Global X coordinate
 * @param y Global Y coordinate
 * @return Pointer to first object at position, or NULL if none
 *
 * Returns linked list of objects at position.
 * Use obj->next to iterate through multiple objects.
 *
 * Performance: O(n) where n = active object count
 * Worst case: ~2400 cycles for 48 objects
 */
TinyObj* get_objects_at(unsigned char x, unsigned char y);

/**
 * @brief Spawn monster at global coordinates
 *
 * @param x Global X coordinate
 * @param y Global Y coordinate
 * @param mon_type Monster type (MonsterType enum)
 * @param hp Initial hit points
 * @return Pointer to spawned monster, or NULL if pool is full
 *
 * Performance: ~90 cycles (0.09ms)
 */
TinyMon* spawn_monster(unsigned char x, unsigned char y,
                       unsigned char mon_type,
                       unsigned char hp);

/**
 * @brief Despawn monster and return to free list
 *
 * @param mon Pointer to monster to despawn
 *
 * Performance: ~120 cycles (0.12ms)
 */
void despawn_monster(TinyMon *mon);

/**
 * @brief Get monster at coordinates
 *
 * @param x Global X coordinate
 * @param y Global Y coordinate
 * @return Pointer to monster at position, or NULL if none
 *
 * Returns first monster found at position.
 * Note: Typically only one monster per tile in roguelikes.
 *
 * Performance: O(n) where n = active monster count
 * Worst case: ~1200 cycles for 24 monsters
 */
TinyMon* get_monster_at(unsigned char x, unsigned char y);

// =============================================================================
// INLINE HELPER FUNCTIONS (Oscar64 Optimization)
// =============================================================================

/**
 * @brief Pack local room coordinates into single byte
 *
 * @param local_x Room-local X (0-15)
 * @param local_y Room-local Y (0-15)
 * @return Packed byte (x:4bit + y:4bit)
 *
 * Performance: ~10 cycles (inline)
 */
static inline unsigned char pack_local_pos(unsigned char local_x,
                                           unsigned char local_y) {
    return (local_x << 4) | (local_y & 0x0F);
}

/**
 * @brief Unpack local X from packed coordinate
 *
 * @param packed Packed coordinate byte
 * @return Local X coordinate (0-15)
 *
 * Performance: ~5 cycles (inline)
 */
static inline unsigned char unpack_local_x(unsigned char packed) {
    return packed >> 4;
}

/**
 * @brief Unpack local Y from packed coordinate
 *
 * @param packed Packed coordinate byte
 * @return Local Y coordinate (0-15)
 *
 * Performance: ~5 cycles (inline)
 */
static inline unsigned char unpack_local_y(unsigned char packed) {
    return packed & 0x0F;
}

/**
 * @brief Convert global to room-local X coordinate
 *
 * @param global_x Global X coordinate
 * @param room_id Room index
 * @return Room-local X coordinate
 *
 * Performance: ~15 cycles (inline)
 */
static inline unsigned char global_to_local_x(unsigned char global_x,
                                              unsigned char room_id) {
    return global_x - room_list[room_id].x;
}

/**
 * @brief Convert global to room-local Y coordinate
 *
 * @param global_y Global Y coordinate
 * @param room_id Room index
 * @return Room-local Y coordinate
 *
 * Performance: ~15 cycles (inline)
 */
static inline unsigned char global_to_local_y(unsigned char global_y,
                                              unsigned char room_id) {
    return global_y - room_list[room_id].y;
}

/**
 * @brief Check if metadata type matches
 *
 * @param flags Flags byte from metadata
 * @param type TileMetaType enum value
 * @return 1 if match, 0 otherwise
 *
 * Performance: ~8 cycles (inline)
 */
static inline unsigned char is_meta_type(unsigned char flags,
                                        unsigned char type) {
    return (flags & TMTYPE_MASK) == type;
}

#endif // TMEA_CORE_H
