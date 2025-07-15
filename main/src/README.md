
# Source Directory Logic and Module Responsibilities (Refactored)

This document details the logic, pipeline, and file responsibilities within the `src` directory of the Oscar64/C64 dungeon map generator. It reflects the 2025 refactor, which unified all edge/perimeter logic, door/corridor placement, and module responsibilities. All code is fully commented for Oscar64 and C64 hardware compatibility, with static memory usage throughout.

---

## Map Generation Pipeline

The map generation process is a multi-stage, rule-based pipeline, designed for organic dungeon layouts and strict C64 memory constraints. Each step is implemented in a dedicated module, with all logic optimized for Oscar64 and static memory (no malloc/free, all arrays are fixed size).

### 1. Initialization

- **`mapgen_init()`**: Clears the map, resets all room and corridor data, and invalidates caches. Ensures a clean state for each new map.
- **`init_rule_based_connection_system()`**: Initializes the connection matrix (tracks which rooms are connected), resets static memory pools for corridors, and precomputes pairwise room distances for efficient corridor planning.

### 2. Room Placement (Grid-Based, Perimeter-Defined)

- **Grid Division**: The map is divided into a fixed grid (see `GRID_SIZE`), with each cell able to host at most one room. This prevents clustering and ensures even distribution.
- **Randomized Placement**: For each room, a grid cell is chosen, and the room's position within the cell is randomized (with a small offset) to avoid strict alignment and create a natural, non-uniform dungeon feel.
- **Validation**: Before placing a room, `can_place_room()` checks for overlap and minimum distance to other rooms. If valid, `place_room()` commits the room to the map.
- **Room Center Caching**: Each room's center is cached for fast access by corridor and stairs algorithms.
- **Unified Perimeter Logic**: All edge/perimeter checks use the new, standardized definition. All placement and validation routines are consistent and robust.

### 3. Room Connection & Corridor Generation (MST-Based, Perimeter-Defined)

- **Pipeline Control**: The main function `generate_level()` manages the connection of all rooms using a strict, rule-based system.
- **Minimum Spanning Tree (MST) Algorithm**: Rooms are connected using an MST approach—always connecting the closest unconnected room, ensuring all connections are as short as possible and follow all rules.
- **Connection Rules**: `rule_based_connect_rooms()` enforces:
  - No overlap or illegal adjacency between rooms or corridors.
  - No redundant (direct or indirect) connections.
  - Existing corridors are reused only if all rules are satisfied (`can_reuse_existing_path()`).
  - Otherwise, a new corridor is created with `draw_rule_based_corridor()`.
- **Corridor Drawing**: `draw_rule_based_corridor()`:
  - Calculates the exit point for each room using `find_room_exit()`. **Exit points are always placed exactly 2 tiles away from the room perimeter, never inside the room or directly on the edge.**
  - Constructs the corridor path (typically L- or Z-shaped) between these exit points, using a greedy Manhattan path. The `corridor_endpoint_override` flag allows the corridor to legally start at the room boundary if needed.
  - All adjacency and overlap rules are strictly enforced, and the logic is robust for all room shapes and orientations.
- **Door Placement**: After the corridor is generated, `place_door_between_rooms()` places doors at the first and last walkable tiles of the corridor path—these are always on the room perimeter, ensuring a seamless and visually consistent connection, even for corners and edge cases.

This logic guarantees that all corridors and doors are placed according to the unified perimeter definition, with no dynamic memory allocation and full compatibility with Oscar64 and C64 hardware.

### 4. Stairs Placement

- **`add_stairs()`**: Places up and down stairs in the highest-priority rooms (usually the start and end rooms), always at the room center. Room priorities are assigned based on their position in the MST and other heuristics.

### 5. Wall and Door Placement (Unified Perimeter Logic)

- **Wall Generation**: Walls and corners are placed in two fast passes around all walkable areas, ensuring tight and visually correct enclosure. (See above for details.)

- **Door Placement**: Always at the interface between a room and a corridor, never inside the room or deep in the corridor. The logic is robust for all corridor shapes, including corners. Doors are always placed at the exact perimeter tile where the corridor meets the room. (See above for details.)

### 6. Display

