---
name: plugin-to-oscd-tooling
description: Migrate an OpenSCD plugin's devDependencies and config files onto the shared @omicronenergy/oscd-tooling `oscd` CLI. Load when asked to move a plugin to oscd-tooling, reduce plugin devDependency boilerplate, or when a plugin's package.json still declares its own eslint/rollup/wtr/wds/husky/commitlint stack.
---

# Recipe: Migrate a Plugin to `@omicronenergy/oscd-tooling`

## Problem

Most OpenSCD plugin repos each carry their own copy of the dev toolchain:
ESLint + `@typescript-eslint/*` + `@open-wc/eslint-config` + Prettier, Rollup +
plugins, Web Test Runner + Playwright, Web Dev Server, Custom Elements Manifest
analyzer, Husky + lint-staged + commitlint, `gh-pages`, `rimraf`,
`concurrently`, `npm-check-updates`, `typedoc`. Across many plugin repos this
is expensive to keep in sync and upgrade.

`@omicronenergy/oscd-tooling` centralizes all of this behind an `oscd` CLI
(`oscd lint`, `oscd build`, `oscd bundle`, `oscd test`, `oscd start`,
`oscd start-bundle`, `oscd analyze`, `oscd deploy`, `oscd updates`,
`oscd install-hooks`, `oscd commitlint`, `oscd lint-staged`,
`oscd install-playwright`). The CLI resolves every underlying tool binary and
shared config from within `oscd-tooling`'s own `node_modules`/`configs/`,
executed with the consuming repo as `process.cwd()`. Read the package's own
`README.md` (`node_modules/@omicronenergy/oscd-tooling/README.md` once
installed, or the repo README) for the authoritative, up-to-date command and
config list — this skill captures the *migration recipe and footguns*, not a
duplicate of that reference.

A completed reference migration exists at `oscd-editor-sld` — diff against it
when in doubt about the target shape of `package.json`/`tsconfig.json`/
`eslint.config.js`.

## Pre-flight

1. Confirm the plugin's `src/*.spec.ts`/`*.test.ts` files' direct imports
   (e.g. `@open-wc/testing`, `sinon`). Anything imported directly by test or
   demo source must remain a **declared** dependency (dev or runtime,
   matching how it's imported) even after migration — `oscd`'s resolution of
   shared tools does not cover packages the plugin's own code imports by name.
2. Check `demo/*.html` for direct side-effect imports too (e.g.
   `@webcomponents/scoped-custom-element-registry`). These often already
   resolve after migration only because some *other* runtime dependency
   happens to pull them in transitively (a phantom dependency) — don't rely
   on that; declare them explicitly, mirroring how `oscd-editor-sld` keeps
   `@webcomponents/scoped-custom-element-registry` in `dependencies` because
   its demo imports it directly.
3. Note the current `"version"` of `@omicronenergy/oscd-tooling` on npm
   (`npm view @omicronenergy/oscd-tooling version`) to pin a sane `^` range.

## File-by-file changes

- **`package.json`**
  - `devDependencies`: delete every tool now owned by `oscd-tooling` (see its
    README's "Migrating a Plugin" section for the current list — ESLint
    stack, Rollup + plugins, `typescript`, `rimraf`, `concurrently`, WTR/WDS,
    CEM analyzer, `typedoc`, `gh-pages`, `husky`, `commitlint`/`@commitlint/*`,
    `lint-staged`, `npm-check-updates`, `prettier` + `eslint-plugin-prettier`/
    `eslint-config-prettier`, Playwright). Add `@omicronenergy/oscd-tooling`.
    Keep anything imported directly by plugin/test/demo source (pre-flight
    step 1–2).
  - Delete the top-level `"overrides"` pin for `playwright` unless there's a
    documented reason for it — `oscd-tooling` owns and pins its own
    Playwright version.
  - Delete the top-level `"prettier"` and `"lint-staged"` keys. Once migrated,
    `oscd lint-staged` always uses the tooling package's own
    `lint-staged.config.js`, so a local `"lint-staged"` field becomes silently
    dead config, not an override.
  - Rewrite `scripts` to call `oscd <command>` (see the tooling README for
    the full command list and flags like `--analyze`/`--no-clean`/`--watch`).
    Drop scripts for tools that no longer exist locally (e.g. a bare
    `update-deps` calling `npx npm-check-updates` becomes `oscd updates`).
- **`tsconfig.json`**: replace with a thin extension of the shared base
  config, keeping only project-relative paths locally (`outDir`, `rootDir`,
  `include`) — do not hoist these into the shared config, TypeScript resolves
  them relative to the file that declares them:
  ```json
  {
    "extends": "@omicronenergy/oscd-tooling/configs/base.tsconfig.json",
    "compilerOptions": { "outDir": "dist", "rootDir": "src" },
    "include": ["src/**/*.ts"]
  }
  ```
- **`eslint.config.js`**: optional (not required by `oscd lint`, only useful
  for editor integration). If kept, reduce to:
  ```js
  import oscdEsLintConfig from '@omicronenergy/oscd-tooling/configs/eslint.config.js';
  export default [...oscdEsLintConfig];
  ```
- **Delete**: `rollup.config.js`, `web-test-runner.config.js`,
  `web-dev-server.config.js`, `commitlint.config.js`, `.husky/`.
- **`.githooks/`**: don't hand-write it — run `npm run prepare` (mapped to
  `oscd install-hooks`) after `npm install`; it generates
  `.githooks/{pre-commit,commit-msg}` and sets `core.hooksPath` to
  `.githooks`. Verify with `git config --get core.hooksPath`.
