---
name: scl-icons
description: Replace legacy OpenSCD SVG icon helpers with oscd-ui OscdIcon component using SCL_ICONS text-based lookup. Load during Step 5 icon migration.
---

# Recipe: Replace Legacy Icons With OscdIcon

## Problem

Legacy plugins define local SVG icon constants (`gooseIcon`, `smvIcon`) or import from `@openscd/open-scd/src/icons/icons.js`. Standalone plugins use `OscdIcon` which handles both SCL icons and Material Symbols.

## How OscdIcon Works

`OscdIcon` checks if text content matches an SCL icon name from the `SCL_ICONS` record. If matched, renders SVG inline. Otherwise, falls through to Material Symbols font ligature.

Recognized SCL icon names: `gooseIcon`, `smvIcon`, `reportIcon`, `logIcon`

## Required Edits

### 1. Delete local icon files

Remove `foundation/icons.ts` or equivalent.

### 2. Update scopedElements

```ts
import { OscdIcon } from '@omicronenergy/oscd-ui/icon/OscdIcon.js';
static scopedElements = { 'oscd-icon': OscdIcon };
```

### 3. Replace SVG interpolation with icon name text

```ts
// Before
import { gooseIcon } from '../foundation/icons.js';
html`<mwc-icon slot="graphic">${gooseIcon}</mwc-icon>`

// After
html`<oscd-icon slot="start">gooseIcon</oscd-icon>`
```

### 4. Handle iconControlLookup patterns

```ts
// Before
const defined = { ReportControl: reportIcon, GSEControl: gooseIcon, ... };
html`<mwc-icon>${defined[controlTag]}</mwc-icon>`

// After
const controlBlockIconName: Record<string, string> = {
  ReportControl: 'reportIcon',
  LogControl: 'logIcon',
  GSEControl: 'gooseIcon',
  SampledValueControl: 'smvIcon',
};
html`<oscd-icon>${controlBlockIconName[controlTag]}</oscd-icon>`
```

### 5. Update CSS selectors

Replace `mwc-icon` selectors with `oscd-icon`.

## Verification

- No `@openscd/open-scd/src/icons/icons.js` imports
- No local `foundation/icons.ts`
- No `@material/mwc-icon` imports
- Icons render correctly
- Material Symbols ligatures (edit, close, etc.) still work via same `<oscd-icon>`

## Known Exceptions

- If no SCL icon name exists in `SCL_ICONS`, keep SVG as local constant and render as slotted child of `<oscd-icon>` (slot fallback works for arbitrary SVG content)
