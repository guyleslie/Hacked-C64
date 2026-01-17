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
//   Byte 2:    Map size preset (0=SMALL, 1=MEDIUM, 2=LARGE)
//   Byte 3:    Room count preset
//   Byte 4:    Room size preset (reserved)
//   Byte 5:    Secret rooms preset
//   Byte 6:    False corridors preset
//   Byte 7:    Secret treasures preset
//   Byte 8:    Hidden corridors preset
//
// Total: 9 bytes (no PRG header, sequential file format)
// =============================================================================

// Export buffer for seed-based save (9 bytes)
static unsigned char seed_export_buffer[9];

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

    // Use the stored preset value directly - it already contains the correct settings
    // This avoids derivation errors and ensures exact reproducibility
    unsigned char preset = current_params.preset;

    // Store config presets (all use the same preset for consistency)
    seed_export_buffer[2] = preset;  // map_size
    seed_export_buffer[3] = preset;  // room_count
    seed_export_buffer[4] = preset;  // room_size (reserved)
    seed_export_buffer[5] = preset;  // secret_rooms
    seed_export_buffer[6] = preset;  // false_corridors
    seed_export_buffer[7] = preset;  // secret_treasures
    seed_export_buffer[8] = preset;  // hidden_corridors

    // Set the filename for file operations
    krnio_setnam(filename);

    // Open file for writing on device 8 (floppy)
    // fnum=2, device=8, channel=1 (write mode)
    if (krnio_open(2, 8, 1)) {
        // Write 9 bytes of seed/config data (no PRG header)
        krnio_write(2, (const char*)seed_export_buffer, 9);
        krnio_close(2);
    }
}

/**
 * @brief Load map seed and configuration from disk
 *
 * Loads seed and configuration parameters from file, then sets up
 * the mapgen system to regenerate the exact same map.
 *
 * @param filename PETSCII filename (max 16 chars)
 * @param config Output configuration to populate
 * @return 1 on success, 0 on failure
 */
unsigned char load_map_seed(const char* filename, MapConfig* config) {
    unsigned int seed;
    int bytes_read;

    // Set the filename for file operations
    krnio_setnam(filename);

    // Open file for reading on device 8 (floppy)
    // fnum=2, device=8, channel=0 (read mode)
    if (!krnio_open(2, 8, 0)) {
        return 0;  // Open failed
    }

    // Read 9 bytes of seed/config data
    bytes_read = krnio_read(2, (char*)seed_export_buffer, 9);
    krnio_close(2);

    // Check if we read enough data
    if (bytes_read < 9) {
        return 0;  // Read failed or incomplete
    }

    // Extract seed (little-endian)
    seed = seed_export_buffer[0] | ((unsigned int)seed_export_buffer[1] << 8);

    // Initialize mapgen with loaded seed
    mapgen_init(seed);

    // Extract configuration presets
    config->map_size = (PresetLevel)seed_export_buffer[2];
    config->room_count = (PresetLevel)seed_export_buffer[3];
    config->room_size = (PresetLevel)seed_export_buffer[4];
    config->secret_rooms = (PresetLevel)seed_export_buffer[5];
    config->false_corridors = (PresetLevel)seed_export_buffer[6];
    config->secret_treasures = (PresetLevel)seed_export_buffer[7];
    config->hidden_corridors = (PresetLevel)seed_export_buffer[8];

    // Validate loaded values (must be 0-2)
    if (config->map_size > LEVEL_LARGE) config->map_size = LEVEL_MEDIUM;
    if (config->room_count > LEVEL_LARGE) config->room_count = LEVEL_MEDIUM;
    if (config->room_size > LEVEL_LARGE) config->room_size = LEVEL_MEDIUM;
    if (config->secret_rooms > LEVEL_LARGE) config->secret_rooms = LEVEL_MEDIUM;
    if (config->false_corridors > LEVEL_LARGE) config->false_corridors = LEVEL_MEDIUM;
    if (config->secret_treasures > LEVEL_LARGE) config->secret_treasures = LEVEL_MEDIUM;
    if (config->hidden_corridors > LEVEL_LARGE) config->hidden_corridors = LEVEL_MEDIUM;

    return 1;  // Success
}

#endif // DEBUG_MAPGEN
