---
name: plugin-to-oscd-tooling
description: Read when moving an OpenSCD plugin onto the shared `@omicronenergy/oscd-tooling` CLI, or when its package.json still declares local eslint/rollup/wtr/husky devDeps.
---

# Migrate a Plugin to `@omicronenergy/oscd-tooling`

**Use when** swapping a plugin's local dev toolchain for the shared `oscd` CLI,
or pruning duplicated tooling devDeps.

**Don't use for** — `plugin-migration` orchestrates monorepo → standalone
migration; `legacy-*`, `mwc-to-oscd-ui`, `editv1-to-editv2` convert source.
This skill touches build config only.

## Problem

Every plugin repo duplicates ESLint/Prettier, Rollup, WTR/WDS, CEM, Husky,
commitlint and helper devDependencies — costly to keep in sync.
`@omicronenergy/oscd-tooling` centralizes them behind an `oscd` CLI resolving
binaries and shared configs from its own package, run with the plugin as `cwd`.
Reference migration: `oscd-editor-sld`.

## Procedure

1. **Pre-flight.** Note direct imports in `src/*.spec.ts`/`*.test.ts` and
   `demo/*.html` — those stay declared. Read the tooling version to pin.
2. **Edit `package.json`**: prune tool devDeps, add
   `@omicronenergy/oscd-tooling`, drop `overrides`/`prettier`/`lint-staged`,
   rewrite `scripts` to `oscd <command>`.
3. **Edit configs**: thin `tsconfig.json`, optional thin `eslint.config.js`;
   delete rollup/WTR/WDS/commitlint configs and `.husky/`; generate `.githooks/`
   via `npm run prepare`; workflows usually untouched.
4. **Decide CEM explicitly** with the owner — keep or drop
   `custom-elements.json`. Separate scope, never implied.
5. **Fix the README** same pass; stale lint/build/test prose is a defect.

## Pitfalls

- Prettier is dropped, not replaced — expect a one-time reformat diff.
- Phantom deps: reinstall clean, then exercise `demo/` and `test/`.
- Never hoist `rootDir`/`outDir`/`include` into the shared base tsconfig.
- Never drop a package the plugin's own source imports by name.
- Triage test failures against assertion logic before blaming migration.

## Verify

After every structural change, not only at the end:

1. `npm install` (+ `prepare` hook install succeeds)
2. `git config --get core.hooksPath` → `.githooks`
3. `npm run lint`
4. `npm run build`
5. `npm run bundle`
6. `npm test`
7. README rewritten

## Reference

| File | Read when |
|---|---|
| [`reference/file-changes.md`](reference/file-changes.md) | Editing files: `oscd` commands, full prune list, config bodies, hooks/workflow detail. |
| [`reference/footguns.md`](reference/footguns.md) | A surprise appears: reformat diff, resolution failure, CEM/README scope, test triage, anti-patterns. |
