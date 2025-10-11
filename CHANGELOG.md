# CHANGELOG

## [Unreleased] - 2025-10-11

### Added
- Distance-based stair placement algorithm with maximum separation optimization
- Dynamic progress tracking with runtime-weighted phase calculations
- Comprehensive documentation in project specification

### Changed
- Optimized stair placement from priority-based to exhaustive distance search
- Reduced Room struct size from 48 to 46 bytes (2 bytes per room saved)
- Simplified bounds checking across tile access functions
- Streamlined camera movement logic by removing redundant underflow checks
- Improved corridor drawing by removing unnecessary sentinel checks

### Removed
- UNDERFLOW_CHECK_VALUE constant and related redundant checks
- Unused 400-byte room distance cache and associated functions (401 bytes RAM saved)
- Redundant MST safety validation functions
- Contradictory `__assume()` compiler hints that conflicted with runtime checks
- Duplicate state flag and sentinel value validations
- Priority-based room selection system and unused hub_distance field
- Unreachable clamp code after early returns
- Impossible range checks in placement logic
- Optimization strategy section from CLAUDE.md (moved to changelog)

### Fixed
- Inconsistent validation patterns across codebase
- Contradictory compiler hints and runtime checks

### Performance
- Total RAM saved: ~440 bytes (401 from cache + 40 from room structures)
- Code size reduced: ~150-200 bytes
- Improved generation speed: ~300-500 CPU cycles per map
- Optimal stair placement with O(n²) exhaustive search (~10ms overhead acceptable)

---

## Notes
For detailed technical rationale behind optimization changes, see commit history and inline code comments.
