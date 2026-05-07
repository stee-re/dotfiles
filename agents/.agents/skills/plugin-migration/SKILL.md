---
name: plugin-migration
description: Orchestrator for migrating legacy OpenSCD monorepo plugins to standalone packages. Load when starting or continuing any plugin migration. References recipe skills for specific transformations.
---

# Plugin Migration Workflow

This skill orchestrates the migration of legacy OpenSCD plugins from the monorepo into standalone npm packages. Each migration follows a fixed step sequence. Load the referenced recipe skills on-demand for specific transformation patterns.

## Before Starting

1. Read the plugin's migration brief in `./migrations/<plugin>.md` for plugin-specific context.
2. Check the "Step Status" section to know which step to execute next.
3. Work only in `output/<plugin-name>/`. Never edit `legacy/`, `libs/`, or `template/`.

## Step Sequence

### Step 1: Planning (analysis only — no code changes)

**Goal:** Produce a migration brief detailed enough to execute without rediscovering facts.

**Checklist:**
- Identify plugin kind, entry point, all direct/indirect imports
- Map shared code roots reused across migrations
- Identify replacements from shared libraries (load `$scl-lib`, `$oscd-api`, `$oscd-ui` skills)
- Identify forbidden dependencies (`@openscd/open-scd`, `@openscd/xml`, `@openscd/core`)
- Compile files to copy, files to rewrite, files to leave behind
- Identify test files (*.spec.ts = unit, *.test.ts = visual regression, *.testfiles.ts = fixtures)
- Detect hidden coupling (global state, implicit registrations, editCount patterns)
- Identify host-provided properties (nsdoc, etc.)
- Record open risks and unanswered questions
- List applicable recipes

**Exit:** Brief is complete enough to execute step 2 without re-inventorying.

---

### Step 2: Initial Migration (build a compiling standalone package)

**Goal:** Duplicate template, copy/transform legacy files, make it build standalone.

**CRITICAL: Step 2 is NEVER "N/A".** Even if the legacy plugin already has its own repo or appears standalone-shaped, you MUST scaffold from `template/oscd-template-menu/`. The template defines the canonical project structure: `src/` directory, `"type": "module"`, `NodeNext` module resolution, flat eslint config, scripts, devDependencies, rollup config, web-test-runner config, etc. Skipping this results in a project that inherits legacy tooling, broken scripts, and non-standard structure.

**Procedure (in order):**
1. Duplicate `template/oscd-template-menu/` into `output/<package-name>/`, remove `.git`
2. Rename all template identifiers — load `$adapt-menu-template` skill
3. Update package metadata (exports, demo, README)
4. Create local foundation modules — load `$legacy-foundation-helpers`, `$legacy-xml-helpers`, `$deprecated-editor-actions` skills as needed
5. Copy legacy source files into `src/` and transform all imports
6. Add plugin-specific dependencies to package.json (keep template devDeps as-is)
7. `npm install`, verify build with `npm run build`

**Import rewriting rules (apply to every copied file):**
- `lit-element` → `lit` (runtime) + `lit/decorators.js` (decorators)
- `lit-html/directives/*` → `lit/directives/*.js`
- Add `.js` extension to all relative imports
- `lit-translate` → `@lit/localize` — load `$lit-translate-to-lit-localize` skill (MUST be done in Step 2)
- mwc-* side-effect imports → class imports + `scopedElements` registration — load `$scoped-elements` skill
- Forbidden package imports → local foundation or shared library — load relevant recipe skills

**Cross-cutting concerns for Step 2:**
- `editCount` → `docVersion` (all property declarations and bindings)
- Remove `@customElement` decorators from all non-test files
- Host-provided properties must have standalone defaults — load `$nsdoc-standalone` skill if needed
- Constructor DOM traversal → `connectedCallback()` (load `$scoped-elements` skill)
- Background plugin for deprecated editor actions — load `$deprecated-editor-actions` skill

