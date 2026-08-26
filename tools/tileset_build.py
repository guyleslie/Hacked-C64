#!/usr/bin/env python3
"""Build C64 tileset assets from a CharPad CTM file.

The map tiles are 3x3 characters. Visual layers do not have to be drawn by hand
in CharPad; this tool can generate them from mask tables:

  grid  a one pixel black line on the top edge and the left edge of every
        walkable tile. Neighbouring tiles complete each other's frame, so a
        continuous lattice appears over the walkable area.
  fog   an optional checkerboard of black pixels (disabled by default).

Both layers are stencils: only black matters, everything else passes through.
On the VIC-II that is a single bitwise operation per character row, and the
polarity depends on the character's colour mode:

  hires char (colour RAM 0)     set bits show black foreground
                                -> layer is OR
  multicolour char (colour 8)   %11 bit pairs show colour RAM black
                                -> layer is OR on complete pixel pairs

Characters that do not currently use their per-character colour can be safely
remapped to colour 0/8 in the generated variant. Falling back to background
colour 0 is only possible when $d021 is black.

Because the layers are pure masks, the tileset authored in CharPad only has to
contain the clean artwork. The lit/fog variants and the framed characters are
derived here, deduplicated, and emitted as C tables.

Usage examples:

    python tools/tileset_build.py main/assets/tileset.ctm --self-test
    python tools/tileset_build.py main/assets/tileset.ctm --preview build/tiles.png
    python tools/tileset_build.py main/assets/tileset.ctm --out-dir main/src/tiles
"""

import argparse
import os
import struct
import sys
import zlib

# -----------------------------------------------------------------------------
# CharPad CTM v7 container
# -----------------------------------------------------------------------------

BLOCK_CHARS = 0xB0
BLOCK_CHAR_ATTRS = 0xB1
BLOCK_TILES = 0xB2
BLOCK_TILE_ATTRS = 0xB3
BLOCK_TILE_NAMES = 0xB4
BLOCK_MAP = 0xB5


class Ctm:
    """A parsed CharPad CTM v7 file."""

    def __init__(self, data):
        if data[:3] != b"CTM":
            raise ValueError("not a CTM file")
        self.version = data[3]
        if self.version != 7:
            raise ValueError("unsupported CTM version %d (expected 7)" % self.version)

        self.bg0, self.bg1, self.bg2 = data[4], data[5], data[6]

        pos = 12
        pos = self._expect(data, pos, BLOCK_CHARS)
        char_count = (data[pos] | data[pos + 1] << 8) + 1
        pos += 2
        self.chars = [list(data[pos + i * 8:pos + i * 8 + 8]) for i in range(char_count)]
        pos += char_count * 8

        pos = self._expect(data, pos, BLOCK_CHAR_ATTRS)
        self.char_attrs = list(data[pos:pos + char_count])
        pos += char_count

        pos = self._expect(data, pos, BLOCK_TILES)
        tile_count = (data[pos] | data[pos + 1] << 8) + 1
        self.tile_w, self.tile_h = data[pos + 2], data[pos + 3]
        pos += 4
        cells = self.tile_w * self.tile_h
        self.tiles = []
        for _ in range(tile_count):
            self.tiles.append([data[pos + i * 2] | data[pos + i * 2 + 1] << 8
                               for i in range(cells)])
            pos += cells * 2

        # The remaining blocks are optional for asset generation. The map block
        # is kept because it documents how the wall tiles are meant to join.
        self.map_w = self.map_h = 0
        self.map = []
        idx = data.find(bytes([0xDA, BLOCK_MAP]), pos)
        if idx >= 0:
            p = idx + 2
            self.map_w = data[p] | data[p + 1] << 8
            self.map_h = data[p + 2] | data[p + 3] << 8
            p += 4
            need = self.map_w * self.map_h * 2
            if len(data) - p >= need:
                self.map = [[data[p + (y * self.map_w + x) * 2]
                             | data[p + (y * self.map_w + x) * 2 + 1] << 8
                             for x in range(self.map_w)]
                            for y in range(self.map_h)]

    @staticmethod
    def _expect(data, pos, marker):
        if data[pos] != 0xDA or data[pos + 1] != marker:
            raise ValueError("expected block 0x%02X at offset %d" % (marker, pos))
        return pos + 2

    @property
    def cells_per_tile(self):
        return self.tile_w * self.tile_h

    def is_hires(self, char_index):
        return self.char_attrs[char_index] < 8

    @classmethod
    def load(cls, path):
        with open(path, "rb") as handle:
            return cls(handle.read())


# -----------------------------------------------------------------------------
# Overlay layers
# -----------------------------------------------------------------------------

def grid_mask(cell, tile_w, tile_h, hires):
    """Black frame on the tile's top edge and left edge.

    In multicolour a pixel is two bits wide, so the left line is one multicolour
    pixel (two physical pixels). In hires it is a single physical pixel.

    The cell where the two lines meet also gets a joint pixel just below the
    corner, so the turn reads as solid instead of a thin hook.
    """
    col, row = cell % tile_w, cell // tile_w
    mask = [0] * 8
    if row == 0:
        mask[0] = 0xFF
    if col == 0:
        left = 0xC0 if not hires else 0x80
        for r in range(8):
            mask[r] |= left
        if row == 0:
            mask[1] |= 0xC0
    return mask


def fog_mask(cell, tile_w, tile_h, hires):
    """Checkerboard of black pixels, used to darken explored-but-unseen tiles."""
    del cell, tile_w, tile_h
    even, odd = (0xAA, 0x55) if hires else (0xCC, 0x33)
    return [even if (r & 1) == 0 else odd for r in range(8)]


LAYERS = {
    "grid": grid_mask,
    "fog": fog_mask,
}

# Variant order must match the TILE_VARIANT_* constants emitted below.
VARIANTS = [
    ("LIT", ("grid",)),
    ("FOG", ("grid", "fog")),
]


