# Identifier rename and demo wiring (Part 2)

Replace all `oscd-template-menu` / `OscdTemplateMenu` in:

- `src/<target>.spec.ts` — import path, class name, define tag, describe string, fixture tag
- `src/<target>.test.ts` — same + snapshot names
- `custom-elements.json` — class, tag, module path
- `README.md` — badge URLs, package name, heading
- `demo/plugins.js` — verify no template names remain
- `demo/index.html` — page title
- `package.json` — verify name/description/exports

## Test file content replacement
```ts
// Before
import OscdTemplateMenu from './oscd-template-menu.js';
customElements.define('oscd-template-menu', OscdTemplateMenu);
describe('oscd-template-menu', () => {
  let plugin: OscdTemplateMenu;
  plugin = await fixture(html`<oscd-template-menu></oscd-template-menu>`);

// After
import OscdEditorSubscriberGooseData from './oscd-editor-subscriber-goose-data.js';
customElements.define('oscd-editor-subscriber-goose-data', OscdEditorSubscriberGooseData);
describe('oscd-editor-subscriber-goose-data', () => {
  let plugin: OscdEditorSubscriberGooseData;
  plugin = await fixture(html`<oscd-editor-subscriber-goose-data></oscd-editor-subscriber-goose-data>`);
```

Remove menu-only test logic like `await plugin.run()`.

## demo/plugins.js — preserve Source Editor

ADD the new plugin alongside the Source Editor, don't replace it:
```js
editor: [
  { name: 'New Plugin', icon: 'link', requireDoc: true, tagName: 'oscd-editor-new-plugin' },
  { name: 'Source Editor', icon: 'data_object', requireDoc: true,
    src: 'https://omicronenergyoss.github.io/oscd-editor-source/oscd-editor-source.js' },
],
```