- **Display**: `testdisplay.c` and `mapgen_display.c` handle rendering the map to the C64 screen, including viewport navigation, user interaction, and delta screen refresh for performance. Visual output now matches the new edge/perimeter logic.

### 7. Map Export

The project includes a dedicated Oscar64/C64 binary export function implemented in `map_export.c` as `save_compact_map(const char* filename)`. This function saves the compact 3-bit-per-tile map (`compact_map`) directly to disk in a C64-compatible binary format using KERNAL routines (device 8, e.g., disk drive).

- `save_compact_map` is called after map generation, when the map is finalized and ready for export. The filename is `MAPDATA.BIN`.
- The export will write the map to the C64 disk drive (device 8) as a PRG file with the given name.
- The function is not yet integrated into the main pipeline, so it must be called manually from your code (for example, after map generation or via a dedicated export command).

---

## Refactoring Key Design Points

- **Unified Perimeter Logic**: All modules now use a single, clear definition of the room edge (perimeter). All placement, validation, and rendering logic is consistent and robust.
- **Door and Corridor Placement**: **Exit points for corridors are always placed exactly 2 tiles away from the room perimeter, and doors are always placed exactly 1 tile away from the perimeter.** Doors never appear inside the room or deep in the corridor. There is never a gap between the corridor and the room. The `corridor_endpoint_override` flag allows the corridor to legally start at the room boundary.
- **Physical Connections Only**: All connections are realized as walkable corridors; no abstract or logical-only links.
- **Rule-based, Deterministic System**: No random corridor carving; all steps follow strict rules for reproducibility and C64 compatibility.
- **Oscar64/C64 Optimizations**: Static memory pools, compact map storage (3 bits/tile), and minimal stack usage. All algorithms are designed for speed and memory efficiency on real hardware. No dynamic memory allocation is used anywhere.
- **Known Limitation – Door Placement at Room Outside Corners**: In cases where corridors connect to rooms at the corners of the room perimeter, doors may not be placed at the ideal or intended positions. The current logic always places doors at the exit tile, which is on the straight edge. This is a known limitation and will be improved in future updates.

---

## C Source Files in 'main/src/' (Refactored Responsibilities)

- `main.c`: Entry point; Oscar64 file I/O; top-level control and user interaction
- `mapgen/map_generation.c`: Orchestrates the full pipeline (`generate_level()`), wall and stair placement (`add_walls()`, `add_stairs()`), and ensures all steps use the unified perimeter logic.
- `mapgen/rule_based_connection_system.c`: Implements the MST-based connection system, rule-based corridor and door generation, and all connection validation. All corridor endpoints and door placements are strictly at the perimeter.
- `mapgen/room_management.c`: Handles room placement, sizing, and exit calculation. All logic referencing room boundaries uses the standardized edge definition.
- `mapgen/door_placement.c`: Handles all door placement logic. Doors are always placed at the interface between a room and a corridor, on the perimeter.
- `mapgen/map_export.c`: Map export routines (not yet integrated into the main pipeline).
- `mapgen/testdisplay.c`: Map rendering, viewport, input, delta refresh. Visual output now matches the new edge/perimeter logic.
- `mapgen/utility.c`: Math, random, cache, and helper functions. All edge/perimeter checks use the new definition.
- `mapgen/public.c`: Public API for mapgen. API now guarantees consistent, unambiguous behavior for all mapgen operations.

## Header Files in 'main/src/'

- `common.h`: Shared constants, macros, and utility functions used throughout the codebase
- `mapgen_types.h`: Data structures for rooms, corridors, map tiles, and related types. All core types, constants, and macros for map generation.
- `mapgen_api.h`: Public API for initializing and generating dungeons
- `mapgen_internal.h`: Internal state, helpers, and private definitions for map generation
- `mapgen_utility.h`: Math, randomization, coordinate, and C64-specific helper routines. All edge/perimeter checks use the new definition.
- `mapgen_display.h`: API for rendering and navigation on the C64 screen
- `map_export.h`: API for exporting maps in Oscar64/C64-compatible formats
- `oscar64_console.h`: Oscar64-specific console/graphics routines for C64 display

---

## Developer Workflow

All code is fully commented for C64/Oscar64 compatibility and clarity. For build instructions, see the root `README.md`. For further details, see the code and comments in each module.
