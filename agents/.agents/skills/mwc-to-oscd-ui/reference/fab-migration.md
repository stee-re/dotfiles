# FAB Migration (mwc-fab → oscd-fab)

## Critical Differences

The MD3 FAB has fundamentally different API behavior from MWC FAB:

| MWC (`mwc-fab`) | MD3 (`oscd-fab`) | Impact |
|---|---|---|
| `mini` attribute | `size="small"` | Shape changes (see below) |
| `icon="name"` renders icon internally | `icon` attribute does NOTHING | Must use slotted `<oscd-icon>` |
| `label="text"` is accessibility-only on mini | `label="text"` makes FAB **extended** (visually shows text) | Buttons become wide pills |
| Circular shape (50% radius) | Rounded-square (12px radius for small) | Must override with CSS token |
| `--mdc-theme-secondary` / `--mdc-theme-on-secondary` | `--md-fab-container-color` / `--md-fab-icon-color` | Different token names |
| No touch-target margin | Adds margin via `:host([size=small][touch-target=wrapper])` | Causes vertical offset in inline layouts |

## Correct Pattern

```html
<!-- WRONG — icon attr does nothing, label extends the FAB -->
<oscd-fab size="small" icon="add" label="Add Item" title="Add Item"></oscd-fab>

<!-- CORRECT — slotted icon, aria-label for a11y, title for tooltip -->
<oscd-fab size="small" aria-label="Add Item" title="Add Item">
  <oscd-icon slot="icon">add</oscd-icon>
</oscd-fab>
```

## Required CSS for Circular Small FABs

```css
oscd-fab {
  --md-fab-container-color: #fff;
  --md-fab-icon-color: rgb(0, 0, 0 / 0.83);
  --md-fab-small-container-shape: 50%;  /* circular, not rounded-square */
}
```

## Container Layout Fix

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

## Custom-Colored FABs

```html
<!-- MWC -->
<mwc-fab mini style="--mdc-theme-secondary: #12579B; --mdc-theme-on-secondary: white;">

<!-- MD3 -->
<oscd-fab size="small" style="--md-fab-container-color: #12579B; --md-fab-icon-color: white;">
```

## SVG Icons in FABs

SVG icons slotted into FABs must have `slot="icon"` and should use `stroke="currentColor"` or `fill="currentColor"` to inherit `--md-fab-icon-color` via the CSS `color` property set on `::slotted(*)`.
