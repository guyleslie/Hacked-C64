#!/usr/bin/env python3
"""Deterministic host-side audit for the C64 map generator.

The simulator mirrors the room placement, Prim-style room network, and normal
straight/L/Z corridor drawing used by main/src/mapgen.  It intentionally has
no third-party dependencies, so large seed ranges can be checked quickly
before the same seeds are verified in VICE.

Profiles:
  current  - mirrors the current C implementation.
  guarded  - keeps the same placement and corridor rules, but adds an
             exhaustive placement fallback and avoids saturated MST parents.

This is a regression/audit tool, not a replacement for VICE verification.
"""

from __future__ import annotations

import argparse
import json
from collections import Counter
from dataclasses import asdict, dataclass, field
from enum import IntEnum
from pathlib import Path
from typing import Iterable, Sequence


class Tile(IntEnum):
    EMPTY = 0
    WALL = 1
    FLOOR = 2
    DOOR = 3


@dataclass(frozen=True)
class MapSpec:
    name: str
    width: int
    grid_size: int
    target_rooms: int


MAP_SPECS = {
    "small": MapSpec("small", 50, 3, 9),
    "medium": MapSpec("medium", 64, 4, 16),
    "large": MapSpec("large", 78, 5, 20),
}

MIN_ROOM_SIZE = 4
MAX_ROOM_SIZE = 8
MIN_ROOM_DISTANCE = 4
PLACEMENT_ATTEMPTS = 15
MAX_ROOM_CONNECTIONS = 4
MAX_GUARDED_LAYOUT_ATTEMPTS = 16


class Lcg16:
    """The exact 16-bit LCG used by mapgen_utils.c::rnd()."""

    def __init__(self, seed: int) -> None:
        self.state = seed & 0xFFFF or 1

    def rnd(self, maximum: int) -> int:
        if maximum <= 1:
            return 0
        self.state = (self.state * 75 + 74) & 0xFFFF
        return ((self.state >> 8) & 0xFF) % maximum


@dataclass
class DoorRef:
    target: int
    x: int
    y: int
    wall_side: int
    corridor_type: int


@dataclass
class Room:
    x: int
    y: int
    w: int
    h: int
    grid_index: int
    doors: list[DoorRef] = field(default_factory=list)

    @property
    def center_x(self) -> int:
        return self.x + (self.w - 1) // 2

    @property
    def center_y(self) -> int:
        return self.y + (self.h - 1) // 2

    @property
    def connections(self) -> int:
        return len(self.doors)

    def contains_floor(self, x: int, y: int) -> bool:
        return self.x <= x < self.x + self.w and self.y <= y < self.y + self.h

    def contains_wall(self, x: int, y: int) -> bool:
        return (
            self.x - 1 <= x <= self.x + self.w
            and self.y - 1 <= y <= self.y + self.h
            and not self.contains_floor(x, y)
        )


@dataclass
class AuditEvents:
    placement_random_failures: int = 0
    placement_scan_recoveries: int = 0
    placement_size_recoveries: int = 0
    placement_true_failures: int = 0
    mst_capacity_stops: int = 0
    corridor_hits_walkable: int = 0
    corridor_hits_wall: int = 0
    corridor_hits_third_room: int = 0
    corridor_parallel_touches: int = 0
    same_wall_reuses: int = 0
    same_wall_different_point: int = 0

    def nonzero(self) -> dict[str, int]:
        return {key: value for key, value in asdict(self).items() if value}


@dataclass
class SeedResult:
    seed: int
    map_size: str
    profile: str
    rooms: int
    target_rooms: int
    connections: int
    required_connections: int
    fully_connected: bool
    checksum: int
    events: AuditEvents

    @property
    def room_shortfall(self) -> int:
        return self.target_rooms - self.rooms

    @property
    def connection_shortfall(self) -> int:
        return self.required_connections - self.connections

    @property
    def failed(self) -> bool:
        return self.room_shortfall > 0 or not self.fully_connected


