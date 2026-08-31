# Per-Component Migration Recipes

## IconButtonToggle (mwc-icon-button-toggle → oscd-icon-button)

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

## Dialog (mwc-dialog → oscd-dialog)

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

## Divider

```ts
// Before
html`<li divider role="separator"></li>`
// After
html`<oscd-divider></oscd-divider>`
```

Import `OscdDivider` from `@omicronenergy/oscd-ui/divider/OscdDivider.js`, register as `'oscd-divider'` in `scopedElements`. Update CSS from `li[divider]` to `oscd-divider`.
