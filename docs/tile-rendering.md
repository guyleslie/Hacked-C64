# Tile rendering and overlay layers

How the dungeon is drawn with the CharPad tileset, and why the black frame and
the fog of war are generated rather than drawn by hand.

## The problem

A map cell is one 3x3 character tile. The frame that makes walkable tiles read
as a lattice used to be painted into the tile artwork, and so did the fog of
war checkerboard. Both cost artwork freedom: in multicolour character mode a
cell has three global colours plus one colour RAM value, and a line painted
into the artwork takes one of them away from the tile itself.

Overlaying an actual bitmap is not an option. VIC-II display modes are mutually
exclusive - character mode or bitmap mode, never both - and there is no
transparency or layering. Sprites are the only real overlay and there are eight
per raster line, all of which the architecture plan already allocates.

## The model

Both effects are **stencils**: only black matters, everything else passes
through. On the VIC-II that is one bitwise operation per character row, applied
to the character set rather than to the screen. The result on screen is exactly
what an overlay would look like.

```
grid   one pixel of black on the tile's top edge and left edge
fog    a checkerboard of black pixels that darkens the tile
```

Neighbouring tiles complete each other's frame, so drawing only the top and
left edge produces a continuous lattice across the walkable area.

`tools/tileset_build.py` stamps these masks into the character set at build
time and emits the result as C tables. Nothing is stamped at runtime, and the
renderer only picks which pre-stamped character to write to screen memory.

### Mask polarity

Which bitwise operation paints black depends on the character's colour mode:

| character | how black is produced | operation |
|---|---|---|
| hires, colour RAM `0` | set bits show the black foreground | `rows[r] \| mask[r]` |
| hires, colour RAM `1-7` | cleared bits show background colour 0 | `rows[r] & ~mask[r]` |
| multicolour, colour RAM `>= 8` | `%00` bit pairs show background colour 0 | `rows[r] & ~pairs(mask[r])` |

Clearing a multicolour character has to take out **whole bit pairs**. Clearing
a single bit turns `%11` into `%01`, which changes the colour instead of going
to black.

The two cleared cases only produce black if `$d021` is black. The tool warns
when it is not.

### A layer can only darken what is not already background

If a tile's body is painted with the `%00` bit pair, it already shows
background colour 0 and there is nothing for a stencil to take away. The tool
warns about this too.

Two ways out:

- give the character colour RAM value `0`, which makes it a hires black
  character; the layers then work by setting bits, and the body still shows
  `$d021` where no bit is set;
- or set `$d021` to black and paint the tile body in real colours, which is the
  version that gives the artwork its colours back.

## Current palette state

`main/assets/tileset.ctm` is authored with:

```
$d021 = 11 (dark grey)   the floor body
$d022 = 12 (medium grey)
$d023 =  9 (brown)
```

The frame characters are hires with colour `0`, so the frame is black and the
layers already work on them. The plain floor body character is multicolour and
entirely `%00`, so it cannot be darkened - which is why the fogged floor had to
be drawn by hand.

Running the tool reports exactly which characters are affected.

### Migrating to a black background

Setting `$d021 = 0` frees the layers to work on every character and gives each
floor character its full four colours back. The cost:

- the dark grey floor body has to move out of `$d021`. In multicolour, colour
  RAM can only select colours `0-7`, so **the greys, brown and orange are only
  reachable through the three global registers**. Moving dark grey into
  `$d023` displaces the brown the walls currently use.
- characters that use `%00` as a visible surface need repainting. Walls, doors
  and frames do not use it and are unaffected.

This is an artwork decision, not a code one - the tool and the renderer work
either way.

## Wall joining

A wall tile picks its shape from which of its four neighbours are also
wall-like. Doors and gratings count as wall-like: a wall run continues through
them.

```
CONN_UP = 1   CONN_DOWN = 2   CONN_LEFT = 4   CONN_RIGHT = 8
```

| connections | tile | meaning |
|---|---|---|
| left + right | 3 | horizontal run |
| up + down | 4 | vertical run |
| right + down | 5 | corner opening right and down |
| left + down | 6 | corner opening left and down |
| right + up | 7 | corner opening right and up |
| left + up | 8 | corner opening left and up |

