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

## Doors and the wall rim

The wall's grey top rim belongs to the wall, and the view looks down from the
upper right, so the rim is what a wall shows towards the walkable side.

The rule, in one line: **the rim appears only where there is a door.**

| cell | drawn as |
|---|---|
| closed door in an up-down wall | iron grating `12`, or wooden door `18` |
| closed door in a left-right wall | iron grating `13`, or wooden door `18` |
| **open** door in an up-down wall | `14` - rim kept, leaf gone, walkable below |
| **open** door in a left-right wall | `15` - rim kept, leaf gone, walkable below |
| walkable cell with no door | plain floor `1`, no rim |

Opening a door takes away the leaf but not the wall it sits in, which is why an
open door has its own artwork rather than turning into plain floor. A gap in a
wall that is not a door gets no rim at all.

The white corner dots are not drawn by the renderer. They are part of the
corner tile artwork and appear wherever two top rims meet, so picking the right
corner tile puts them in the right place automatically.

Door state comes from TMEA: `is_door_open()` was added alongside the existing
`is_door_secret()` and `is_door_locked()` queries. Whether a closed door is
wooden or an iron grating is still open game data, behind
`tiles_door_is_wooden()`.

## Reproducing the reference map

The acceptance test for the renderer is whether the tile selection rule can put
back the map that was drawn by hand, given only what the map generator
produces: walkable cells, walls, and the positions and states of doors, stairs
and items. Nothing about the artwork is fed in beyond that.

```powershell
python tools/tileset_build.py main/assets/tileset.ctm --self-test
python tools/tileset_build.py main/assets/tileset.ctm --grid-tiles 1,19 --repro-preview build/map-repro.png
```

**All 169 cells match.** The check runs on every `--self-test`, so redrawing
the reference map will flag a selection rule that no longer matches it.

Two rules were tried and rejected on the way, both recorded here so they are
not tried again:

- *a walkable cell next to a wall gets a rim* - the reference map draws plain
  floor next to walls almost everywhere, so this was wrong by 34 cells.
- *a walkable cell pinched between two walls is a passage and gets a rim* -
  that condition also holds for every cell of a one-tile-wide corridor, and it
  fires at six places in the reference map where only one is drawn with a rim.
  The one that is drawn with a rim is an open door, which is what the rule
  above captures.

## Files

| File | Role |
|---|---|
| `main/assets/tileset.ctm` | CharPad source artwork, the only hand edited asset |
| `tools/tileset_build.py` | Parses the CTM, stamps the layers, emits C tables |
| `main/src/tiles/tileset_data.c/.h` | Generated - do not edit by hand |
| `main/src/tiles/tile_render.c/.h` | VIC setup, tile blit, tile selection, viewport |
| `main/src/tiles/tile_viewer.c/.h` | Camera, joystick input, redraw loop |
| `main/src/tileviewer.c` | Entry point for the viewer PRG |
| `build-tileviewer.bat` | Builds the viewer |
| `main/src/mapgen/tmea_core.c/.h` | `is_door_open()` query used by door selection |

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

## Tile viewer PRG

The build scripts find the compiler in this order: the `OSCAR64_HOME`
environment variable, a copy inside the repository at `oscar64\`, then
`E:\Apps\oscar64`. Set `OSCAR64_HOME` for anything else:

```powershell
set OSCAR64_HOME=E:\Apps\oscar64
```

`build-tileviewer.bat` produces a standalone program that generates a dungeon
and scrolls it on screen with the tile renderer, replacing the
one-character-per-cell PETSCII preview. The viewport shows 10x8 map cells
instead of 40x25, so scrolling is how the map gets inspected.

| control | action |
|---|---|
| joystick 2 | scroll one map cell per two frames |
| FIRE | generate a new dungeon with a fresh seed |
| Q | quit and restore the kernal display |

What the map generator produces is drawn like this:

| map cell | drawn as |
|---|---|
| door | iron grating, orientation from the wall run |
| secret door | plain wall - `tiles_select()` asks TMEA and joins it into the wall |
| deception door (hidden passage, niche) | plain wall, same path |
| stairs up / down | the two staircase tiles |
| wall | joined wall shape |
| floor | plain floor with the generated frame |

All the hidden-feature doors go through `add_secret_door_metadata()` in the
generator, so a single `is_door_secret()` check covers hidden rooms, hidden
passages and niches alike. Nothing about them is visible.

### Memory layout

The viewer copies the character set to `$3800`, the last 2 KB slot of VIC bank
0, leaving `$0801-$37FF` for code and data. **Nothing in the code can check
that the linker respected it.** If the build outgrows the space, move the VIC
to bank 1 through CIA2 port A and put the screen at `$4400` and the character
set at `$4800`; bank 1 has no character ROM shadow, so all of it is usable.

Scrolling redraws the whole viewport, 720 screen bytes plus 720 colour bytes.
That is a few milliseconds and fine for step scrolling. Shifting screen memory
and filling only the new edge is the optimisation if it ever needs to be
smoother.

## Wiring it into the build

The viewer PRG has its own entry point and builds on its own. To bring the tile
renderer into the main program as well, following the OSCAR64 single-file
model, add to `main/src/main.c`:

```c
#include "tiles/tileset_data.c"
#include "tiles/tile_render.c"
```

and add `-i="%SCRIPT_DIR%main\src\tiles"` to the build scripts. This has not
been done here because the OSCAR64 toolchain was not available to verify the
resulting build.
