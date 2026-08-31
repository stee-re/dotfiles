---
name: scoped-elements
description: Use when code calls customElements.define, uses side-effect element imports, or a scoped custom tag renders empty under ScopedElementsMixin.
---

# Migrate Global Registration to Scoped Elements

**Use when**
- Legacy `customElements.define(...)` or side-effect imports like `import '@material/mwc-icon'`
- A custom tag renders empty/un-upgraded in a scoped shadow root
- Adding a child component to a `ScopedElementsMixin` plugin

**Don't use for** — oscd-ui replacements for `mwc-*` (`mwc-to-oscd-ui`, `oscd-ui`), the dialogs host (`scl-dialogs-embedding`), member/CSS ordering (`code-structure`), or test flakiness (`test-hardening`).

## Problem

Legacy code relies on global registration. Standalone plugins use `ScopedElementsMixin`: a scoped shadow root consults ONLY its own registry, never the global one.

## Procedure

1. Extend `ScopedElementsMixin(LitElement)` (from `@open-wc/scoped-elements/lit-element.js`) and declare `static scopedElements = { 'oscd-icon': OscdIcon };`.
2. Register in EVERY component whose template uses the tag — parent registries do not propagate to children, and base-class templates need registration in each concrete subclass.
3. Replace side-effect imports with class imports plus a `scopedElements` entry.
4. Move constructor DOM traversal into `connectedCallback()`.

## Pitfalls

- The `scopedElements` key must match the template tag exactly; after a tag rename update BOTH.
- Submodule imports need `.js` under `moduleResolution: "NodeNext"`.
- Registration must be synchronous; a Promise value throws `TypeError: Cannot read properties of undefined (reading 'attributeChangedCallback')`.
- Load the scoped-registry polyfill exactly once in tests; check for duplicate loading before blaming registrations.

## Verify

- Child components render (no empty custom-element tags); no duplicate-registration errors.
- Every component using a custom tag has it in its own `scopedElements`.
- No side-effect imports for scoped components.

## Reference

| File | Read when |
|---|---|
| `reference/registration-rules.md` | Examples for tag-key mismatch, side-effect imports, submodule extensions, sync registration, test polyfill |
| `reference/constructor-dom-traversal.md` | `this.closest()` in a constructor, or listeners that silently never fire |
