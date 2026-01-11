// Map export utility for C64/Oscar64 compatible binary format
// Exports the compact_map to a .bin file for easy loading on C64

#ifdef DEBUG_MAPGEN

// System headers
#include <c64/kernalio.h>
#include <string.h>
// Project headers
#include "mapgen_types.h"
#include "mapgen_internal.h"
#include "mapgen_api.h"
#include "map_export.h"


// Save the compact map to disk using C64 KERNAL routines (device 8)
// The filename must be a PETSCII string, max 16 chars
// File format:
//   Byte 0-1: PRG load address (added automatically by KERNAL SAVE)
//   Byte 2:   Map size (width == height, 48/72/96)
//   Byte 3+:  Packed tile data (3 bits per tile)
void save_compact_map(const char* filename) {
    // Get current map size from generation parameters
    unsigned char current_map_size = mapgen_get_map_size();

    // Calculate actual bytes needed for this map size
    // Formula: (size * size * 3 + 7) / 8
    unsigned short tile_bits = (unsigned short)current_map_size * current_map_size * 3;
    unsigned short actual_map_bytes = (tile_bits + 7) >> 3;  // Divide by 8 with rounding up

    // Create export buffer: [map_size (1 byte)] + [compact_map data]
    // Static buffer with maximum possible size (96x96 = 6912 bytes + 1 size byte)
    static unsigned char export_buffer[1 + ((96 * 96 * 3 + 7) / 8)];

    // First byte: map size
    export_buffer[0] = current_map_size;

    // Copy actual map data (only needed bytes, not full buffer)
    memcpy(export_buffer + 1, compact_map, actual_map_bytes);

    // Set the filename for KERNAL SAVE
    krnio_setnam(filename);

    // Save to device 8 (disk drive)
    // KERNAL SAVE automatically adds 2-byte PRG header (load address)
    // Final file: [load_addr (2)] + [map_size (1)] + [map_data (actual_map_bytes)]
    krnio_save(8, export_buffer, export_buffer + 1 + actual_map_bytes);
}

#endif // DEBUG_MAPGEN