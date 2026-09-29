# qa-tests/

Empty by design. Stage 3/4 (`automation-writer` agent) creates `qa-tests/<module>/<feature>/CASES.md`
plus co-located `<case-id>.yaml` Maestro flows here, one pair per requirement ID, once the first
ticket runs through the pipeline (Phase 2).

**Naming note:** the requirements doc (`ios-qa-automation-requirements.md`, Section 2) calls this
folder `tests/`. It's named `qa-tests/` in this repo instead because macOS's default filesystem is
case-insensitive, and this repo already has a `Tests/` folder (the Xcode unit test target,
`Tests/ShopDemoTests/`) — `tests/` and `Tests/` would silently resolve to the same directory on disk
and collide. `qa-tests/` avoids that collision while keeping the same internal structure the spec
describes.

A module-level `qa-tests/<module>/CLAUDE.md` convention exists in the target design (Section 5 of
`ios-qa-automation-requirements.md`) but is explicitly deferred — this pilot has one app and one
module, so the root CLAUDE.md is sufficient for now. Add a module-level CLAUDE.md only when a second
module actually needs different conventions.

Note: this is unrelated to `.maestro/` at the repo root, which holds pre-existing, informal smoke
flows for the demo app and is not part of this pipeline's managed test tree.
