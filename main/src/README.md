
# Oscar64/C64 Dungeon Map Generator – Source Directory Overview

This document describes the logic, pipeline, and file responsibilities in the `src` directory of the Oscar64/C64 dungeon map generator. All code is fully commented for Oscar64 and C64 hardware compatibility, using static memory throughout (no dynamic allocation).

---

## Tile Encoding and Compact Tile Types (mapgen_types.h)

This project uses two levels of tile encoding for the dungeon map:

### 1. PETSCII Tile Encoding

These values are used for rendering the map directly to the C64 screen memory. Each constant represents a PETSCII character code, chosen for visual clarity and compatibility with Oscar64 and C64 hardware.

```c
#define EMPTY   32    // Space character: represents empty tiles
#define WALL    160   // PETSCII block: used for walls
#define CORNER  230   // PETSCII corner: used for map corners
#define FLOOR   46    // Period (.) character: used for walkable floor
#define DOOR    171   // Inverse plus (+): marks doorways between rooms/corridors
#define UP      60    // Less-than (<): represents stairs up
#define DOWN    62    // Greater-than (>): represents stairs down
```

These codes are written directly to $0400 (C64 screen memory) for fast display. The choice of PETSCII values ensures the map is visually clear and matches C64 conventions.

### 2. Compact Tile Type Encoding

For internal map logic and storage, each tile is represented by a compact type (0-6). This allows efficient use of memory (3 bits per tile) and fast processing, critical for C64 hardware constraints.

```c
#define TILE_EMPTY   0 // Unused/empty tile
#define TILE_WALL    1 // Wall tile
#define TILE_FLOOR   2 // Walkable floor tile
#define TILE_DOOR    3 // Door tile (room/corridor interface)
#define TILE_UP      4 // Stairs up
#define TILE_DOWN    5 // Stairs down
#define TILE_CORNER  6 // Corner tile (visual enclosure)
```

The compact encoding is used for map generation, logic, and export. When rendering, these types are converted to PETSCII codes for display. This separation allows the generator to use minimal memory while still producing visually rich maps on the C64.

---

## 1. Map Generation Pipeline

The map generation process is a multi-stage, rule-based pipeline designed for organic dungeon layouts and strict C64 memory constraints. Each step is implemented in a dedicated module, with all logic using static memory and Oscar64 best practices.

### 1.1 Initialization

Initialization is split between two functions: `mapgen_init()` and `init_rule_based_connection_system()`.

- `mapgen_init()` (see `mapgen/public.c`):
  - Seeds the random number generator for Oscar64/C64 compatibility using `init_rng()`.
  - Does not reset map or room data directly; this is deferred to the main generation function to avoid double initialization.
  - Ensures the system is ready for map generation, but leaves memory pool and display buffer resets to later steps.

- `init_rule_based_connection_system()` (see `mapgen/rule_based_connection_system.c`):
  - Zeros out the room-to-room connection matrix for MST and corridor logic, using Oscar64-optimized loops for static memory.
  - Sets all room distance cache entries to `255` (invalid marker), ensuring no stale data.
  - Resets corridor memory pools (`active_count`, `next_free_index`) and connection caches for deterministic corridor reuse.
  - Precomputes and caches all valid room-to-room distances for fast MST and connection logic, using `calculate_room_distance()`. This cache is symmetric and marked valid after initialization.
  - All memory is statically allocated; no dynamic allocation is used, ensuring C64 compatibility.

This two-step initialization guarantees a clean, reproducible state for each new map, with all caches, pools, and matrices reset and ready for generation. Oscar64 best practices are followed throughout, with static memory and minimal stack usage.

### 1.2 Room Placement (Grid-Based, Perimeter-Defined)

Room placement is managed by grid logic and robust perimeter validation to ensure organic layouts and strict C64 memory safety.

- The map is divided into a fixed grid (`GRID_SIZE`), with each cell hosting at most one room for even distribution. Room positions within cells are randomized using a C64-optimized random number generator and additional mixing for better entropy.
- The function `can_place_room(x, y, w, h)` (see `room_management.c`) performs enhanced edge checks to ensure rooms are not too close to map edges, and uses thorough overlap and minimum distance validation:
  - Checks for adequate space from map edges (minimum 3 tiles).
  - Validates that no part of the new room overlaps or is too close to existing rooms, using both bounding box and minimum distance checks.
  - Ensures all tiles in the proposed area are empty and not part of another room or corridor.
- The function `place_room(x, y, w, h)` commits valid rooms to the map, marking the floor tiles and updating the room list.
- Room centers are cached for fast access in all modules, using a static array (`room_center_cache`) and helper functions (`get_room_center()`, `init_room_center_cache()`), ensuring the center is always inside the room and close to the edge for optimal corridor placement.
- All edge/perimeter checks use a unified definition via `is_on_room_edge(x, y)` (see `utility.c`), which identifies the standardized room perimeter for door and corridor logic:
  - Left:   `x == room->x`
  - Right:  `x == room->x + room->w - 1`
  - Top:    `y == room->y`
  - Bottom: `y == room->y + room->h - 1`
