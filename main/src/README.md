# Map Generation Logic (C64 Oscar64 Project)

This document describes the dungeon map generation process as implemented in the project, based on a detailed code analysis (2025.07.08).

## 1. Initialization

- **reset_all_generation_data**: Clears the map, resets the room list, invalidates caches, and initializes the rule-based connection system.
- **init_rule_based_connection_system**: Zeros the connection matrix, resets memory pools, and precomputes room distances.

## 2. Room Placement

- **create_rooms**: Places rooms using a grid-based approach with random offsets for organic, non-uniform layouts.
- The map area is divided into a fixed-size grid (typically 4x4 or similar, see `GRID_SIZE` in the code), and each grid cell can host at most one room.
- For each room, a grid cell is chosen, and the room's position within the cell is randomized to avoid strict alignment and create a more natural dungeon feel.
- This method ensures good room distribution, prevents excessive overlap, and makes it easy to control the maximum number of rooms.
- Each room's center is cached for fast access by other algorithms (corridor generation, stairs placement, etc.).

## 3. Room Connection (Corridor Generation)

- **generate_level**: Main pipeline function.
- Uses a Minimum Spanning Tree (MST) approach:
  - Starts with one connected room.
  - Iteratively connects the closest unconnected room to the connected set, always obeying connection rules.
  - Uses `rule_based_connect_rooms` for each connection.

### Room Connections and Corridors

- In this project, every room connection is always realized as a physical corridor ("corridor" in the strict sense).
- There are no abstract or logical-only connections: if two rooms are connected, there is always a corridor tile path between them.
- The connection process either reuses an existing corridor (if possible and allowed by the rules), or creates a new one.
- The connection matrix and related logic (see `rule_based_connect_rooms` and `draw_rule_based_corridor`) ensure that all connections are represented by actual corridors on the map.

### rule_based_connect_rooms

- Checks if rooms can be safely connected (no overlap, minimum distance, etc.).
- Avoids redundant connections (direct or indirect).
- Tries to reuse existing corridors if possible.
- If not, calls `draw_rule_based_corridor` to create a new corridor.

### draw_rule_based_corridor

- Determines the exit point for each room using `find_room_exit`:
  - **Corridors always start and end on a tile just outside the room wall**, not from the room's interior.
  - The exit is chosen based on the direction to the target room's center.
- Draws an L-shaped corridor:
  - First moves straight from the starting wall exit until aligned with the target exit on one axis.
  - Then bends and continues to the target exit.
- After the corridor is drawn, doors are placed at both ends (on the wall tile between the room and corridor), if valid.

## 4. Wall Placement

- **add_walls**: Scans all floor and door tiles, placing walls on adjacent empty tiles. This is highly optimized for the C64.

## 5. Stairs Placement

- **add_stairs**: Places up and down stairs in the highest-priority rooms (usually start and end rooms), at their center.

## Key Points

- **Corridors never start from the room's interior**; they always begin and end just outside the room wall, with doors placed at the wall.
- The system is fully rule-based, with no exceptions or random corridor carving.
- All steps are optimized for the Commodore 64 and Oscar64 toolchain.

---

 For further details, see the following key functions:

- `generate_level` (main/src/mapgen/map_generation.c)
- `rule_based_connect_rooms` (main/src/mapgen/rule_based_connection_system.c)
- `draw_rule_based_corridor` (main/src/mapgen/rule_based_connection_system.c)
- `find_room_exit` (main/src/mapgen/room_management.c)
- `add_walls` (main/src/mapgen/map_generation.c)
- `add_stairs` (main/src/mapgen/map_generation.c)

---

## Header Files in `main/src/`

The following header files are available in the `main/src` directory and provide the main API and internal definitions for the map generation system:

- `common.h`
- `map_export.h`
- `mapgen_api.h`
- `mapgen_display.h`
- `mapgen_internal.h`
- `mapgen_types.h`
- `mapgen_utility.h`
- `oscar64_console.h`
