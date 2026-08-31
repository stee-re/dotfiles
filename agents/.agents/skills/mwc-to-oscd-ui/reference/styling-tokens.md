# Styling & Layout Migration

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
