# Footguns & anti-patterns

Read when triaging a surprise during migration (unexpected reformat diff,
resolution failure, test failure, CEM/README question).

## Footguns

1. **Prettier is dropped, not replaced.** `oscd-tooling`'s shared ESLint config
   formats via `@stylistic/eslint-plugin` rules, not Prettier. There is no
   equivalent "keep Prettier" path in the shared config today. Removing
   Prettier is a real behavior change worth calling out explicitly to plugin
   owners/reviewers, since it can produce a one-time reformat diff on the next
   `oscd lint --format` (though in practice, if the plugin's ESLint rules
   already matched Prettier's output, there may be zero diff).
2. **Phantom dependencies.** After pruning
   `devDependencies`/`dependencies`, always run a clean `npm install` (delete
   `package-lock.json` first if the plugin's lockfile predates the prune) and
   then exercise `demo/` and `test/` — packages that still resolve only because
   a sibling dependency happens to hoist them into `node_modules` are one
   dependency-graph change away from breaking.
3. **CEM/`custom-elements.json` is orthogonal to this migration.** No known
   OpenSCD runtime (shell, editor, oscd-api) reads `custom-elements.json` —
   it's only ever referenced via the standard
   `"customElements": "custom-elements.json"` package.json pointer, which
   nothing in this ecosystem currently consumes. `oscd analyze`/`--analyze`
   flags are opt-in wrappers around the same `cem analyze` call the plugin
   already ran; migrating tooling does not require keeping or dropping CEM
   generation. Decide this explicitly with the plugin owner and treat it as a
   separate scope item, not an automatic side effect of the tooling swap. If
   dropping it: delete `custom-elements.json`, the `analyze` script, the
   `customElements` package.json field, and any `--analyze` flags wired into
   `build`/`bundle`/`start` scripts.
4. **README boilerplate goes stale — fix it, don't replicate it.** A "Tooling
   configs" README section claiming "the configuration is in the
   `package.json`" is a leftover from before the `oscd-tooling` migration — it
   is factually wrong once configs live in `oscd-tooling`'s shared `configs/`.
   This was found stale in the reference migration (`oscd-editor-sld`) too, but
   "the reference repo is also stale" is not an acceptable precedent to copy
   forward. As part of *every* migration: rewrite the "Tooling configs" section
   (and any other README passage describing lint/build/test/format mechanics)
   to describe the actual `oscd <command>` / thin-wrapper-config setup, and
   correct the "What is this?" copy if it was ever copy-pasted from an
   unrelated plugin. Do not defer this to "someday" or leave it for the plugin
   owner to notice — treat a stale README as a migration defect to fix in the
   same pass, before considering the migration done.
5. **Don't assume test failures are migration-caused.** Compare failures
   against the underlying assertion logic, not the toolchain. For example, a
   `chai` `array.to.deep.include(partialObject)` assertion requires an exact
   deep-equal array member, not a partial-field match — a pre-existing test bug
   unrelated to swapping `@open-wc/testing`/WTR wiring. Confirm same
   `@open-wc/testing`/chai major version before vs. after to rule out a
   version-driven behavior change before concluding "pre-existing bug."

## Verification notes

- `npm install`: clean the lockfile if pruning heavily. Must complete without
  errors, and `prepare` (`oscd install-hooks`) must report success.
- `git config --get core.hooksPath` → `.githooks`, and
  `.githooks/{pre-commit,commit-msg}` exist.
- `npm run lint` (`oscd lint`) — passes; note any reformat diff caused by
  dropping Prettier.
- `npm run build` (`oscd build`) — succeeds, `dist/` contains expected
  `.js`/`.d.ts` output.
- `npm run bundle` (`oscd bundle`) — succeeds; pre-existing rollup warnings
  about external CDN URL imports in demo bundles are not migration bugs.
- `npm test` (`oscd test`) — run and triage failures against footgun 5 before
  assuming the migration broke something.
- README — rewrite the "Tooling configs" section (and any other stale
  lint/build/test/format description) per footgun 4. Not optional, and not
  satisfied by leaving a TODO or flagging it for later.

## Anti-patterns

- Never move `rootDir`/`outDir`/`include` into the shared base tsconfig — they
  must stay in each consuming project's own `tsconfig.json`.
- Never leave a local `"prettier"`/`"lint-staged"` package.json field behind
  "just in case" — it's dead config once migrated and misleads future readers
  into thinking it's still honored.
- Never drop a package that's imported directly by plugin/test/demo source just
  because `oscd-tooling` also happens to depend on it — that's an
  implementation detail of the CLI, not a guarantee for the plugin's own module
  graph.
- Never treat "CEM removal" as implied by "tooling migration" — get an explicit
  decision.