def _expand_pairs(value):
    """Widen every set bit to cover its whole multicolour bit pair."""
    out = 0
    for shift in (6, 4, 2, 0):
        if (value >> shift) & 3:
            out |= 3 << shift
    return out


def _hires_foreground_outside_mask(rows, mask):
    return any(rows[r] & (~mask[r] & 0xFF) for r in range(8))


def _multicolour_char_colour_outside_mask(rows, mask):
    """Whether a %11 pixel pair survives outside the layer mask."""
    pairs = [_expand_pairs(value) for value in mask]
    for r, byte in enumerate(rows):
        for shift in (6, 4, 2, 0):
            bits = 3 << shift
            if byte & bits == bits and not pairs[r] & bits:
                return True
    return False


def apply_black_mask(rows, mask, attr, bg0):
    """Stamp a black stencil and return (rows, output_attr, applied).

    In multicolour mode colour RAM value 8 means that the character-specific
    colour selected by %11 is black. This is the key path for the clean floor
    in newest5: setting complete pixel pairs paints a true black frame without
    consuming any of the three global colours.

    A non-black per-character colour may still be remapped to black when no
    foreground/%11 artwork survives outside the mask. Otherwise black can only
    be revealed through background colour 0 when $d021 is black.
    """
    if attr < 8:
        if attr == 0 or not _hires_foreground_outside_mask(rows, mask):
            return [rows[r] | mask[r] for r in range(8)], 0, True
        if bg0 == 0:
            return [rows[r] & (~mask[r] & 0xFF) for r in range(8)], attr, True
        return list(rows), attr, False

    pairs = [_expand_pairs(value) for value in mask]
    if (attr & 7) == 0 or not _multicolour_char_colour_outside_mask(rows, mask):
        return [rows[r] | pairs[r] for r in range(8)], 8, True
    if bg0 == 0:
        return [rows[r] & (~pairs[r] & 0xFF) for r in range(8)], attr, True
    return list(rows), attr, False


def apply_mask(rows, mask, attr, bg0=0):
    """Compatibility wrapper used by the small mask unit tests."""
    stamped, _, _ = apply_black_mask(rows, mask, attr, bg0)
    return stamped


def strip_mask(rows, mask, hires):
    """Remove a baked-in layer, for migrating hand drawn artwork.

    Stamping is lossy and this cannot be checked from the result alone: OR
    cannot tell a layer pixel from an artwork pixel underneath it, and
    re-stamping a stripped character always reproduces the input regardless.
    Only use this where the artwork is known to be blank under the mask.
    Authoring the CTM without the layers is the reliable path.

    Not defined for multicolour characters, where the stamp clears whole bit
    pairs and the artwork underneath is gone for good.
    """
    if not hires:
        raise ValueError("cannot strip a layer from a multicolour character")
    return [rows[r] & (~mask[r] & 0xFF) for r in range(8)]


# -----------------------------------------------------------------------------
# Tile roles
# -----------------------------------------------------------------------------

# Wall joining, read out of the map drawn in CharPad. A wall tile picks its
# shape from which of its four neighbours are also wall-like:
#
#     L+R -> horizontal run      R+D -> corner opening right and down
#     U+D -> vertical run        L+D -> corner opening left and down
#                                R+U -> corner opening right and up
#                                L+U -> corner opening left and up
#
# The connection mask below is CONN_UP | CONN_DOWN | CONN_LEFT | CONN_RIGHT.
CONN_UP, CONN_DOWN, CONN_LEFT, CONN_RIGHT = 1, 2, 4, 8

WALK_UP, WALK_DOWN, WALK_LEFT, WALK_RIGHT = 1, 2, 4, 8
WALK_UL, WALK_UR, WALK_DL, WALK_DR = 16, 32, 64, 128

WALL_SHAPES = [
    ("HORIZONTAL", CONN_LEFT | CONN_RIGHT),
    ("VERTICAL", CONN_UP | CONN_DOWN),
    ("CORNER_RD", CONN_RIGHT | CONN_DOWN),
    ("CORNER_LD", CONN_LEFT | CONN_DOWN),
    ("CORNER_RU", CONN_RIGHT | CONN_UP),
    ("CORNER_LU", CONN_LEFT | CONN_UP),
]


def analyse_map(ctm, wall_tiles, wall_like):
    """Derive the wall connection mask -> tile index table from the drawn map.

    `wall_tiles` are the tiles whose shape is being classified. `wall_like` are
    the tiles that count as a connection when looking at a neighbour, which has
    to include doors and gratings: they sit inside a wall run and the wall must
    keep running through them.

    Returns {connection mask: {tile index: times seen}} so both the rule and any
    disagreement in the source map are visible.
    """
    if not ctm.map:
        return {}
    observed = {}
    for y in range(ctm.map_h):
        for x in range(ctm.map_w):
            tile = ctm.map[y][x]
            if tile not in wall_tiles:
                continue
            mask = 0
            for dx, dy, bit in ((0, -1, CONN_UP), (0, 1, CONN_DOWN),
                                (-1, 0, CONN_LEFT), (1, 0, CONN_RIGHT)):
                nx, ny = x + dx, y + dy
                if 0 <= nx < ctm.map_w and 0 <= ny < ctm.map_h:
                    if ctm.map[ny][nx] in wall_like:
                        mask |= bit
            observed.setdefault(mask, {})
            observed[mask][tile] = observed[mask].get(tile, 0) + 1
    return observed


# -----------------------------------------------------------------------------
# Map reproduction
# -----------------------------------------------------------------------------

# Cell roles the game engine knows about, independent of any artwork.
ROLE_EMPTY, ROLE_FLOOR, ROLE_WALL, ROLE_DOOR = 0, 1, 2, 3
ROLE_STAIR_A, ROLE_STAIR_B, ROLE_ITEM = 4, 5, 6
ROLE_NAMES = ("empty", "floor", "WALL", "DOOR", "stairA", "stairB", "item")

