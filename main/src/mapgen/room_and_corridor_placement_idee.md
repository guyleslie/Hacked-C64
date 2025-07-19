# Smarter, Grid-Aware Corridor Routing for Oscar64/C64 Dungeon Generation idee

## Background

In the current Oscar64/C64 dungeon generator, rooms are distributed randomly within a fixed 4x4 grid, and corridors are constructed using simple L- or Z-shaped paths with limited flexibility. While this approach is efficient and compatible with C64 hardware, it can lead to suboptimal connectivity—especially when a corridor must navigate around other rooms to connect two distant cells. The present logic may also inadvertently block potential future connections, reducing the organic feel and replayability of the generated dungeons.

### Proposed Solution

To address these limitations, we propose a smarter, grid-aware corridor routing algorithm with the following features:

- **Multiple, Randomized Breakpoints:**  
  Instead of restricting corridors to 2 or 3 segments, allow up to 3–4 breakpoints (bends) in the corridor path. These breakpoints should be chosen randomly, but with logic that ensures the path remains valid and does not block other potential connections in the grid.

- **Grid-Aware Pathfinding:**  
  The routing algorithm should be aware of the 4x4 grid structure. When planning a path, it should attempt to avoid crossing through or adjacent to other rooms, and should not create corridors that would isolate grid cells or prevent future connections.

- **Preservation of Perimeter and Exit Logic:**  
  Maintain the current, robust logic for door and exit placement: doors are always placed at the room perimeter (+1 from the edge), and corridor exit points are at +2. This ensures visual and logical consistency, and matches the unified perimeter definition described in the README.

- **Organic, Minimal Connection Strategy:**  
  The goal is not to connect every room directly in a single pass, but to allow connections to form organically, with as few corridors as possible. The algorithm should leverage the grid structure and smarter routing to maximize connectivity while minimizing overlap and redundancy.

- **Oscar64/C64 Hardware Compatibility:**  
  All logic must use static memory allocation, minimal stack usage, and be fully compatible with Oscar64 and C64 hardware constraints. No dynamic memory allocation is permitted.

### Implementation Approach

1. **Path Planning:**  
   - When connecting two rooms, attempt to find a path with up to 3–4 bends, using randomized but grid-aware breakpoints.
   - If a direct path is blocked by another room, the algorithm should attempt to route around the obstacle, selecting breakpoints that maintain the possibility of future connections.
   - The pathfinding should avoid creating corridors that unnecessarily block or isolate other grid cells.

2. **Static Memory Management:**  
   - All pathfinding and corridor data must be stored in statically allocated arrays, in line with Oscar64/C64 best practices.

   - The new corridor routing logic should be integrated into the existing MST-based connection system, replacing the current L/Z-shaped path construction in `draw_rule_based_corridor()`.
   - All adjacency and overlap rules must continue to be strictly enforced.

3. **Note on Exit Point Placement:**
The exit point is not always placed at the exact center of the room. Instead, it is offset by ± randInt((room_width – 1)/2) (and similarly for height), introducing random variation. This makes corridor and door placement more diverse and organic, resulting in less predictable and more natural dungeon layouts.

4. **Integration with Existing Pipeline:**  
   - The new corridor routing logic should be integrated into the existing MST-based connection system, replacing the current L/Z-shaped path construction in `draw_rule_based_corridor()`.
   - All adjacency and overlap rules must continue to be strictly enforced.

5. **Testing and Validation:**  
   - The new system should be tested to ensure that it produces robust, walkable connections, maintains the organic feel of the dungeon, and does not introduce regressions in wall, door, or stairs placement.

### Benefits

- **Improved Connectivity:**  
  Smarter routing enables more reliable connections between rooms, even in complex grid layouts.
- **Greater Replayability:**  
  More organic and varied corridor shapes increase the uniqueness of each generated dungeon.
- **Full C64 Compatibility:**  
  The approach remains fully compatible with Oscar64 and C64 hardware constraints, using only static memory and deterministic logic.

---

This approach will result in more natural, flexible, and robust corridor layouts, improving both the visual quality and connectivity of the generated dungeons, while remaining fully compatible with the constraints and best practices outlined in the Oscar64/C64 project README.
