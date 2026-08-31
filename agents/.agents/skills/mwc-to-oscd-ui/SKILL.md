---
name: mwc-to-oscd-ui
description: Load when replacing @material/mwc-* imports, mwc-* tags, or inert --mdc-* CSS vars with @omicronenergy/oscd-ui scoped equivalents (Step 5 UI migration).
---

# Replace mwc-* With oscd-ui Scoped Components

**Use when**

- A plugin imports `@material/mwc-*` or renders `mwc-*` tags.
- Styles still set `--mdc-*` custom properties.

**Don't use for** — oscd-ui import paths, tags, APIs: `oscd-ui`. Icon helpers: `scl-icons`. Filtered-list parity: `filtered-list-to-oscd-ui`. `ScopedElementsMixin` setup: `scoped-elements`.

## Problem

MWC is deprecated and its M3 successors are not drop-in: attributes become slots, event names change, and `--mdc-*` tokens are inert on M3, failing silently.

## Procedure

1. Remove `@material/mwc-*` imports; import `@omicronenergy/oscd-ui` equivalents via the `Oscd*.js` path.
2. Replace `mwc-*` tags with `oscd-*` tags in templates.
3. Register each replacement in `scopedElements` — **the key MUST equal the template tag**, else it won't resolve.
4. Swap dead `--mdc-theme-*` vars for M3 component tokens.
5. Update handlers where event names/payloads differ.
6. Update selectors that reference the old tag names — CSS rules, and `@query` /
   `@queryAll` decorators.
7. Remove the old UI dependencies from `package.json`.
8. Preserve keyboard behavior and accessibility.

## Pitfalls

- Leaving `--mdc-*` vars in place: inert on M3, no error, colourless render.
- `scopedElements` key not spelled exactly like the template tag.
- Big-bang replacement without intermediate verification; more in `reference/pitfalls.md`.

## Verify

- **Full scan before "done"**: `grep -rn "mwc\|--mdc-" src` must return **zero** hits (imports, tags, CSS vars).
- No `@material/mwc-*` imports remain where an oscd-ui equivalent exists.
- UI renders correctly; handlers fire; keyboard and accessibility intact.

## Reference

| File | Read when |
|---|---|
| `../oscd-ui/reference/legacy-mapping.md` | You need the replacement for a specific `mwc-*` component. |
| `reference/fab-migration.md` | The plugin uses `mwc-fab`. |
| `reference/component-recipes.md` | Migrating `mwc-icon-button-toggle`, `mwc-dialog`, `li[divider]`. |
| `reference/styling-tokens.md` | Touching styles: `--mdc-theme-*` → M3 tokens, `100vw` → `100cqi`. |
| `reference/pitfalls.md` | Auditing `scopedElements` keys, or a component has no equivalent (`mwc-check-list-item`, `mwc-formfield`, `mwc-snackbar`). |

