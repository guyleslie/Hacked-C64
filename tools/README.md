# Map generator audit tool

`mapgen_audit.py` is a dependency-free, deterministic host-side model of the
room placement, normal MST room network, and straight/L/Z corridor drawing in
`main/src/mapgen`.

It is intended for fast seed sweeps before selected seeds are verified in
VICE. It does not replace an emulator or real-hardware test.

## Examples

Run the internal consistency checks:

```powershell
python tools/mapgen_audit.py --self-test
```

Audit seeds 1 through 10,000 with the original placement profile:

```powershell
python tools/mapgen_audit.py --profile current --audit-level fast --size all --seeds 1:10000
```

Audit the production C implementation's guarded, rule-preserving profile:

```powershell
python tools/mapgen_audit.py --profile guarded --audit-level fast --size all --seeds 1:10000
```

Inspect one problematic medium-map seed:

```powershell
python tools/mapgen_audit.py --profile current --audit-level full --size medium --inspect 6116
```

Write a machine-readable report:

```powershell
python tools/mapgen_audit.py --profile guarded --audit-level fast --size all --seeds 1:10000 --json build/mapgen-audit-guarded.json
```

## Measured invariants and events

- requested versus placed room count;
- required versus created MST connections;
- saturated four-connection room failures;
- existing walkable tiles and walls touched by a new corridor;
- third-party room interiors crossed by a corridor;
- side-adjacent corridor runs that may create a two-tile-wide bulge;
- reuse of a room wall at the same or a different physical door coordinate;
- deterministic 16-bit map checksum.

The historically named `current` profile is the original pre-fallback baseline.
The `guarded` profile mirrors the production C code: after the existing 15
random placement attempts fail, it scans the same placement region and finally
tries the already-valid minimum 4x4 room size. It also skips a connected MST
parent that already has four stored connections. If the complete layout is
still short, it retries the same unchanged placement rules up to sixteen times
while continuing the deterministic seeded RNG stream.

Use `--audit-level fast` for large room/network seed sweeps. It does not draw
normal corridors and therefore omits corridor-tile events. Use
`--audit-level full` for smaller ranges or individual seeds when crossings,
walls, junctions, and possible two-tile-wide bulges must be inspected.

## C64/VICE cycle benchmark

`mapgen_benchmark.c` runs a fixed mix of ordinary and retry-heavy seeds through
the real OSCAR64-compiled generator. `run_mapgen_benchmark.ps1` uses the VICE
debug cartridge and `-limitcycles` to find the exact suite completion cycle.
The value includes identical VICE autostart overhead, so compare results made
on the same machine and emulator setup rather than treating it as generator-only
cycle accounting.

Measure generator cycles:

```powershell
powershell -ExecutionPolicy Bypass -File tools/run_mapgen_benchmark.ps1 -Mode cycles
```

For comparison with the old per-tile row multiplication:

```powershell
powershell -ExecutionPolicy Bypass -File tools/run_mapgen_benchmark.ps1 -Mode cycles -LegacyRowOffsets
```

The `-LegacyRoomBounds` switch similarly restores direct `Room` structure
lookups for placement tests. Switches can be combined to isolate or reproduce
individual optimization steps.

Calculate a 16-bit aggregate checksum for the same generated maps:

```powershell
powershell -ExecutionPolicy Bypass -File tools/run_mapgen_benchmark.ps1 -Mode checksum
```

Use the checksum before and after an optimization to verify that map geometry,
feature placement, and deterministic RNG results did not change.
