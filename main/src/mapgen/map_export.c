// Map export utility for C64/Oscar64 compatible binary format
// Exports the compact_map to a .bin file for easy loading on C64

// System headers
#include <c64/kernalio.h>
#include <string.h>
// Project headers
#include "mapgen_types.h"
#include "mapgen_internal.h"
#include "map_export.h"


// Save the compact map to disk using C64 KERNAL routines (device 8)
// The filename must be a PETSCII string, max 16 chars
void save_compact_map(const char* filename) {
    // Calculate the exact size of the compact map in bytes
    // 64x64 tiles * 3 bits per tile = 12288 bits = 1536 bytes
    const unsigned short map_size = (MAP_H * MAP_W * 3 + 7) / 8; // Round up division
    
    // Set the filename for KERNAL SAVE
    krnio_setnam(filename);
    
    // Save the compact_map array to device 8 (disk drive)
    // Parameters: device number, start address, end address (exclusive)
    krnio_save(8, compact_map, compact_map + map_size);
    
    // The file is saved as a PRG file with load address
    // This allows the map to be loaded back with LOAD "MAPDATA.BIN",8,1
}