---
name: adapt-menu-template
description: Reshape the oscd-template-menu standalone template into an editor plugin — class rename, ScopedElementsMixin, lit imports, docVersion, test and demo wiring.
---

# Adapt Menu Template to Editor Plugin

**Use when**
- `src/oscd-template-menu.ts` still exists in a scaffolded standalone plugin.
- `oscd-template-menu` / `OscdTemplateMenu` identifiers remain anywhere in the package.
- The entry point still uses `lit-element`, `@customElement`, `editCount`, or side-effect child imports.

**Don't use for** — forbidden monorepo imports in the entry point: `$legacy-foundation-helpers` (`@openscd/open-scd` foundation), `$lit-translate-to-lit-localize` (translation), `$scoped-elements` (general scoped registration rules).

## Problem

The standalone template is menu-oriented (`oscd-template-menu`), running on demand via `run()`. Editor plugins render immediately and take `doc` / `docVersion`. The template must be reshaped and every template identifier renamed.

## Procedure

1. Replace `src/oscd-template-menu.ts` with the legacy entry point content.
2. Apply transformations a-j from `reference/transformations.md` (rename, lit imports, ScopedElementsMixin, scopedElements, `editCount` → `docVersion`, `.js` extensions, decorator removal, property pruning).
3. Rename all template identifiers across src, tests, `custom-elements.json`, README, demo, and `package.json`; wire the demo — see `reference/rename-and-demo.md`.
4. Remove menu-only test logic such as `await plugin.run()`.

## Pitfalls

- Replacing the Source Editor in `demo/plugins.js` instead of adding alongside it.
- Leaving side-effect imports for children now listed in `scopedElements`.
- Adding an `editor` property (only needed after Step 3).

## Verify

- `grep -ri 'oscd-template-menu\|OscdTemplateMenu' output/<plugin>/` returns no matches
- Main source extends `ScopedElementsMixin(LitElement)`
- Has `static scopedElements` listing all rendered children
- No side-effect imports for scoped children
- No `editCount` remains
- No `@customElement` decorator on entry point
- All relative imports have `.js` extensions
- All `lit-element` imports rewritten to `lit` / `lit/decorators.js`

## Reference

| File | Read when |
|---|---|
| `reference/transformations.md` | Editing the main source file (steps a-j) |
| `reference/rename-and-demo.md` | Renaming template identifiers or wiring `demo/plugins.js` |
