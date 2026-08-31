# oscd-ui Component Inventory

Class → import path → tag. Use the `Oscd*.js` path for `ScopedElementsMixin` plugins.

## Buttons

| Class | Import | Tag |
|---|---|---|
| `OscdElevatedButton` | `@omicronenergy/oscd-ui/button/OscdElevatedButton.js` | `oscd-elevated-button` |
| `OscdFilledButton` | `@omicronenergy/oscd-ui/button/OscdFilledButton.js` | `oscd-filled-button` |
| `OscdFilledTonalButton` | `@omicronenergy/oscd-ui/button/OscdFilledTonalButton.js` | `oscd-filled-tonal-button` |
| `OscdOutlinedButton` | `@omicronenergy/oscd-ui/button/OscdOutlinedButton.js` | `oscd-outlined-button` |
| `OscdTextButton` | `@omicronenergy/oscd-ui/button/OscdTextButton.js` | `oscd-text-button` |

## Icon & Icon Buttons

| Class | Import | Tag |
|---|---|---|
| `OscdIcon` | `@omicronenergy/oscd-ui/icon/OscdIcon.js` | `oscd-icon` |
| `OscdIconButton` | `@omicronenergy/oscd-ui/iconbutton/OscdIconButton.js` | `oscd-icon-button` |
| `OscdFilledIconButton` | `@omicronenergy/oscd-ui/iconbutton/OscdFilledIconButton.js` | `oscd-filled-icon-button` |
| `OscdFilledTonalIconButton` | `@omicronenergy/oscd-ui/iconbutton/OscdFilledTonalIconButton.js` | `oscd-filled-tonal-icon-button` |
| `OscdOutlinedIconButton` | `@omicronenergy/oscd-ui/iconbutton/OscdOutlinedIconButton.js` | `oscd-outlined-icon-button` |

## Form Controls

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

## Lists & Menus

| Class | Import | Tag |
|---|---|---|
| `OscdList` | `@omicronenergy/oscd-ui/list/OscdList.js` | `oscd-list` |
| `OscdListItem` | `@omicronenergy/oscd-ui/list/OscdListItem.js` | `oscd-list-item` |
| `OscdMenu` | `@omicronenergy/oscd-ui/menu/OscdMenu.js` | `oscd-menu` |
| `OscdMenuItem` | `@omicronenergy/oscd-ui/menu/OscdMenuItem.js` | `oscd-menu-item` |
| `OscdSubMenu` | `@omicronenergy/oscd-ui/menu/OscdSubMenu.js` | `oscd-sub-menu` |

## Dialog

| Class | Import | Tag |
|---|---|---|
| `OscdDialog` | `@omicronenergy/oscd-ui/dialog/OscdDialog.js` | `oscd-dialog` |

## SCL-Specific Components

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

## Navigation & Layout

| Class | Import | Tag |
|---|---|---|
| `OscdNavigationDrawer` | `@omicronenergy/oscd-ui/navigation-drawer/OscdNavigationDrawer.js` | `oscd-navigation-drawer` |
| `OscdAppBar` | `@omicronenergy/oscd-ui/app-bar/OscdAppBar.js` | `oscd-app-bar` |
| `OscdDivider` | `@omicronenergy/oscd-ui/divider/OscdDivider.js` | `oscd-divider` |
| `OscdTabs` | `@omicronenergy/oscd-ui/tabs/OscdTabs.js` | `oscd-tabs` |
| `OscdPrimaryTab` | `@omicronenergy/oscd-ui/tabs/OscdPrimaryTab.js` | `oscd-primary-tab` |
| `OscdSecondaryTab` | `@omicronenergy/oscd-ui/tabs/OscdSecondaryTab.js` | `oscd-secondary-tab` |

## Progress & Feedback

| Class | Import | Tag |
|---|---|---|
| `OscdCircularProgress` | `@omicronenergy/oscd-ui/progress/OscdCircularProgress.js` | `oscd-circular-progress` |
| `OscdLinearProgress` | `@omicronenergy/oscd-ui/progress/OscdLinearProgress.js` | `oscd-linear-progress` |

## Chips

| Class | Import | Tag |
|---|---|---|
| `OscdAssistChip` | `@omicronenergy/oscd-ui/chips/OscdAssistChip.js` | `oscd-assist-chip` |
| `OscdChipSet` | `@omicronenergy/oscd-ui/chips/OscdChipSet.js` | `oscd-chip-set` |
| `OscdFilterChip` | `@omicronenergy/oscd-ui/chips/OscdFilterChip.js` | `oscd-filter-chip` |
| `OscdInputChip` | `@omicronenergy/oscd-ui/chips/OscdInputChip.js` | `oscd-input-chip` |
| `OscdSuggestionChip` | `@omicronenergy/oscd-ui/chips/OscdSuggestionChip.js` | `oscd-suggestion-chip` |

## Other

| Class | Import | Tag |
|---|---|---|
| `OscdRipple` | `@omicronenergy/oscd-ui/ripple/OscdRipple.js` | `oscd-ripple` |
| `OscdFocusRing` | `@omicronenergy/oscd-ui/focus/OscdFocusRing.js` | `oscd-focus-ring` |
| `OscdElevation` | `@omicronenergy/oscd-ui/elevation/OscdElevation.js` | `oscd-elevation` |
| `OscdFab` | `@omicronenergy/oscd-ui/fab/OscdFab.js` | `oscd-fab` |
| `OscdBrandedFab` | `@omicronenergy/oscd-ui/fab/OscdBrandedFab.js` | `oscd-branded-fab` |

## Labs (experimental)

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
