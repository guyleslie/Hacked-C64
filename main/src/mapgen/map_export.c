// Map export utility for C64/Oscar64 compatible binary format
// Exports the compact_map to a .bin file for easy loading on C64
#include <c64/kernalio.h>
#include "mapgen_types.h"
#include "mapgen_globals.h"

// Save the compact map to disk using C64 KERNAL routines (device 8)
// The filename must be a PETSCII string, max 16 chars, and reside in C64 RAM.
void save_compact_map(const char* filename) {
    // Oscar64-style export: set filename and save using KERNAL routines
    // Save the compact_map array to device 8 
    krnio_setnam(filename); 
    krnio_save(8, (const char*)compact_map, (const char*)(compact_map + sizeof(compact_map)));
}
