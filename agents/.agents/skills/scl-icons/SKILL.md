---
name: scl-icons
description: Use when code defines local SVG constants like gooseIcon/smvIcon, imports @openscd/open-scd/src/icons/icons.js, or renders mwc-icon; swap to oscd-icon.
---

# Replace Legacy Icons With OscdIcon

**Use when**
- Local SVG icon constants (`gooseIcon`, `smvIcon`) or a `foundation/icons.ts`
- `import ... from '@openscd/open-scd/src/icons/icons.js'`
- `<mwc-icon>` usage or `@material/mwc-icon` imports

**Don't use for** — non-icon Material swaps (`mwc-to-oscd-ui`), the wider component API map (`oscd-ui`), or registering the tag itself (`scoped-elements`).

## Problem

Legacy plugins define local SVG icon constants or import legacy icon helpers. `OscdIcon` matches its text content against the `SCL_ICONS` record and renders that SVG inline; otherwise it falls through to a Material Symbols font ligature. Recognized SCL icon names: `gooseIcon`, `smvIcon`, `reportIcon`, `logIcon`.

## Procedure

1. Delete `foundation/icons.ts` or equivalent.
2. Register the component:

```ts
import { OscdIcon } from '@omicronenergy/oscd-ui/icon/OscdIcon.js';
static scopedElements = { 'oscd-icon': OscdIcon };
```

3. Replace SVG interpolation with the icon name as text:

```ts
// Before: html`<mwc-icon slot="graphic">${gooseIcon}</mwc-icon>`
html`<oscd-icon slot="start">gooseIcon</oscd-icon>`;
```

4. Convert `iconControlLookup` maps to name strings:

```ts
const controlBlockIconName: Record<string, string> = {
  ReportControl: 'reportIcon',
  LogControl: 'logIcon',
  GSEControl: 'gooseIcon',
  SampledValueControl: 'smvIcon',
};
html`<oscd-icon>${controlBlockIconName[controlTag]}</oscd-icon>`;
```

5. Replace `mwc-icon` CSS selectors with `oscd-icon`.

## Pitfalls

- If no matching name exists in `SCL_ICONS`, keep the SVG as a local constant and render it as a slotted child of `<oscd-icon>` — slot fallback accepts arbitrary SVG.
- Slotted/inline SVG must use `fill="currentColor"` (or `stroke="currentColor"`), never literal colors. Ligatures inherit `color`, but a raw `<svg><path .../></svg>` defaults to `fill: black` and silently ignores `--md-fab-icon-color`/on-surface color — invisible until a dark theme exposes it. Path-based icons (e.g. SLD `resize`/`move` glyphs) need explicit `currentColor`.

## Verify

- No `@openscd/open-scd/src/icons/icons.js` imports, no local `foundation/icons.ts`, no `@material/mwc-icon` imports.
- Icons render; Material Symbols ligatures (edit, close, etc.) still work via the same `<oscd-icon>`.
