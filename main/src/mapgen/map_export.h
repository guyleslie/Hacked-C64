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
 * the exact same map. File format:
 *
 *   Byte 0-1:  PRG load address (added by KERNAL)
 *   Byte 2-3:  Seed (16-bit, little-endian)
 *   Byte 4:    Map size preset (0=SMALL, 1=MEDIUM, 2=LARGE)
 *   Byte 5:    Room count preset
 *   Byte 6:    Room size preset (reserved)
 *   Byte 7:    Secret rooms preset
 *   Byte 8:    False corridors preset
 *   Byte 9:    Secret treasures preset
 *   Byte 10:   Hidden corridors preset
 *
 * Total file size: 11 bytes
 *
 * @param filename PETSCII filename (max 16 chars)
 */
void save_map_seed(const char* filename);

#endif // DEBUG_MAPGEN

#endif // MAP_EXPORT_H
