---
name: oscd-ui
description: API reference and legacy mapping for @omicronenergy/oscd-ui component library. Load when replacing mwc-*, md-*, @scopedelement/material-web, @openenergytools/* UI components, or legacy OpenSCD icons.
---

# @omicronenergy/oscd-ui v0.0.12

Scoped Material Design and SCL-specific UI components for standalone OpenSCD plugins.

## Import Convention

Each component has two export paths:

- **`Oscd*.js`** — bare class, no global registration (for `ScopedElementsMixin` usage)
- **`oscd-*.js`** — calls `customElements.define(...)` and re-exports the class

**Always use the `Oscd*.js` path** in migrated plugins that use `ScopedElementsMixin`.

## Component Inventory

### Buttons

| Class | Import | Tag |
|---|---|---|
| `OscdElevatedButton` | `@omicronenergy/oscd-ui/button/OscdElevatedButton.js` | `oscd-elevated-button` |
| `OscdFilledButton` | `@omicronenergy/oscd-ui/button/OscdFilledButton.js` | `oscd-filled-button` |
| `OscdFilledTonalButton` | `@omicronenergy/oscd-ui/button/OscdFilledTonalButton.js` | `oscd-filled-tonal-button` |
| `OscdOutlinedButton` | `@omicronenergy/oscd-ui/button/OscdOutlinedButton.js` | `oscd-outlined-button` |
| `OscdTextButton` | `@omicronenergy/oscd-ui/button/OscdTextButton.js` | `oscd-text-button` |

### Icon & Icon Buttons

| Class | Import | Tag |
|---|---|---|
| `OscdIcon` | `@omicronenergy/oscd-ui/icon/OscdIcon.js` | `oscd-icon` |
| `OscdIconButton` | `@omicronenergy/oscd-ui/iconbutton/OscdIconButton.js` | `oscd-icon-button` |
| `OscdFilledIconButton` | `@omicronenergy/oscd-ui/iconbutton/OscdFilledIconButton.js` | `oscd-filled-icon-button` |
| `OscdFilledTonalIconButton` | `@omicronenergy/oscd-ui/iconbutton/OscdFilledTonalIconButton.js` | `oscd-filled-tonal-icon-button` |
| `OscdOutlinedIconButton` | `@omicronenergy/oscd-ui/iconbutton/OscdOutlinedIconButton.js` | `oscd-outlined-icon-button` |

### Form Controls

| Class | Import | Tag |
|---|---|---|
| `OscdCheckbox` | `@omicronenergy/oscd-ui/checkbox/OscdCheckbox.js` | `oscd-checkbox` |
| `OscdRadio` | `@omicronenergy/oscd-ui/radio/OscdRadio.js` | `oscd-radio` |
| `OscdSwitch` | `@omicronenergy/oscd-ui/switch/OscdSwitch.js` | `oscd-switch` |
| `OscdSlider` | `@omicronenergy/oscd-ui/slider/OscdSlider.js` | `oscd-slider` |
| `OscdFilledSelect` | `@omicronenergy/oscd-ui/select/OscdFilledSelect.js` | `oscd-filled-select` |
| `OscdOutlinedSelect` | `@omicronenergy/oscd-ui/select/OscdOutlinedSelect.js` | `oscd-outlined-select` |
| `OscdSelectOption` | `@omicronenergy/oscd-ui/select/OscdSelectOption.js` | `oscd-select-option` |
| `OscdFilledTextField` | `@omicronenergy/oscd-ui/textfield/OscdFilledTextField.js` | `oscd-filled-text-field` |
| `OscdOutlinedTextField` | `@omicronenergy/oscd-ui/textfield/OscdOutlinedTextField.js` | `oscd-outlined-text-field` |

### Lists & Menus

| Class | Import | Tag |
|---|---|---|
| `OscdList` | `@omicronenergy/oscd-ui/list/OscdList.js` | `oscd-list` |
| `OscdListItem` | `@omicronenergy/oscd-ui/list/OscdListItem.js` | `oscd-list-item` |
| `OscdMenu` | `@omicronenergy/oscd-ui/menu/OscdMenu.js` | `oscd-menu` |
| `OscdMenuItem` | `@omicronenergy/oscd-ui/menu/OscdMenuItem.js` | `oscd-menu-item` |
| `OscdSubMenu` | `@omicronenergy/oscd-ui/menu/OscdSubMenu.js` | `oscd-sub-menu` |

### Dialog

| Class | Import | Tag |
|---|---|---|
| `OscdDialog` | `@omicronenergy/oscd-ui/dialog/OscdDialog.js` | `oscd-dialog` |

### SCL-Specific Components

| Class | Import | Tag |
|---|---|---|
| `OscdActionList` | `@omicronenergy/oscd-ui/action-list/OscdActionList.js` | `oscd-action-list` |
| `OscdActionIcon` | `@omicronenergy/oscd-ui/action-icon/OscdActionIcon.js` | `oscd-action-icon` |
| `OscdActionPane` | `@omicronenergy/oscd-ui/action-pane/OscdActionPane.js` | `oscd-action-pane` |
| `OscdActionTree` | `@omicronenergy/oscd-ui/action-tree/OscdActionTree.js` | `oscd-action-tree` |
| `OscdSclCheckbox` | `@omicronenergy/oscd-ui/scl-checkbox/OscdSclCheckbox.js` | `oscd-scl-checkbox` |
| `OscdSclIcon` | `@omicronenergy/oscd-ui/scl-icon/OscdSclIcon.js` | `oscd-scl-icon` |
| `OscdSclSelect` | `@omicronenergy/oscd-ui/scl-select/OscdSclSelect.js` | `oscd-scl-select` |
| `OscdSclTextField` | `@omicronenergy/oscd-ui/scl-textfield/OscdSclTextField.js` | `oscd-scl-text-field` |
| `OscdTreeGrid` | `@omicronenergy/oscd-ui/tree-grid/OscdTreeGrid.js` | `oscd-tree-grid` |

**Note:** `OscdTreeGrid.js` also exports data types: `Tree` (`Partial<Record<string, TreeNode>>`), `TreeNode`, `TreeSelection`, `Path`. When the legacy `@openenergytools/tree-grid` was imported for the `Tree` type (not the component), use `import type { Tree } from '@omicronenergy/oscd-ui/tree-grid/OscdTreeGrid.js'`.


### Navigation & Layout

| Class | Import | Tag |
|---|---|---|
| `OscdNavigationDrawer` | `@omicronenergy/oscd-ui/navigation-drawer/OscdNavigationDrawer.js` | `oscd-navigation-drawer` |
| `OscdAppBar` | `@omicronenergy/oscd-ui/app-bar/OscdAppBar.js` | `oscd-app-bar` |
| `OscdDivider` | `@omicronenergy/oscd-ui/divider/OscdDivider.js` | `oscd-divider` |
| `OscdTabs` | `@omicronenergy/oscd-ui/tabs/OscdTabs.js` | `oscd-tabs` |
| `OscdPrimaryTab` | `@omicronenergy/oscd-ui/tabs/OscdPrimaryTab.js` | `oscd-primary-tab` |
| `OscdSecondaryTab` | `@omicronenergy/oscd-ui/tabs/OscdSecondaryTab.js` | `oscd-secondary-tab` |

### Progress & Feedback

| Class | Import | Tag |
|---|---|---|
| `OscdCircularProgress` | `@omicronenergy/oscd-ui/progress/OscdCircularProgress.js` | `oscd-circular-progress` |
| `OscdLinearProgress` | `@omicronenergy/oscd-ui/progress/OscdLinearProgress.js` | `oscd-linear-progress` |

### Chips

| Class | Import | Tag |
|---|---|---|
| `OscdAssistChip` | `@omicronenergy/oscd-ui/chips/OscdAssistChip.js` | `oscd-assist-chip` |
| `OscdChipSet` | `@omicronenergy/oscd-ui/chips/OscdChipSet.js` | `oscd-chip-set` |
| `OscdFilterChip` | `@omicronenergy/oscd-ui/chips/OscdFilterChip.js` | `oscd-filter-chip` |
| `OscdInputChip` | `@omicronenergy/oscd-ui/chips/OscdInputChip.js` | `oscd-input-chip` |
| `OscdSuggestionChip` | `@omicronenergy/oscd-ui/chips/OscdSuggestionChip.js` | `oscd-suggestion-chip` |

### Other

| Class | Import | Tag |
|---|---|---|
| `OscdRipple` | `@omicronenergy/oscd-ui/ripple/OscdRipple.js` | `oscd-ripple` |
| `OscdFocusRing` | `@omicronenergy/oscd-ui/focus/OscdFocusRing.js` | `oscd-focus-ring` |
| `OscdElevation` | `@omicronenergy/oscd-ui/elevation/OscdElevation.js` | `oscd-elevation` |
| `OscdFab` | `@omicronenergy/oscd-ui/fab/OscdFab.js` | `oscd-fab` |
| `OscdBrandedFab` | `@omicronenergy/oscd-ui/fab/OscdBrandedFab.js` | `oscd-branded-fab` |

### Labs (experimental)

| Class | Import | Tag |
|---|---|---|
| `OscdBadge` | `@omicronenergy/oscd-ui/labs/badge/OscdBadge.js` | `oscd-badge` |
| `OscdElevatedCard` | `@omicronenergy/oscd-ui/labs/card/OscdElevatedCard.js` | `oscd-elevated-card` |
| `OscdFilledCard` | `@omicronenergy/oscd-ui/labs/card/OscdFilledCard.js` | `oscd-filled-card` |
| `OscdOutlinedCard` | `@omicronenergy/oscd-ui/labs/card/OscdOutlinedCard.js` | `oscd-outlined-card` |
| `OscdItem` | `@omicronenergy/oscd-ui/labs/item/OscdItem.js` | `oscd-item` |
| `OscdNavigationBar` | `@omicronenergy/oscd-ui/labs/navigationbar/OscdNavigationBar.js` | `oscd-navigation-bar` |
| `OscdNavigationTab` | `@omicronenergy/oscd-ui/labs/navigationtab/OscdNavigationTab.js` | `oscd-navigation-tab` |
| `OscdOutlinedSegmentedButton` | `@omicronenergy/oscd-ui/labs/segmentedbutton/OscdOutlinedSegmentedButton.js` | `oscd-outlined-segmented-button` |
| `OscdOutlinedSegmentedButtonSet` | `@omicronenergy/oscd-ui/labs/segmentedbuttonset/OscdOutlinedSegmentedButtonSet.js` | `oscd-outlined-segmented-button-set` |

## Critical Usage Notes

### OscdMenuItem headline pattern

`<oscd-menu-item>` does NOT have a `headline` attribute. The headline is a **named slot**:

```typescript
// CORRECT
html`<oscd-menu-item @click=${handler}>
  <div slot="headline">${msg('Edit')}</div>
</oscd-menu-item>`

// WRONG (renders blank)
html`<oscd-menu-item headline="Edit" @click=${handler}></oscd-menu-item>`
```

### OscdIcon with SCL icons

`OscdIcon` checks if text content matches an SCL icon name from the `SCL_ICONS` record. If matched, renders the SVG. Otherwise falls through to Material Symbols font ligature.

Recognized SCL icon names: `gooseIcon`, `smvIcon`, `reportIcon`, `logIcon`

```typescript
// Renders SCL goose icon SVG
html`<oscd-icon>gooseIcon</oscd-icon>`
// Renders Material Symbols "edit" ligature
html`<oscd-icon>edit</oscd-icon>`
```

### Divider replacement

Replace `<li divider role="separator"></li>` with `<oscd-divider></oscd-divider>`. Update CSS selectors from `li[divider]` to `oscd-divider`.

## Legacy Mapping

### From `@scopedelement/material-web` (md-*)

| Legacy | oscd-ui Replacement |
|---|---|
| `MdRadio` from `.../radio/radio.js` | `OscdRadio` from `.../radio/OscdRadio.js` → `oscd-radio` |
| `MdDialog` from `.../dialog/MdDialog.js` | `OscdDialog` from `.../dialog/OscdDialog.js` → `oscd-dialog` |
| `MdIcon` from `.../icon/MdIcon.js` | `OscdIcon` from `.../icon/OscdIcon.js` → `oscd-icon` |
| `MdIconButton` from `.../iconbutton/MdIconButton.js` | `OscdIconButton` from `.../iconbutton/OscdIconButton.js` → `oscd-icon-button` |
| `MdOutlinedButton` from `.../button/MdOutlinedButton.js` | `OscdOutlinedButton` from `.../button/OscdOutlinedButton.js` → `oscd-outlined-button` |
| `MdCheckbox` from `.../checkbox/MdCheckbox.js` | `OscdCheckbox` from `.../checkbox/OscdCheckbox.js` → `oscd-checkbox` |
| `MdTextButton` from `.../button/MdTextButton.js` | `OscdTextButton` from `.../button/OscdTextButton.js` → `oscd-text-button` |

### From `@material/mwc-*` (deprecated MWC)

| Legacy | oscd-ui Replacement |
|---|---|
| `Icon` from `@material/mwc-icon` | `OscdIcon` → `oscd-icon` |
| `IconButton` from `@material/mwc-icon-button` | `OscdIconButton` → `oscd-icon-button` |
| `List` from `@material/mwc-list` | `OscdList` → `oscd-list` |
| `ListItem` from `@material/mwc-list/mwc-list-item.js` | `OscdListItem` → `oscd-list-item` |
| `CheckListItem` from `@material/mwc-list/mwc-check-list-item.js` | `OscdSelectionList` → `oscd-selection-list` (different API) |
| `Menu` from `@material/mwc-menu` | `OscdMenu` → `oscd-menu` |
| `Radio` from `@material/mwc-radio` | `OscdRadio` → `oscd-radio` |
| `Formfield` from `@material/mwc-formfield` | No direct equivalent — use plain `<label>` wrapping |

### From `@openenergytools/*`

| Legacy | oscd-ui Replacement |
|---|---|
| `ActionList`, `ActionItem` from `@openenergytools/filterable-lists/dist/ActionList.js` | `OscdActionList` → `oscd-action-list` |
| `SclCheckbox` from `@openenergytools/scl-checkbox` | `OscdSclCheckbox` → `oscd-scl-checkbox` |
| `SclSelect` from `@openenergytools/scl-select` | `OscdSclSelect` → `oscd-scl-select` |
| `SclTextField` from `@openenergytools/scl-text-field` | `OscdSclTextField` → `oscd-scl-text-field` |
| `TreeGrid`, `Tree` from `@openenergytools/tree-grid` | `OscdTreeGrid` → `oscd-tree-grid` |

### From `@openscd/open-scd/src/icons/icons.js`

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

### From legacy `<filtered-list>`

Replace with `OscdActionList` or `OscdSelectionList` depending on the use case. The APIs are NOT identical — verify filter, selection, and event behavior.

## Dependencies

- `lit ^3.3.0`
- `@omicronenergy/oscd-material-web-base ^2.4.0`
- `@open-wc/scoped-elements ^3.0.5`
