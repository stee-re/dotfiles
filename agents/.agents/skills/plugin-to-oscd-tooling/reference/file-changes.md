# File-by-file changes

Detail for step 2 of [`../SKILL.md`](../SKILL.md). Read when actually editing
`package.json`, `tsconfig.json`, `eslint.config.js`, hooks, or workflows.

## Why this migration exists

Most OpenSCD plugin repos each carry their own copy of the dev toolchain:
ESLint + `@typescript-eslint/*` + `@open-wc/eslint-config` + Prettier, Rollup +
plugins, Web Test Runner + Playwright, Web Dev Server, Custom Elements Manifest
analyzer, Husky + lint-staged + commitlint, `gh-pages`, `rimraf`,
`concurrently`, `npm-check-updates`, `typedoc`. Across many plugin repos this
is expensive to keep in sync and upgrade.

`@omicronenergy/oscd-tooling` centralizes all of this behind an `oscd` CLI:
`oscd lint`, `oscd build`, `oscd bundle`, `oscd test`, `oscd start`,
`oscd start-bundle`, `oscd analyze`, `oscd deploy`, `oscd updates`,
`oscd install-hooks`, `oscd commitlint`, `oscd lint-staged`,
`oscd install-playwright`. The CLI resolves every underlying tool binary and
shared config from within `oscd-tooling`'s own `node_modules`/`configs/`,
executed with the consuming repo as `process.cwd()`.

Read the package's own `README.md`
(`node_modules/@omicronenergy/oscd-tooling/README.md` once installed, or the
repo README) for the authoritative, up-to-date command and config list — this
skill captures the *migration recipe and footguns*, not a duplicate of that
reference.

A completed reference migration exists at `oscd-editor-sld` — diff against it
when in doubt about the target shape of
`package.json`/`tsconfig.json`/`eslint.config.js`.

## Pre-flight detail

1. Confirm the plugin's `src/*.spec.ts`/`*.test.ts` files' direct imports
   (e.g. `@open-wc/testing`, `sinon`). Anything imported directly by test or
   demo source must remain a **declared** dependency (dev or runtime, matching
   how it's imported) even after migration — `oscd`'s resolution of shared
   tools does not cover packages the plugin's own code imports by name.
2. Check `demo/*.html` for direct side-effect imports too (e.g.
   `@webcomponents/scoped-custom-element-registry`). These often already
   resolve after migration only because some *other* runtime dependency
   happens to pull them in transitively (a phantom dependency) — don't rely on
   that; declare them explicitly, mirroring how `oscd-editor-sld` keeps
   `@webcomponents/scoped-custom-element-registry` in `dependencies` because
   its demo imports it directly.
3. Note the current `"version"` of `@omicronenergy/oscd-tooling` on npm
   (`npm view @omicronenergy/oscd-tooling version`) to pin a sane `^` range.

## `package.json`

- `devDependencies`: delete every tool now owned by `oscd-tooling` (see its
  README's "Migrating a Plugin" section for the current list — ESLint stack,
  Rollup + plugins, `typescript`, `rimraf`, `concurrently`, WTR/WDS, CEM
  analyzer, `typedoc`, `gh-pages`, `husky`, `commitlint`/`@commitlint/*`,
  `lint-staged`, `npm-check-updates`, `prettier` +
  `eslint-plugin-prettier`/`eslint-config-prettier`, Playwright). Add
  `@omicronenergy/oscd-tooling`. Keep anything imported directly by
  plugin/test/demo source (pre-flight steps 1–2).
- Delete the top-level `"overrides"` pin for `playwright` unless there's a
  documented reason for it — `oscd-tooling` owns and pins its own Playwright
  version.
- Delete the top-level `"prettier"` and `"lint-staged"` keys. Once migrated,
  `oscd lint-staged` always uses the tooling package's own
  `lint-staged.config.js`, so a local `"lint-staged"` field becomes silently
  dead config, not an override.
- Rewrite `scripts` to call `oscd <command>` (see the tooling README for the
  full command list and flags like `--analyze`/`--no-clean`/`--watch`). Drop
  scripts for tools that no longer exist locally (e.g. a bare `update-deps`
  calling `npx npm-check-updates` becomes `oscd updates`).

## `tsconfig.json`

Replace with a thin extension of the shared base config, keeping only
project-relative paths locally (`outDir`, `rootDir`, `include`) — do not hoist
these into the shared config, TypeScript resolves them relative to the file
that declares them:

```json
{
  "extends": "@omicronenergy/oscd-tooling/configs/base.tsconfig.json",
  "compilerOptions": { "outDir": "dist", "rootDir": "src" },
  "include": ["src/**/*.ts"]
}
```

## `eslint.config.js`

Optional (not required by `oscd lint`, only useful for editor integration). If
kept, reduce to:

```js
import oscdEsLintConfig from '@omicronenergy/oscd-tooling/configs/eslint.config.js';
export default [...oscdEsLintConfig];
```

## Delete

`rollup.config.js`, `web-test-runner.config.js`, `web-dev-server.config.js`,
`commitlint.config.js`, `.husky/`.

## `.githooks/`

Don't hand-write it — run `npm run prepare` (mapped to `oscd install-hooks`)
after `npm install`; it generates `.githooks/{pre-commit,commit-msg}` and sets
`core.hooksPath` to `.githooks`. Verify with
`git config --get core.hooksPath`.

## `.github/workflows/*.yml`

Usually untouched if the repo already calls shared reusable workflows from
`oscd-gh-workflows`. Diff against a migrated reference plugin to confirm before
assuming no change is needed.
