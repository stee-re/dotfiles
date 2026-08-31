# Step 2 — Initial migration

**Goal:** duplicate the template, copy and transform legacy files, make it build
standalone.

**Step 2 is NEVER "N/A".** Even if the legacy plugin already has its own repo or
appears standalone-shaped, you MUST scaffold from `template/oscd-template-menu/`.
The template defines the canonical project structure: `src/` directory,
`"type": "module"`, `NodeNext` module resolution, flat eslint config, scripts,
devDependencies, rollup config, web-test-runner config. Skipping this yields a
project that inherits legacy tooling, broken scripts and non-standard structure.

## Procedure (in order)

1. Duplicate `template/oscd-template-menu/` into `output/<package-name>/`, remove `.git`.
2. Rename all template identifiers — load `adapt-menu-template`.
3. Update package metadata (exports, demo, README).
4. Create local foundation modules — load `legacy-foundation-helpers`,
   `legacy-xml-helpers`, `deprecated-editor-actions` as needed.
5. Copy legacy source files into `src/` and transform all imports.
6. Add plugin-specific dependencies to `package.json` (keep template devDeps as-is).
7. `npm install`, then verify with `npm run build`.

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
