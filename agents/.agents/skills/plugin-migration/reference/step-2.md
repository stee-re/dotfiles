# Step 2 — Initial migration

**Goal:** use the canonical scaffold, select the required plugin kind, copy and
transform legacy files, and make the result build standalone.

**Prerequisite:** Step 1's documented plan has explicit user approval. Use the
scaffold, revision, tooling strategy and destination recorded in its Resources
section; do not assume historical folder names.

## Required basis

Use **oscd-plugin-scafold**, named and linked in `../SKILL.md`, as the target's
basis. This is the combined editor/menu starter, not the SCL DataTypeTemplates
editor (`oscd-editor-template`) or the old menu-only `oscd-template-menu`.
Do not silently substitute another starter if unavailable; record the blocker
and resolve it with the user.

Record its checkout, revision and working-tree changes in Resources. The
scaffold has `src/oscd-editor-scafold.ts` and `src/oscd-menu-scafold.ts`,
separate exports, tests and demo entries, and shared `oscd` tooling with a thin
multi-entry Rollup extension. Verify those facts against the chosen revision.

**Do not skip the scaffold phase.** A standalone-looking source tree does not
prove its tooling is suitable. Establish the current template's package
structure, scripts, configuration and dependencies rather than inheriting
legacy tooling. If the selected scaffold uses shared `oscd` tooling, load
`plugin-to-oscd-tooling` for relevant configuration details; do not replace it
with old local tool configs.

## Procedure (in order)

1. Materialize the agreed scaffold in the approved destination. Preserve the
   worklog and existing files; do not overwrite collisions. Do not copy the
   scaffold's `.git`, `node_modules`, `dist`, coverage, development worklog or
   release history, or remove the destination's Git metadata.
2. Select editor, menu or both and purge the unused plugin using the checklist
   below. Rename retained identifiers — load `adapt-menu-template`.
3. Update package metadata (exports, demo, README).
4. Create local foundation modules — load `legacy-foundation-helpers`,
   `legacy-xml-helpers`, `deprecated-editor-actions` as needed.
5. Copy legacy source files into `src/` and transform all imports.
6. Add plugin-specific dependencies to `package.json`, preserving the agreed
   scaffold's tooling unless a change has been approved.
7. `npm install`, then verify with `npm run build`.

## Remove the unused plugin completely

For an editor-only target, remove `oscd-menu-scafold`; for menu-only, remove
`oscd-editor-scafold`. Keep both only if the approved plan requires both.

- Delete the unused source and co-located spec; remove any associated helpers,
  fixtures or snapshots only after checking whether the retained plugin uses them.
- Remove its package export and Rollup entry. Keep a thin local Rollup extension
  when the retained filename differs from the package basename; the shared
  single-entry default requires that match.
- Remove its demo import, registry definition and editor/menu list entry.
- Remove its README/setup examples and all other active references.
- Rename retained source/specs, classes, tags, exports, Rollup inputs and demo
  references consistently; update package/repository metadata and the lockfile.
- Clean/rebuild and inspect package contents so stale bundles or declarations
  cannot ship. Check source, demo, configuration and package metadata for stale
  scaffold identifiers; historical worklog provenance is not an active reference.

## Import rewriting rules

Apply to every copied file:

- `lit-element` → `lit` (runtime) + `lit/decorators.js` (decorators)
- `lit-html/directives/*` → `lit/directives/*.js`
- Add `.js` extension to all relative imports
- `lit-translate` → `@lit/localize` — load `lit-translate-to-lit-localize`
  (MUST be done in step 2)
- `mwc-*` side-effect imports → class imports + `scopedElements` registration —
  load `scoped-elements`
- Forbidden package imports → local foundation or shared library

## Cross-cutting concerns

- `editCount` → `docVersion` (all property declarations and bindings)
- Remove `@customElement` decorators from all non-test files
- Host-provided properties need standalone defaults — load `nsdoc-standalone`
- Constructor DOM traversal → `connectedCallback()` — load `scoped-elements`
- Background plugin for deprecated editor actions — load
  `deprecated-editor-actions`

## Forbidden dependencies

Must NOT appear in `package.json` or `src/`:

- `@openscd/open-scd` (not published)
- `@openscd/xml` (not published)
- `@openscd/core` (deprecated export path absent from the published package)

## Exit criteria

- `npm i` succeeds without errors
- `npm run build` succeeds
- `npx tsc --noEmit` passes
- No forbidden imports in `src/`
- Unused scaffold source/spec/export/bundle/demo/documentation references absent
- Retained exports resolve and package contents exclude discarded entry artifacts
- No `lit-translate` in `package.json` or runtime imports
- Every `mwc-*` used in a template is registered in that component's own
  `scopedElements`
- Plugin renders in the standalone demo: tab appears, English strings visible,
  child components render
- Demo includes Source Editor alongside the new plugin (loaded via `src` from CDN)
- Demo `plugins.js` uses `tagName` for locally-registered plugins and `src` for
  remote ones (the shell handles both)

## Verification order

Run after EVERY structural change:

1. `npm i` — must complete without errors
2. `npx tsc --noEmit` — must pass
3. `npm run build` — must succeed and output to `dist/`
4. Confirm `dist/` does NOT contain source files (tsconfig `rootDir` must be `./src`)