- **`.github/workflows/*.yml`**: usually untouched if the repo already calls
  shared reusable workflows from `oscd-gh-workflows`. Diff against a migrated
  reference plugin to confirm before assuming no change is needed.

## Known footguns

1. **Prettier is dropped, not replaced.** `oscd-tooling`'s shared ESLint
   config formats via `@stylistic/eslint-plugin` rules, not Prettier. There
   is no equivalent "keep Prettier" path in the shared config today. Removing
   Prettier is a real behavior change worth calling out explicitly to
   plugin owners/reviewers, since it can produce a one-time reformat diff on
   the next `oscd lint --format` (though in practice, if the plugin's ESLint
   rules already matched Prettier's output, there may be zero diff).
2. **Phantom dependencies.** After pruning `devDependencies`/`dependencies`,
   always run a clean `npm install` (delete `package-lock.json` first if the
   plugin's lockfile predates the prune) and then exercise `demo/` and
   `test/` — packages that still resolve only because a sibling dependency
   happens to hoist them into `node_modules` are one dependency-graph change
   away from breaking.
3. **CEM/`custom-elements.json` is orthogonal to this migration.** No known
   OpenSCD runtime (shell, editor, oscd-api) reads `custom-elements.json` —
   it's only ever referenced via the standard
   `"customElements": "custom-elements.json"` package.json pointer, which
   nothing in this ecosystem currently consumes. `oscd analyze`/
   `--analyze` flags are opt-in wrappers around the same `cem analyze` call
   the plugin already ran; migrating tooling does not require keeping or
   dropping CEM generation. Decide this explicitly with the plugin owner and
   treat it as a separate scope item, not an automatic side effect of the
   tooling swap. If dropping it: delete `custom-elements.json`, the
   `analyze` script, the `customElements` package.json field, and any
   `--analyze` flags wired into `build`/`bundle`/`start` scripts.
4. **README boilerplate goes stale — fix it, don't replicate it.** A "Tooling
   configs" README section claiming "the configuration is in the
   `package.json`" is a leftover from before the `oscd-tooling` migration —
   it is factually wrong once configs live in `oscd-tooling`'s shared
   `configs/`. This was found stale in the reference migration
   (`oscd-editor-sld`) too, but "the reference repo is also stale" is not an
   acceptable precedent to copy forward. As part of *every* migration:
   rewrite the "Tooling configs" section (and any other README passage
   describing lint/build/test/format mechanics) to describe the actual
   `oscd <command>` / thin-wrapper-config setup, and correct the "What is
   this?" copy if it was ever copy-pasted from an unrelated plugin. Do not
   defer this to "someday" or leave it for the plugin owner to notice —
   treat a stale README as a migration defect to fix in the same pass,
   before considering the migration done.
5. **Don't assume test failures are migration-caused.** Compare failures
   against the underlying assertion logic, not the toolchain. For example, a
   `chai` `array.to.deep.include(partialObject)` assertion requires an exact
   deep-equal array member, not a partial-field match — a pre-existing test
   bug unrelated to swapping `@open-wc/testing`/WTR wiring. Confirm same
   `@open-wc/testing`/chai major version before vs. after to rule out a
   version-driven behavior change before concluding "pre-existing bug."

## Verification order

Run after every structural change, not just at the end:

1. `npm install` (clean lockfile if pruning heavily) — must complete without
   errors, and `prepare` (`oscd install-hooks`) must report success.
2. `git config --get core.hooksPath` → `.githooks`, and
   `.githooks/{pre-commit,commit-msg}` exist.
3. `npm run lint` (`oscd lint`) — passes; note any reformat diff caused by
   dropping Prettier.
4. `npm run build` (`oscd build`) — succeeds, `dist/` contains expected
   `.js`/`.d.ts` output.
5. `npm run bundle` (`oscd bundle`) — succeeds; pre-existing rollup warnings
   about external CDN URL imports in demo bundles are not migration bugs.
6. `npm test` (`oscd test`) — run and triage failures against footgun #5
   before assuming the migration broke something.
7. README — rewrite the "Tooling configs" section (and any other stale
   lint/build/test/format description) per footgun #4. Not optional, and not
   satisfied by leaving a TODO or flagging it for later.

## Anti-Patterns

- Never move `rootDir`/`outDir`/`include` into the shared base tsconfig —
  they must stay in each consuming project's own `tsconfig.json`.
- Never leave a local `"prettier"`/`"lint-staged"` package.json field behind
  "just in case" — it's dead config once migrated and misleads future
  readers into thinking it's still honored.
- Never drop a package that's imported directly by plugin/test/demo source
  just because `oscd-tooling` also happens to depend on it — that's an
  implementation detail of the CLI, not a guarantee for the plugin's own
  module graph.
- Never treat "CEM removal" as implied by "tooling migration" — get an
  explicit decision.
