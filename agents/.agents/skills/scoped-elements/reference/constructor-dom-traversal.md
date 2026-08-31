# Constructor DOM Traversal Fix

With `ScopedElementsMixin`, child elements are created by Lit's rendering system. Constructors run BEFORE the element is connected to the DOM. `this.closest()`, `this.parentElement`, and `this.getRootNode()` return `null` in the constructor.

## Detection

- `this.closest(...)` in a constructor
- `this.parentElement` in a constructor
- `addEventListener` on a DOM-queried parent in a constructor

## Symptoms

- Event listeners silently fail to register (no error, no behavior)
- Cross-component communication doesn't work
- UI renders but interactive features are non-functional

## Fix

Move DOM-traversing initialization to `connectedCallback()`, cleanup to `disconnectedCallback()`:

```ts
// Legacy (doesn't work with ScopedElementsMixin)
constructor() {
  super();
  const parentDiv = this.closest('.container');
  if (parentDiv) {
    parentDiv.addEventListener('fcda-select', this.onFcdaSelectEvent.bind(this));
  }
}

// Standalone
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