# Which tileset tile stands for which role in the reference artwork. The hand
# drawn fog copies collapse onto their lit originals first, because fog is a
# generated layer and not a separate map cell.
FOG_DUPLICATES = {10: 9, 15: 13, 16: 14}
TILE_ROLE = {
    0: ROLE_EMPTY, 1: ROLE_FLOOR, 18: ROLE_ITEM,
    8: ROLE_STAIR_A, 9: ROLE_STAIR_B,
    2: ROLE_WALL, 3: ROLE_WALL, 4: ROLE_WALL,
    5: ROLE_WALL, 6: ROLE_WALL, 7: ROLE_WALL,
    # Tiles 13 and 14 are open doors: the leaf is gone but the wall's top rim
    # stays, which is why they are not plain floor. A cell with no door has no
    # rim at all.
    11: ROLE_DOOR, 12: ROLE_DOOR, 17: ROLE_DOOR, 13: ROLE_DOOR, 14: ROLE_DOOR,
}

TILE_WALL_H, TILE_WALL_V = 2, 3
TILE_WALL_RD, TILE_WALL_LD, TILE_WALL_RU, TILE_WALL_LU = 4, 5, 6, 7
TILE_GRATE_V, TILE_GRATE_H, TILE_DOOR_WOOD = 11, 12, 17
TILE_DOOR_OPEN_V, TILE_DOOR_OPEN_H = 13, 14

# Walkable tiles in newest5: floor, both stairs and open-door variants.
# Closed doors, walls and the black outside tile deliberately receive none.
DEFAULT_GRID_TILES = {1, 8, 9, 10, 13, 14, 15, 16}
DEFAULT_FOG_TILES = set()


def map_roles(ctm):
    """Reduce the drawn map to engine roles, plus the door state game data."""
    grid = [[FOG_DUPLICATES.get(v, v) for v in row] for row in ctm.map]
    roles = [[TILE_ROLE[v] for v in row] for row in grid]
    wooden = {(x, y)
              for y in range(ctm.map_h) for x in range(ctm.map_w)
              if grid[y][x] == TILE_DOOR_WOOD}
    opened = {(x, y)
              for y in range(ctm.map_h) for x in range(ctm.map_w)
              if grid[y][x] in (TILE_DOOR_OPEN_V, TILE_DOOR_OPEN_H)}
    return grid, roles, wooden, opened


def reproduce_map(ctm):
    """Re-derive the drawn map from roles alone.

    This is the acceptance test for the renderer: given only what the map
    generator produces - walkable cells, walls, door and stair positions - the
    tile selection rule has to put back the tiles that were drawn by hand.

    Returns (drawn, predicted, mismatches).
    """
    if not ctm.map:
        return None, None, []
    grid, roles, wooden, opened = map_roles(ctm)
    w, h = ctm.map_w, ctm.map_h

    def role(x, y):
        if x < 0 or y < 0 or x >= w or y >= h:
            return ROLE_EMPTY
        return roles[y][x]

    def wall_like(x, y):
        return role(x, y) in (ROLE_WALL, ROLE_DOOR)

    def walkable_space(x, y):
        return role(x, y) not in (ROLE_EMPTY, ROLE_WALL)

    def select_wall(x, y):
        mask = 0
        if wall_like(x, y - 1): mask |= CONN_UP
        if wall_like(x, y + 1): mask |= CONN_DOWN
        if wall_like(x - 1, y): mask |= CONN_LEFT
        if wall_like(x + 1, y): mask |= CONN_RIGHT

        walk_mask = 0
        for dx, dy, bit in (
                (0, -1, WALK_UP), (0, 1, WALK_DOWN),
                (-1, 0, WALK_LEFT), (1, 0, WALK_RIGHT),
                (-1, -1, WALK_UL), (1, -1, WALK_UR),
                (-1, 1, WALK_DL), (1, 1, WALK_DR)):
            if walkable_space(x + dx, y + dy):
                walk_mask |= bit

        shape = select_wall_shape(
            mask, walk_mask,
            far_left_walkable=walkable_space(x - 2, y),
            far_upper_left_wall=wall_like(x - 2, y - 2))
        return {
            CONN_LEFT | CONN_RIGHT: TILE_WALL_H,
            CONN_UP | CONN_DOWN: TILE_WALL_V,
            CONN_RIGHT | CONN_DOWN: TILE_WALL_RD,
            CONN_LEFT | CONN_DOWN: TILE_WALL_LD,
            CONN_RIGHT | CONN_UP: TILE_WALL_RU,
            CONN_LEFT | CONN_UP: TILE_WALL_LU,
        }[shape]

    def select(x, y):
        current = role(x, y)
        if current == ROLE_EMPTY:
            return 0
        if current == ROLE_WALL:
            return select_wall(x, y)
        if current == ROLE_DOOR:
            vertical = wall_like(x, y - 1) or wall_like(x, y + 1)
            if (x, y) in opened:
                return TILE_DOOR_OPEN_V if vertical else TILE_DOOR_OPEN_H
            if (x, y) in wooden:
                return TILE_DOOR_WOOD
            return TILE_GRATE_V if vertical else TILE_GRATE_H
        if current == ROLE_STAIR_A:
            return 8
        if current == ROLE_STAIR_B:
            return 9
        if current == ROLE_ITEM:
            return 18
        return 1

    predicted = [[select(x, y) for x in range(w)] for y in range(h)]
    mismatches = [(x, y, grid[y][x], predicted[y][x])
                  for y in range(h) for x in range(w)
                  if predicted[y][x] != grid[y][x]]
    return grid, predicted, mismatches


