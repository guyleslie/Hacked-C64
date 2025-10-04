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
    // Calculate the actual size of the compact_map array
    const unsigned short map_size = sizeof(compact_map);
    
    // Set the filename for KERNAL SAVE
    krnio_setnam(filename);
    
    // Save the compact_map raw data to device 8 (disk drive)
    // Use pointer arithmetic that matches actual array bounds
    krnio_save(8, compact_map, compact_map + map_size);
    
    // The file is saved as a PRG file with load address
    // This allows the map to be loaded back with LOAD "MAPDATA.BIN",8,1
}