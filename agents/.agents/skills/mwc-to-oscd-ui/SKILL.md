---
name: mwc-to-oscd-ui
description: Replace deprecated mwc-* Material Web Components with @omicronenergy/oscd-ui scoped equivalents. Load during Step 5 UI migration.
---

# Recipe: Replace mwc-* With oscd-ui Scoped Components

## Inventory (subscriber migration set)

| `mwc-*` component | oscd-ui replacement | Tag |
|---|---|---|
| `mwc-icon` (`@material/mwc-icon`) | `OscdIcon` | `oscd-icon` |
| `mwc-icon-button` (`@material/mwc-icon-button`) | `OscdIconButton` | `oscd-icon-button` |
| `mwc-icon-button-toggle` (`@material/mwc-icon-button-toggle`) | `OscdIconButton` with `toggle` + `selected` | `oscd-icon-button` |
| `mwc-fab` (`@material/mwc-fab`) | `OscdFab` | `oscd-fab` |
| `mwc-button` (`@material/mwc-button`) | `OscdButton` | `oscd-button` |
| `mwc-dialog` (`@material/mwc-dialog`) | `OscdDialog` | `oscd-dialog` |
| `mwc-textfield` (`@material/mwc-textfield`) | `OscdTextField` | `oscd-text-field` |
| `mwc-list` (`@material/mwc-list`) | `OscdList` | `oscd-list` |
| `mwc-list-item` (`@material/mwc-list/mwc-list-item.js`) | `OscdListItem` | `oscd-list-item` |
| `mwc-check-list-item` (`@material/mwc-list/mwc-check-list-item.js`) | `OscdSelectionList` | `oscd-selection-list` (different API) |
| `mwc-menu` (`@material/mwc-menu`) | `OscdMenu` | `oscd-menu` |
| `mwc-radio` (`@material/mwc-radio`) | `OscdRadio` | `oscd-radio` |
| `mwc-formfield` (`@material/mwc-formfield`) | No direct equivalent — use plain `<label>` wrapping | — |

## Divider Replacement

```ts
// Before
html`<li divider role="separator"></li>`
// After
html`<oscd-divider></oscd-divider>`
```

Import `OscdDivider` from `@omicronenergy/oscd-ui/divider/OscdDivider.js`, register as `'oscd-divider'` in `scopedElements`. Update CSS from `li[divider]` to `oscd-divider`.

## FAB Migration (mwc-fab → oscd-fab)

### Critical Differences

The MD3 FAB has fundamentally different API behavior from MWC FAB:

| MWC (`mwc-fab`) | MD3 (`oscd-fab`) | Impact |
|---|---|---|
| `mini` attribute | `size="small"` | Shape changes (see below) |
| `icon="name"` renders icon internally | `icon` attribute does NOTHING | Must use slotted `<oscd-icon>` |
| `label="text"` is accessibility-only on mini | `label="text"` makes FAB **extended** (visually shows text) | Buttons become wide pills |
| Circular shape (50% radius) | Rounded-square (12px radius for small) | Must override with CSS token |
| `--mdc-theme-secondary` / `--mdc-theme-on-secondary` | `--md-fab-container-color` / `--md-fab-icon-color` | Different token names |
| No touch-target margin | Adds margin via `:host([size=small][touch-target=wrapper])` | Causes vertical offset in inline layouts |

### Correct Pattern

```html
<!-- ❌ WRONG — icon attr does nothing, label extends the FAB -->
<oscd-fab size="small" icon="add" label="Add Item" title="Add Item"></oscd-fab>

<!-- ✅ CORRECT — slotted icon, aria-label for a11y, title for tooltip -->
<oscd-fab size="small" aria-label="Add Item" title="Add Item">
  <oscd-icon slot="icon">add</oscd-icon>
</oscd-fab>
```

### Required CSS for Circular Small FABs

```css
oscd-fab {
  --md-fab-container-color: #fff;
  --md-fab-icon-color: rgb(0, 0, 0 / 0.83);
  --md-fab-small-container-shape: 50%;  /* circular, not rounded-square */
}
```

### Container Layout Fix

When FABs are in an inline-flow container (e.g. `<nav>`), the MD3 touch-target wrapper margin causes vertical misalignment. Fix by making the container a flex container:

```css
nav {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  column-gap: 4px;
  row-gap: 8px;
}
```

**Important**: Switching to flex collapses whitespace-based spacing between inline elements. You MUST add explicit `gap` to compensate.

### Custom-Colored FABs

```html
<!-- MWC -->
<mwc-fab mini style="--mdc-theme-secondary: #12579B; --mdc-theme-on-secondary: white;">

<!-- MD3 -->
<oscd-fab size="small" style="--md-fab-container-color: #12579B; --md-fab-icon-color: white;">
```

### SVG Icons in FABs

SVG icons slotted into FABs must have `slot="icon"` and should use `stroke="currentColor"` or `fill="currentColor"` to inherit `--md-fab-icon-color` via the CSS `color` property set on `::slotted(*)`.

## IconButtonToggle Migration (mwc-icon-button-toggle → oscd-icon-button)

