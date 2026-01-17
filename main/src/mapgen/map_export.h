// =============================================================================
// Map Export Module Header - Seed-Based Save System
// =============================================================================
// Provides functions for saving map generation seed and configuration.
//
// Only compiled when DEBUG_MAPGEN is defined.
// =============================================================================

#ifndef MAP_EXPORT_H
#define MAP_EXPORT_H

#ifdef DEBUG_MAPGEN

/**
 * @brief Save map seed and configuration to disk
 *
 * Saves only the seed and configuration parameters needed to regenerate
 * the exact same map. File format (sequential file):
 *
 *   Byte 0-1:  Seed (16-bit, little-endian)
 *   Byte 2:    Map size preset (0=SMALL, 1=MEDIUM, 2=LARGE)
 *   Byte 3:    Room count preset
 *   Byte 4:    Room size preset (reserved)
 *   Byte 5:    Secret rooms preset
 *   Byte 6:    False corridors preset
 *   Byte 7:    Secret treasures preset
 *   Byte 8:    Hidden corridors preset
 *
 * Total file size: 9 bytes
 *
 * @param filename PETSCII filename (max 16 chars)
 */
void save_map_seed(const char* filename);

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
unsigned char load_map_seed(const char* filename, MapConfig* config);

#endif // DEBUG_MAPGEN

#endif // MAP_EXPORT_H
