# Refined, code-aware implementation plan for smarter, grid-aware corridor routing

---

## 1. Data Structures & Existing Logic

- **Rooms:**  
  - Defined in `Room rooms[MAX_ROOMS]` (used everywhere).
  - Room placement and validation in room_management.c (`can_place_room`, `place_room`).
- **Corridors:**  
  - `CorridorPath` struct in door_placement.c (holds arrays of x/y for each path point).
  - Corridors tracked in rule_based_connection_system.c (`CorridorPool`, `connection_matrix`).
- **Grid & Connections:**  
  - 4x4 grid logic is implicit in room placement and connection rules.
  - MST (Minimum Spanning Tree) connection logic in rule_based_connection_system.c.

---

## 2. Corridor Path Planning

- **Current:**  
  - Corridors are drawn as simple L/Z shapes, with endpoints on room perimeters.
  - Door placement uses the first/last walkable tile of the corridor path.

- **Required Upgrade:**  
  - Allow up to 3–4 bends (breakpoints) in the corridor path.
  - Breakpoints must be grid-aware: avoid rooms, do not block future connections.
  - Use static arrays for all path data (see `CorridorPath`).

---

## 3. Algorithm Steps

### A. Path Planning Function

- **Prototype:**

  ```c
  unsigned char plan_corridor_path(Room *roomA, Room *roomB, CorridorPath *path);
  ```

- **Logic:**
  1. Calculate start/end points (offset from room center, as in README).
  2. Randomly select up to 3–4 breakpoints, ensuring:
     - No breakpoint is inside or adjacent to a room (`can_place_room`/`is_on_room_edge` logic).
     - Path does not block grid cells (check against `rooms[]` and `connection_matrix`).
  3. Store all points in `CorridorPath` (static arrays).

### B. Integration

- **Replace L/Z logic in rule_based_connection_system.c:**
  - Find the corridor drawing function (likely `draw_rule_based_corridor`).
  - Replace with call to `plan_corridor_path`.
  - Use the new path for corridor drawing and door placement.

### C. Door & Exit Placement

- **Use existing logic in door_placement.c:**
  - Place doors at first/last walkable tile of the corridor.
  - Offset exit points as described (random offset from room center).

### D. Adjacency & Overlap Rules

- **Enforce with existing functions:**
  - Use `can_place_room` and perimeter checks to validate breakpoints.
  - Use `connection_matrix` to avoid blocking future connections.

---
 