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

Audit seeds 1 through 10,000 with the current implementation profile:

```powershell
python tools/mapgen_audit.py --profile current --audit-level fast --size all --seeds 1:10000
```

Compare that result with the guarded, rule-preserving fallback profile:

```powershell
python tools/mapgen_audit.py --profile guarded --audit-level fast --size all --seeds 1:10000
```

Inspect one problematic medium-map seed:

```powershell
python tools/mapgen_audit.py --profile current --audit-level full --size medium --inspect 6116
```

Write a machine-readable report:

```powershell
python tools/mapgen_audit.py --profile current --audit-level fast --size all --seeds 1:10000 --json build/mapgen-audit-current.json
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

The `current` profile mirrors the existing C code. The `guarded` profile keeps
the same map rules but, after the existing 15 random placement attempts fail,
scans the same placement region and finally tries the already-valid minimum
4x4 room size. It also skips a connected MST parent that already has four
stored connections. If the complete layout is still short, it retries the same
unchanged placement rules up to sixteen times while continuing the deterministic
seeded RNG stream.

Use `--audit-level fast` for large room/network seed sweeps. It does not draw
normal corridors and therefore omits corridor-tile events. Use
`--audit-level full` for smaller ranges or individual seeds when crossings,
walls, junctions, and possible two-tile-wide bulges must be inspected.
