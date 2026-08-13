// =============================================================================
// C64 Map Generator Benchmark
// =============================================================================
// Runs a fixed mix of normal and difficult seeds without DEBUG_MAPGEN UI code.
// VICE's debug cartridge register exits the emulator when the suite is done,
// allowing the host runner to find the exact minimum -limitcycles value.

#include "mapgen/mapgen_api.h"
#include "mapgen/mapgen_config.h"
#include "mapgen/mapgen_internal.h"

// OSCAR64 single-file module composition, matching main/src/main.c.
#include "mapgen/tmea_core.c"
#include "mapgen/tmea_data.c"
#include "mapgen/mapgen_config.c"
#include "mapgen/mapgen_utils.c"
#include "mapgen/map_generation.c"
#include "mapgen/room_management.c"
#include "mapgen/connection_system.c"

#define VICE_DEBUG_EXIT (*(volatile unsigned char *)0xD7FF)
#define BENCHMARK_COMPLETE_EXIT 0x42

typedef struct {
    unsigned int seed;
    unsigned char map_size;
} BenchmarkCase;

// Includes ordinary seeds plus known retry-heavy placement cases.
static const BenchmarkCase benchmark_cases[] = {
    {    1, 0 },
    { 4095, 0 },
    {    1, 1 },
    {12345, 1 },
    { 1583, 1 },
    { 6116, 1 },
    {    1, 2 },
    {12345, 2 }
};

#if defined(BENCH_CHECKSUM_LOW) || defined(BENCH_CHECKSUM_HIGH)
static unsigned int checksum_byte(unsigned int checksum, unsigned char value) {
    checksum = (checksum << 5) | (checksum >> 11);
    return checksum ^ value;
}

static unsigned int checksum_generated_map(unsigned int checksum) {
    unsigned short tile_bits = (unsigned short)current_params.map_width *
                               current_params.map_height * 3;
    unsigned short total_bytes = (tile_bits + 7) >> 3;

    for (unsigned short i = 0; i < total_bytes; i++) {
        checksum = checksum_byte(checksum, compact_map[i]);
    }

    checksum = checksum_byte(checksum, room_count);
    checksum = checksum_byte(checksum, total_connections);
    checksum = checksum_byte(checksum, total_hidden_rooms);
    checksum = checksum_byte(checksum, total_niches);
    checksum = checksum_byte(checksum, total_decoys);
    return checksum;
}
#endif

int main(void) {
    const unsigned char case_count =
        sizeof(benchmark_cases) / sizeof(benchmark_cases[0]);

#if defined(BENCH_CHECKSUM_LOW) || defined(BENCH_CHECKSUM_HIGH)
    unsigned int checksum = 0xC64D;
#endif

    init_tmea_system();

    for (unsigned char i = 0; i < case_count; i++) {
        mapgen_init(benchmark_cases[i].seed);
        if (mapgen_generate_with_params(
                benchmark_cases[i].map_size,
                1,  // 25% hidden rooms
                1,  // 25% niches
                1   // 25% deception
            ) != 0) {
            VICE_DEBUG_EXIT = 0x7F;
            while (1) {}
        }

#if defined(BENCH_CHECKSUM_LOW) || defined(BENCH_CHECKSUM_HIGH)
        checksum = checksum_generated_map(checksum);
#endif
    }

#if defined(BENCH_CHECKSUM_LOW)
    VICE_DEBUG_EXIT = (unsigned char)(checksum & 0xFF);
#elif defined(BENCH_CHECKSUM_HIGH)
    VICE_DEBUG_EXIT = (unsigned char)(checksum >> 8);
#else
    // Keep this distinct from VICE's successful -limitcycles termination.
    VICE_DEBUG_EXIT = BENCHMARK_COMPLETE_EXIT;
#endif

    while (1) {}
    return 0;
}