- All memory is statically allocated, and all logic is designed for Oscar64/C64 compatibility.

This approach guarantees even room distribution, robust overlap prevention, and consistent perimeter logic for all subsequent map generation steps.

### 1.3 Room Connection & Corridor Generation (MST-Based)

Room connections and corridor generation are handled by a strict, rule-based system using a Minimum Spanning Tree (MST) approach, optimized for C64 hardware.

- The function `generate_level()` (see `map_generation.c`) orchestrates the connection process:
  - Rooms are connected using MST logic, always choosing the shortest valid connection between connected and unconnected rooms.
  - All connections must comply with strict rules: no overlap, no illegal adjacency, and no redundant corridors.
  - Connection attempts fallback to any remaining unconnected room, but always obey the rules.

- The function `rule_based_connect_rooms(room1, room2)` (see `rule_based_connection_system.c`):
  - Validates that rooms can be safely connected and are not already directly or indirectly connected.
  - Attempts to reuse existing corridors if all rules are satisfied (`can_reuse_existing_path()` and `connect_via_existing_corridors()`).
  - If reuse is not possible, creates a new corridor using `draw_rule_based_corridor()`.

- The function `draw_rule_based_corridor(room1, room2)`:
  - Calculates exit points for each room using `find_room_exit()`, always 2 tiles away from the perimeter for robust connections.
  - Constructs the corridor path using a Z-shaped or L-shaped greedy Manhattan path, with axis order randomized for variety.
  - Places corridor tiles at the exit points and along the path, using static memory for all path data.
  - The `corridor_endpoint_override` flag allows corridors to start at the room boundary if needed.

- The function `find_room_exit(room, target_x, target_y, &exit_x, &exit_y)` (see `room_management.c`):
  - Determines which edge to use for the exit based on the direction to the target room.
  - Ensures all corridor endpoints are always 2 tiles away from the room perimeter, never inside the room.

- Doors are placed at the first and last walkable tiles of the corridor path using `place_door_between_rooms()` (see `door_placement.c`), always on the room perimeter for seamless connections.

- All adjacency and overlap rules are strictly enforced for all room shapes and corridor paths. All memory is statically allocated, and all logic is designed for Oscar64/C64 compatibility.

This approach guarantees robust, walkable connections between rooms, with strict rule enforcement and optimal memory usage for the C64.

### 1.4 Stairs Placement

Stairs are placed in the highest-priority rooms, typically representing the start and end points of the dungeon.

- The function `add_stairs()` (see `map_generation.c`):
  - Requires at least two rooms to place stairs.
  - Selects the starting room for "up" stairs by finding the room with the highest priority value (`rooms[i].priority`).
  - Selects the ending room for "down" stairs by finding the room with the second highest priority, ensuring it is not the same as the starting room.
  - Uses `get_room_center()` to place stairs at the exact center of each selected room, guaranteeing stairs are always accessible and visually correct.
  - Places the "up" stairs (`TILE_UP`) in the starting room and the "down" stairs (`TILE_DOWN`) in the ending room, using static memory and C64-optimized tile placement.
  - Progress indicators are printed during selection for user feedback.

This approach ensures stairs are always placed in the most important rooms, with priorities determined by MST position and custom heuristics, and always at the room center for consistency and C64 compatibility.

### 1.5 Wall and Door Placement

Walls and corners are placed in two fast passes around walkable areas to ensure tight, visually correct enclosure, and doors are always placed at the interface between room and corridor.

- The function `add_walls()` (see `map_generation.c`):
  - First pass: Scans the entire map for floor and door tiles, then places walls in all adjacent empty tiles (north, south, east, west) to enclose walkable areas.
  - Second pass: Places corner tiles (both outer and inner) diagonally from walkable tiles, using robust logic to handle all corridor and room shapes. Outer corners are placed where two adjacent walls meet and the diagonal is empty; inner corners are placed where two adjacent walkable tiles meet and the diagonal is a wall, with additional checks for surrounding walls.
  - Progress indicators are printed during wall placement for user feedback.
  - All wall and corner placement uses static memory and C64-optimized tile access.

- Door placement:
  - Doors are always placed at the interface between room and corridor, never inside the room or deep in the corridor.
  - The logic for door placement is robust for all corridor shapes, including corners, and uses the standardized room edge (perimeter) definition for consistency.
  - Functions such as `place_door_between_rooms()` and `place_door()` ensure doors are placed at the first and last walkable tiles of the corridor path, always on the room perimeter.

This approach guarantees visually correct enclosure of all walkable areas, robust door placement for seamless connections, and strict adherence to Oscar64/C64 hardware constraints.