class DungeonModel:
    def __init__(self, spec: MapSpec, seed: int, profile: str, audit_level: str = "fast") -> None:
        self.spec = spec
        self.seed = seed
        self.profile = profile
        self.audit_level = audit_level
        self.rng = Lcg16(seed)
        self.tiles = [bytearray(spec.width) for _ in range(spec.width)]
        self.rooms: list[Room] = []
        self.events = AuditEvents()
        self.connections_made = 0

    def get_tile(self, x: int, y: int) -> Tile:
        if 0 <= x < self.spec.width and 0 <= y < self.spec.width:
            return Tile(self.tiles[y][x])
        return Tile.EMPTY

    def set_tile(self, x: int, y: int, tile: Tile) -> None:
        if 0 <= x < self.spec.width and 0 <= y < self.spec.width:
            self.tiles[y][x] = tile

    def can_place_room(self, x: int, y: int, w: int, h: int) -> bool:
        buffer_x1 = x - MIN_ROOM_DISTANCE if x >= MIN_ROOM_DISTANCE + 1 else 1
        buffer_y1 = y - MIN_ROOM_DISTANCE if y >= MIN_ROOM_DISTANCE + 1 else 1
        buffer_x2 = x + w + MIN_ROOM_DISTANCE
        buffer_y2 = y + h + MIN_ROOM_DISTANCE

        if buffer_x2 + 1 >= self.spec.width or buffer_y2 + 1 >= self.spec.width:
            return False

        # During room placement the only occupied tiles are complete room
        # rectangles (floor plus their one-tile wall perimeter). Rectangle
        # intersection is therefore exactly equivalent to scanning every
        # packed tile in room_management.c, but is much faster on the host.
        for room in self.rooms:
            room_x1 = room.x - 1
            room_y1 = room.y - 1
            room_x2 = room.x + room.w
            room_y2 = room.y + room.h
            separated = (
                buffer_x2 < room_x1
                or room_x2 < buffer_x1
                or buffer_y2 < room_y1
                or room_y2 < buffer_y1
            )
            if not separated:
                return False
        return True

    def can_place_room_tile_scan(self, x: int, y: int, w: int, h: int) -> bool:
        """Slow reference implementation matching the original packed-tile scan."""
        buffer_x1 = x - MIN_ROOM_DISTANCE if x >= MIN_ROOM_DISTANCE + 1 else 1
        buffer_y1 = y - MIN_ROOM_DISTANCE if y >= MIN_ROOM_DISTANCE + 1 else 1
        buffer_x2 = x + w + MIN_ROOM_DISTANCE
        buffer_y2 = y + h + MIN_ROOM_DISTANCE
        if buffer_x2 + 1 >= self.spec.width or buffer_y2 + 1 >= self.spec.width:
            return False
        return all(
            self.get_tile(ix, iy) == Tile.EMPTY
            for iy in range(buffer_y1, buffer_y2 + 1)
            for ix in range(buffer_x1, buffer_x2 + 1)
        )

    def placement_bounds(self, grid_index: int, w: int, h: int) -> tuple[int, int, int, int] | None:
        grid_size = self.spec.grid_size
        grid_x = grid_index % grid_size
        grid_y = grid_index // grid_size
        cell_w = (self.spec.width - 8) // grid_size
        cell_h = (self.spec.width - 8) // grid_size

        cell_min_x = 1 + grid_x * cell_w
        cell_min_y = 1 + grid_y * cell_h
        cell_max_x = cell_min_x + cell_w - 1
        cell_max_y = cell_min_y + cell_h - 1

        expanded_min_x = cell_min_x - MIN_ROOM_DISTANCE if cell_min_x > MIN_ROOM_DISTANCE else 1
        expanded_min_y = cell_min_y - MIN_ROOM_DISTANCE if cell_min_y > MIN_ROOM_DISTANCE else 1
        expanded_max_x = cell_max_x + MIN_ROOM_DISTANCE
        expanded_max_y = cell_max_y + MIN_ROOM_DISTANCE

        clamp_argument = self.spec.width - 1
        if expanded_max_x >= clamp_argument:
            expanded_max_x = clamp_argument - 1
        if expanded_max_y >= clamp_argument:
            expanded_max_y = clamp_argument - 1

        placement_max_x = expanded_max_x - (w - 1)
        placement_max_y = expanded_max_y - (h - 1)
        if expanded_min_x > placement_max_x or expanded_min_y > placement_max_y:
            return None
        return expanded_min_x, expanded_min_y, placement_max_x, placement_max_y

    def try_random_positions(self, grid_index: int, w: int, h: int) -> tuple[int, int] | None:
        bounds = self.placement_bounds(grid_index, w, h)
        if bounds is None:
            return None
        min_x, min_y, max_x, max_y = bounds
        range_x = max_x - min_x + 1
        range_y = max_y - min_y + 1
        for _ in range(PLACEMENT_ATTEMPTS):
            x = min_x + self.rng.rnd(range_x)
            y = min_y + self.rng.rnd(range_y)
            if self.can_place_room(x, y, w, h):
                return x, y
        self.events.placement_random_failures += 1
        return None

    def scan_positions(self, grid_index: int, w: int, h: int) -> tuple[int, int] | None:
        """Exhaustively scan the same current placement region from a random start."""
        bounds = self.placement_bounds(grid_index, w, h)
        if bounds is None:
            return None
        min_x, min_y, max_x, max_y = bounds
        range_x = max_x - min_x + 1
        range_y = max_y - min_y + 1
        start_x = self.rng.rnd(range_x)
        start_y = self.rng.rnd(range_y)

        for y_offset in range(range_y):
            y = min_y + (start_y + y_offset) % range_y
            for x_offset in range(range_x):
                x = min_x + (start_x + x_offset) % range_x
                if self.can_place_room(x, y, w, h):
                    return x, y
        return None

    def place_room(self, grid_index: int, x: int, y: int, w: int, h: int) -> None:
        if self.audit_level == "full":
            for iy in range(y, y + h):
                for ix in range(x, x + w):
                    self.set_tile(ix, iy, Tile.FLOOR)
            for ix in range(x - 1, x + w + 1):
                self.set_tile(ix, y - 1, Tile.WALL)
                self.set_tile(ix, y + h, Tile.WALL)
            for iy in range(y, y + h):
                self.set_tile(x - 1, iy, Tile.WALL)
                self.set_tile(x + w, iy, Tile.WALL)
        self.rooms.append(Room(x, y, w, h, grid_index))

    def create_room_layout(self) -> None:
        positions = list(range(self.spec.grid_size * self.spec.grid_size))
        for index in range(len(positions) - 1, 0, -1):
            swap_index = self.rng.rnd(index + 1)
            positions[index], positions[swap_index] = positions[swap_index], positions[index]

        for grid_index in positions:
            if len(self.rooms) >= self.spec.target_rooms:
                break
            initial_w = MIN_ROOM_SIZE + self.rng.rnd(MAX_ROOM_SIZE - MIN_ROOM_SIZE + 1)
            initial_h = MIN_ROOM_SIZE + self.rng.rnd(MAX_ROOM_SIZE - MIN_ROOM_SIZE + 1)
            result = self.try_random_positions(grid_index, initial_w, initial_h)
            chosen_w, chosen_h = initial_w, initial_h

            if result is None and self.profile == "guarded":
                result = self.scan_positions(grid_index, initial_w, initial_h)
                if result is not None:
                    self.events.placement_scan_recoveries += 1

            if result is None and self.profile == "guarded":
                fallback_w = MIN_ROOM_SIZE
                fallback_h = MIN_ROOM_SIZE
                if (initial_w, initial_h) != (fallback_w, fallback_h):
                    result = self.try_random_positions(grid_index, fallback_w, fallback_h)
                    if result is None:
                        result = self.scan_positions(grid_index, fallback_w, fallback_h)
                    if result is not None:
                        chosen_w, chosen_h = fallback_w, fallback_h
                        self.events.placement_size_recoveries += 1

            if result is None:
                self.events.placement_true_failures += 1
                continue
            self.place_room(grid_index, result[0], result[1], chosen_w, chosen_h)

    def create_rooms(self) -> None:
        attempts = MAX_GUARDED_LAYOUT_ATTEMPTS if self.profile == "guarded" else 1
        for layout_attempt in range(attempts):
            if layout_attempt:
                self.rooms.clear()
                if self.audit_level == "full":
                    self.tiles = [bytearray(self.spec.width) for _ in range(self.spec.width)]
            self.create_room_layout()
            if len(self.rooms) >= self.spec.target_rooms:
                break

    @staticmethod
    def line_points(start: tuple[int, int], end: tuple[int, int]) -> list[tuple[int, int]]:
        x, y = start
        target_x, target_y = end
        result: list[tuple[int, int]] = []
        while True:
            result.append((x, y))
            if x == target_x and y == target_y:
                return result
            if x < target_x:
                x += 1
            elif x > target_x:
                x -= 1
            if y < target_y:
                y += 1
            elif y > target_y:
                y -= 1

    @staticmethod
    def wall_side(room: Room, point: tuple[int, int]) -> int:
        x, y = point
        if x < room.x:
            return 0
        if x >= room.x + room.w:
            return 1
        if y < room.y:
            return 2
        return 3

    @staticmethod
    def exit_toward(room: Room, target_x: int, target_y: int) -> tuple[int, int]:
        dx = abs(target_x - room.center_x)
        dy = abs(target_y - room.center_y)
        if dx > dy:
            return (room.x + room.w, room.center_y) if target_x > room.center_x else (room.x - 1, room.center_y)
        return (room.center_x, room.y + room.h) if target_y > room.center_y else (room.center_x, room.y - 1)

    def route(self, room1: int, room2: int) -> tuple[int, tuple[int, int], tuple[int, int], list[list[tuple[int, int]]]]:
        first = self.rooms[room1]
        second = self.rooms[room2]

        if first.center_x == second.center_x:
            faces = (
                first.y + first.h <= second.y
                if first.center_y < second.center_y
                else second.y + second.h <= first.y
            )
            if faces:
                exit1 = (first.center_x, first.y + first.h if first.center_y < second.center_y else first.y - 1)
                exit2 = (second.center_x, second.y - 1 if first.center_y < second.center_y else second.y + second.h)
                return 0, exit1, exit2, [self.line_points(exit1, exit2)]

        if first.center_y == second.center_y:
            faces = (
                first.x + first.w <= second.x
                if first.center_x < second.center_x
                else second.x + second.w <= first.x
            )
            if faces:
                exit1 = (first.x + first.w if first.center_x < second.center_x else first.x - 1, first.center_y)
                exit2 = (second.x - 1 if first.center_x < second.center_x else second.x + second.w, second.center_y)
                return 0, exit1, exit2, [self.line_points(exit1, exit2)]

        separated_x = first.x + first.w <= second.x or second.x + second.w <= first.x
        separated_y = first.y + first.h <= second.y or second.y + second.h <= first.y
        if separated_x and separated_y:
            corridor_type = 1
            dx = abs(second.center_x - first.center_x)
            dy = abs(second.center_y - first.center_y)
            if dx > dy:
                exit1 = (first.x + first.w if second.center_x > first.center_x else first.x - 1, first.center_y)
                exit2 = (second.center_x, second.y - 1 if second.center_y > first.center_y else second.y + second.h)
            else:
                exit1 = (first.center_x, first.y + first.h if second.center_y > first.center_y else first.y - 1)
                exit2 = (second.x - 1 if second.center_x > first.center_x else second.x + second.w, second.center_y)
        else:
            corridor_type = 2
            exit1 = self.exit_toward(first, second.center_x, second.center_y)
            exit2 = self.exit_toward(second, first.center_x, first.center_y)

        first_side = self.wall_side(first, exit1)
        if corridor_type == 1:
            breakpoints = [(exit2[0], exit1[1])] if first_side < 2 else [(exit1[0], exit2[1])]
        elif first_side < 2:
            middle_x = (exit1[0] + exit2[0]) // 2
            breakpoints = [(middle_x, exit1[1]), (middle_x, exit2[1])]
        else:
            middle_y = (exit1[1] + exit2[1]) // 2
            breakpoints = [(exit1[0], middle_y), (exit2[0], middle_y)]

        segments: list[list[tuple[int, int]]] = []
        current = exit1
        for endpoint in [*breakpoints, exit2]:
            segments.append(self.line_points(current, endpoint))
            current = endpoint
        return corridor_type, exit1, exit2, segments

    def inspect_route(
        self,
        room1: int,
        room2: int,
        exit1: tuple[int, int],
        exit2: tuple[int, int],
        segments: Sequence[Sequence[tuple[int, int]]],
    ) -> None:
        points: list[tuple[int, int]] = []
        for segment in segments:
            for point in segment:
                if not points or point != points[-1]:
                    points.append(point)

        for point in points:
            if point in (exit1, exit2):
                continue
            tile = self.get_tile(*point)
            if tile in (Tile.FLOOR, Tile.DOOR):
                self.events.corridor_hits_walkable += 1
            elif tile == Tile.WALL:
                self.events.corridor_hits_wall += 1
            for index, room in enumerate(self.rooms):
                if index not in (room1, room2) and room.contains_floor(*point):
                    self.events.corridor_hits_third_room += 1
                    break

        for segment in segments:
            horizontal = segment[0][1] == segment[-1][1]
            for x, y in segment:
                if self.get_tile(x, y) in (Tile.FLOOR, Tile.DOOR):
                    continue
                neighbors = ((x, y - 1), (x, y + 1)) if horizontal else ((x - 1, y), (x + 1, y))
                if any(self.get_tile(*neighbor) in (Tile.FLOOR, Tile.DOOR) for neighbor in neighbors):
                    self.events.corridor_parallel_touches += 1

    def wall_segment(self, segment: Sequence[tuple[int, int]]) -> None:
        x1, y1 = segment[0]
        x2, y2 = segment[-1]
        if y1 == y2:
            start, end = sorted((x1, x2))
            for x in range(start, end + 1):
                if self.get_tile(x, y1 - 1) == Tile.EMPTY:
                    self.set_tile(x, y1 - 1, Tile.WALL)
                if self.get_tile(x, y1 + 1) == Tile.EMPTY:
                    self.set_tile(x, y1 + 1, Tile.WALL)
            if self.get_tile(start - 1, y1) == Tile.EMPTY:
                self.set_tile(start - 1, y1, Tile.WALL)
            if self.get_tile(end + 1, y1) == Tile.EMPTY:
                self.set_tile(end + 1, y1, Tile.WALL)
        else:
            start, end = sorted((y1, y2))
            for y in range(start, end + 1):
                if self.get_tile(x1 - 1, y) == Tile.EMPTY:
                    self.set_tile(x1 - 1, y, Tile.WALL)
                if self.get_tile(x1 + 1, y) == Tile.EMPTY:
                    self.set_tile(x1 + 1, y, Tile.WALL)
            if self.get_tile(x1, start - 1) == Tile.EMPTY:
                self.set_tile(x1, start - 1, Tile.WALL)
            if self.get_tile(x1, end + 1) == Tile.EMPTY:
                self.set_tile(x1, end + 1, Tile.WALL)

    def draw_route(self, segments: Sequence[Sequence[tuple[int, int]]]) -> None:
        for index, segment in enumerate(segments):
            for point in segment:
                self.set_tile(*point, Tile.FLOOR)
            self.wall_segment(segment)
            if index < len(segments) - 1:
                junction_x, junction_y = segment[-1]
                for y in range(junction_y - 1, junction_y + 2):
                    for x in range(junction_x - 1, junction_x + 2):
                        if self.get_tile(x, y) == Tile.EMPTY:
                            self.set_tile(x, y, Tile.WALL)

    def add_connection(self, room1: int, room2: int) -> bool:
        first = self.rooms[room1]
        second = self.rooms[room2]
        if first.connections >= MAX_ROOM_CONNECTIONS or second.connections >= MAX_ROOM_CONNECTIONS:
            return False

        corridor_type, exit1, exit2, segments = self.route(room1, room2)
        if self.audit_level == "full":
            self.inspect_route(room1, room2, exit1, exit2, segments)

        for room, exit_point in ((first, exit1), (second, exit2)):
            side = self.wall_side(room, exit_point)
            existing = [(door.x, door.y) for door in room.doors if door.wall_side == side]
            if existing:
                self.events.same_wall_reuses += 1
                if exit_point not in existing:
                    self.events.same_wall_different_point += 1

        if self.audit_level == "full":
            self.draw_route(segments)
            self.set_tile(*exit1, Tile.DOOR)
            self.set_tile(*exit2, Tile.DOOR)
        side1 = self.wall_side(first, exit1)
        side2 = self.wall_side(second, exit2)
        first.doors.append(DoorRef(room2, *exit1, side1, corridor_type))
        second.doors.append(DoorRef(room1, *exit2, side2, corridor_type))
        return True

    def build_network(self) -> None:
        if not self.rooms:
            return
        connected = [False] * len(self.rooms)
        connected[0] = True

        while self.connections_made < len(self.rooms) - 1:
            best_pair: tuple[int, int] | None = None
            best_distance = 255
            for first_index, first in enumerate(self.rooms):
                if not connected[first_index]:
                    continue
                if self.profile == "guarded" and first.connections >= MAX_ROOM_CONNECTIONS:
                    continue
                for second_index, second in enumerate(self.rooms):
                    if connected[second_index] or first_index == second_index:
                        continue
                    distance = abs(first.center_x - second.center_x) + abs(first.center_y - second.center_y)
                    if distance < best_distance:
                        best_distance = distance
                        best_pair = first_index, second_index

            if best_pair is None:
                break
            if not self.add_connection(*best_pair):
                self.events.mst_capacity_stops += 1
                break
            connected[best_pair[1]] = True
            self.connections_made += 1

    def checksum(self) -> int:
        value = 0
        if self.audit_level == "fast":
            for room in self.rooms:
                for item in (room.x, room.y, room.w, room.h, room.grid_index):
                    value = ((value << 5) - value + item) & 0xFFFF
                for door in room.doors:
                    for item in (door.target, door.x, door.y, door.wall_side, door.corridor_type):
                        value = ((value << 5) - value + item) & 0xFFFF
            return value
        for row in self.tiles:
            for tile in row:
                value = ((value << 5) - value + tile) & 0xFFFF
        return value

    def run(self) -> SeedResult:
        self.create_rooms()
        self.build_network()
        required = max(0, len(self.rooms) - 1)
        return SeedResult(
            seed=self.seed,
            map_size=self.spec.name,
            profile=self.profile,
            rooms=len(self.rooms),
            target_rooms=self.spec.target_rooms,
            connections=self.connections_made,
            required_connections=required,
            fully_connected=self.connections_made == required,
            checksum=self.checksum(),
            events=self.events,
        )