def report_reproduction(ctm):
    drawn, predicted, mismatches = reproduce_map(ctm)
    if drawn is None:
        print("no map block in the CTM file, reproduction not checked")
        return
    total = ctm.map_w * ctm.map_h
    print("map reproduction: %d of %d cells match (%.1f%%)"
          % (total - len(mismatches), total, 100.0 * (total - len(mismatches)) / total))

    def roles_around(x, y):
        roles = map_roles(ctm)[1]
        out = []
        for dy in (-1, 0, 1):
            line = []
            for dx in (-1, 0, 1):
                nx, ny = x + dx, y + dy
                inside = 0 <= nx < ctm.map_w and 0 <= ny < ctm.map_h
                line.append(ROLE_NAMES[roles[ny][nx] if inside else ROLE_EMPTY])
            out.append(" ".join("%-6s" % name for name in line))
        return out

    for x, y, want, got in mismatches:
        print("  (%2d,%2d) drawn tile %2d, rule gives %2d" % (x, y, want, got))
        for line in roles_around(x, y):
            print("          %s" % line)

    print()
    print("  drawn" + " " * (ctm.map_w * 3 - 4) + "  rule")
    for y in range(ctm.map_h):
        left = " ".join("%2d" % v if v else " ." for v in drawn[y])
        right = " ".join("%2d" % v if v else " ." for v in predicted[y])
        print("  %s   %s%s" % (left, right, "" if left == right else "   <-"))


# -----------------------------------------------------------------------------
# Variant generation
# -----------------------------------------------------------------------------

class CharPool:
    """Interns character bitmaps so identical results share one slot."""

    def __init__(self):
        self.entries = []
        self._index = {}

    def intern(self, rows, attr):
        key = (tuple(rows), attr)
        found = self._index.get(key)
        if found is None:
            found = len(self.entries)
            if found > 255:
                raise ValueError("more than 256 characters required")
            self._index[key] = found
            self.entries.append((list(rows), attr))
        return found


def build(ctm, grid_tiles, fog_tiles, strip=()):
    """Generate every tile variant and return (pool, tables, warnings)."""
    pool = CharPool()
    warnings = []
    tables = []

    source = [list(rows) for rows in ctm.chars]
    for layer_name in strip:
        mask_fn = LAYERS[layer_name]
        for tile_index, cells in enumerate(ctm.tiles):
            if layer_name == "grid" and tile_index not in grid_tiles:
                continue
            if layer_name == "fog" and tile_index not in fog_tiles:
                continue
            for cell, char_index in enumerate(cells):
                hires = ctm.is_hires(char_index)
                if not hires:
                    continue
                mask = mask_fn(cell, ctm.tile_w, ctm.tile_h, hires)
                source[char_index] = strip_mask(source[char_index], mask, hires)

    for variant_name, layer_names in VARIANTS:
        table = []
        for tile_index, cells in enumerate(ctm.tiles):
            row = []
            for cell, char_index in enumerate(cells):
                attr = ctm.char_attrs[char_index]
                output_attr = attr
                hires = attr < 8
                rows = list(source[char_index])
                for layer_name in layer_names:
                    if layer_name == "grid" and tile_index not in grid_tiles:
                        continue
                    if layer_name == "fog" and tile_index not in fog_tiles:
                        continue
                    mask = LAYERS[layer_name](cell, ctm.tile_w, ctm.tile_h, hires)
                    rows, output_attr, applied = apply_black_mask(
                        rows, mask, output_attr, ctm.bg0)
                    if not applied:
                        warnings.append(
                            "tile %d cell %d (char %d, colour %d): the %s "
                            "layer cannot be black with $d021=%d because the "
                            "character-specific colour is used by artwork "
                            "outside the mask." % (tile_index, cell, char_index,
                                                   attr, layer_name, ctm.bg0))
                row.append(pool.intern(rows, output_attr))
            table.append(row)
        tables.append((variant_name, table))

    # Deduplicate the warning list while keeping order.
    seen = set()
    unique = []
    for text in warnings:
        if text not in seen:
            seen.add(text)
            unique.append(text)
    return pool, tables, unique


# -----------------------------------------------------------------------------
# C emitter
# -----------------------------------------------------------------------------

HEADER_TEMPLATE = """\
#ifndef TILESET_DATA_H
#define TILESET_DATA_H

// =============================================================================
// Tileset data - GENERATED by tools/tileset_build.py, do not edit by hand
// =============================================================================
// Source: {source}
//
// The grid frame is a generated layer, not hand drawn artwork. The optional
// fog mask is disabled by default. Re-run the tool after changing the CTM.

#define TILESET_CHAR_COUNT   {char_count}
#define TILESET_TILE_COUNT   {tile_count}
#define TILESET_TILE_W       {tile_w}
#define TILESET_TILE_H       {tile_h}
#define TILESET_TILE_CELLS   {cells}

{variant_defines}
#define TILE_VARIANT_COUNT   {variant_count}

// Global VIC colour registers this tileset was authored against.
#define TILESET_COLOR_BG0    {bg0}   // $d021 - also the colour the layers stamp
#define TILESET_COLOR_BG1    {bg1}   // $d022
#define TILESET_COLOR_BG2    {bg2}   // $d023

extern const unsigned char tileset_charset[TILESET_CHAR_COUNT * 8];

// Combined tile index: variant * TILESET_TILE_COUNT + tile.
#define TILESET_ENTRY(variant, tile)  ((variant) * TILESET_TILE_COUNT + (tile))
#define TILESET_ENTRY_COUNT           (TILE_VARIANT_COUNT * TILESET_TILE_COUNT)

// Cell-major tables: [cell within the tile][combined tile index].
//
// The renderer walks one cell position across many tiles, so keeping the cell
// outermost makes the combined index the array index and every lookup a single
// absolute-indexed load. The variant is folded into that index so fog of war
// costs nothing extra, and the colour is folded in as a parallel table so the
// inner loop never goes through a second lookup to find a character's colour.
extern const unsigned char tileset_cell_char[TILESET_TILE_CELLS][TILESET_ENTRY_COUNT];
extern const unsigned char tileset_cell_color[TILESET_TILE_CELLS][TILESET_ENTRY_COUNT];

#endif // TILESET_DATA_H
"""


