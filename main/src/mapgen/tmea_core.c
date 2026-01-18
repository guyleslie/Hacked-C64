// =============================================================================
// TILE METADATA EXTENSION ARCHITECTURE (TMEA) v3
// Core Implementation - Oscar64 Optimized
// =============================================================================

#include <stddef.h>  // For NULL
#include "tmea_core.h"
#include "tmea_types.h"
#include "mapgen_types.h"
#include "mapgen_internal.h"
#include "mapgen_utils.h"

// =============================================================================
// GLOBAL STATE DEFINITIONS
// =============================================================================

// Room-scoped metadata storage
RoomTileMeta room_metas[MAX_ROOMS][META_PER_ROOM];  // 240 bytes
unsigned char room_meta_count[MAX_ROOMS];           // 20 bytes

// Global metadata storage (corridors and map-wide)
GlobalTileMeta global_metas[GLOBAL_META_POOL_SIZE]; // 64 bytes
unsigned char global_meta_count;                     // 1 byte

// Entity pools
TinyObj obj_pool[MAX_TINY_OBJECTS];                 // 288 bytes
TinyObj *obj_free_list;                             // 2 bytes
TinyObj *obj_active_list;                           // 2 bytes

TinyMon mon_pool[MAX_TINY_MONSTERS];                // 48 bytes (6 × 8)
TinyMon *mon_free_list;                             // 2 bytes
TinyMon *mon_active_list;                           // 2 bytes

// Total: ~620 bytes

// =============================================================================
// INITIALIZATION FUNCTIONS
// =============================================================================

void init_tmea_system(void) {
    unsigned char i, j;

    // Initialize room metadata pools
    for (i = 0; i < MAX_ROOMS; i++) {
        room_meta_count[i] = 0;

        for (j = 0; j < META_PER_ROOM; j++) {
            room_metas[i][j].local_pos = META_SENTINEL;
            room_metas[i][j].flags = 0;
            room_metas[i][j].data = 0;
        }
    }

    // Initialize global metadata pool
    global_meta_count = 0;
    for (i = 0; i < GLOBAL_META_POOL_SIZE; i++) {
        global_metas[i].x = META_SENTINEL;
        global_metas[i].y = META_SENTINEL;
        global_metas[i].flags = 0;
        global_metas[i].data = 0;
    }

    // Initialize object pool (linked list)
    for (i = 0; i < MAX_TINY_OBJECTS - 1; i++) {
        obj_pool[i].next = &obj_pool[i + 1];
        obj_pool[i].x = 0;
        obj_pool[i].y = 0;
        obj_pool[i].type = 0;
        obj_pool[i].data = 0;
    }
    obj_pool[MAX_TINY_OBJECTS - 1].next = NULL;
    obj_free_list = &obj_pool[0];
    obj_active_list = NULL;

    // Initialize monster pool (linked list)
    for (i = 0; i < MAX_TINY_MONSTERS - 1; i++) {
        mon_pool[i].next = &mon_pool[i + 1];
        mon_pool[i].x = 0;
        mon_pool[i].y = 0;
        mon_pool[i].type = 0;
        mon_pool[i].hp = 0;
        mon_pool[i].flags = 0;
        mon_pool[i].state = MSTATE_IDLE;
    }
    mon_pool[MAX_TINY_MONSTERS - 1].next = NULL;
    mon_free_list = &mon_pool[0];
    mon_active_list = NULL;
}

void reset_tmea_data(void) {
    unsigned char i, j;

    // Reset room metadata counts (pools remain allocated)
    for (i = 0; i < MAX_ROOMS; i++) {
        room_meta_count[i] = 0;
    }

    // Reset global metadata count
    global_meta_count = 0;

    // Reset object pool (rebuild free list)
    for (i = 0; i < MAX_TINY_OBJECTS - 1; i++) {
        obj_pool[i].next = &obj_pool[i + 1];
    }
    obj_pool[MAX_TINY_OBJECTS - 1].next = NULL;
    obj_free_list = &obj_pool[0];
    obj_active_list = NULL;

    // Reset monster pool (rebuild free list)
    for (i = 0; i < MAX_TINY_MONSTERS - 1; i++) {
        mon_pool[i].next = &mon_pool[i + 1];
    }
    mon_pool[MAX_TINY_MONSTERS - 1].next = NULL;
    mon_free_list = &mon_pool[0];
    mon_active_list = NULL;
}

// =============================================================================
// TILE METADATA IMPLEMENTATION
// =============================================================================

