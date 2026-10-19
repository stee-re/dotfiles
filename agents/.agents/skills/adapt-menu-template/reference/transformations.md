# Source transformations (Part 1)

Use the retained editor/menu entry selected under
`../../plugin-migration/reference/step-2.md`. Replace its example behavior with
the legacy implementation, then apply only the transformations below that
remain necessary. Do not convert the scaffold's existing editor from a menu.

## a. Rename class
```ts
// Before
export default class GooseSubscribeDataBindingPlugin extends LitElement {
// After
export default class OscdEditorSubscriberGooseData extends ScopedElementsMixin(LitElement) {
```

## b. Rewrite lit-element → lit
```ts
// Before
import { css, html, LitElement, property, TemplateResult } from 'lit-element';
// After
import { css, html, LitElement, TemplateResult } from 'lit';
import { property } from 'lit/decorators.js';
```

## c. Add ScopedElementsMixin
```ts
import { ScopedElementsMixin } from '@open-wc/scoped-elements/lit-element.js';
```

## d. Replace side-effect imports with scopedElements
```ts
// Before
import './subscription/fcda-binding-list.js';
// After
import { FcdaBindingList } from './subscription/fcda-binding-list.js';
static scopedElements = { 'fcda-binding-list': FcdaBindingList };
```

## e. editCount → docVersion
```ts
// Before
@property({ type: Number }) editCount = -1;
// After
@property({ attribute: false }) docVersion?: unknown;

// Bindings: editCount="${this.editCount}" → .docVersion=${this.docVersion}
```

## f-g. Replace forbidden imports
See `legacy-foundation-helpers` and `lit-translate-to-lit-localize` skills.

## h. Add `.js` extensions to all relative imports

## i. Remove `@customElement` decorator

## j. Only keep properties the plugin actually uses

**Always required:** `doc`, `docVersion`
**Keep only if referenced:** `nsdoc`, `docs`, `docName`, `locale`
**Keep only if used:** `editor` for direct Transactor API usage; event-based
plugins do not need an unused property. Do not infer need from a phase number.
