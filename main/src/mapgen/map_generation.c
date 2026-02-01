// =============================================================================
// Map Generation Module for C64 Map Generator
// Structure following the generation pipeline
// =============================================================================

#include "mapgen_types.h"      // For Room, MAX_ROOMS
#include "mapgen_internal.h"   // For add_stairs, add_walls, etc. and global variable declarations
#include "mapgen_utils.h"      // For get_room_center, coords_in_bounds, calculate_room_distance
#include "mapgen_display.h"    // For initialize_camera, reset_viewport_state, reset_display_state
#include "mapgen_config.h"     // For MapParameters
#include "mapgen_progress.h"   // For progress bar functions (DEBUG only)

// =============================================================================
// DYNAMIC GENERATION PARAMETERS
// =============================================================================

// Current generation parameters (set via mapgen_set_parameters)
// Non-static so other modules can access via extern declaration
MapParameters current_params = {
    64,  // map_width (default MEDIUM)
    64,  // map_height
    4,   // grid_size (4x4 for MEDIUM)
    16,  // max_rooms (4x4=16)
    4,   // min_room_size
    8,   // max_room_size
    4,   // hidden_room_count (25% of 16)
    25,  // niche_count (ratio %, calculated post-MST)
    25   // deception_count (ratio %, calculated post-MST)
};

// =============================================================================
// RUNTIME FEATURE COUNTERS
// =============================================================================
// Track features during generation for deception system balancing

unsigned char total_connections = 0;     // MST corridors created
unsigned char total_hidden_rooms = 0;    // Hidden rooms placed
unsigned char total_niches = 0;          // Wall niches placed
unsigned char total_decoys = 0;          // Decoy corridors placed
unsigned char available_walls_count = 0; // Walls without doors

// =============================================================================
// PHASE 1: ROOM CREATION
// =============================================================================
// Note: create_rooms() function is implemented in room_management.c
// This phase creates rooms using grid-based placement

// =============================================================================
// PHASE 2: ROOM CONNECTION SYSTEM
// =============================================================================
// Note: Connection system is implemented in connection_system.c
// Creates corridors between rooms using MST algorithm with fallback

// =============================================================================
// PHASE 3: STAIR PLACEMENT SYSTEM
// =============================================================================

// Place stairs in rooms with maximum distance for optimal separation
void add_stairs(void) {
    if (room_count < 2) return; // Need at least 2 rooms for stairs

#ifdef DEBUG_MAPGEN
    // Phase 6: Stair placement progress - starting
    update_progress_step(6, 0, 2);
#endif

    // Find room pair with maximum distance (brute-force optimal)
    unsigned char start_room = 0;
    unsigned char end_room = 1;
    unsigned char max_distance = calculate_room_distance(0, 1);

    for (unsigned char i = 0; i < room_count; i++) {
        for (unsigned char j = i + 1; j < room_count; j++) {
            unsigned char dist = calculate_room_distance(i, j);
            if (dist > max_distance) {
                max_distance = dist;
                start_room = i;
                end_room = j;
            }
        }
    }

    // Place up stairs in starting room center
    // Direct metadata access - cached room centers
    unsigned char up_x = room_list[start_room].center_x;
    unsigned char up_y = room_list[start_room].center_y;
    set_compact_tile(up_x, up_y, TILE_UP);

#ifdef DEBUG_MAPGEN
    update_progress_step(6, 1, 2);
#endif

    // Place down stairs in ending room center
    unsigned char down_x = room_list[end_room].center_x;
    unsigned char down_y = room_list[end_room].center_y;
    set_compact_tile(down_x, down_y, TILE_DOWN);

#ifdef DEBUG_MAPGEN
    // Phase 6: Stair placement complete
    update_progress_step(6, 2, 2);
#endif
}

// =============================================================================
// POST-MST FEATURE COUNT CALCULATION
// =============================================================================

/**
 * @brief Calculate actual feature counts after MST and hidden rooms are placed
 *
 * Uses runtime-tracked topology data to calculate safe feature counts.
 * Deception is limited by usable non-branching corridors (excluding hidden rooms).
 */