unsigned char add_tile_metadata(unsigned char x, unsigned char y,
                                unsigned char flags,
                                unsigned char data) {
    unsigned char room_id;

    // Strategy 1: Try room-based storage (optimal for 70% of cases)
    if (point_in_any_room(x, y, &room_id)) {
        __assume(room_id < MAX_ROOMS);  // Oscar64 optimization hint

        // Check if room pool has space
        if (room_meta_count[room_id] < META_PER_ROOM) {
            // Calculate room-local coordinates
            unsigned char local_x = global_to_local_x(x, room_id);
            unsigned char local_y = global_to_local_y(y, room_id);

            // Get next available slot
            unsigned char idx = room_meta_count[room_id];
            RoomTileMeta *meta = &room_metas[room_id][idx];

            // Store metadata
            meta->local_pos = pack_local_pos(local_x, local_y);
            meta->flags = flags;
            meta->data = data;

            // Increment counter
            room_meta_count[room_id]++;

            // Mark tile as having metadata
            set_compact_tile(x, y, TILE_MARKER);

            return 1; // Success (room-based)
        }

        // Room pool full, fallback to global pool
        // (continue to Strategy 2 below)
    }

    // Strategy 2: Use global pool (corridors or room overflow)
    if (global_meta_count >= GLOBAL_META_POOL_SIZE) {
        return 0; // All pools full - failure
    }

    // Allocate from global pool
    GlobalTileMeta *gmeta = &global_metas[global_meta_count];

    gmeta->x = x;
    gmeta->y = y;
    gmeta->flags = flags;
    gmeta->data = data;

    global_meta_count++;

    // Mark tile as having metadata
    set_compact_tile(x, y, TILE_MARKER);

    return 1; // Success (global pool)
}

unsigned char get_tile_metadata(unsigned char x, unsigned char y,
                                unsigned char *out_flags,
                                unsigned char *out_data) {
    unsigned char room_id;
    unsigned char i;

    // Quick reject: Does tile have metadata marker?
    if (get_compact_tile(x, y) != TILE_MARKER) {
        return 0; // No metadata
    }

    // Strategy 1: Search room pool first (70% hit rate)
    if (point_in_any_room(x, y, &room_id)) {
        __assume(room_id < MAX_ROOMS);

        // Calculate room-local coordinates
        unsigned char local_x = global_to_local_x(x, room_id);
        unsigned char local_y = global_to_local_y(y, room_id);
        unsigned char packed = pack_local_pos(local_x, local_y);

        // Linear search in room's metadata (max 4 items)
        for (i = 0; i < room_meta_count[room_id]; i++) {
            if (room_metas[room_id][i].local_pos == packed) {
                // Found it!
                if (out_flags) *out_flags = room_metas[room_id][i].flags;
                if (out_data) *out_data = room_metas[room_id][i].data;
                return 1;
            }
        }
    }

    // Strategy 2: Search global pool (30% hit rate)
    for (i = 0; i < global_meta_count; i++) {
        if (global_metas[i].x == x && global_metas[i].y == y) {
            // Found it!
            if (out_flags) *out_flags = global_metas[i].flags;
            if (out_data) *out_data = global_metas[i].data;
            return 1;
        }
    }

    // Not found in either pool (should not happen if TILE_MARKER is set)
    return 0;
}

unsigned char remove_tile_metadata(unsigned char x, unsigned char y) {
    unsigned char room_id;
    unsigned char i;

    // Quick reject: Does tile have metadata marker?
    if (get_compact_tile(x, y) != TILE_MARKER) {
        return 0; // No metadata to remove
    }

    // Strategy 1: Try room pool
    if (point_in_any_room(x, y, &room_id)) {
        __assume(room_id < MAX_ROOMS);

        unsigned char local_x = global_to_local_x(x, room_id);
        unsigned char local_y = global_to_local_y(y, room_id);
        unsigned char packed = pack_local_pos(local_x, local_y);

        for (i = 0; i < room_meta_count[room_id]; i++) {
            if (room_metas[room_id][i].local_pos == packed) {
                // Found it - remove by compacting array
                // Move last element to this position
                unsigned char last_idx = room_meta_count[room_id] - 1;
                if (i != last_idx) {
                    room_metas[room_id][i] = room_metas[room_id][last_idx];
                }

                // Clear last slot
                room_metas[room_id][last_idx].local_pos = META_SENTINEL;
                room_metas[room_id][last_idx].flags = 0;
                room_metas[room_id][last_idx].data = 0;

                room_meta_count[room_id]--;

                // Clear TILE_MARKER flag (restore original tile)
                // Note: We don't know the original tile type, so set to TILE_FLOOR
                set_compact_tile(x, y, TILE_FLOOR);

                return 1;
            }
        }
    }

    // Strategy 2: Try global pool
    for (i = 0; i < global_meta_count; i++) {
        if (global_metas[i].x == x && global_metas[i].y == y) {
            // Found it - remove by compacting array
            unsigned char last_idx = global_meta_count - 1;
            if (i != last_idx) {
                global_metas[i] = global_metas[last_idx];
            }

            // Clear last slot
            global_metas[last_idx].x = META_SENTINEL;
            global_metas[last_idx].y = META_SENTINEL;
            global_metas[last_idx].flags = 0;
            global_metas[last_idx].data = 0;

            global_meta_count--;

            // Clear TILE_MARKER flag
            set_compact_tile(x, y, TILE_FLOOR);

            return 1;
        }
    }

    return 0; // Not found
}

