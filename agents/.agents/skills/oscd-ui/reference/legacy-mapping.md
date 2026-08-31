# Legacy → oscd-ui Mapping

Single source of truth for legacy component replacement. Referenced by the
`mwc-to-oscd-ui` migration recipe.

## From `@material/mwc-*` (deprecated MWC)

| Legacy | oscd-ui Replacement | Tag |
|---|---|---|
| `Icon` / `mwc-icon` from `@material/mwc-icon` | `OscdIcon` | `oscd-icon` |
| `IconButton` / `mwc-icon-button` from `@material/mwc-icon-button` | `OscdIconButton` | `oscd-icon-button` |
| `mwc-icon-button-toggle` from `@material/mwc-icon-button-toggle` | `OscdIconButton` with `toggle` + `selected` | `oscd-icon-button` |
| `mwc-fab` from `@material/mwc-fab` | `OscdFab` | `oscd-fab` |
| `mwc-button` from `@material/mwc-button` | `OscdButton` | `oscd-button` |
| `mwc-dialog` from `@material/mwc-dialog` | `OscdDialog` | `oscd-dialog` |
| `mwc-textfield` from `@material/mwc-textfield` | `OscdTextField` | `oscd-text-field` |
| `List` / `mwc-list` from `@material/mwc-list` | `OscdList` | `oscd-list` |
| `ListItem` / `mwc-list-item` from `@material/mwc-list/mwc-list-item.js` | `OscdListItem` | `oscd-list-item` |
| `CheckListItem` / `mwc-check-list-item` from `@material/mwc-list/mwc-check-list-item.js` | `OscdSelectionList` (different API) | `oscd-selection-list` |
| `Menu` / `mwc-menu` from `@material/mwc-menu` | `OscdMenu` | `oscd-menu` |
| `Radio` / `mwc-radio` from `@material/mwc-radio` | `OscdRadio` | `oscd-radio` |
| `Formfield` / `mwc-formfield` from `@material/mwc-formfield` | No direct equivalent — use plain `<label>` wrapping | — |

## From `@scopedelement/material-web` (md-*)

| Legacy | oscd-ui Replacement |
|---|---|
| `MdRadio` from `.../radio/radio.js` | `OscdRadio` from `.../radio/OscdRadio.js` → `oscd-radio` |
| `MdDialog` from `.../dialog/MdDialog.js` | `OscdDialog` from `.../dialog/OscdDialog.js` → `oscd-dialog` |
| `MdIcon` from `.../icon/MdIcon.js` | `OscdIcon` from `.../icon/OscdIcon.js` → `oscd-icon` |
| `MdIconButton` from `.../iconbutton/MdIconButton.js` | `OscdIconButton` from `.../iconbutton/OscdIconButton.js` → `oscd-icon-button` |
| `MdOutlinedButton` from `.../button/MdOutlinedButton.js` | `OscdOutlinedButton` from `.../button/OscdOutlinedButton.js` → `oscd-outlined-button` |
| `MdCheckbox` from `.../checkbox/MdCheckbox.js` | `OscdCheckbox` from `.../checkbox/OscdCheckbox.js` → `oscd-checkbox` |
| `MdTextButton` from `.../button/MdTextButton.js` | `OscdTextButton` from `.../button/OscdTextButton.js` → `oscd-text-button` |

## From `@openenergytools/*`

| Legacy | oscd-ui Replacement |
|---|---|
| `ActionList`, `ActionItem` from `@openenergytools/filterable-lists/dist/ActionList.js` | `OscdActionList` → `oscd-action-list` |
| `SclCheckbox` from `@openenergytools/scl-checkbox` | `OscdSclCheckbox` → `oscd-scl-checkbox` |
| `SclSelect` from `@openenergytools/scl-select` | `OscdSclSelect` → `oscd-scl-select` |
| `SclTextField` from `@openenergytools/scl-text-field` | `OscdSclTextField` → `oscd-scl-text-field` |
| `TreeGrid`, `Tree` from `@openenergytools/tree-grid` | `OscdTreeGrid` → `oscd-tree-grid` |

## From `@openscd/open-scd/src/icons/icons.js`

Delete local SVG icon files. Use `OscdIcon` with SCL icon text names:

```typescript
// Before
import { gooseIcon } from '../foundation/icons.js';
html`<mwc-icon slot="graphic">${gooseIcon}</mwc-icon>`

// After
html`<oscd-icon slot="start">gooseIcon</oscd-icon>`
```

For control block type lookups:

```typescript
const controlBlockIconName: Record<string, string> = {
  ReportControl: 'reportIcon',
  LogControl: 'logIcon',
  GSEControl: 'gooseIcon',
  SampledValueControl: 'smvIcon',
};
html`<oscd-icon>${controlBlockIconName[controlTag]}</oscd-icon>`
```

## From legacy `<filtered-list>`

Replace with `OscdActionList` or `OscdSelectionList` depending on the use case. The APIs are NOT identical — verify filter, selection, and event behavior.