The tileset has no T piece and no cross piece, so a junction has to reduce to
one vertical and one horizontal direction. **Down wins over up, right wins over
left.** A tile connected on one axis only becomes the matching straight run.

This rule was read out of the 13x13 map drawn in the CTM file, not invented. It
reproduces all 72 wall placements in that map, junctions included.
`tools/tileset_build.py --self-test` re-checks it against the map on every run,
so redrawing the reference map will flag a rule that no longer matches.

Adding T and cross pieces to the tileset would remove the reduction step; the
rule is then a plain sixteen-entry lookup.

## Reproducing the reference map

The acceptance test for the renderer is whether the tile selection rule can put
back the map that was drawn by hand, given only what the map generator
produces: walkable cells, walls, and the positions of doors, stairs and items.
Door artwork kind (wooden door versus iron grating) is game data and is fed in,
not derived.

```powershell
python tools/tileset_build.py main/assets/tileset.ctm --self-test
python tools/tileset_build.py main/assets/tileset.ctm --grid-tiles 1,19 --repro-preview build/map-repro.png
```

**167 of the 169 cells match.** The two that do not are the same spot:

```
  (8,11) drawn tile  5, rule gives  6
  (9,11) drawn tile 15, rule gives  1
```

This is not a rule that needs more tuning. Cell `(9,11)` and cell `(9,3)` have
**identical role neighbourhoods** - a walkable cell with walls left and right,
walkable above and below - and are drawn differently:

| cell | drawn as | what it implies |
|---|---|---|
| `(9,3)` | plain floor `1` | the wall stops at the gap; the flanking corner turns away from it |
| `(9,11)` | rim tile `15` | the wall runs over the gap; the flanking corner turns into it |

No geometric rule can produce both, so one convention has to be picked. The
renderer currently follows the `(9,3)` convention, which is the one used
everywhere else in the map. Choosing the `(9,11)` convention instead means
treating a pinched walkable cell as part of the wall line for joining purposes,
and emitting tile 14 or 15 for it - but only where the flanking walls continue
the run, otherwise every one-tile-wide corridor turns into a rim.

The rim tiles `14` and `15` appear once each in the reference map, which is too
little to derive a rule from. Drawing more examples of the intended case is the
way to settle it.

## Files

| File | Role |
|---|---|
| `main/assets/tileset.ctm` | CharPad source artwork, the only hand edited asset |
| `tools/tileset_build.py` | Parses the CTM, stamps the layers, emits C tables |
| `main/src/tiles/tileset_data.c/.h` | Generated - do not edit by hand |
| `main/src/tiles/tile_render.c/.h` | VIC setup, tile blit, tile selection, viewport |

## Workflow

Draw the tiles in CharPad **without** the frame and **without** the fog
checkerboard, then regenerate:

```powershell
python tools/tileset_build.py main/assets/tileset.ctm --self-test
python tools/tileset_build.py main/assets/tileset.ctm --grid-tiles 1,19 --out-dir main/src/tiles --preview build/tileset-preview.png
```

`--grid-tiles` lists the tiles that receive the frame, `--fog-tiles` the ones
that can be darkened (everything except the empty tile by default, so pickups
darken along with the floor they sit on).

Changing the frame - thicker, dashed, also on the right edge - is an edit to
`grid_mask()` in the tool. The artwork is never touched.

### Redundant tiles

Tiles 2, 11, 16 and 17 in the current CTM are hand drawn fog copies of tiles 1,
10, 14 and 15. The fog variant is generated now, so they can be deleted from
the tileset.

## Wiring it into the build

`main/src/tiles/` is not included from `main/src/main.c` yet. Following the
OSCAR64 single-file model, add:

```c
#include "tiles/tileset_data.c"
#include "tiles/tile_render.c"
```

and add `-i="%SCRIPT_DIR%main\src\tiles"` to the build scripts. This has not
been done here because the OSCAR64 toolchain was not available to verify the
resulting build.
