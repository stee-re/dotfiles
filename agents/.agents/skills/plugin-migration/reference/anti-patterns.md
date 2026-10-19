# Migration anti-patterns

Mistakes to never repeat.

1. **Never skip the scaffold phase.** Use the template and destination resolved
   in the approved worklog, not historical workspace paths. A standalone-looking
   legacy tree does not establish suitable tooling; verify it against the
   agreed scaffold.

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

6. **Run implementation verification in order after structural changes:**
   `npm i` → `npx tsc --noEmit` → `npm run build`. Do not proceed until all
   three pass. Planning requires document/evidence checks, not installation.

7. **Never keep the only plan in the conversation or infer approval.**
   Populate the worklog, resolve blocking questions, then stop for review and
   explicit approval before copying code, scaffolding or transforming source.