def parse_seed_range(text: str) -> range:
    if ":" in text:
        start_text, end_text = text.split(":", 1)
        start, end = int(start_text), int(end_text)
    else:
        start, end = 1, int(text)
    if start < 1 or end > 65535 or start > end:
        raise argparse.ArgumentTypeError("seed range must be within 1..65535 and start <= end")
    return range(start, end + 1)


def run_seed(spec: MapSpec, seed: int, profile: str, audit_level: str = "fast") -> SeedResult:
    return DungeonModel(spec, seed, profile, audit_level).run()


def result_to_dict(result: SeedResult) -> dict[str, object]:
    data = asdict(result)
    data["room_shortfall"] = result.room_shortfall
    data["connection_shortfall"] = result.connection_shortfall
    data["failed"] = result.failed
    return data


def summarize(
    spec: MapSpec,
    seed_range: range,
    profile: str,
    examples: int,
    audit_level: str,
) -> dict[str, object]:
    room_counts: Counter[int] = Counter()
    event_totals: Counter[str] = Counter()
    event_seed_counts: Counter[str] = Counter()
    failed_seeds: list[dict[str, object]] = []
    full_room_count = 0
    connected_count = 0

    for seed in seed_range:
        result = run_seed(spec, seed, profile, audit_level)
        room_counts[result.rooms] += 1
        if result.rooms == spec.target_rooms:
            full_room_count += 1
        if result.fully_connected:
            connected_count += 1
        for name, count in result.events.nonzero().items():
            event_totals[name] += count
            event_seed_counts[name] += 1
        if result.failed and len(failed_seeds) < examples:
            failed_seeds.append(result_to_dict(result))

    total = len(seed_range)
    return {
        "map_size": spec.name,
        "profile": profile,
        "audit_level": audit_level,
        "seed_start": seed_range.start,
        "seed_end": seed_range.stop - 1,
        "seed_count": total,
        "room_counts": dict(sorted(room_counts.items())),
        "full_room_rate": full_room_count / total,
        "connected_rate": connected_count / total,
        "event_totals": dict(event_totals),
        "event_seed_rates": {name: count / total for name, count in event_seed_counts.items()},
        "failed_examples": failed_seeds,
    }