unsigned char update_tile_metadata_flags(unsigned char x, unsigned char y,
                                        unsigned char flags) {
    unsigned char room_id;
    unsigned char i;

    // Quick reject
    if (get_compact_tile(x, y) != TILE_MARKER) {
        return 0;
    }

    // Try room pool
    if (point_in_any_room(x, y, &room_id)) {
        __assume(room_id < MAX_ROOMS);

        unsigned char local_x = global_to_local_x(x, room_id);
        unsigned char local_y = global_to_local_y(y, room_id);
        unsigned char packed = pack_local_pos(local_x, local_y);

        for (i = 0; i < room_meta_count[room_id]; i++) {
            if (room_metas[room_id][i].local_pos == packed) {
                room_metas[room_id][i].flags = flags;
                return 1;
            }
        }
    }

    // Try global pool
    for (i = 0; i < global_meta_count; i++) {
        if (global_metas[i].x == x && global_metas[i].y == y) {
            global_metas[i].flags = flags;
            return 1;
        }
    }

    return 0;
}

unsigned char update_tile_metadata_data(unsigned char x, unsigned char y,
                                       unsigned char data) {
    unsigned char room_id;
    unsigned char i;

    // Quick reject
    if (get_compact_tile(x, y) != TILE_MARKER) {
        return 0;
    }

    // Try room pool
    if (point_in_any_room(x, y, &room_id)) {
        __assume(room_id < MAX_ROOMS);

        unsigned char local_x = global_to_local_x(x, room_id);
        unsigned char local_y = global_to_local_y(y, room_id);
        unsigned char packed = pack_local_pos(local_x, local_y);

        for (i = 0; i < room_meta_count[room_id]; i++) {
            if (room_metas[room_id][i].local_pos == packed) {
                room_metas[room_id][i].data = data;
                return 1;
            }
        }
    }

    // Try global pool
    for (i = 0; i < global_meta_count; i++) {
        if (global_metas[i].x == x && global_metas[i].y == y) {
            global_metas[i].data = data;
            return 1;
        }
    }

    return 0;
}

// =============================================================================
// ENTITY POOL IMPLEMENTATION
// =============================================================================

TinyObj* spawn_object(unsigned char x, unsigned char y,
                      unsigned char obj_type) {
    // Check if free list is empty
    if (obj_free_list == NULL) {
        return NULL; // Pool exhausted
    }

    // Allocate from free list
    TinyObj *obj = obj_free_list;
    obj_free_list = obj->next;

    // Initialize object
    obj->x = x;
    obj->y = y;
    obj->type = obj_type;
    obj->data = 0;  // modifier/amount - set by caller if needed

    // Add to active list
    obj->next = obj_active_list;
    obj_active_list = obj;

    return obj;
}

void despawn_object(TinyObj *obj) {
    if (obj == NULL) return;

    // Remove from active list
    if (obj_active_list == obj) {
        // Object is at head of active list
        obj_active_list = obj->next;
    } else {
        // Find predecessor in active list
        TinyObj *current = obj_active_list;
        while (current != NULL && current->next != obj) {
            current = current->next;
        }

        if (current != NULL) {
            current->next = obj->next;
        }
    }

    // Add to free list
    obj->next = obj_free_list;
    obj_free_list = obj;

    // Clear object data
    obj->x = 0;
    obj->y = 0;
    obj->type = 0;
    obj->data = 0;
}

TinyObj* get_objects_at(unsigned char x, unsigned char y) {
    TinyObj *current = obj_active_list;
    TinyObj *result = NULL;

    while (current != NULL) {
        if (current->x == x && current->y == y) {
            // Found an object at this position
            // For now, return first match
            // TODO: Build linked list of all objects at position
            return current;
        }
        current = current->next;
    }

    return NULL;
}

