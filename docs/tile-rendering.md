# Tile rendering and overlay layers

How the dungeon is drawn from the final `newest5` CharPad reference, with the
black frame generated around walkable cells rather than drawn into the source.

## The problem

A map cell is one 3x3 character tile. The frame that makes walkable tiles read
as a lattice used to be painted into the tile artwork. `newest5` contains the
clean artwork: floor, stairs and open doors are walkable; walls, closed doors
and the black outside tile are not.

Overlaying an actual bitmap is not an option. VIC-II display modes are mutually
exclusive - character mode or bitmap mode, never both - and there is no
transparency or layering. Sprites are the only real overlay and there are eight
per raster line, all of which the architecture plan already allocates.

## The model

The grid is a **stencil**: only black matters, everything else passes through.
On the VIC-II it is applied to generated character variants at build time. The
renderer selects a framed tile for a walkable state and a clean tile for an
unwalkable state, so opening and closing a door also adds or removes its grid.

```
grid   one multicolour pixel of black on the tile's top and left edge
```

Neighbouring tiles complete each other's frame, so drawing only the top and
left edge produces a continuous lattice across the walkable area.

`tools/tileset_build.py` stamps this mask into the character set at build
time and emits the result as C tables. Nothing is stamped at runtime, and the
renderer only picks which pre-stamped character to write to screen memory.

### Mask polarity

Which bitwise operation paints black depends on the character's colour mode:

| character | how black is produced | operation |
|---|---|---|
| hires, colour RAM `0` | set bits show the black foreground | `rows[r] \| mask[r]` |
| multicolour, colour RAM `8` | `%11` pairs show the character-specific black | `rows[r] \| pairs(mask[r])` |
| unused per-character colour | generated copy is safely remapped to black | remap, then OR |
| black `$d021` fallback | cleared pixels show background colour 0 | AND with inverse mask |

Multicolour masks always operate on **whole bit pairs**. Changing only one bit
would select a different VIC colour instead of painting a black pixel.

## Current palette state

`main/assets/tileset.ctm` is authored with:

```
$d021 = 11 (dark grey)   the floor body
$d022 = 12 (medium grey)
$d023 =  9 (brown)
```

The clean floor uses multicolour attribute `8`. Its `%00` body stays dark grey,
while the generated frame writes `%11`, whose character colour is black. This
keeps the existing three global colours and does not require bitmap mode.

The old checkerboard fog is disabled by default. `TILE_VARIANT_FOG` remains a
no-op hook until visibility artwork/rules are decided.

## Wall joining

A wall tile picks its shape from which of its four neighbours are also
wall-like. Doors and gratings count as wall-like: a wall run continues through
them.

```
CONN_UP = 1   CONN_DOWN = 2   CONN_LEFT = 4   CONN_RIGHT = 8
```

| connections | tile | meaning |
|---|---|---|
| left + right | 2 | horizontal run |
| up + down | 3 | vertical run |
| right + down | 4 | corner opening right and down |
| left + down | 5 | corner opening left and down |
| right + up | 6 | corner opening right and up |
| left + up | 7 | corner opening left and up |

The four-bit connection mask is not enough on generated maps. Walls belonging
to nearby rooms or one-tile corridors can touch even though they are not the
same visible run. The final `newest5` reference resolves junctions from the
walkable space around them:

- a T branch becomes a corner only when a walkable diagonal beside that branch
  confirms a real boundary;
- without that confirmation the through axis remains a straight horizontal or
  vertical wall, removing the repeated white-dotted false bridges;
- a vertical T with a confirmed right branch uses `RD`; a confirmed left
  branch normally uses `LD`, with the isolated upper-left case using `LU`;
- a horizontal T follows the same rule with its upper or lower diagonals;
- a cross follows the confirmed walkable diagonal, using the lower-right
  perspective as the no-context fallback;
- two visually identical 3x3 door-overlap patterns inspect one second-ring
  cell to decide which adjacent wall cell owns the corner.

Doors count both as wall connections and as walkable openings. Diagonal reads
are performed only for T/cross masks; ordinary runs and two-way corners retain
the four-neighbour fast path.

The final reference is the 24x24 map from `newest5 ctm6.ctm`, now stored in the
project CTM while retaining the multicolour-8 clean-floor attribute required by
the generated black grid. The rule reproduces all **211 wall placements** and
all **576 map cells** exactly. `tools/tileset_build.py --self-test` checks the
complete contextual reproduction on every build.

Adding T and cross pieces to the tileset would remove the reduction step; the
rule is then a plain sixteen-entry lookup.

## Doors and the wall rim

The wall's grey top rim belongs to the wall, and the view looks down from the
upper right, so the rim is what a wall shows towards the walkable side.

The rule, in one line: **the rim appears only where there is a door.**

