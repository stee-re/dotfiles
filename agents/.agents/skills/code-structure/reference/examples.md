# Code Structure — Worked Examples

Illustrative correct/wrong examples for the rules in `../SKILL.md`. Read only when a rule
is ambiguous or disputed.

## File naming

- `OscdEditorPublisher` → `oscd-editor-publisher.ts`
- `GseControlEditor` → `gse-control-editor.ts`

## Import ordering

```ts
import { html, LitElement } from 'lit';
import { property, query } from 'lit/decorators.js';
import { ScopedElementsMixin } from '@open-wc/scoped-elements/lit-element.js';
import { OscdIcon } from '@omicronenergy/oscd-ui/icon/OscdIcon.js';

import { compareNames } from './foundation/scl.js';
import { GseControlEditor } from './editors/gsecontrol/gse-control-editor.js';

import type { EditV2 } from '@openscd/oscd-api';
import type { ActionItem } from '@omicronenergy/oscd-ui/action-list/OscdActionList.js';
```

External package groups seen here: lit, @open-wc, @omicronenergy, @openscd.
Relative imports: ./foundation, ../editors.

## Decorator formatting

```ts
// CORRECT
@property({ attribute: false })
doc!: XMLDocument;

@query('oscd-scl-dialogs')
private sclDialogs!: OscdSclDialogs;

@state()
private selectedControl: Element | null = null;

// WRONG
@property doc!: XMLDocument;
@query('oscd-scl-dialogs') private sclDialogs!: OscdSclDialogs;
```

## Class member ordering (annotated)

```ts
export default class MyComponent extends ScopedElementsMixin(LitElement) {
  // 1. Static scoped elements
  static scopedElements = { ... };

  // 2. @property declarations (public reactive properties)
  @property({ attribute: false })
  doc!: XMLDocument;

  @property({ attribute: false })
  docVersion?: unknown;

  // 3. @state declarations (private reactive state)
  @state()
  private selectedItem: Element | null = null;

  // 4. @query declarations
  @query('oscd-scl-dialogs')
  private sclDialogs!: OscdSclDialogs;

  // 5. @queryAll declarations
  @queryAll('.content > oscd-scl-checkbox')
  private checkboxes!: NodeListOf<HTMLElement>;

  // 6. Constructor (if needed)
  constructor() { ... }

  // 7. Lifecycle methods (in lifecycle order)
  override connectedCallback(): void { ... }
  override disconnectedCallback(): void { ... }
  override willUpdate(changed: PropertyValues): void { ... }
  override firstUpdated(): void { ... }
  override updated(changed: PropertyValues): void { ... }

  // 8. Event handlers (always prefixed "handle")
  private handleEditDialogEvent = (event: Event) => { ... };
  private handleControlSelect(event: CustomEvent): void { ... }
  private handleMenuAction(action: string): void { ... }

  // 9. Private methods (business logic, helpers)
  private getAssociatedDataSet(control: Element): Element | null { ... }
  private isDataSetSingleUse(dataSet: Element): boolean { ... }

  // 10. Sub-renderers (prefixed "render" + specific part)
  private renderControlItem(control: Element): TemplateResult { ... }
  private renderLNodeListItem(ln: Element): TemplateResult { ... }
  private renderContextMenu(): TemplateResult { ... }

  // 11. Main render method
  render(): TemplateResult { ... }

  // 12. Static styles
  static styles = css`...`;
}
```

## Control flow

```ts
// CORRECT
if (!element) {
  return null;
}

if (condition) {
  doThing();
}

// WRONG
if (!element) return null;
if (condition) doThing();
```

## CSS ordering within `static styles`

```ts
static styles = css`
  * {
    --md-sys-color-primary: var(--oscd-primary);
    --item-height: 48px;
  }

  :host {
    display: flex;
    flex-direction: column;
    height: 100%;
  }

  .header { ... }
  .content { ... }
  .content .list-item { ... }
  .content .list-item .detail { ... }
  .footer { ... }
`;
```

Order: `*` selector (CSS variable overrides and variable declarations) →
host/container styles (`:host`, `.container`, top-level layout) → top-to-bottom
UI order (styles for elements the user sees first come first) →
specific/nested styles (more granular rules later, roughly in order of visual
appearance).

## Template binding style

```ts
// GOOD: Property binding
html`<child-component .doc=${this.doc} .docVersion=${this.docVersion}></child-component>`

// BAD: Attribute binding for complex values
html`<child-component doc="${this.doc}" editCount="${this.editCount}"></child-component>`

// GOOD: Event binding in template
html`<oscd-icon-button @click=${this.handleEdit}><oscd-icon>edit</oscd-icon></oscd-icon-button>`

// BAD: addEventListener in connectedCallback for template elements
connectedCallback() {
  this.shadowRoot.querySelector('oscd-icon-button')?.addEventListener('click', ...);
}
```

Exception: `addEventListener` in lifecycle methods is acceptable when the
listener target is outside the template.

## Type assertions

```ts
// GOOD: Prefer narrowing
if (isInsert(edit)) {
  const parent = edit.parent;
}

// GOOD: Type guard
function isElement(node: Node): node is Element {
  return node.nodeType === Node.ELEMENT_NODE;
}

// CAUTION: Use 'as' only when unavoidable
const detail = (event as CustomEvent).detail;
```

Use `as` only when the type system cannot express the narrowing and you are
certain of the type.

## Handler naming

`handle<What>`: `handleEditDialogEvent`, `handleControlSelect`,
`handleFilterChange`.

## Sub-renderer naming

`render<What>`: `renderControlItem`, `renderLNodeListItem`,
`renderContextMenu`.

## Spelling

American English applies to identifiers, type names, file and directory names,
symbols, and code comments. This holds even when the surrounding prose (docs, PR
descriptions, reviewer notes) uses British English, because American spelling is
the software ecosystem norm (`artifact`, `color`, `behavior`, `initialize`,
`center`).

```ts
// CORRECT — American spelling in code
class SldArtifactContext { ... }   // src/drawing/artifacts/
const color = '#BB1326';
function initializeViewer() { ... }

// WRONG — British spelling in code
class SldArtefactContext { ... }   // src/drawing/artefacts/
const colour = '#BB1326';
function initialiseViewer() { ... }
```

Prose in Markdown docs may follow the author's preferred variety of English;
this rule constrains code only.

## Boolean checks

```ts
// GOOD: Explicit
if (element !== null) { ... }
if (items.length > 0) { ... }

// CAUTION: Acceptable for booleans
if (isValid) { ... }
```

## Template conditionals

```ts
html`${this.hasDataSet
  ? this.renderDataSetItem()
  : nothing}`
```

## Test co-location

```
src/
  toolbar/
    sld-toolbar.ts
    sld-toolbar.spec.ts        ← tests toolbar behavior
    sld-ied-menu.ts
    sld-ied-menu.spec.ts       ← tests IED menu behavior
    sld-ied-importer.ts
    sld-ied-importer.spec.ts   ← tests importer behavior
  oscd-editor-sld.ts
  oscd-editor-sld.spec.ts      ← tests root orchestration only
```

**Why:** Having a parent's spec file test child component internals makes it
impossible to know where tests live. It couples the test suite to an
implementation detail (the parent's structure) rather than the component's
contract. When someone changes `sld-ied-menu`, they should find its tests in
`sld-ied-menu.spec.ts` — not buried in a 1200-line parent spec.

When refactoring code into a new file/component, identify which tests are really
testing that extracted logic and move them to a co-located spec.
