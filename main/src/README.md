
# Source Directory Logic and File Responsibilities

This document describes the detailed logic and file responsibilities within the `src` directory of the C64 Oscar64 dungeon map generator. It is intended as a technical reference for developers working on or extending the map generation system.

---

## Map Generation Pipeline: Detailed Logic

The map generation process is a multi-stage pipeline, designed for both organic dungeon layouts and strict C64 memory constraints. Each step is implemented in a dedicated module and function, with all logic optimized for Oscar64.

### 1. Initialization

- **`mapgen_init()`**: Clears the map, resets all room and corridor data, and invalidates caches. This ensures a clean state for each new map.
- **`init_rule_based_connection_system()`**: Initializes the connection matrix (tracks which rooms are connected), resets static memory pools for corridors, and precomputes pairwise room distances for efficient corridor planning.

### 2. Room Placement (Organic Grid-Based)

- **Grid Division**: The map is divided into a fixed grid (see `GRID_SIZE`), with each cell able to host at most one room. This prevents clustering and ensures even distribution.
- **Randomized Placement**: For each room, a grid cell is chosen, and the room's position within the cell is randomized (with a small offset) to avoid strict alignment and create a natural, non-uniform dungeon feel.
- **Validation**: Before placing a room, `can_place_room()` checks for overlap and minimum distance to other rooms. If valid, `place_room()` commits the room to the map.
- **Room Center Caching**: Each room's center is cached for fast access by corridor and stairs algorithms.

### 3. Room Connection & Corridor Generation (MST-Based)

- **Pipeline Control**: The main function `generate_level()` orchestrates the connection of all rooms.
- **Minimum Spanning Tree (MST) Algorithm**: Starting from one room, the algorithm iteratively connects the closest unconnected room to the connected set, always choosing the shortest valid connection and obeying all rules.
- **Connection Rules**: `rule_based_connect_rooms()` ensures:
  - No overlap or illegal adjacency between rooms/corridors.
  - No redundant (direct or indirect) connections.
  - Existing corridors are reused if possible (`can_reuse_existing_path()`).
  - If not, a new corridor is created with `draw_rule_based_corridor()`.
- **Corridor Drawing**: `draw_rule_based_corridor()`:
  - Determines the exit point for each room using `find_room_exit()`. Exits are always just outside the room wall, never inside.
  - Draws an L-shaped corridor: first straight from the starting exit until aligned with the target, then bends and continues to the target exit.
  - The corridor path is stored as a sequence of tiles.
- **Door Placement**: After the corridor is drawn, `place_door_between_rooms()` places doors at both ends of the corridor (the first and last walkable tiles), ensuring every connection is physically realized and accessible.

### 4. Stairs Placement

- **`add_stairs()`**: Places up and down stairs in the highest-priority rooms (usually the start and end rooms), always at the room center. Room priorities are assigned based on their position in the MST and other heuristics.

### 5. Wall and Door Placement

- **Wall Placement**: `add_walls()` scans all floor and door tiles, placing walls on any adjacent empty tile. This is highly optimized for C64 memory and speed, and ensures all rooms and corridors are properly enclosed.
- **Door Placement**: (see above) is always at the interface between a room and a corridor, never inside the room or deep in the corridor. The logic is robust for all corridor shapes, including corners.

### 6. Display

- **Display**: `mapgen_display.c` handles rendering the map to the C64 screen, including viewport navigation and user interaction.

### 7. Map Export (not yet used)

- **Export**: `map_export.c` provides routines for saving the generated map in Oscar64/C64-compatible binary format, using Oscar64 KERNAL routines for file I/O.\
  **Note:** The export functionality exists, but is not yet called or integrated into the current pipeline.

## Key Design Points

- **Corridors always start/end just outside room walls**; never from the room interior. Doors are placed at the wall boundary using a robust, symmetric algorithm.
- **All connections are physical corridors**; no abstract/logical-only links. Every connection is realized as a walkable path on the map.
- **Rule-based, deterministic system**: No random corridor carving; all steps follow strict rules for reproducibility and C64 compatibility.
- **Oscar64/C64 optimizations**: Static memory pools, compact map storage (3 bits/tile), and minimal stack usage. All algorithms are designed for speed and memory efficiency on real hardware.

## C Source Files in 'main/src/'

- `main/src/main.c`: `main()`; Oscar64 file I/O; top-level control and user interaction
- `main/src/mapgen/map_generation.c`: `generate_level()`, `add_walls()`, `add_stairs()`
- `main/src/mapgen/rule_based_connection_system.c`: `rule_based_connect_rooms()`, `draw_rule_based_corridor()`, `can_reuse_existing_path()`
- `main/src/mapgen/room_management.c`: `create_rooms()`, `find_room_exit()`, and room placement helpers
- `main/src/mapgen/door_placement.c`: `place_door()`, `place_door_between_rooms()` (handles all door logic)
- `main/src/mapgen/map_export.c`: Map export routines
- `main/src/mapgen/mapgen_display.c`: Map rendering and navigation

## Header Files in 'main/src/'

- `common.h`: Shared constants, macros, and utility functions used throughout the codebase.
- `mapgen_types.h`: Data structures for rooms, corridors, map tiles, and related types.
- `mapgen_api.h`: Public API for initializing and generating dungeons.
- `mapgen_internal.h`: Internal state, helpers, and private definitions for map generation.
- `mapgen_utility.h`: Math, randomization, and C64-specific helper routines.
- `mapgen_display.h`: API for rendering and navigation on the C64 screen.
- `map_export.h`: API for exporting maps in Oscar64/C64-compatible formats.
- `oscar64_console.h`: Oscar64-specific console/graphics routines for C64 display.

---

For further details, see the code and comments in each module. All code is fully commented for C64/Oscar64 compatibility and clarity.
