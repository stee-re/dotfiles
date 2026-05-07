---
name: scoped-elements
description: Migrate global customElements.define to ScopedElementsMixin with scoped registrations. Covers mwc-* registration, constructor DOM traversal fix, and child propagation rules.
---

# Recipe: Migrate Global Registration to Scoped Elements

## Problem

Legacy code relies on global `customElements.define(...)` or side-effect imports. Standalone plugins use `ScopedElementsMixin` where scoped shadow roots consult ONLY the scoped registry, not the global registry.

## Required Pattern

```ts
import { ScopedElementsMixin } from '@open-wc/scoped-elements/lit-element.js';
import { OscdIcon } from '@omicronenergy/oscd-ui/icon/OscdIcon.js';

export default class MyComponent extends ScopedElementsMixin(LitElement) {
  static scopedElements = {
    'oscd-icon': OscdIcon,
  };
}
```

## Critical Rules

### Each component registers its OWN dependencies

A parent's `scopedElements` do NOT propagate to children's shadow roots. If a child uses `<oscd-icon>` in its template, that child MUST register `'oscd-icon': OscdIcon` in its own `scopedElements` — even if the parent also registers it.

### Base class templates require registration in subclasses

If a base class renders `<oscd-dialog>`, `<oscd-icon>`, etc. but has no `scopedElements` of its own (because it's not a concrete element), every subclass that extends it MUST register those tags. The scoped registry is per-class.

### The scopedElements key MUST match the template tag exactly

```ts
// ✅ CORRECT
static scopedElements = { 'oscd-action-list': OscdActionList };
// template: <oscd-action-list ...>

// ❌ WRONG — tag won't resolve
static scopedElements = { 'action-list': OscdActionList };
// template: <oscd-action-list ...>
```

**After any tag rename, always update BOTH the template tags AND the scopedElements keys.**

### No side-effect imports for scoped components

```ts
// ❌ WRONG — invisible to scoped roots
import '@material/mwc-icon';

// ✅ CORRECT — import class, register in scopedElements
import { Icon } from '@material/mwc-icon';
static scopedElements = { 'mwc-icon': Icon };
```

### Submodule imports need .js extension

With `moduleResolution: "NodeNext"`:
```ts
import { ListItem } from '@material/mwc-list/mwc-list-item.js'; // ✅
import { ListItem } from '@material/mwc-list/mwc-list-item';    // ❌
```

### Synchronous registration only

`@open-wc/scoped-elements` v3 calls `registry.define(tagName, klass)` synchronously during `attachShadow`. Passing a Promise instead of a constructor causes `TypeError: Cannot read properties of undefined (reading 'attributeChangedCallback')`.

```ts
// ❌ WRONG — async/lazy
'oscd-scl-dialogs': (async () => (await import(...)).default)()

// ✅ CORRECT — synchronous
import OscdSclDialogs from '@omicronenergy/oscd-scl-dialogs/OscdSclDialogs.js';
static scopedElements = { 'oscd-scl-dialogs': OscdSclDialogs };
```

## Constructor DOM Traversal Fix

With `ScopedElementsMixin`, child elements are created by Lit's rendering system. Constructors run BEFORE the element is connected to the DOM. `this.closest()`, `this.parentElement`, `this.getRootNode()` return `null` in the constructor.

### Detection

- `this.closest(...)` in a constructor
- `this.parentElement` in a constructor
- `addEventListener` on a DOM-queried parent in a constructor

### Symptoms

- Event listeners silently fail to register (no error, no behavior)
- Cross-component communication doesn't work
- UI renders but interactive features are non-functional

### Fix

Move DOM-traversing initialization to `connectedCallback()`, cleanup to `disconnectedCallback()`:

```ts
// ❌ Legacy (doesn't work with ScopedElementsMixin)
constructor() {
  super();
  const parentDiv = this.closest('.container');
  if (parentDiv) {
    parentDiv.addEventListener('fcda-select', this.onFcdaSelectEvent.bind(this));
  }
}

// ✅ Standalone
private boundHandler = this.onFcdaSelectEvent.bind(this);

override connectedCallback(): void {
  super.connectedCallback();
  const parentDiv = this.closest('.container');
  if (parentDiv) parentDiv.addEventListener('fcda-select', this.boundHandler);
}

override disconnectedCallback(): void {
  const parentDiv = this.closest('.container');
  if (parentDiv) parentDiv.removeEventListener('fcda-select', this.boundHandler);
  super.disconnectedCallback();
}
```

## Verification

- Rendered child components appear correctly (no empty custom-element tags)
- No duplicate-registration errors
- Each component using custom tags in its template has them in its own `scopedElements`
- No side-effect imports for components that should be scoped