void calculate_post_mst_feature_counts(void) {
    // Niche count: percentage of non-hidden rooms
    unsigned char eligible_rooms = room_count - total_hidden_rooms;
    current_params.niche_count =
        calculate_percentage_count(eligible_rooms, current_params.niche_count);

    // Deception: limited by usable non-branching corridors
    unsigned char usable_non_branching = count_non_branching_from_flags();
    if (usable_non_branching > total_hidden_rooms) {
        usable_non_branching -= total_hidden_rooms;
    } else {
        usable_non_branching = 0;
    }

    // Deception count capped by available non-branching corridors
    unsigned char max_deception = calculate_percentage_count(
        usable_non_branching, current_params.deception_count);
    current_params.deception_count = max_deception;
}

// =============================================================================
// MAIN MAP GENERATION PIPELINE
// =============================================================================

// Level generation pipeline with incremental wall building
unsigned char generate_level(void) {

#ifdef DEBUG_MAPGEN
    // Initialize progress bar system
    init_generation_progress();
    init_progress_weights();  // Pre-calculate phase boundaries with initial estimates

    // Phase 1: Create rooms with walls using grid-based placement
    show_phase(0); // "Building Rooms"
#endif

    create_rooms();
    // Early exit if no rooms were created
    if (room_count == 0) {
#ifdef DEBUG_MAPGEN
        finish_progress_bar();
#endif
        return 0; // Generation failed
    }

    // Initialize available walls counter after rooms are created
    // Each room starts with 4 walls, decremented as doors/connections are added
    available_walls_count = room_count * 4;

#ifdef DEBUG_MAPGEN
    // Phase 2: Room Connection System with corridor walls
    show_phase(1); // "Connecting Rooms"
#endif
    build_room_network();

#ifdef DEBUG_MAPGEN
    // Phase 2: Convert single-connection rooms to hidden rooms
    show_phase(2); // "Hiding Rooms"
#endif
    place_hidden_rooms(current_params.hidden_room_count);

    // POST-MST CALCULATION: Calculate feature counts using runtime data
    calculate_post_mst_feature_counts();

#ifdef DEBUG_MAPGEN
    // Phase 3: Carve wall niches
    show_phase(3); // "Carving Niches"
#endif
    place_niches(current_params.niche_count);

#ifdef DEBUG_MAPGEN
    // Phase 4: Place decoy corridors (dead-ends)
    show_phase(4); // "Decoys"
#endif
    place_decoy_corridors(current_params.deception_count);

#ifdef DEBUG_MAPGEN
    // Phase 5: Hide passages (use actual decoy count for balance)
    show_phase(5); // "Hidden Passages"
#endif
    place_hidden_passages(total_decoys);

#ifdef DEBUG_MAPGEN
    // Phase 3: Place stairs for level navigation
    show_phase(6); // "Placing Stairs"
#endif
    add_stairs();

#ifdef DEBUG_MAPGEN
    // Finish progress bar and show completion message
    finish_progress_bar();
    show_phase(7); // "Complete"

    // Initialize camera for debug preview mode
    initialize_camera();

    // VIC-II raster-based delay (more reliable on C64)
    // Wait for multiple frame cycles for visible delay
    for (unsigned char frames = 0; frames < 150; frames++) {  // ~3 seconds at 50Hz PAL
        // Wait for raster line 0 (top of screen)
        while (*(volatile unsigned char*)0xD012 != 0) {
            // Wait for raster to reach top
        }
        // Wait for raster to leave line 0
        while (*(volatile unsigned char*)0xD012 == 0) {
            // Wait for next frame to start
        }
    }

    // Now render the map after progress bar is complete
    render_map_viewport(1);
#endif

    return 1; // Generation successful
}

// =============================================================================
// PUBLIC API FUNCTIONS
// =============================================================================

// Set generation parameters from configuration
void mapgen_set_parameters(const MapParameters *params) {
    if (params) {
        current_params = *params;
    }
}

// Get current generation parameters (for testing/debugging)
void mapgen_get_parameters(MapParameters *params) {
    if (params) {
        *params = current_params;
    }
}

// Get current map size (width == height)
unsigned char mapgen_get_map_size(void) {
    return current_params.map_width;
}

