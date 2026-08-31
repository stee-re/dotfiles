# Scoped Registration Rules — Full Examples

## Required pattern

```ts
import { ScopedElementsMixin } from '@open-wc/scoped-elements/lit-element.js';
import { OscdIcon } from '@omicronenergy/oscd-ui/icon/OscdIcon.js';

export default class MyComponent extends ScopedElementsMixin(LitElement) {
  static scopedElements = {
    'oscd-icon': OscdIcon,
  };
}
```

## Each component registers its OWN dependencies

A parent's `scopedElements` do NOT propagate to children's shadow roots. If a child uses `<oscd-icon>` in its template, that child MUST register `'oscd-icon': OscdIcon` in its own `scopedElements` — even if the parent also registers it.

## Base class templates require registration in subclasses

If a base class renders `<oscd-dialog>`, `<oscd-icon>`, etc. but has no `scopedElements` of its own (because it is not a concrete element), every subclass that extends it MUST register those tags. The scoped registry is per-class.

## The scopedElements key MUST match the template tag exactly

```ts
// CORRECT
static scopedElements = { 'oscd-action-list': OscdActionList };
// template: <oscd-action-list ...>

// WRONG - tag won't resolve
static scopedElements = { 'action-list': OscdActionList };
// template: <oscd-action-list ...>
```

After any tag rename, always update BOTH the template tags AND the `scopedElements` keys.

## No side-effect imports for scoped components

```ts
// WRONG - invisible to scoped roots
import '@material/mwc-icon';

// CORRECT - import class, register in scopedElements
import { Icon } from '@material/mwc-icon';
static scopedElements = { 'mwc-icon': Icon };
```

## Submodule imports need .js extension

With `moduleResolution: "NodeNext"`:

```ts
import { ListItem } from '@material/mwc-list/mwc-list-item.js'; // correct
import { ListItem } from '@material/mwc-list/mwc-list-item';    // wrong
```

## Synchronous registration only

`@open-wc/scoped-elements` v3 calls `registry.define(tagName, klass)` synchronously during `attachShadow`. Passing a Promise instead of a constructor causes `TypeError: Cannot read properties of undefined (reading 'attributeChangedCallback')`.

```ts
// WRONG - async/lazy
'oscd-scl-dialogs': (async () => (await import(...)).default)()

// CORRECT - synchronous
import OscdSclDialogs from '@omicronenergy/oscd-scl-dialogs/OscdSclDialogs.js';
static scopedElements = { 'oscd-scl-dialogs': OscdSclDialogs };
```

## Load the scoped registry polyfill exactly once in tests

When `web-test-runner.config.*` uses `@web/dev-server-polyfill` with `scopedCustomElementRegistry: true`, do NOT also import `@webcomponents/scoped-custom-element-registry` in spec files. The scoped registry polyfill is not safe to load twice: scoped registries may contain the expected definitions while rendered scoped children remain plain `HTMLElement`s and never upgrade.

```ts
// WRONG when WTR already injects the polyfill
import '@webcomponents/scoped-custom-element-registry';
import { fixture } from '@open-wc/testing';

// CORRECT: let web-test-runner.config.* inject it once
import { fixture } from '@open-wc/testing';
```

If child components fail to upgrade in tests, first check for duplicate polyfill loading before changing `scopedElements` registrations.
