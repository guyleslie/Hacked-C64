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
    const unsigned short map_size = COMPACT_MAP_SIZE; // 3072 bytes
    
    // Set the filename for KERNAL SAVE
    krnio_setnam(filename);
    
    // Save the compact_map raw data to device 8 (disk drive)
    // Original simple approach - just save the raw map data
    krnio_save(8, compact_map, compact_map + map_size);
    
    // The file is saved as a PRG file with load address
    // This allows the map to be loaded back with LOAD "MAPDATA.BIN",8,1
}