| cell | drawn as |
|---|---|
| closed door in an up-down wall | iron grating `11`, or wooden door `17` |
| closed door in a left-right wall | iron grating `12`, or wooden door `17` |
| **open** door in an up-down wall | `13` - rim and generated grid, leaf gone |
| **open** door in a left-right wall | `14` - rim and generated grid, leaf gone |
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
python tools/tileset_build.py main/assets/tileset.ctm --repro-preview build/map-repro.png
```

**All 576 cells match.** The check runs on every `--self-test`, so redrawing
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
| `build-mapgen-tile-viewer.bat` | Regenerates the tiles and builds the viewer PRG |
| `main/src/mapgen/tmea_core.c/.h` | `is_door_open()` query used by door selection |

## Workflow

Draw the tiles in CharPad **without** the frame and checkerboard, then regenerate:

```powershell
python tools/tileset_build.py main/assets/tileset.ctm --self-test
python tools/tileset_build.py main/assets/tileset.ctm --out-dir main/src/tiles --preview build/tileset-preview.png
```

The default `--grid-tiles` set is `1,8,9,10,13,14,15,16`: floor, stairs and
open-door variants. `--fog-tiles` defaults to empty.

Changing the frame - thicker, dashed, also on the right edge - is an edit to
`grid_mask()` in the tool. The artwork is never touched.

### Redundant tiles

Tiles 10, 15 and 16 currently duplicate tiles 9, 13 and 14. They are retained
because the final reference map still uses them, and receive the same grid rule.

## Tile viewer PRG

The build scripts find the compiler in this order: the `OSCAR64_HOME`
environment variable, a copy inside the repository at `oscar64\`, then
`E:\Apps\oscar64`. Set `OSCAR64_HOME` for anything else:

```powershell
set OSCAR64_HOME=E:\Apps\oscar64
```

`build-mapgen-tile-viewer.bat` regenerates the C tables and produces
`build/Hacked C64-mapgen-tile-viewer.prg`, a standalone program that generates a dungeon
and scrolls it on screen with the tile renderer, replacing the
one-character-per-cell PETSCII preview. The viewport shows 10x8 map cells
instead of 40x25, so scrolling is how the map gets inspected.

| control | action |
|---|---|
| joystick 2 | four-way scroll, stable 8-pixel character steps |
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

### Scrolling

The camera moves in atomic character steps. Each step covers eight pixels in
four fixed two-pixel VIC fine-scroll phases. Once a step starts, its direction
is held until the next character alignment; the joystick is sampled again
there.

The earlier implementation rebuilt all 1,000 screen cells in a hidden buffer
for every character boundary. That consumed approximately one whole PAL frame
before each transition and caused the visible pause on direction changes. The
normal scrolling path now follows OSCAR64's
`samples/scrolling/cgrid8way.c` instead:

- **Screen RAM and Color RAM move in place.** The copy is divided at raster row
  12; movement down uses a third section at row 20 and two saved seam rows.
  Each part is written only after the raster has passed it, so no half-shifted
  picture is exposed.
- **Only the entering edge is generated.** A horizontal step reads 25 new
  character/colour pairs from the 3x3 tile cache; a vertical step reads 40.
  There is no 1,000-cell render queue to fill during ordinary movement.
- **The copy loops use fixed `$C800` addresses and compile-time-unrolled screen
  rows.** This is important on the C64: a runtime screen pointer made OSCAR64
  generate address setup inside the raster-critical section.
- **Double buffering at `$C800` and `$CC00` remains for full redraws only**,
  such as FIRE generating a new dungeon. Colour RAM still has one shadow per
  full-screen buffer; after an in-place scroll the active shadow is lazily
  resynchronised only if such a redraw is requested.
- **38 column and 24 row mode** hides the partially scrolled edge behind the
  border. `VIC_CTRL2_MCM` has to be preserved when writing the fine scroll or
  the whole screen drops back to hires.
- **The positive camera limit includes one black character lane.** The VIC
  border hides the last lane of the 40x25 backing screen in 38x24 mode, so the
  exact end position advances one character beyond the map and lets
  `tiles_select()` fill that lane with black. At the limit, two final
  two-pixel fine-scroll phases (`4 -> 2 -> 0`) expose the half character still
  covered by the border. Reversing restores `0 -> 2 -> 4` before the next
  character shift, so the direction change cannot jump.
- **The top and left limits have their own final `4 -> 6` phase.** CSEL/RSEL
  still cover two pixels of the first map row/column at character position
  zero. The extra phase exposes those pixels without adding a virtual leading
  row, and movement away from the edge restores `6 -> 4` before shifting RAM.
- **A tile cache** of 14x9 entries holds the visible tiles. Only the newly
  exposed row or column is selected when the view crosses a tile, which keeps
  `tiles_select()` - the expensive part, several `get_compact_tile()` calls per
  wall - out of the scrolling path entirely.
- **Cell-major tables** `tileset_cell_char[cell][entry]` and
  `tileset_cell_color[cell][entry]` make each lookup a single indexed load. The
    visual variant is folded into the entry index.

The raster-critical viewer code preserves the processor flags, masks IRQs only
for the four-phase copy, then restores the previous interrupt state. When the
full game installs its own music/raster IRQ, that handler and the scroll
schedule must be integrated rather than allowed to interrupt these copy
sections. The viewer is four-way; a diagonal joystick position keeps the most
recently used cardinal axis.

The viewer must be built with `-n`. Without native code generation OSCAR64
emits bytecode and the expansion is nowhere near frame rate.

### Memory layout

The VIC runs in bank 3, where `$C000-$CFFF` is plain RAM - no `$01` bank
switching, and no character ROM shadow:

```
$C000-$C7FF   character set
$C800-$CBFF   screen buffer 0
$CC00-$CFFF   screen buffer 1
```

`main/src/tileviewer.c` caps the CPU program region at `$A000`. This keeps the
OSCAR64 heap and software stacks below the BASIC ROM window at `$A000-$BFFF`,
while also staying clear of the VIC data at `$C000`:

```c
#pragma region( main, 0x0a00, 0xa000, , , {code, data, bss, heap, stack} )
```

Colour RAM stays at `$D800` regardless of the VIC bank.

## Wiring it into the build

The viewer PRG has its own entry point and builds on its own. To bring the tile
renderer into the main program as well, following the OSCAR64 single-file
model, add to `main/src/main.c`:

```c
#include "tiles/tileset_data.c"
#include "tiles/tile_render.c"
```

and add `-i="%SCRIPT_DIR%main\src\tiles"` to the build scripts. The standalone
mapgen tile viewer already uses this integration and is verified with OSCAR64.
