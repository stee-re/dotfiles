---
name: oscd-ui
description: Load when a plugin imports @material/mwc-*, md-*, @scopedelement/material-web, @openenergytools/* UI, or OpenSCD icons, or when you need an @omicronenergy/oscd-ui import path, tag, or API detail.
---

# @omicronenergy/oscd-ui API Reference

**Use when**

- You need the exact import path, tag, or API of an oscd-ui component.
- You are replacing `@material/mwc-*`, `md-*`, `@scopedelement/material-web`, `@openenergytools/*` UI, `@openscd/open-scd` icons, or `<filtered-list>`.

**Don't use for** — the mwc-* migration procedure, FAB/dialog recipes, `--mdc-*` cleanup: `mwc-to-oscd-ui`. Icon-helper replacement: `scl-icons`. Filtered-list behavior parity: `filtered-list-to-oscd-ui`. Scoped registration mechanics: `scoped-elements`.

## Package

- `@omicronenergy/oscd-ui` v0.0.12 — scoped Material Design and SCL-specific components for standalone OpenSCD plugins.
- Peers: `lit ^3.3.0`, `@omicronenergy/oscd-material-web-base ^2.4.0`, `@open-wc/scoped-elements ^3.0.5`.

## Import convention

- **`Oscd*.js`** — bare class, no global registration (for `ScopedElementsMixin` usage)
- **`oscd-*.js`** — calls `customElements.define(...)` and re-exports the class

**Always use the `Oscd*.js` path** in migrated plugins that use `ScopedElementsMixin`.

## Symbol index

| Symbols | Documented in |
|---|---|
| All `Oscd*` classes/tags (buttons, icons, form controls, lists, menus, dialog, SCL-specific, navigation, progress, chips, FAB, labs); `Tree`, `TreeNode`, `TreeSelection`, `Path` | `reference/component-inventory.md` |
| Legacy `Md*`, `mwc-*`, `@openenergytools/*`, icon helpers, `<filtered-list>` | `reference/legacy-mapping.md` |
| `OscdMenuItem` headline slot, `OscdIcon` / `SCL_ICONS`, `OscdDivider` | `reference/usage-notes.md` |

## Verify

- `npx tsc --noEmit` — catches wrong import paths and missing exports.
- Every rendered hyphenated tag is a `scopedElements` key spelled identically, else it silently fails to resolve.
- Render it (unit or VTR harness): wrong slot names render blank without error.

## Reference

| File | Read when |
|---|---|
| `reference/component-inventory.md` | You need an exact import path or tag, or the `OscdTreeGrid` data types. |
| `reference/legacy-mapping.md` | You need the replacement for a legacy component or icon helper. |
| `reference/usage-notes.md` | Before writing templates using `oscd-menu-item`, `oscd-icon`, or `oscd-divider`. |
