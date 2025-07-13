# Hacked-C64 Refactored: Detailed Module Documentation

---

## 1. mapgen_types.h

**Purpose:**  
Defines all core types, constants, and macros for map generation.

**Key Elements:**

- **Room Structure:** Holds position (`x`, `y`), size (`w`, `h`), and other metadata.
- **CorridorPath Structure:** Stores arrays of x/y coordinates for corridor tiles.
- **Tile Types:**  
  - `TILE_WALL`, `TILE_DOOR`, `TILE_FLOOR`, etc.
  - Macros for converting between logical and display tile values.
- **Constants:**  
  - Map size, max rooms, max corridor segments, etc.

**Refactor Impact:**  

- All logic referencing room boundaries now uses the standardized edge definition.
- Macros and constants for tile types are used consistently in all modules.

---

## 2. mapgen_utility.h / utility.c

**Purpose:**  
Provides utility functions for coordinate math, tile access, and validation.

**Key Functions:**

- **`is_on_room_edge(x, y)`**  
  - Returns 1 if `(x, y)` is on the standardized edge (perimeter) of any room.
  - Used for validating door and corridor placement.
- **`tile_is_wall(x, y)`, `tile_is_door(x, y)`**  
  - Fast checks for tile type at a given coordinate.
- **Math Helpers:**  
  - `fast_abs_diff`, `manhattan_distance`, etc.
- **Room Center Cache:**  
  - Functions to cache and retrieve room centers for fast access.

**Refactor Impact:**  

- All edge/perimeter checks use the new definition.
- Comments and function names updated for clarity.

---

## 3. room_management.c

**Purpose:**  
Handles room placement, sizing, and exit calculation.

**Key Functions:**

- **`find_room_exit(Room *room, target_x, target_y, *exit_x, *exit_y)`**  
  - Finds the exit point on the room edge (perimeter) closest to a target.
  - Exits are always just outside the room edge (never inside).
- **`create_rooms()`**  
  - Places rooms on the map, ensuring minimum spacing and no overlap.
- **Validation:**  
  - Ensures rooms do not overlap and are within map bounds.

**Refactor Impact:**  

- Exit logic always places exits just outside the perimeter.
- All placement and validation routines use the standardized edge definition.

---

## 4. rule_based_connection_system.c

**Purpose:**  
Implements the minimum spanning tree (MST) and rule-based corridor/door generation.

**Key Functions:**

- **`draw_rule_based_corridor(room1, room2)`**  
  - Draws an L-shaped corridor between two rooms, always starting/ending just outside the room edge.
  - Uses `find_room_exit()` for endpoint calculation.
- **`can_place_corridor_tile(x, y)`**  
  - Validates corridor tile placement, including edge and adjacency rules.
- **`rule_based_connect_rooms()`**  
  - Connects all rooms using MST logic and the above functions.

**Refactor Impact:**  

- All corridor endpoints and door placements are now strictly at the perimeter.
- Corridor logic is robust for all room shapes and orientations.

---

## 5. door_placement.h / door_placement.c

**Purpose:**  
Handles all door placement logic.

**Key Functions:**

- **`place_door(x, y)`**  
  - Places a door at the specified coordinate (assumes correct edge/perimeter placement).
- **`place_door_between_rooms(roomA, roomB, path)`**  
  - Places doors at the first and last walkable tiles of a corridor path, always on the room edge/perimeter.

**Refactor Impact:**  

- Door placement is now always at the interface between a room and a corridor, on the perimeter.
- All comments and function names use the new terminology.

---

## 6. map_generation.c

**Purpose:**  
Top-level procedural map generation pipeline.

**Key Functions:**

- **`generate_level()`**
  - Orchestrates room creation, connection, wall generation, and stair placement.
- **`add_walls()`**  
  - Places walls around floor and door tiles, enclosing all rooms and corridors.

**Refactor Impact:**  

- All steps use the new edge/perimeter logic for validation and placement.
- Wall generation is robust and efficient.

---

## 7. map_export.c / map_export.h

**Purpose:**  
Handles exporting the generated map to Oscar64/C64-compatible binary format.

**Key Functions:**

- **Export routines** for saving map data.

**Refactor Impact:**  

- None.

---

## 8. testdisplay.c

**Purpose:**  
Provides a simple ASCII/char-based visual test for map output.

**Key Functions:**

- **Rendering routines** for displaying the map and verifying logic visually.

**Refactor Impact:**  

- Visual output now matches the new edge/perimeter logic.

---

## 9. public.c / mapgen_api.h

**Purpose:**  
Implements and exposes the public API for map generation.

**Key Functions:**

- **API wrappers** for core mapgen functions.

**Refactor Impact:**  

- API now guarantees consistent, unambiguous behavior for all mapgen operations.

---

## 10. mapgen_internal.h, mapgen_display.h, common.h, oscar64_console.h

**Purpose:**  

- Internal helpers, display routines, and shared macros/constants.

**Refactor Impact:**  

- Updated as needed to use the new terminology and logic.

---

## Corridor and Door Placement Refactor (2025-07-13)

### Summary of Changes

1. **Door Placement Logic Fixed:**
   - Doors are now placed directly at the actual room exit tiles (`exit1_x, exit1_y` and `exit2_x, exit2_y`), instead of extrapolating from the corridor direction. This eliminates any gap between the corridor and the room.

2. **Corridor Drawing Logic Improved:**
   - The corridor now starts directly at the room edge (exit tile), so the corridor visually connects right up to the door and the room, with no empty space in between.

3. **Endpoint Override Usage:**
   - The `corridor_endpoint_override` flag is used to allow placing a corridor tile on the room edge for the first tile, ensuring the corridor can legally start at the room boundary.

4. **Known Limitation – Door Placement at Room Outside Corners:**
   - In cases where corridors connect to rooms at the corners of the room perimeter, the doors may not be placed at the ideal or intended positions.  The current logic always places doors at the exit tile, which is on the straight edge on the outside of room paths where the corridor started or where the corridor ended. The doors therefore appear further away from the end of the corridor in these cases.

- Doors are now always placed to the exact location on both of exit points. The logic of corridors does not follow this implementation, but stops one space before the rooms.

- Door placement at room outside corners is not yet handled and require further logic to ensure doors and corridor exit points are handled in these special cases differently when corridors pass through the corners of the outer edges of rooms.

---

## Summary of Refactor Impact (except for the above)

- **All modules** now use a single, clear definition of the room edge (perimeter).
- **All placement, validation, and rendering logic** is consistent and robust.
- **All comments, function names, and documentation** use the new terminology.
- **Result:** The codebase is easier to maintain, less error-prone, and more understandable for future development.

---
