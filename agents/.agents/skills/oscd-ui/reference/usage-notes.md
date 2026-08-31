# Critical Usage Notes

## OscdMenuItem headline pattern

`<oscd-menu-item>` does NOT have a `headline` attribute. The headline is a **named slot**:

```typescript
// CORRECT
html`<oscd-menu-item @click=${handler}>
  <div slot="headline">${msg('Edit')}</div>
</oscd-menu-item>`

// WRONG (renders blank)
html`<oscd-menu-item headline="Edit" @click=${handler}></oscd-menu-item>`
```

## OscdIcon with SCL icons

`OscdIcon` checks if text content matches an SCL icon name from the `SCL_ICONS` record. If matched, renders the SVG. Otherwise falls through to Material Symbols font ligature.

Recognized SCL icon names: `gooseIcon`, `smvIcon`, `reportIcon`, `logIcon`

```typescript
// Renders SCL goose icon SVG
html`<oscd-icon>gooseIcon</oscd-icon>`
// Renders Material Symbols "edit" ligature
html`<oscd-icon>edit</oscd-icon>`
```

## Divider replacement

Replace `<li divider role="separator"></li>` with `<oscd-divider></oscd-divider>`. Update CSS selectors from `li[divider]` to `oscd-divider`.

Import `OscdDivider` from `@omicronenergy/oscd-ui/divider/OscdDivider.js`, register as `'oscd-divider'` in `scopedElements`.
