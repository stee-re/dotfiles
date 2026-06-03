---
name: code-structure
description: Enforce project structure conventions for scoped web components. Covers class member ordering, CSS ordering, decorator formatting, naming, imports, exports, and template patterns.
---

# Code Structure & Conventions

This skill defines the structural conventions for all migrated plugin code. Load when reviewing, writing, or restructuring component files.

## File Naming

- File name is always the **kebab-case** of the class name (which is always **CamelCase**).
- `OscdEditorPublisher` → `oscd-editor-publisher.ts`
- `GseControlEditor` → `gse-control-editor.ts`

## Import Ordering

Group imports in this order, separated by a blank line between groups:

1. **External packages** (lit, @open-wc, @omicronenergy, @openscd)
2. **Relative imports** (./foundation, ../editors)
3. **Type-only imports** (`import type { ... }`)

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

## Export Style

- **Single default export** per component file (the class).
- **Named exports** for types, interfaces, and utility functions.
- Entry point file has the default export class; child utilities have named exports only.

## Decorator Formatting

Decorators ALWAYS on their own line above the declaration:

```ts
// ✅ CORRECT
@property({ attribute: false })
doc!: XMLDocument;

@query('oscd-scl-dialogs')
private sclDialogs!: OscdSclDialogs;

@state()
private selectedControl: Element | null = null;

// ❌ WRONG
@property doc!: XMLDocument;
@query('oscd-scl-dialogs') private sclDialogs!: OscdSclDialogs;
```

## Class Member Ordering

Within a scoped web component class, members MUST appear in this order:

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

## Control Flow

Never use one-liner if statements. The `if` line always ends with `{`:

```ts
// ✅ CORRECT
if (!element) {
  return null;
}

if (condition) {
  doThing();
}

// ❌ WRONG
if (!element) return null;
if (condition) doThing();
```

## CSS Ordering Within `static styles`

1. **`*` selector** — CSS variable overrides and variable declarations
2. **Host/container styles** — `:host`, `.container`, top-level layout
3. **Top-to-bottom UI order** — styles for elements the user sees first come first
4. **Specific/nested styles** — more granular rules come later, roughly in order of visual appearance

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

## Template Binding Style

- Prefer `.property=${value}` (property binding) over `attribute="${value}"` (attribute binding)
- Use `@event` in templates, not `addEventListener` in lifecycle methods (unless the listener target is outside the template)

```ts
// ✅ Property binding
html`<child-component .doc=${this.doc} .docVersion=${this.docVersion}></child-component>`

// ❌ Attribute binding for complex values
html`<child-component doc="${this.doc}" editCount="${this.editCount}"></child-component>`

// ✅ Event binding in template
html`<oscd-icon-button @click=${this.handleEdit}><oscd-icon>edit</oscd-icon></oscd-icon-button>`

// ❌ addEventListener in connectedCallback for template elements
connectedCallback() {
  this.shadowRoot.querySelector('oscd-icon-button')?.addEventListener('click', ...);
}
```

## Event Dispatch Pattern

- Always use `this.dispatchEvent(new CustomEvent(...))` for state changes that cross component boundaries.
- Never use direct DOM manipulation for propagating state.
- Custom events should be `{ bubbles: true, composed: true }` unless there's a specific reason not to.

## Type Assertions

- Prefer type guards or explicit narrowing over `as` casts.
- Use `as` only when the type system cannot express the narrowing and you are certain of the type.

```ts
// ✅ Prefer narrowing
if (isInsert(edit)) {
  const parent = edit.parent;
}

// ✅ Type guard
function isElement(node: Node): node is Element {
  return node.nodeType === Node.ELEMENT_NODE;
}

// ⚠️ Use 'as' only when unavoidable
const detail = (event as CustomEvent).detail;
```

## Additional Patterns

### Handler naming

Event handlers are always named `handle<What>`:
- `handleEditDialogEvent`
- `handleControlSelect`
- `handleFilterChange`

### Sub-renderer naming

Sub-renderers are always named `render<What>`:
- `renderControlItem`
- `renderLNodeListItem`
- `renderContextMenu`

### Boolean checks

Prefer explicit comparisons for nullability:
```ts
// ✅ Explicit
if (element !== null) { ... }
if (items.length > 0) { ... }

// ⚠️ Acceptable for booleans
if (isValid) { ... }
```

### Template conditionals

Use ternary with `nothing` for conditional rendering, not `if` statements inside templates:
```ts
html`${this.hasDataSet
  ? this.renderDataSetItem()
  : nothing}`
```

## Test Co-location

When extracting a component or module from a parent, **move the related tests with it**. Tests must live alongside the code they exercise.

- Each component gets its own `.spec.ts` file in the same directory as the component.
- A parent's spec file should only test the parent's own orchestration logic — NOT the internal behavior of its children.
- When refactoring code into a new file/component, identify which tests are really testing that extracted logic and move them to a co-located spec.

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

**Why:** Having a parent's spec file test child component internals makes it impossible to know where tests live. It couples the test suite to an implementation detail (the parent's structure) rather than the component's contract. When someone changes `sld-ied-menu`, they should find its tests in `sld-ied-menu.spec.ts` — not buried in a 1200-line parent spec.
