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
// File format (seed-based, reproducible):
//   Byte 0-1:  PRG load address (added automatically by KERNAL SAVE)
//   Byte 2-3:  Seed (16-bit, little-endian)
//   Byte 4:    Map size preset (0=SMALL, 1=MEDIUM, 2=LARGE)
//   Byte 5:    Room count preset
//   Byte 6:    Room size preset (reserved)
//   Byte 7:    Secret rooms preset
//   Byte 8:    False corridors preset
//   Byte 9:    Secret treasures preset
//   Byte 10:   Hidden corridors preset
//
// Total: 9 bytes of data (+ 2 byte PRG header = 11 bytes)
// =============================================================================

// Export buffer for seed-based save (9 bytes)
static unsigned char seed_export_buffer[9];

// External reference to current generation parameters
extern MapParameters current_params;

/**
 * @brief Save map seed and configuration to disk
 *
 * Saves only the seed and configuration parameters needed to regenerate
 * the exact same map. Much smaller than saving raw map data (~11 bytes
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

    // Set the filename for KERNAL SAVE
    krnio_setnam(filename);

    // Save to device 8 (disk drive)
    // KERNAL SAVE automatically adds 2-byte PRG header (load address)
    // Final file: [load_addr (2)] + [seed (2)] + [config (7)] = 11 bytes
    krnio_save(8, seed_export_buffer, seed_export_buffer + 9);
}

#endif // DEBUG_MAPGEN
