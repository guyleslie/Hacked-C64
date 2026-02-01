// =============================================================================
// Map Export Module - Seed-Based Save System
// =============================================================================
// Exports map generation seed and configuration for reproducible regeneration.
// File size: ~11 bytes (vs 800-2400+ bytes for packed map data)
//
// Only compiled when DEBUG_MAPGEN is defined.
// =============================================================================

#ifdef DEBUG_MAPGEN

// System headers
#include <c64/kernalio.h>
// Project headers
#include "mapgen_types.h"
#include "mapgen_internal.h"
#include "mapgen_api.h"
#include "mapgen_config.h"
#include "map_export.h"

// =============================================================================
// SEED-BASED SAVE FORMAT
// =============================================================================
// File format (sequential file, seed-based, reproducible):
//   Byte 0-1:  Seed (16-bit, little-endian)
//   Byte 2:    Packed presets (2 bits each: map_size, hidden_rooms, niches, deception)
//
// Total: 3 bytes
// =============================================================================

// Export buffer for seed-based save (7 bytes)
static unsigned char seed_export_buffer[7];

// External reference to current generation parameters
extern MapParameters current_params;

/**
 * @brief Save map seed and configuration to disk
 *
 * Saves only the seed and configuration parameters needed to regenerate
 * the exact same map. Much smaller than saving raw map data (9 bytes
 * vs 800-2400+ bytes).
 *
 * @param filename PETSCII filename (max 16 chars)
 */
void save_map_seed(const char* filename) {
    // Get seed from mapgen system
    unsigned int seed = mapgen_get_seed();

    // Store seed as little-endian
    seed_export_buffer[0] = (unsigned char)(seed & 0xFF);        // Low byte
    seed_export_buffer[1] = (unsigned char)((seed >> 8) & 0xFF); // High byte

    // Pack 4 presets into 1 byte (2 bits each, values 0-2)
    // Bits: [7:6]=deception, [5:4]=niches, [3:2]=hidden_rooms, [1:0]=map_size
    seed_export_buffer[2] =
        ((current_params.deception_count > 30 ? 2 : current_params.deception_count > 15 ? 1 : 0) << 6) |
        ((current_params.niche_count > 30 ? 2 : current_params.niche_count > 15 ? 1 : 0) << 4) |
        ((current_params.hidden_room_count > 3 ? 2 : current_params.hidden_room_count > 1 ? 1 : 0) << 2) |
        (current_params.grid_size > 4 ? 2 : current_params.grid_size > 3 ? 1 : 0);

    krnio_setnam(filename);
    if (krnio_open(2, 8, 1)) {
        krnio_write(2, (const char*)seed_export_buffer, 3);
        krnio_close(2);
    }
}

/**
 * @brief Load map seed and configuration from disk
 *
 * @param filename PETSCII filename (max 16 chars)
 * @param config Output configuration to populate
 * @return 1 on success, 0 on failure
 */
unsigned char load_map_seed(const char* filename, MapConfig* config) {
    krnio_setnam(filename);
    if (!krnio_open(2, 8, 0)) {
        return 0;
    }

    int bytes_read = krnio_read(2, (char*)seed_export_buffer, 3);
    krnio_close(2);

    if (bytes_read < 3) {
        return 0;
    }

    // Extract seed (little-endian)
    unsigned int seed = seed_export_buffer[0] | ((unsigned int)seed_export_buffer[1] << 8);
    mapgen_init(seed);

    // Unpack presets from byte 2
    unsigned char packed = seed_export_buffer[2];
    config->map_size = (PresetLevel)(packed & 0x03);
    config->hidden_rooms = (PresetLevel)((packed >> 2) & 0x03);
    config->niches = (PresetLevel)((packed >> 4) & 0x03);
    config->deception = (PresetLevel)((packed >> 6) & 0x03);

    // Clamp to valid range (0-2)
    if (config->map_size > LEVEL_LARGE) config->map_size = LEVEL_MEDIUM;
    if (config->hidden_rooms > LEVEL_LARGE) config->hidden_rooms = LEVEL_MEDIUM;
    if (config->niches > LEVEL_LARGE) config->niches = LEVEL_MEDIUM;
    if (config->deception > LEVEL_LARGE) config->deception = LEVEL_MEDIUM;

    return 1;
}

#endif // DEBUG_MAPGEN
