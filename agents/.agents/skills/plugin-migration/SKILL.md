---
name: plugin-migration
description: Orchestrates migrating a legacy OpenSCD monorepo plugin into a standalone package. Load when starting or resuming a migration, or when asked which step comes next.
---

# Plugin Migration Orchestrator

**Use when** moving a legacy plugin out of the monorepo into a standalone npm
package, or resuming a migration already in progress.

**Don't use for** individual transformations — each step names the recipe skill
that owns it. This skill only sequences them.

**Escalate to** — `iec-61850` if a step exposes SCL manipulation whose
correctness is unclear, particularly when porting legacy code that constructs or
reorders elements. Routine porting does not need it.

## Before starting

1. Read the plugin's brief in `./migrations/<plugin>.md`.
2. Check its "Step Status" to find the next step.
3. Work only in `output/<plugin-name>/`. Never edit `legacy/`, `libs/`, or
   `template/`.

## Sequence

| Step | Goal | Load | Exit |
|---|---|---|---|
| 1 | Migration brief detailed enough to execute without rediscovery | `scl-lib`, `oscd-api`, `oscd-ui` | Brief complete; no re-inventorying needed for step 2 |
| 2 | A compiling standalone package scaffolded from the template | `adapt-menu-template`, `legacy-foundation-helpers`, `legacy-xml-helpers`, `deprecated-editor-actions`, `lit-translate-to-lit-localize`, `scoped-elements`, `nsdoc-standalone` | See `reference/step-2.md` |
| 3 | All deprecated editor actions replaced by EditV2 | `editv1-to-editv2`, `oscd-api` | No deprecated action imports; all edits via `newEditEventV2`; behaviour unchanged; tests pass |
| 4 | Legacy wizards replaced by `oscd-scl-dialogs` where supported | `scl-dialogs-embedding` | Supported wizards replaced; gaps documented; dialogs emit valid edits; tests pass |
| 5 | All legacy UI replaced by `@omicronenergy/oscd-ui` | `mwc-to-oscd-ui`, `oscd-ui`, `scl-icons`, `filtered-list-to-oscd-ui` | No `mwc-*`, `md-*` or `@openenergytools/*` UI imports in `src/`; UI renders; tests pass |
| 6 | Dialogs embedded in the plugin root, host-independent | `scl-dialogs-embedding` | Dialog opens from the embedded instance; events don't escape the plugin; builds and tests pass |

**Step 2 is never "N/A"** — even a plugin that already looks standalone must be
scaffolded from `template/oscd-template-menu/`. Skipping it inherits broken
legacy tooling. See `reference/step-2.md`.

## Rules

- Never change logic. Only imports, types, registrations and property shapes.
- Flag code smells for later review; do not fix them during migration.
- Migrate one plugin at a time, but analyse all up front for shared code.
- Update the brief's Step Status after each step.

## Verify

After **every** structural change, in this order:

```
npm i && npx tsc --noEmit && npm run build
```

Confirm `dist/` contains no source files (`rootDir` must be `./src`). Do not
start the next step until all three pass.

## Reference

| File | Read when |
|---|---|
| `reference/step-2.md` | Executing step 2 — full procedure, import-rewriting rules and exit criteria |
| `reference/anti-patterns.md` | Before starting any step, and when a migration has gone wrong |