def print_summary(summary: dict[str, object]) -> None:
    print(
        f"{summary['map_size']:>6}  profile={summary['profile']}  "
        f"audit={summary['audit_level']}  seeds={summary['seed_count']}"
    )
    print(f"  room counts: {summary['room_counts']}")
    print(f"  full rooms:  {summary['full_room_rate']:.2%}")
    print(f"  connected:   {summary['connected_rate']:.2%}")
    rates = summary["event_seed_rates"]
    if rates:
        print("  event seed rates:")
        for name, rate in sorted(rates.items()):
            print(f"    {name:<32} {rate:>8.2%}")
    examples = summary["failed_examples"]
    if examples:
        compact = [
            {
                "seed": item["seed"],
                "rooms": f"{item['rooms']}/{item['target_rooms']}",
                "connections": f"{item['connections']}/{item['required_connections']}",
            }
            for item in examples
        ]
        print(f"  failed examples: {compact}")


def self_test() -> None:
    rng = Lcg16(1)
    assert [rng.rnd(10) for _ in range(5)] == [0, 3, 3, 2, 4]

    first = run_seed(MAP_SPECS["small"], 1, "current", "full")
    second = run_seed(MAP_SPECS["small"], 1, "current", "full")
    assert result_to_dict(first) == result_to_dict(second)
    assert first.connections <= max(0, first.rooms - 1)

    guarded = run_seed(MAP_SPECS["small"], 1, "guarded", "full")
    assert guarded.rooms >= first.rooms
    assert guarded.connections <= max(0, guarded.rooms - 1)

    # The optimized room-rectangle collision test must remain identical to the
    # original tile scan for every sampled coordinate and room size.
    placement_model = DungeonModel(MAP_SPECS["small"], 1234, "current", "full")
    placement_model.create_rooms()
    for w, h in ((4, 4), (5, 7), (8, 8)):
        for y in range(1, placement_model.spec.width, 3):
            for x in range(1, placement_model.spec.width, 3):
                assert placement_model.can_place_room(x, y, w, h) == placement_model.can_place_room_tile_scan(x, y, w, h)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--profile", choices=("current", "guarded"), default="current")
    parser.add_argument(
        "--audit-level",
        choices=("fast", "full"),
        default="fast",
        help="fast checks room/network invariants; full also draws and audits every corridor tile",
    )
    parser.add_argument("--size", choices=(*MAP_SPECS, "all"), default="all")
    parser.add_argument("--seeds", type=parse_seed_range, default=parse_seed_range("1000"), metavar="START:END")
    parser.add_argument("--examples", type=int, default=5)
    parser.add_argument("--json", type=Path, help="write the complete summary as JSON")
    parser.add_argument("--inspect", type=int, metavar="SEED", help="print one detailed seed result")
    parser.add_argument("--self-test", action="store_true")
    args = parser.parse_args()

    if args.self_test:
        self_test()
        print("self-test: OK")
        return 0

    specs: Iterable[MapSpec]
    if args.size == "all":
        specs = MAP_SPECS.values()
    else:
        specs = (MAP_SPECS[args.size],)

    if args.inspect is not None:
        for spec in specs:
            print(
                json.dumps(
                    result_to_dict(run_seed(spec, args.inspect, args.profile, args.audit_level)),
                    indent=2,
                )
            )
        return 0

    summaries = [
        summarize(spec, args.seeds, args.profile, args.examples, args.audit_level)
        for spec in specs
    ]
    for summary in summaries:
        print_summary(summary)

    if args.json:
        args.json.parent.mkdir(parents=True, exist_ok=True)
        args.json.write_text(json.dumps(summaries, indent=2), encoding="utf-8")
        print(f"JSON report: {args.json}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