### 1.6 Display

Map rendering and user interaction are handled by highly optimized routines for the C64 screen, supporting smooth viewport navigation, input, and delta refresh.

- The files `testdisplay.c` and `mapgen_display.c`:
  - Implement viewport management using a camera system that centers the view on the player or target, with strict boundary logic to prevent out-of-bounds errors.
  - Use a previous screen buffer (`screen_buffer`) and dirty flags (`screen_dirty`) to optimize delta refresh, updating only changed regions for maximum performance.
  - Support perfect scroll optimization, updating the screen with minimal redraws when the viewport moves.
  - Render the map using direct Oscar64 screen memory access (`screen_memory` at $0400), converting internal tile types to PETSCII codes for C64 display.
  - Provide input handling for navigation, allowing the user to move the camera and interact with the map in real time.
  - All display logic matches the unified edge/perimeter definition, ensuring visual consistency with the underlying map logic.
  - All routines are statically allocated and optimized for C64 hardware constraints.

This approach guarantees fast, flicker-free map rendering, responsive navigation, and robust input handling, all fully compatible with Oscar64 and C64 hardware.

### 1.7 Map Export

Map export is handled by a dedicated utility function, triggered manually by pressing the 'M' key during runtime. This saves the generated map in a C64 PRG format.

The file `map_export.c` implements `save_compact_map(const char* filename)`, which called directly from `main.c` when the user presses 'M':

- Exports the compact 3-bit-per-tile map (`compact_map`) to disk using Oscar64 krnio_save routines, targeting device 8 (disk drive).
- The filename must be a PETSCII string (max 16 characters) and is copied to a C64 RAM buffer for the KERNAL SAVE routine.
- The exported file is saved as a PRG file, using the filename provided in `main.c` (`MAPDATA.BIN`). The file contains only the compact map data.
- No error checking is performed; the function assumes the disk is ready and the filename is valid.

---

## 2. Key Design Points

- **Unified Perimeter Logic**: All modules use a single, clear definition of the room edge (perimeter). Placement, validation, and rendering are consistent and robust.
- **Door and Corridor Placement**: Exit points for corridors are always 2 tiles away from the room perimeter; doors are always 1 tile away. Doors never appear inside the room or deep in the corridor. No gap between corridor and room. The `corridor_endpoint_override` flag allows corridors to start at the room boundary.
- **Physical Connections Only**: All connections are walkable corridors; no abstract/logical-only links.
- **Rule-based, Deterministic System**: No random corridor carving; all steps follow strict rules for reproducibility and C64 compatibility.
- **Oscar64/C64 Optimizations**: Static memory pools, compact map storage (3 bits/tile), minimal stack usage. No dynamic memory allocation.
- **Known Limitation – Door Placement at Room Corners**: When corridors connect to rooms at outside corners, doors may not be ideally placed. Current logic places doors at the exit tile on the straight edge.

---

## 3. Source Files and Responsibilities

### C Source Files in `main/src/`

- `main.c`: Entry point; Oscar64 file I/O; top-level control and user interaction
- `mapgen/map_generation.c`: Orchestrates the full pipeline (`generate_level()`), wall and stair placement (`add_walls()`, `add_stairs()`), ensures unified perimeter logic
- `mapgen/rule_based_connection_system.c`: Implements MST-based connection system, rule-based corridor and door generation, connection validation
- `mapgen/room_management.c`: Handles room placement, sizing, exit calculation, using standardized edge definition
- `mapgen/door_placement.c`: Handles all door placement logic; doors always at room/corridor interface, on perimeter
- `mapgen/map_export.c`: Map export routines
- `mapgen/testdisplay.c`: Map rendering, viewport, input, delta refresh; visual output matches new edge/perimeter logic
- `mapgen/utility.c`: Math, random, cache, helper functions; all edge/perimeter checks use new definition
- `mapgen/public.c`: Public API for mapgen; guarantees consistent, unambiguous behavior

### Header Files in `main/src/`

- `common.h`: Shared constants, macros, utility functions
- `mapgen_types.h`: Data structures for rooms, corridors, map tiles, and related types; core types, constants, macros
- `mapgen_api.h`: Public API for initializing and generating dungeons
- `mapgen_internal.h`: Internal state, helpers, private definitions
- `mapgen_utility.h`: Math, randomization, coordinate, C64-specific helpers; all edge/perimeter checks use new definition
- `mapgen_display.h`: API for rendering and navigation on C64 screen
- `map_export.h`: API for exporting maps in Oscar64/C64-compatible formats
- `oscar64_console.h`: Oscar64-specific console/graphics routines for C64 display

---

## 4. Developer Workflow

All code is fully commented for C64/Oscar64 compatibility and clarity. For build instructions, see the root `README.md`. For further details, consult the code and comments in each module.
