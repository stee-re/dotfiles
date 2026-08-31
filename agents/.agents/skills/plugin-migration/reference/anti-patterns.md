# Migration anti-patterns

Mistakes to never repeat.

1. **Never skip step 2.** Even if a legacy plugin "looks standalone", it must be
   scaffolded from `template/oscd-template-menu/`. The template defines canonical
   config: `"type": "module"`, `NodeNext` resolution, `src/` directory, correct
   scripts, modern devDeps. Copying a legacy repo inherits broken tooling.

2. **Never apply source transforms before the project structure is correct.**
   Steps 3+ assume source lives in `src/`, builds to `dist/`, and that `npm i`
   and `npm run build` work. Verify the foundation first.

3. **Verify `npm i` immediately after any structural change** — not just
   `tsc --noEmit`. A full `npm i` exercises prepare/prepublish hooks and catches
   config issues early.

4. **`rootDir` must be `./src`.** If `rootDir` is `./`, tsc outputs to
   `dist/src/...` or worse, may overwrite source. Match the template's tsconfig.

5. **Demo `plugins.js` must use the shell's plugin contract.** `oscd-shell`
   accepts both `tagName` (pre-registered) and `src` (dynamically loaded and
   registered). Local plugins use `tagName` with `registry.define()`. Remote
   plugins use a `src` URL. Never mix — an entry needs one or the other, not both.

6. **Run verification in order after every step:** `npm i` → `tsc --noEmit` →
   `npm run build`. Do not proceed until all three pass.
