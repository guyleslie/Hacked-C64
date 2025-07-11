// Map export utility for C64/Oscar64 compatible binary format
// Exports the compact_map to a .bin file for easy loading on C64
#include "mapgen/mapgen_types.h"

// Externally defined compact_map
extern unsigned char compact_map[MAP_H * MAP_W * 3 / 8];

// Save the compact map to disk using C64 KERNAL routines (device 8)
// The filename must be a PETSCII string, max 16 chars, and reside in C64 RAM.
//
// Example usage: save_compact_map("MAPDATA");
void save_compact_map(const char* filename) {
    // Calculate start and end address of the data to save
    unsigned int start = (unsigned int)(compact_map);
    unsigned int end = start + sizeof(compact_map);

    // Calculate filename length (max 16 chars)
    unsigned char fnlen = 0;
    const char* p = filename;
    while (*p && fnlen < 16) { ++fnlen; ++p; }

    // Copy filename to C64 RAM buffer (assume $033C)
    unsigned char* fnptr = (unsigned char*)0x033C;
    for (unsigned char i = 0; i < fnlen; ++i) {
        fnptr[i] = filename[i];
    }

    // Set filename length at $B7, pointer at $FB/$FC
    *((unsigned char*)0x00B7) = fnlen;
    *((unsigned char*)0x00FB) = 0x3C; // $033C low
    *((unsigned char*)0x00FC) = 0x03; // $033C high

    // Set start and end address for SAVE at $AE/$AF (start), $B0/$B1 (end)
    *((unsigned char*)0x00AE) = (unsigned char)(start & 0xFF);
    *((unsigned char*)0x00AF) = (unsigned char)((start >> 8) & 0xFF);
    *((unsigned char*)0x00B0) = (unsigned char)(end & 0xFF);
    *((unsigned char*)0x00B1) = (unsigned char)((end >> 8) & 0xFF);


    // Call KERNAL SAVE routine ($FFD8)
    // Device number in A (8 = disk), filename info already set up
    __asm {
        lda #8
        jsr $ffd8
    }

    // Note: No error checking is performed. The file will be saved as PRG to device 8.
}
