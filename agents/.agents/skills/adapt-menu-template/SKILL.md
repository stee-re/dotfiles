---
name: adapt-menu-template
description: Adapt the standalone menu template into an editor plugin. Covers class rename, ScopedElementsMixin setup, lit imports, scoped child registration, test file updates, and demo configuration.
---

# Recipe: Adapt Menu Template to Editor Plugin

## Problem

The standalone template is menu-oriented (`oscd-template-menu`). Editor plugins render UI immediately. The template must be reshaped.

## Part 1: Replace Main Source File

Replace `src/oscd-template-menu.ts` with legacy entry point content, then apply transformations:

### a. Rename class
```ts
// Before
export default class GooseSubscribeDataBindingPlugin extends LitElement {
// After  
export default class OscdEditorSubscriberGooseData extends ScopedElementsMixin(LitElement) {
```

### b. Rewrite lit-element → lit
```ts
// Before
import { css, html, LitElement, property, TemplateResult } from 'lit-element';
// After
import { css, html, LitElement, TemplateResult } from 'lit';
import { property } from 'lit/decorators.js';
```

### c. Add ScopedElementsMixin
```ts
import { ScopedElementsMixin } from '@open-wc/scoped-elements/lit-element.js';
```

### d. Replace side-effect imports with scopedElements
```ts
// Before
import './subscription/fcda-binding-list.js';
// After
import { FcdaBindingList } from './subscription/fcda-binding-list.js';
static scopedElements = { 'fcda-binding-list': FcdaBindingList };
```

### e. editCount → docVersion
```ts
// Before
@property({ type: Number }) editCount = -1;
// After
@property({ attribute: false }) docVersion?: unknown;

// Bindings: editCount="${this.editCount}" → .docVersion=${this.docVersion}
```

### f-g. Replace forbidden imports
See `$legacy-foundation-helpers` and `$lit-translate-to-lit-localize` skills.

### h. Add .js extensions to all relative imports

### i. Remove @customElement decorator

### j. Only keep properties the plugin actually uses

**Always required:** `doc`, `docVersion`
**Keep only if referenced:** `nsdoc`, `docs`, `docName`, `locale`
**Do NOT add:** `editor` (only needed after Step 3)

## Part 2: Rename Template Identifiers

Replace all `oscd-template-menu` / `OscdTemplateMenu` in:
- `src/<target>.spec.ts` — import path, class name, define tag, describe string, fixture tag
- `src/<target>.test.ts` — same + snapshot names
- `custom-elements.json` — class, tag, module path
- `README.md` — badge URLs, package name, heading
- `demo/plugins.js` — verify no template names remain
- `demo/index.html` — page title
- `package.json` — verify name/description/exports

### Test file content replacement
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

## Demo plugins.js — Preserve Source Editor

ADD the new plugin alongside the Source Editor, don't replace it:
```js
editor: [
  { name: 'New Plugin', icon: 'link', requireDoc: true, tagName: 'oscd-editor-new-plugin' },
  { name: 'Source Editor', icon: 'data_object', requireDoc: true,
    src: 'https://omicronenergyoss.github.io/oscd-editor-source/oscd-editor-source.js' },
],
```

## Verification

- `grep -ri 'oscd-template-menu\|OscdTemplateMenu' output/<plugin>/` returns no matches
- Main source extends `ScopedElementsMixin(LitElement)`
- Has `static scopedElements` listing all rendered children
- No side-effect imports for scoped children
- No `editCount` remains
- No `@customElement` decorator on entry point
- All relative imports have `.js` extensions
- All `lit-element` imports rewritten to `lit` / `lit/decorators.js`
