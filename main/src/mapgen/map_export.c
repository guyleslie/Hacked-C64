// Map export utility for C64/Oscar64 compatible binary format
// Exports the compact_map to a .bin file for easy loading on C64
#include <stdio.h>
#include "../mapgen_types.h"

// Externally defined compact_map
extern unsigned char compact_map[MAP_H * MAP_W * 3 / 8];

// Save the compact map to a binary file
void save_compact_map(const char* filename) {
    FILE* f = fopen(filename, "wb");
    if (!f) return;
    fwrite(compact_map, 1, sizeof(compact_map), f);
    fclose(f);
}
