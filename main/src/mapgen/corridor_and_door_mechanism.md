# Corridor and Door Placement Mechanism in the Game

This document describes in detail how corridors are constructed and how doors are placed in the map generation system of the game, based on the C64 Oscar64-compatible codebase.

## Corridor Construction Logic

Corridors are generated to connect rooms on the map. The process is handled primarily in `rule_based_connection_system.c` and involves the following steps:

1. **Corridor Start and End Points (Room Exit Selection):**
   - For each pair of rooms to be connected, the algorithm determines a specific exit point (an edge tile) on each room. These points serve as the start and end points of the corridor.
   - The exit point for each room is chosen so that it is exactly 2 tiles away from the room perimeter (either at perimeter -2 or perimeter +2, depending on direction), and as close as possible to the center of the other room. This ensures that corridors take the most direct route between rooms, while still starting and ending at a fixed offset from the room boundary.
   - The function `find_room_exit()` is responsible for this selection. It does not simply scan the perimeter, but deliberately places the exit at a position 2 tiles outside the room edge, either horizontally or vertically, depending on which direction is closer to the target room's center.
   - The start and end points of the corridor are always outside the room, never inside or directly on the room's edge. This guarantees that the corridor visually and logically connects to the room at a fixed distance from its boundary, not through the interior or immediately adjacent.
   - These exit points (perimeter ±2) are also used to determine where doors will be placed, ensuring a consistent and logical connection between rooms and corridors.

2. **Corridor Path Generation:**
   - The corridor is drawn in two straight segments (L- or Z-shaped), using a greedy Manhattan path:
     - First, from the exit of the first room to a pivot point (usually the midpoint between the two exits).
     - Then, from the pivot to the exit of the second room.
   - The direction of the first segment (X or Y first) is randomized for variety.
   - The path is stored in a static `CorridorPath` struct to minimize stack usage on the C64.
   - Each tile along the path is set to `TILE_FLOOR` if it passes rule checks (e.g., not inside a room, not adjacent to a room except at endpoints).

3. **Corridor Placement Rules:**
   - Corridors must not overlap with rooms (except at endpoints).
   - Corridors cannot be adjacent to rooms, except at the endpoints where they connect to the room edge.
   - A global flag (`corridor_endpoint_override`) allows placement at the room edge for the first tile.

## Door Placement Logic

Doors are placed to connect the corridor to the rooms. The logic is as follows:

1. **Door Position Calculation:**
   - After the corridor path is generated, doors are placed one tile closer to the room than the corridor endpoint.
   - This ensures that doors are always at the room perimeter +1 tile, not at the corridor endpoint itself.
   - The direction (which side of the room) is determined by comparing the exit coordinates to the room's position and size.

2. **Door Placement Function:**
   - The `place_door(x, y)` function sets the tile at `(x, y)` to `TILE_DOOR`.
   - In some cases, doors may also be placed at the first and last walkable tiles of the corridor path (see `place_door_between_rooms`).

## Summary of the Process

- For each room pair to be connected:
  1. Find the best exit points on each room edge.
  2. Draw a corridor path in two straight segments (L or Z shape), avoiding rooms and their immediate surroundings except at endpoints.
  3. Place doors at the room perimeter, one tile closer to the room than the corridor endpoint.

## Relevant Files

- `rule_based_connection_system.c`: Main corridor and door placement logic.
- `door_placement.c`: Door placement helper functions.
- `mapgen_types.h`: Data structures and tile type definitions.
- `mapgen_utility.h`: Utility functions for room and tile operations.

---
