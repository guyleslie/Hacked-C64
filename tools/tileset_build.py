#!/usr/bin/env python3
"""Build C64 tileset assets from a CharPad CTM file.

The map tiles are 3x3 characters. Two visual layers are *not* drawn by hand in
CharPad; this tool generates them from mask tables:

  grid  a one pixel black line on the top edge and the left edge of every
        walkable tile. Neighbouring tiles complete each other's frame, so a
        continuous lattice appears over the walkable area.
  fog   a checkerboard of black pixels that darkens explored but currently
        unseen tiles (fog of war).

Both layers are stencils: only black matters, everything else passes through.
On the VIC-II that is a single bitwise operation per character row, and the
polarity depends on the character's colour mode:

  hires char (colour RAM < 8)   set bits show the foreground colour
                                -> layer is OR, and is black when colour == 0
  multicolour char (>= 8)       %00 bit pairs show background colour 0
                                -> layer is AND, and is black when $d021 == 0

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


def stamp_is_or(attr):
    """True when setting bits is what paints black on this character.

    Only a hires character whose foreground is black can be stamped by setting
    bits. Every other character has to have bits cleared instead, which reveals
    background colour 0 - black only if $d021 is black.
    """
    return attr == 0


def apply_mask(rows, mask, attr):
    """Stamp the black stencil onto one character.

    A hires black character takes the mask as OR: set bits show its black
    foreground. Anything else takes it as AND, clearing pixels down to
    background colour 0. Clearing a multicolour character has to take out whole
    bit pairs, otherwise %11 would degrade to %01 instead of going to %00.
    """
    if stamp_is_or(attr):
        return [rows[r] | mask[r] for r in range(8)]
    if attr < 8:
        return [rows[r] & (~mask[r] & 0xFF) for r in range(8)]
    return [rows[r] & (~_expand_pairs(mask[r]) & 0xFF) for r in range(8)]


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
FOG_DUPLICATES = {2: 1, 11: 10, 16: 14, 17: 15}
TILE_ROLE = {
    0: ROLE_EMPTY, 1: ROLE_FLOOR, 19: ROLE_ITEM,
    9: ROLE_STAIR_A, 10: ROLE_STAIR_B,
    3: ROLE_WALL, 4: ROLE_WALL, 5: ROLE_WALL,
    6: ROLE_WALL, 7: ROLE_WALL, 8: ROLE_WALL,
    12: ROLE_DOOR, 13: ROLE_DOOR, 18: ROLE_DOOR,
    # Wall rim tiles must be derived from geometry, so they enter as floor.
    14: ROLE_FLOOR, 15: ROLE_FLOOR,
}

TILE_WALL_H, TILE_WALL_V = 3, 4
TILE_WALL_RD, TILE_WALL_LD, TILE_WALL_RU, TILE_WALL_LU = 5, 6, 7, 8
TILE_GRATE_V, TILE_GRATE_H, TILE_DOOR_WOOD = 12, 13, 18


def map_roles(ctm):
    """Reduce the drawn map to engine roles, plus the door artwork kinds."""
    grid = [[FOG_DUPLICATES.get(v, v) for v in row] for row in ctm.map]
    roles = [[TILE_ROLE[v] for v in row] for row in grid]
    wooden = {(x, y)
              for y in range(ctm.map_h) for x in range(ctm.map_w)
              if grid[y][x] == TILE_DOOR_WOOD}
    return grid, roles, wooden


def reproduce_map(ctm):
    """Re-derive the drawn map from roles alone.

    This is the acceptance test for the renderer: given only what the map
    generator produces - walkable cells, walls, door and stair positions - the
    tile selection rule has to put back the tiles that were drawn by hand.

    Returns (drawn, predicted, mismatches).
    """
    if not ctm.map:
        return None, None, []
    grid, roles, wooden = map_roles(ctm)
    w, h = ctm.map_w, ctm.map_h

    def role(x, y):
        if x < 0 or y < 0 or x >= w or y >= h:
            return ROLE_EMPTY
        return roles[y][x]

    def wall_like(x, y):
        return role(x, y) in (ROLE_WALL, ROLE_DOOR)

    def select_wall(x, y):
        down, up = wall_like(x, y + 1), wall_like(x, y - 1)
        left, right = wall_like(x - 1, y), wall_like(x + 1, y)
        if down:
            return TILE_WALL_RD if right else (TILE_WALL_LD if left else TILE_WALL_V)
        if up:
            return TILE_WALL_RU if right else (TILE_WALL_LU if left else TILE_WALL_V)
        return TILE_WALL_H

    def select(x, y):
        current = role(x, y)
        if current == ROLE_EMPTY:
            return 0
        if current == ROLE_WALL:
            return select_wall(x, y)
        if current == ROLE_DOOR:
            if (x, y) in wooden:
                return TILE_DOOR_WOOD
            if wall_like(x, y - 1) or wall_like(x, y + 1):
                return TILE_GRATE_V
            return TILE_GRATE_H
        if current == ROLE_STAIR_A:
            return 9
        if current == ROLE_STAIR_B:
            return 10
        if current == ROLE_ITEM:
            return 19
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
        _, roles, _ = map_roles(ctm)
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

    if ctm.bg0 != 0:
        warnings.append(
            "background colour 0 is %d, not black - multicolour characters "
            "will show that colour where the layers stamp." % ctm.bg0)

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
                hires = attr < 8
                rows = list(source[char_index])
                for layer_name in layer_names:
                    if layer_name == "grid" and tile_index not in grid_tiles:
                        continue
                    if layer_name == "fog" and tile_index not in fog_tiles:
                        continue
                    mask = LAYERS[layer_name](cell, ctm.tile_w, ctm.tile_h, hires)
                    stamped = apply_mask(rows, mask, attr)
                    # An OR character that does not change is simply already
                    # stamped. An AND character that does not change had no
                    # non-background pixels to take away, which is a real gap.
                    if stamped == rows and not stamp_is_or(attr):
                        warnings.append(
                            "char %d is entirely background, so the %s layer "
                            "has nothing to darken. Give it colour 0 to make it "
                            "a hires black character, or paint its body in a "
                            "real colour." % (char_index, layer_name))
                    rows = stamped
                row.append(pool.intern(rows, attr))
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
// The grid frame and the fog checkerboard are generated overlay layers, not
// hand drawn artwork. Re-run the tool after changing the CTM file.

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
extern const unsigned char tileset_char_color[TILESET_CHAR_COUNT];
extern const unsigned char tileset_tile_chars[TILE_VARIANT_COUNT][TILESET_TILE_COUNT][TILESET_TILE_CELLS];

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
    out.append("// Colour RAM nibble per character. Values < 8 are hires characters.")
    out.append("const unsigned char tileset_char_color[TILESET_CHAR_COUNT] = {")
    for start in range(0, char_count, 12):
        chunk = pool.entries[start:start + 12]
        out.append("    " + " ".join("%d," % attr for _, attr in chunk))
    out.append("};")
    out.append("")
    out.append("// Character indices per tile, one block per visual variant.")
    out.append("const unsigned char tileset_tile_chars[TILE_VARIANT_COUNT]"
               "[TILESET_TILE_COUNT][TILESET_TILE_CELLS] = {")
    for variant_name, table in tables:
        out.append("    { // TILE_VARIANT_%s" % variant_name)
        for tile_index, row in enumerate(table):
            out.append("        { %s },  // tile %d" % (
                ", ".join("%3d" % c for c in row), tile_index))
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
    """Verify the layer model against artwork that already has it baked in.

    The reference tileset was drawn by hand with both layers included. Every
    framed and fogged character must be reproducible from the blank floor
    character by stamping the masks, otherwise the mask tables are wrong.
    """
    failures = []

    def check(name, got, want):
        if list(got) != list(want):
            failures.append("%s: got %s want %s" % (
                name,
                " ".join("%02x" % b for b in got),
                " ".join("%02x" % b for b in want)))

    blank = ctm.chars[4]
    for cell, expected in ((0, 1), (1, 2), (3, 3)):
        mask = grid_mask(cell, ctm.tile_w, ctm.tile_h, hires=True)
        check("grid cell %d -> char %d" % (cell, expected),
              apply_mask(blank, mask, attr=0), ctm.chars[expected])

    fog = fog_mask(0, ctm.tile_w, ctm.tile_h, hires=True)
    for lit, fogged in ((1, 5), (2, 6), (3, 7), (4, 8)):
        check("fog char %d -> char %d" % (lit, fogged),
              apply_mask(ctm.chars[lit], fog, attr=0), ctm.chars[fogged])

    # Stripping only recovers artwork that is blank under the mask. The fogged
    # blank floor qualifies. The fogged frame does not: its top line shares
    # pixels with the checkerboard, so those pixels are gone. Both are asserted
    # so the limitation stays visible rather than being discovered later.
    check("strip fog char 8 -> char 4",
          strip_mask(ctm.chars[8], fog, hires=True), ctm.chars[4])
    if strip_mask(ctm.chars[5], fog, hires=True) == ctm.chars[1]:
        failures.append("strip fog char 5: expected artwork loss, got a clean "
                        "recovery - the overlap assumption changed")

    # Multicolour polarity: stamping must clear whole bit pairs. The hires
    # corner joint adds nothing here, because one multicolour pixel is already
    # two physical pixels wide.
    check("multicolour grid pair clear",
          apply_mask([0xFF] * 8, grid_mask(0, 3, 3, hires=False), attr=8),
          [0x00] + [0x3F] * 7)

    # A hires character that is not black darkens by clearing pixels, so the
    # fog thins its foreground instead of painting the foreground colour on.
    check("hires non-black fog clears",
          apply_mask([0xF0] * 8, [0xAA] * 8, attr=7), [0x50] * 8)

    return failures


def select_wall_shape(mask):
    """Reduce a four-way connection mask to one of the six available shapes.

    Read out of the map drawn in CharPad. The tileset has no T or cross piece,
    so a junction keeps one vertical and one horizontal direction, preferring
    DOWN over UP and RIGHT over LEFT. A tile connected on one axis only becomes
    the matching straight run. This reproduces every wall tile in the reference
    map, junctions included.
    """
    vertical = CONN_DOWN if mask & CONN_DOWN else (CONN_UP if mask & CONN_UP else 0)
    horizontal = CONN_RIGHT if mask & CONN_RIGHT else (CONN_LEFT if mask & CONN_LEFT else 0)
    if vertical and horizontal:
        return vertical | horizontal
    if vertical:
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
                             "(default: every tile except the empty tile 0)")
    parser.add_argument("--wall-tiles", default="3,4,5,6,7,8",
                        help="tile indices whose wall shape the joining report classifies")
    parser.add_argument("--wall-like", default="3,4,5,6,7,8,12,13,15,17,18",
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
        report_wall_rule(ctm, parse_indices(args.wall_tiles, ()),
                         parse_indices(args.wall_like, ()))
        print()
        report_reproduction(ctm)
        return 1 if failures else 0

    all_tiles = range(len(ctm.tiles))
    grid_tiles = parse_indices(args.grid_tiles, [1, 2])
    fog_tiles = parse_indices(args.fog_tiles, [t for t in all_tiles if t != 0])
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

    report_wall_rule(ctm, parse_indices(args.wall_tiles, ()),
                     parse_indices(args.wall_like, ()))
    print()
    report_reproduction(ctm)
    return 0


if __name__ == "__main__":
    sys.exit(main())