def emit_c(ctm, pool, tables, source_name):
    char_count = len(pool.entries)
    variant_defines = "\n".join(
        "#define TILE_VARIANT_%-9s %d" % (name, i)
        for i, (name, _) in enumerate(tables))

    header = HEADER_TEMPLATE.format(
        source=source_name,
        char_count=char_count,
        tile_count=len(ctm.tiles),
        tile_w=ctm.tile_w,
        tile_h=ctm.tile_h,
        cells=ctm.cells_per_tile,
        variant_defines=variant_defines,
        variant_count=len(tables),
        bg0=ctm.bg0,
        bg1=ctm.bg1,
        bg2=ctm.bg2,
    )

    out = []
    out.append("// =============================================================================")
    out.append("// Tileset data - GENERATED by tools/tileset_build.py, do not edit by hand")
    out.append("// =============================================================================")
    out.append("// Source: %s" % source_name)
    out.append("")
    out.append('#include "tileset_data.h"')
    out.append("")
    out.append("// Character bitmaps, eight bytes each.")
    out.append("const unsigned char tileset_charset[TILESET_CHAR_COUNT * 8] = {")
    for index, (rows, _) in enumerate(pool.entries):
        out.append("    %s  // char %d" % (
            "".join("0x%02x, " % b for b in rows), index))
    out.append("};")
    out.append("")
    cells = ctm.cells_per_tile

    for name, pick in (("tileset_cell_char", lambda ch: ch),
                       ("tileset_cell_color", lambda ch: pool.entries[ch][1])):
        out.append("// Indexed by TILESET_ENTRY(variant, tile); variants run in order.")
        out.append("const unsigned char %s[TILESET_TILE_CELLS]"
                   "[TILESET_ENTRY_COUNT] = {" % name)
        for cell in range(cells):
            out.append("    { // cell %d (col %d, row %d)"
                       % (cell, cell % ctm.tile_w, cell // ctm.tile_w))
            for variant_name, table in tables:
                values = ", ".join("%3d" % pick(table[t][cell])
                                   for t in range(len(table)))
                out.append("        %s,   // TILE_VARIANT_%s" % (values, variant_name))
            out.append("    },")
        out.append("};")
        out.append("")
    return header, "\n".join(out)


# -----------------------------------------------------------------------------
# PNG preview
# -----------------------------------------------------------------------------

PALETTE = [
    (0x00, 0x00, 0x00), (0xFF, 0xFF, 0xFF), (0x68, 0x37, 0x2B), (0x70, 0xA4, 0xB2),
    (0x6F, 0x3D, 0x86), (0x58, 0x8D, 0x43), (0x35, 0x28, 0x79), (0xB8, 0xC7, 0x6F),
    (0x6F, 0x4F, 0x25), (0x43, 0x39, 0x00), (0x9A, 0x67, 0x59), (0x44, 0x44, 0x44),
    (0x6C, 0x6C, 0x6C), (0x9A, 0xD2, 0x84), (0x6C, 0x5E, 0xB5), (0x95, 0x95, 0x95),
]

DIGITS = {
    "0": ("111", "101", "101", "101", "111"),
    "1": ("010", "110", "010", "010", "111"),
    "2": ("111", "001", "111", "100", "111"),
    "3": ("111", "001", "111", "001", "111"),
    "4": ("101", "101", "111", "001", "001"),
    "5": ("111", "100", "111", "001", "111"),
    "6": ("111", "100", "111", "101", "111"),
    "7": ("111", "001", "010", "010", "010"),
    "8": ("111", "101", "111", "101", "111"),
    "9": ("111", "101", "111", "001", "111"),
}


class Canvas:
    def __init__(self, width, height, scale):
        self.w, self.h, self.scale = width, height, scale
        self.rows = [bytearray(width * scale * 3) for _ in range(height * scale)]

    def point(self, x, y, colour):
        if not (0 <= x < self.w and 0 <= y < self.h):
            return
        rgb = bytes(colour)
        for dy in range(self.scale):
            row = self.rows[y * self.scale + dy]
            base = x * self.scale * 3
            for dx in range(self.scale):
                off = base + dx * 3
                row[off:off + 3] = rgb

    def label(self, x, y, text, colour=(255, 255, 255)):
        for i, ch in enumerate(text):
            glyph = DIGITS.get(ch)
            if not glyph:
                continue
            for gy, line in enumerate(glyph):
                for gx, bit in enumerate(line):
                    if bit == "1":
                        self.point(x + i * 4 + gx, y + gy, colour)

    def write_png(self, path):
        raw = b"".join(b"\x00" + bytes(r) for r in self.rows)

        def chunk(tag, payload):
            body = tag + payload
            return (struct.pack(">I", len(payload)) + body
                    + struct.pack(">I", zlib.crc32(body)))

        png = (b"\x89PNG\r\n\x1a\n"
               + chunk(b"IHDR", struct.pack(">IIBBBBB", self.w * self.scale,
                                            self.h * self.scale, 8, 2, 0, 0, 0))
               + chunk(b"IDAT", zlib.compress(raw, 9))
               + chunk(b"IEND", b""))
        directory = os.path.dirname(path)
        if directory:
            os.makedirs(directory, exist_ok=True)
        with open(path, "wb") as handle:
            handle.write(png)


def draw_char(canvas, rows, attr, bg0, bg1, bg2, ox, oy):
    for r in range(8):
        byte = rows[r]
        if attr < 8:
            for x in range(8):
                colour = attr if (byte >> (7 - x)) & 1 else bg0
                canvas.point(ox + x, oy + r, PALETTE[colour])
        else:
            for i in range(4):
                pair = (byte >> (6 - i * 2)) & 3
                colour = (bg0, bg1, bg2, attr & 7)[pair]
                canvas.point(ox + i * 2, oy + r, PALETTE[colour])
                canvas.point(ox + i * 2 + 1, oy + r, PALETTE[colour])


def render_preview(ctm, pool, tables, path, columns=5, scale=5):
    tile_px_w, tile_px_h = ctm.tile_w * 8, ctm.tile_h * 8
    label_h = 7
    cell_w, cell_h = tile_px_w + 4, tile_px_h + label_h + 4
    tiles = len(ctm.tiles)
    rows_of_tiles = (tiles + columns - 1) // columns
    block_w = columns * cell_w + 4
    block_h = rows_of_tiles * cell_h + 8

    canvas = Canvas(block_w * len(tables), block_h, scale)
    for v, (variant_name, table) in enumerate(tables):
        bx = v * block_w
        for tile_index, row in enumerate(table):
            tx = bx + 4 + (tile_index % columns) * cell_w
            ty = 4 + (tile_index // columns) * cell_h
            canvas.label(tx, ty, str(tile_index))
            for cell, char_index in enumerate(row):
                rows, attr = pool.entries[char_index]
                draw_char(canvas, rows, attr, ctm.bg0, ctm.bg1, ctm.bg2,
                          tx + (cell % ctm.tile_w) * 8,
                          ty + label_h + (cell // ctm.tile_w) * 8)
        del variant_name
    canvas.write_png(path)


def render_map_comparison(ctm, pool, tables, path, scale=2):
    """Draw the map as authored next to the map the tile rule produces."""
    drawn, predicted, _ = reproduce_map(ctm)
    if drawn is None:
        return False
    table = tables[0][1]                      # lit variant
    tile_w, tile_h = ctm.tile_w * 8, ctm.tile_h * 8
    block_w = ctm.map_w * tile_w
    gap = 16
    canvas = Canvas(block_w * 2 + gap, ctm.map_h * tile_h, scale)

    for index, grid in enumerate((drawn, predicted)):
        ox = index * (block_w + gap)
        for y in range(ctm.map_h):
            for x in range(ctm.map_w):
                for cell, char_index in enumerate(table[grid[y][x]]):
                    rows, attr = pool.entries[char_index]
                    draw_char(canvas, rows, attr, ctm.bg0, ctm.bg1, ctm.bg2,
                              ox + x * tile_w + (cell % ctm.tile_w) * 8,
                              y * tile_h + (cell // ctm.tile_w) * 8)
    canvas.write_png(path)
    return True


# -----------------------------------------------------------------------------
# Self test
# -----------------------------------------------------------------------------

def self_test(ctm):
    """Verify black-mask mechanics and the current clean CTM mapping."""
    failures = []

    def check(name, got, want):
        if list(got) != list(want):
            failures.append("%s: got %s want %s" % (
                name,
                " ".join("%02x" % b for b in got),
                " ".join("%02x" % b for b in want)))

    corner_hires = grid_mask(0, 3, 3, hires=True)
    check("hires black grid",
          apply_mask([0x00] * 8, corner_hires, attr=0, bg0=11),
          [0xFF] + [0xC0] + [0x80] * 6)

    # newest5 uses multicolour colour RAM value 8 on clean floor cells. %11 is
    # therefore the character-specific colour 0 (black), and complete pairs
    # are set rather than cleared to the grey $d021 background.
    corner_mc = grid_mask(0, 3, 3, hires=False)
    rows, attr, applied = apply_black_mask([0x00] * 8, corner_mc, 8, 11)
    check("multicolour colour-8 black grid", rows, [0xFF] + [0xC0] * 7)
    if attr != 8 or not applied:
        failures.append("multicolour colour-8 grid did not stay black")

    # A character that does not use %11 can be remapped from a non-black
    # per-character colour to colour 8 without changing its existing pixels.
    rows, attr, applied = apply_black_mask([0x55] * 8, corner_mc, 11, 11)
    check("unused multicolour colour remap", rows, [0xFF] + [0xD5] * 7)
    if attr != 8 or not applied:
        failures.append("unused multicolour colour was not remapped to black")

    # When %11 artwork survives outside the mask and $d021 is not black there
    # is no black colour slot available. The generator must leave it untouched
    # and report it, rather than silently stamping a grey line.
    source = [0x03] * 8
    rows, attr, applied = apply_black_mask(source, corner_mc, 9, 11)
    check("incompatible multicolour artwork unchanged", rows, source)
    if attr != 9 or applied:
        failures.append("incompatible multicolour artwork was modified")

    # With a black $d021 the safe fallback is still to clear whole pairs.
    check("multicolour black-background fallback",
          apply_mask([0xFF] * 8, corner_mc, attr=9, bg0=0),
          [0x00] + [0x3F] * 7)

    if ctm.tile_w != 3 or ctm.tile_h != 3:
        failures.append("tiles are %dx%d, expected 3x3" %
                        (ctm.tile_w, ctm.tile_h))

    # Final newest5 visual-reference junction rules.
    horizontal_t = CONN_DOWN | CONN_LEFT | CONN_RIGHT
    if select_wall_shape(horizontal_t, WALK_UP) != CONN_LEFT | CONN_RIGHT:
        failures.append("unconfirmed lower T branch did not stay horizontal")
    if select_wall_shape(horizontal_t, WALK_DL) != CONN_LEFT | CONN_DOWN:
        failures.append("lower-left-only T did not select LD")
    if select_wall_shape(horizontal_t, WALK_LEFT | WALK_DL) != CONN_RIGHT | CONN_DOWN:
        failures.append("confirmed lower T branch did not select RD")

    vertical_t_right = CONN_UP | CONN_DOWN | CONN_RIGHT
    if select_wall_shape(vertical_t_right, WALK_LEFT) != CONN_UP | CONN_DOWN:
        failures.append("unconfirmed right T branch did not stay vertical")
    if select_wall_shape(vertical_t_right, WALK_UR) != CONN_RIGHT | CONN_DOWN:
        failures.append("confirmed right T branch did not select RD")

    vertical_t_left = CONN_UP | CONN_DOWN | CONN_LEFT
    if select_wall_shape(vertical_t_left, WALK_RIGHT) != CONN_UP | CONN_DOWN:
        failures.append("unconfirmed left T branch did not stay vertical")
    if select_wall_shape(vertical_t_left, WALK_UL) != CONN_LEFT | CONN_UP:
        failures.append("isolated upper-left T did not select LU")
    if select_wall_shape(vertical_t_left, WALK_DL) != CONN_LEFT | CONN_DOWN:
        failures.append("confirmed lower-left T did not select LD")

    horizontal_t_up = CONN_UP | CONN_LEFT | CONN_RIGHT
    if select_wall_shape(horizontal_t_up, WALK_DOWN) != CONN_LEFT | CONN_RIGHT:
        failures.append("unconfirmed upper T branch did not stay horizontal")
    if select_wall_shape(horizontal_t_up, WALK_UL) != CONN_LEFT | CONN_UP:
        failures.append("upper-left-only T did not select LU")
    if select_wall_shape(horizontal_t_up, WALK_UR) != CONN_RIGHT | CONN_UP:
        failures.append("confirmed upper T branch did not select RU")

    cross = CONN_UP | CONN_DOWN | CONN_LEFT | CONN_RIGHT
    if select_wall_shape(cross, WALK_UR) != CONN_RIGHT | CONN_UP:
        failures.append("upper-right cross did not select RU")
    if select_wall_shape(cross, WALK_DR) != CONN_RIGHT | CONN_DOWN:
        failures.append("lower-right cross did not select RD")

    _, _, mismatches = reproduce_map(ctm)
    if mismatches:
        failures.append("map reproduction differs in %d cells" % len(mismatches))

    _, _, warnings = build(ctm, DEFAULT_GRID_TILES, DEFAULT_FOG_TILES)
    failures.extend("default grid: %s" % warning for warning in warnings)

    return failures


def select_wall_shape(mask, walk_mask=None, far_left_walkable=False,
                      far_upper_left_wall=False):
    """Reduce a four-way connection mask to one of the six available shapes.

    The newest5 reference confirms a junction branch only when walkable space
    lies on the matching diagonal. Otherwise the through axis remains straight.
    Two door-overlap patterns use one second-ring bit to assign the corner to
    the correct neighbouring cell. With no walk context, retain the original
    down/right CharPad fallback for the connection-mask diagnostic report.
    """
    up = bool(mask & CONN_UP)
    down = bool(mask & CONN_DOWN)
    left = bool(mask & CONN_LEFT)
    right = bool(mask & CONN_RIGHT)

    if walk_mask is not None:
        if up and down and right and not left:
            return (CONN_RIGHT | CONN_DOWN
                    if walk_mask & (WALK_UR | WALK_DR)
                    else CONN_UP | CONN_DOWN)

        if up and down and left and not right:
            if not walk_mask & (WALK_UL | WALK_DL):
                return CONN_UP | CONN_DOWN
            if walk_mask == WALK_UL:
                return CONN_LEFT | CONN_UP
            if walk_mask == (WALK_UP | WALK_RIGHT | WALK_UL | WALK_UR):
                return CONN_UP | CONN_DOWN
            if walk_mask == (WALK_UP | WALK_RIGHT | WALK_UL |
                             WALK_UR | WALK_DR):
                return (CONN_LEFT | CONN_DOWN
                        if far_left_walkable else CONN_UP | CONN_DOWN)
            if walk_mask == (WALK_DOWN | WALK_RIGHT | WALK_DL | WALK_DR):
                return (CONN_LEFT | CONN_DOWN
                        if far_upper_left_wall else CONN_UP | CONN_DOWN)
            return CONN_LEFT | CONN_DOWN

        if left and right and up and not down:
            if not walk_mask & (WALK_UL | WALK_UR):
                return CONN_LEFT | CONN_RIGHT
            return (CONN_LEFT | CONN_UP
                    if walk_mask == WALK_UL else CONN_RIGHT | CONN_UP)

        if left and right and down and not up:
            if not walk_mask & (WALK_DL | WALK_DR):
                return CONN_LEFT | CONN_RIGHT
            if (walk_mask & WALK_DL and not walk_mask & WALK_DR and
                    not walk_mask & WALK_LEFT):
                return CONN_LEFT | CONN_DOWN
            return CONN_RIGHT | CONN_DOWN

        if up and down and left and right:
            if walk_mask & WALK_DR:
                return CONN_RIGHT | CONN_DOWN
            if walk_mask & WALK_UR:
                return CONN_RIGHT | CONN_UP
            if walk_mask & WALK_DL:
                return CONN_LEFT | CONN_DOWN
            if walk_mask & WALK_UL:
                return CONN_LEFT | CONN_UP
            return CONN_RIGHT | CONN_DOWN

    # Ordinary two-way shapes, plus the no-context CharPad fallback.
    if down:
        if right:
            return CONN_RIGHT | CONN_DOWN
        if left:
            return CONN_LEFT | CONN_DOWN
        return CONN_UP | CONN_DOWN
    if up:
        if right:
            return CONN_RIGHT | CONN_UP
        if left:
            return CONN_LEFT | CONN_UP
        return CONN_UP | CONN_DOWN
    return CONN_LEFT | CONN_RIGHT


def check_wall_rule(ctm, wall_tiles, wall_like):
    """Confirm select_wall_shape() against every wall tile in the drawn map."""
    observed = analyse_map(ctm, wall_tiles, wall_like)
    if not observed:
        return ["no map block in the CTM file, wall rule not verified"]

    # Learn shape -> tile from the unambiguous two-connection placements.
    shape_tile = {}
    problems = []
    for _, shape in WALL_SHAPES:
        for mask, used in observed.items():
            if mask == shape and len(used) == 1:
                shape_tile[shape] = next(iter(used))

    for mask in sorted(observed):
        # T and cross masks deliberately depend on walkable diagonals (and two
        # rare door-overlap continuations), so a four-bit connection mask alone
        # cannot validate them. reproduce_map() performs the contextual check.
        if mask.bit_count() >= 3:
            continue
        predicted_shape = select_wall_shape(mask)
        expected = shape_tile.get(predicted_shape)
        for tile, count in sorted(observed[mask].items()):
            if expected is None:
                problems.append("mask 0x%X: no reference placement for the "
                                "predicted shape" % mask)
            elif tile != expected:
                problems.append("mask 0x%X: map uses tile %d (x%d), rule "
                                "predicts tile %d" % (mask, tile, count, expected))
    return problems


def report_wall_rule(ctm, wall_tiles, wall_like):
    observed = analyse_map(ctm, wall_tiles, wall_like)
    if not observed:
        print("no map block in the CTM file, wall rule not verified")
        return
    names = {mask: name for name, mask in WALL_SHAPES}
    print("wall joining observed in the CTM map (connection mask -> tile):")
    for mask in sorted(observed):
        used = observed[mask]
        label = names.get(mask, "mask 0x%X" % mask)
        detail = ", ".join("tile %d x%d" % (t, n) for t, n in sorted(used.items()))
        flag = "" if len(used) == 1 else "   <-- ambiguous"
        print("  %-12s %s%s" % (label, detail, flag))
    junctions = [m for m in observed if bin(m).count("1") >= 3]
    if junctions:
        print("  note: the tileset has no T or cross piece, so junction masks "
              "(%s) reuse a corner." % ", ".join("0x%X" % m for m in sorted(junctions)))


# -----------------------------------------------------------------------------
# CLI
# -----------------------------------------------------------------------------

def parse_indices(text, default):
    if text is None:
        return set(default)
    if not text.strip():
        return set()
    out = set()
    for part in text.split(","):
        part = part.strip()
        if "-" in part:
            lo, hi = part.split("-", 1)
            out.update(range(int(lo), int(hi) + 1))
        elif part:
            out.add(int(part))
    return out


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("ctm", help="CharPad CTM v7 tileset file")
    parser.add_argument("--grid-tiles", default=None,
                        help="tile indices that receive the grid frame "
                             "(default: every walkable tile role)")
    parser.add_argument("--fog-tiles", default=None,
                        help="tile indices that receive the fog checkerboard "
                             "(default: none)")
    parser.add_argument("--wall-tiles", default="2,3,4,5,6,7",
                        help="tile indices whose wall shape the joining report classifies")
    parser.add_argument("--wall-like", default="2,3,4,5,6,7,11,12,13,14,15,16,17",
                        help="tile indices that count as a wall connection when "
                             "looking at a neighbour (walls plus doors and gratings)")
    parser.add_argument("--strip", default="",
                        help="comma separated layers to remove from the source "
                             "artwork before generating (grid,fog)")
    parser.add_argument("--out-dir", default=None,
                        help="write tileset_data.c/.h into this directory")
    parser.add_argument("--preview", default=None, help="write a PNG preview")
    parser.add_argument("--repro-preview", default=None,
                        help="write a PNG of the authored map next to the map "
                             "the tile selection rule produces")
    parser.add_argument("--self-test", action="store_true",
                        help="verify the layer masks against the reference artwork")
    parser.add_argument("--quiet", action="store_true",
                        help="omit the wall and full-map diagnostic reports")
    args = parser.parse_args(argv)

    ctm = Ctm.load(args.ctm)
    print("%s: %d chars, %d tiles, %dx%d, map %dx%d"
          % (os.path.basename(args.ctm), len(ctm.chars), len(ctm.tiles),
             ctm.tile_w, ctm.tile_h, ctm.map_w, ctm.map_h))

    if args.self_test:
        failures = self_test(ctm)
        failures += check_wall_rule(ctm, parse_indices(args.wall_tiles, ()),
                                    parse_indices(args.wall_like, ()))
        for line in failures:
            print("FAIL %s" % line)
        print("self-test: %s" % ("FAILED" if failures else "ok"))
        if not args.quiet:
            report_wall_rule(ctm, parse_indices(args.wall_tiles, ()),
                             parse_indices(args.wall_like, ()))
            print()
            report_reproduction(ctm)
        return 1 if failures else 0

    grid_tiles = parse_indices(args.grid_tiles, DEFAULT_GRID_TILES)
    fog_tiles = parse_indices(args.fog_tiles, DEFAULT_FOG_TILES)
    strip = tuple(s.strip() for s in args.strip.split(",") if s.strip())
    for name in strip:
        if name not in LAYERS:
            parser.error("unknown layer %r" % name)

    pool, tables, warnings = build(ctm, grid_tiles, fog_tiles, strip)
    for text in warnings:
        print("warning: %s" % text)
    print("generated %d characters for %d variants"
          % (len(pool.entries), len(tables)))

    if args.out_dir:
        header, source = emit_c(ctm, pool, tables, os.path.basename(args.ctm))
        os.makedirs(args.out_dir, exist_ok=True)
        with open(os.path.join(args.out_dir, "tileset_data.h"), "w") as handle:
            handle.write(header)
        with open(os.path.join(args.out_dir, "tileset_data.c"), "w") as handle:
            handle.write(source)
        print("wrote %s/tileset_data.{c,h}" % args.out_dir)

    if args.preview:
        render_preview(ctm, pool, tables, args.preview)
        print("wrote %s" % args.preview)

    if args.repro_preview:
        if render_map_comparison(ctm, pool, tables, args.repro_preview):
            print("wrote %s" % args.repro_preview)
        else:
            print("no map block in the CTM file, nothing to compare")

    if not args.quiet:
        report_wall_rule(ctm, parse_indices(args.wall_tiles, ()),
                         parse_indices(args.wall_like, ()))
        print()
        report_reproduction(ctm)
    return 0


if __name__ == "__main__":
    sys.exit(main())