**Forbidden dependencies (must NOT appear in package.json or src/):**
- `@openscd/open-scd` (not published)
- `@openscd/xml` (not published)
- `@openscd/core` (deprecated export path doesn't exist in published package)

**Exit criteria:**
- `npm i` succeeds without errors
- `npm run build` succeeds
- `npx tsc --noEmit` passes
- No forbidden imports in `src/`
- No `lit-translate` in package.json or runtime imports
- All mwc-* used in templates registered in component's own `scopedElements`
- Plugin renders in standalone demo (tab appears, English strings visible, child components render)
- Demo includes Source Editor alongside the new plugin (loaded via `src` from CDN)
- Demo `plugins.js` uses `tagName` for locally-registered plugins and `src` for remote ones (shell handles both)

**Verification order (run after EVERY structural change):**
1. `npm i` — must complete without errors
2. `npx tsc --noEmit` — must pass
3. `npm run build` — must succeed and output to `dist/`
4. Confirm `dist/` does NOT contain source files (tsconfig rootDir must be `./src`)

---

### Step 3: EditV2 Migration

**Goal:** Replace all deprecated editor action types with EditV2 and `newEditEventV2`.

**Load:** `$editv1-to-editv2` skill, `$oscd-api` skill

**Procedure:**
- Map each deprecated type to EditV2 equivalent (Create→Insert, Delete→Remove, Update→SetAttributes, Move→Remove+Insert, ComplexAction→EditV2[])
- Replace `newActionEvent(action)` with `newEditEventV2(edit)`
- Import types from `@openscd/oscd-api`, runtime from `@openscd/oscd-api/utils.js`
- Update `editCount`-driven refresh to respond to `docVersion`
- Remove `@omicronenergy/oscd-background-editor-action` dependency
- Remove background plugin from demo/plugins.js
- Add `@openscd/oscd-api` as direct dependency

**Exit criteria:**
- No deprecated editor action imports remain
- All persistent edits flow through `newEditEventV2`
- Behavior remains identical to legacy
- Tests pass

---

### Step 4: SCL Dialogs Migration

**Goal:** Replace legacy wizard code with `oscd-scl-dialogs` where supported.

**Load:** `$scl-dialogs-embedding` skill

**Procedure:**
- Identify all wizard-opening code
- Check each element type against oscd-scl-dialogs support matrix
- Replace supported wizard calls with `newEditDialogEditEvent(element)`
- Keep unsupported cases local, document gaps
- GSEControl and SampledValueControl are now supported

**Exit criteria:**
- All supported wizard calls replaced
- Unsupported cases documented
- Dialog opens and produces valid edits
- Tests pass

---

### Step 5: oscd-ui Migration

**Goal:** Replace all legacy UI components with `@omicronenergy/oscd-ui` equivalents.

**Load:** `$mwc-to-oscd-ui` skill, `$oscd-ui` skill, `$scl-icons` skill, `$filtered-list-to-oscd-ui` skill

**Procedure:**
- Replace `@material/mwc-*` → oscd-ui equivalents
- Replace `@scopedelement/material-web` (md-*) → oscd-ui equivalents
- Replace `@openenergytools/*` UI components → oscd-ui equivalents
- Replace local icon files with OscdIcon + SCL icon names
- Replace `<li divider>` with `<oscd-divider>`
- Update CSS selectors for new tag names
- Update `@queryAll` selectors for renamed tags
- Remove old UI dependencies from package.json

**Exit criteria:**
- No deprecated UI imports remain
- No mwc-*, md-*, @openenergytools/* UI imports in src/
- UI renders correctly
- Tests pass

---

### Step 6: Dialog Embedding (if applicable)

**Goal:** Embed oscd-scl-dialogs in the plugin root so dialog actions don't depend on a host.

**Load:** `$scl-dialogs-embedding` skill

**Procedure:**
- Embed `<oscd-scl-dialogs>` in plugin root with synchronous scopedElements registration
- Wire up any remaining wizard-replacement actions to the embedded dialog instance
- Clean up dividers and other legacy UI remnants

**Exit criteria:**
- Dialog opens from plugin's own embedded instance (no host dependency)
- Events don't escape plugin boundary (stopPropagation)
- All builds and tests pass

---

## General Rules

- Never change logic — only imports, types, registrations, and property shapes
- Where code smells are found, flag them for later review (don't fix during migration)
- One migration at a time, but analyse all up front for shared code
- Update the migration brief's Step Status after completing each step
- Mark applicable recipes in the brief

---

## Anti-Patterns (mistakes to never repeat)

1. **Never skip Step 2.** Even if a legacy plugin "looks standalone," it must be scaffolded from `template/oscd-template-menu/`. The template defines canonical config: `"type": "module"`, `NodeNext` resolution, `src/` directory, correct scripts, modern devDeps. Copying legacy repos inherits broken tooling.

2. **Never apply source transforms before the project structure is correct.** Steps 3+ assume source lives in `src/`, builds to `dist/`, and `npm i` / `npm run build` work. Verify the foundation first.

3. **Verify `npm i` immediately after any structural change.** Not just `tsc --noEmit`. The full `npm i` exercises prepare/prepublish hooks and catches config issues early.

4. **`rootDir` must be `./src`.** If `rootDir` is `./`, tsc outputs to `dist/src/...` or worse, may overwrite source. Always match the template's tsconfig.

5. **Demo `plugins.js` must use the shell's plugin contract.** `oscd-shell` accepts both `tagName` (pre-registered) and `src` (dynamically loaded + registered). Local plugins use `tagName` with `registry.define()`. Remote plugins use `src` URL. Never mix — a plugin entry needs one or the other, not both.

6. **Run verification in order after every step:** `npm i` → `tsc --noEmit` → `npm run build`. Do not proceed to the next step until all three pass.