```html
<!-- MWC -->
<mwc-icon-button-toggle id="labels" onIcon="font_download" offIcon="font_download_off" ?on=${this.showLabels} @icon-button-toggle-change=${...}>
</mwc-icon-button-toggle>

<!-- MD3 -->
<oscd-icon-button id="labels" toggle ?selected=${this.showLabels} @change=${...}>
  <oscd-icon>font_download_off</oscd-icon>
  <oscd-icon slot="selected">font_download</oscd-icon>
</oscd-icon-button>
```

- `.on` property → `.selected` property
- `@icon-button-toggle-change` event → `@change` event
- Icon names go in slotted children, not attributes

## Menu / List Item Colors (mwc-list-item → oscd-menu-item / oscd-list-item)

**FOOTGUN: `--mdc-theme-*` is silently ignored by M3 components.** oscd-ui has zero
`--mdc-theme-*` references, so leftover mwc colour vars set via `style=` resolve to
nothing and the element renders default on-surface — colourless, no error. Always
swap to the M3 component tokens:

| MWC (dead in oscd-ui) | MD3 replacement |
| --- | --- |
| `--mdc-theme-text-primary-on-background` | `--md-menu-item-label-text-color` |
| `--mdc-theme-text-icon-on-background` | `--md-menu-item-leading-icon-color` |

```ts
// MWC (renders nothing on oscd-menu-item)
style: '--mdc-theme-text-primary-on-background: #BB1326; --mdc-theme-text-icon-on-background: #BB1326;'
// MD3
style: '--md-menu-item-label-text-color: #BB1326; --md-menu-item-leading-icon-color: #BB1326;'
```

Prefer semantic tokens for cues (e.g. destructive → `var(--md-sys-color-error, …)`).

## Dialog Migration (mwc-dialog → oscd-dialog)

```html
<!-- MWC -->
<mwc-dialog heading="Title">
  <content/>
  <mwc-button slot="primaryAction" dialogAction="ok">OK</mwc-button>
  <mwc-button slot="secondaryAction" dialogAction="close">Cancel</mwc-button>
</mwc-dialog>

<!-- MD3 -->
<oscd-dialog>
  <span slot="headline">Title</span>
  <content slot="content"/>
  <oscd-button slot="actions" @click=${() => { this.dialog.open = false; }}>Cancel</oscd-button>
  <oscd-button slot="actions" @click=${handleOk}>OK</oscd-button>
</oscd-dialog>
```

- `heading` attr → `<span slot="headline">`
- Content must be in `slot="content"`
- `dialogAction` removed — use explicit `@click` to close
- `.show()` → `.open = true`
- `.close()` → `.open = false`

## Container Width (100vw → 100cqi)

When a plugin uses `max-width: calc(100vw - Npx)` to constrain overflow, replace with container queries:

```css
:host {
  display: block;
  container-type: inline-size;
}

/* Use 100cqi instead of 100vw */
nav {
  max-width: calc(100cqi - 32px);
}
```

This ensures the component responds to its actual available width (e.g. when a side panel is present) rather than the full viewport.

## Required Edits

- Remove deprecated `@material/mwc-*` imports
- Import `@omicronenergy/oscd-ui` equivalents (use `Oscd*.js` path for scoped usage)
- Replace `mwc-*` tags with `oscd-*` tags in templates
- Register in `scopedElements` — **the key MUST match the tag used in templates**
- Update styling hooks where required
- Check event names/payloads differ and update handlers
- Preserve keyboard behavior and accessibility

## CRITICAL: scopedElements Key Must Match Template Tag

When replacing tags, the `scopedElements` key and the tag in the template must be identical. Example:

```typescript
// ✅ CORRECT — key matches template tag
static scopedElements = {
  'oscd-action-list': OscdActionList,  // template uses <oscd-action-list>
};

// ❌ WRONG — key doesn't match template tag
static scopedElements = {
  'action-list': OscdActionList,  // but template uses <oscd-action-list> → won't resolve!
};
```

**Verification step**: After all replacements, for every file with `scopedElements`:
1. Extract all hyphenated tags from `render()` and sub-render methods
2. Confirm each tag appears as a key in `scopedElements`
3. For classes extending a base class, also check tags used in the base's renderers — the subclass must register those too

## Anti-Patterns

- Big-bang replacement without intermediate verification
- Mixing deprecated mwc-* and new oscd-* in the same component tree
- Preserving deprecated UI because styling is inconvenient
- Ignoring accessibility or keyboard regressions

## Verification

- **MUST: full scan before "done"** — grep the whole tree for `mwc` and `--mdc-`; the migration is not complete until there are **zero** occurrences (imports, tags, or CSS vars). Residual `--mdc-*` vars are inert on M3 components and fail silently.
- No `@material/mwc-*` imports remain where oscd-ui equivalent exists
- No residual `--mdc-theme-*` vars (grep `mdc-theme`); they are inert on M3 components
- UI renders and behaves correctly
- Event handlers fire as expected
- Accessibility and keyboard interactions intact

## Known Exceptions

- If oscd-ui does not expose a needed equivalent, keep current implementation and record gap
- `mwc-check-list-item` has no 1:1 equivalent — `OscdSelectionList` has different API
- `mwc-formfield` has no equivalent — use plain `<label>` wrapping
- `mwc-snackbar` has no oscd-ui equivalent — keep `@material/mwc-snackbar` temporarily
