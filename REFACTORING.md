# Refactor: Standardize Room Edge (Perimeter) Logic

## Summary

This refactor unifies and clarifies the definition and usage of "room edge" (perimeter) throughout the map generation codebase, eliminating ambiguity and potential logic errors. All related functions, comments, and documentation have been updated for consistency and correctness.

---

## Key Changes

- **Standardized Room Edge Definition:**  
  - The room edge (perimeter) is now always defined as:
    - Left:   `x == room->x`
    - Right:  `x == room->x + room->w - 1`
    - Top:    `y == room->y`
    - Bottom: `y == room->y + room->h - 1`
  - All code, comments, and documentation now use "edge" or "perimeter" (not "wall" or "boundary" unless referring to actual wall tiles).

- **Function Updates:**
  - `is_on_room_edge(x, y)`: Checks if a coordinate is on the standardized edge of any room.
  - `find_room_exit()`: Always finds an exit just outside the room perimeter, never inside.
  - `draw_rule_based_corridor()`: Corridors always start/end just outside the room edge.
  - `place_door()` and `place_door_between_rooms()`: Doors are always placed at the interface between a room and a corridor, on the perimeter.

- **Documentation and Comments:**
  - All relevant comments and documentation updated to use the new terminology and clarify the logic.
  - README and code comments now clearly distinguish between "edge/perimeter" and "wall".

---

## New Behavior

- All room exit, corridor, and door placement logic is now unambiguous and consistent.
- Corridors always start/end just outside the room perimeter, and doors are always placed at the interface between a room and a corridor.
- This eliminates previous logic errors where "wall", "boundary", or "edge" were used inconsistently.

---

**Result:**  
The codebase now has a single, clear definition of "room edge (perimeter)", and all related logic and comments have been updated for clarity and correctness. This improves maintainability and prevents subtle bugs in map generation and connectivity.