TinyMon* spawn_monster(unsigned char x, unsigned char y,
                       unsigned char mon_type,
                       unsigned char hp) {
    // Check if free list is empty
    if (mon_free_list == NULL) {
        return NULL; // Pool exhausted
    }

    // Allocate from free list
    TinyMon *mon = mon_free_list;
    mon_free_list = mon->next;

    // Initialize monster
    mon->x = x;
    mon->y = y;
    mon->type = mon_type;
    mon->hp = hp;
    mon->flags = MFLAG_ALIVE | MFLAG_HOSTILE;
    mon->state = MSTATE_IDLE;

    // Add to active list
    mon->next = mon_active_list;
    mon_active_list = mon;

    return mon;
}

void despawn_monster(TinyMon *mon) {
    if (mon == NULL) return;

    // Remove from active list
    if (mon_active_list == mon) {
        // Monster is at head of active list
        mon_active_list = mon->next;
    } else {
        // Find predecessor in active list
        TinyMon *current = mon_active_list;
        while (current != NULL && current->next != mon) {
            current = current->next;
        }

        if (current != NULL) {
            current->next = mon->next;
        }
    }

    // Add to free list
    mon->next = mon_free_list;
    mon_free_list = mon;

    // Clear monster data
    mon->x = 0;
    mon->y = 0;
    mon->type = 0;
    mon->hp = 0;
    mon->flags = 0;
    mon->state = MSTATE_IDLE;
}

TinyMon* get_monster_at(unsigned char x, unsigned char y) {
    TinyMon *current = mon_active_list;

    while (current != NULL) {
        if (current->x == x && current->y == y) {
            return current;
        }
        current = current->next;
    }

    return NULL;
}

// =============================================================================
// DOOR METADATA API IMPLEMENTATION
// =============================================================================

unsigned char add_secret_door_metadata(unsigned char x, unsigned char y) {
    // Add door metadata with secret flag
    return add_tile_metadata(x, y, TMTYPE_DOOR | TMFLAG_DOOR_SECRET, 0);
}

unsigned char is_door_secret(unsigned char x, unsigned char y) {
    unsigned char flags, data;

    // Check if tile has metadata
    if (!get_tile_metadata(x, y, &flags, &data)) {
        return 0; // No metadata = not secret
    }

    // Check if metadata is door type
    if (!is_meta_type(flags, TMTYPE_DOOR)) {
        return 0; // Not a door metadata
    }

    // Check if secret flag is set AND not revealed
    return (flags & TMFLAG_DOOR_SECRET) && !(flags & TMFLAG_DOOR_REVEALED);
}

unsigned char is_door_locked(unsigned char x, unsigned char y) {
    unsigned char flags, data;

    if (!get_tile_metadata(x, y, &flags, &data)) {
        return 0; // No metadata = not locked
    }

    if (!is_meta_type(flags, TMTYPE_DOOR)) {
        return 0;
    }

    return (flags & TMFLAG_DOOR_LOCKED) != 0;
}

unsigned char is_door_trapped(unsigned char x, unsigned char y) {
    unsigned char flags, data;

    if (!get_tile_metadata(x, y, &flags, &data)) {
        return 0; // No metadata = not trapped
    }

    if (!is_meta_type(flags, TMTYPE_DOOR)) {
        return 0;
    }

    return (flags & TMFLAG_DOOR_TRAPPED) != 0;
}

unsigned char reveal_secret_door(unsigned char x, unsigned char y) {
    unsigned char flags, data;

    // Get current metadata
    if (!get_tile_metadata(x, y, &flags, &data)) {
        return 0; // No metadata
    }

    // Check if it's a secret door
    if (!is_meta_type(flags, TMTYPE_DOOR) || !(flags & TMFLAG_DOOR_SECRET)) {
        return 0; // Not a secret door
    }

    // Set revealed flag
    flags |= TMFLAG_DOOR_REVEALED;

    // Update metadata
    return update_tile_metadata_flags(x, y, flags);
}

unsigned char set_door_open(unsigned char x, unsigned char y,
                            unsigned char is_open) {
    unsigned char flags, data;

    // Try to get existing metadata
    if (get_tile_metadata(x, y, &flags, &data)) {
        // Update existing metadata
        if (is_open) {
            flags |= TMFLAG_DOOR_OPEN;
        } else {
            flags &= ~TMFLAG_DOOR_OPEN;
        }
        return update_tile_metadata_flags(x, y, flags);
    } else {
        // No metadata exists - create new entry
        flags = TMTYPE_DOOR;
        if (is_open) {
            flags |= TMFLAG_DOOR_OPEN;
        }
        return add_tile_metadata(x, y, flags, 0);
    }
}
