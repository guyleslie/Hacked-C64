# Codex Project Instructions

## Project context

- Before changing or diagnosing the project, read and follow `CLAUDE.md` for the current architecture, C64 constraints, OSCAR64 build pattern, and code conventions.
- Do not guess about OSCAR64 or C64 APIs, compiler behavior, declarations, types, constants, or usage patterns. Check the relevant source material first.

## Required OSCAR64 reference locations

Use these local directories as primary research sources for every OSCAR64 programming task:

1. `E:\Apps\oscar64\include\c64`
   - Installed C64 headers. Use these to verify the exact API declarations, types, constants, and available interfaces used by the installed toolchain.
2. `C:\Users\guyle\OneDrive\Documents\programing\C64\OSCAR64\OscarTutorials-main`
   - OSCAR64 tutorials and working usage examples.
3. `C:\Users\guyle\OneDrive\Documents\programing\C64\OSCAR64\oscar64-main`
   - OSCAR64 compiler source, documentation, libraries, and examples. Use it to investigate compiler/runtime behavior and implementation details.

Search the relevant headers, documentation, examples, and source code in these locations before implementing a feature or proposing a fix. Treat these directories as read-only references unless the user explicitly asks to modify them. If versions or examples disagree, verify which version matches the installed compiler and the project's build configuration; report material conflicts instead of silently choosing one.

## Online source research

- When local references are insufficient, ambiguous, or an existing implementation would be useful, proactively search the web for open-source OSCAR64 games, demos, and source repositories. Inspect the actual source code rather than relying only on search snippets or general C/C64 assumptions.
- Prefer original repositories, official OSCAR64 material, and code that can be tied to a specific compiler version.
- Record the source URL and check its license before adapting code. Do not copy code with missing or incompatible licensing; use it only as conceptual reference.
