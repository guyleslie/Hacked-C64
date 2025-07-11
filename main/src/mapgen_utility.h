// Returns 1 if (x, y) is a valid room wall tile for door placement (not a corner)
unsigned char is_valid_room_wall_for_door(unsigned char x, unsigned char y);
#ifndef MAPGEN_UTILITY_H
#define MAPGEN_UTILITY_H

#include "mapgen_types.h"

// Mathematical and coordinate utility functions
unsigned char fast_abs_diff(unsigned char a, unsigned char b);
void get_room_center(unsigned char room_id, unsigned char *center_x, unsigned char *center_y);
void init_room_center_cache(void);
void clear_room_center_cache(void);
unsigned char manhattan_distance(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2);
unsigned char calculate_room_distance(unsigned char room1, unsigned char room2);
unsigned char calculate_direction(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2);
unsigned char coords_in_bounds(unsigned char x, unsigned char y);
void clamp_to_bounds(unsigned char *x, unsigned char *y);
unsigned char point_in_room(unsigned char x, unsigned char y, unsigned char room_id);
unsigned char rooms_overlap(unsigned char room1, unsigned char room2);
void iterate_room_pairs(void (*callback)(unsigned char room1, unsigned char room2));
void iterate_map_area(unsigned char start_x, unsigned char start_y, unsigned char width, unsigned char height,
                     void (*callback)(unsigned char x, unsigned char y));
void iterate_rooms_cache_friendly(void (*callback)(unsigned char room_id));
void scan_map_with_stride(unsigned char stride, unsigned char offset,
                         void (*callback)(unsigned char x, unsigned char y));
void process_rect_area_optimized(unsigned char x1, unsigned char y1, 
                                unsigned char x2, unsigned char y2,
                                void (*callback)(unsigned char x, unsigned char y));
unsigned char check_tile_has_types(unsigned char x, unsigned char y, unsigned char type_flags);
unsigned char check_adjacent_tile_types(unsigned char x, unsigned char y, unsigned char type_flags, unsigned char include_diagonals);

// Inline fast functions (can be moved to .c as static inline if needed)
inline unsigned char coords_in_bounds_fast(unsigned char x, unsigned char y) {
    return (x < MAP_W) && (y < MAP_H);
}
inline unsigned char tile_is_floor_fast(unsigned char x, unsigned char y) {
    if (!coords_in_bounds_fast(x, y)) return 0;
    return get_tile_raw(x, y) == TILE_FLOOR;
}
inline unsigned char tile_is_door_fast(unsigned char x, unsigned char y) {
    if (!coords_in_bounds_fast(x, y)) return 0;
    return get_tile_raw(x, y) == TILE_DOOR;
}
inline unsigned char tile_is_walkable_fast(unsigned char x, unsigned char y) {
    if (!coords_in_bounds_fast(x, y)) return 0;
    unsigned char tile = get_tile_raw(x, y);
    return (tile == TILE_FLOOR) || (tile == TILE_DOOR);
}
inline unsigned char manhattan_distance_fast(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2) {
    return fast_abs_diff(x1, x2) + fast_abs_diff(y1, y2);
}

#endif // MAPGEN_UTILITY_H
