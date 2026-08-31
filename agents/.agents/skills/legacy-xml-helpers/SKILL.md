---
name: legacy-xml-helpers
description: Replace unpublished @openscd/xml imports — createElement via @openscd/scl-lib deep import, cloneElement as a local src/foundation/xml.ts copy.
---

# Replace @openscd/xml With scl-lib createElement and Local cloneElement

**Use when**
- A plugin imports `createElement` or `cloneElement` from `@openscd/xml`.
- Step 2 initial migration of a plugin that builds or clones XML elements.

**Don't use for** — `@openscd/open-scd` foundation sub-paths: `$legacy-foundation-helpers`. Converting edits themselves to EditV2: `$editv1-to-editv2`.

**Escalate to** — `iec-61850` if the constructed or cloned elements' tag names, attributes, namespace, or sibling position must satisfy SCL schema rules.

## Problem

`@openscd/xml` is not published on npm, so standalone plugins cannot depend on it. `createElement` has a published equivalent; `cloneElement` does not.

## Procedure

1. Repoint `createElement`:
   ```ts
   // Before
   import { createElement } from '@openscd/xml';
   // After
   import { createElement } from '@openscd/scl-lib/dist/foundation/utils.js';
   ```
   Signature: `(doc: XMLDocument, tag: string, attrs: Record<string, string | null | undefined>) => Element`
2. Add a local copy in `src/foundation/xml.ts`:
   ```ts
   export function cloneElement(
     element: Element,
     attrs: Record<string, string | null>
   ): Element {
     const newElement = <Element>element.cloneNode(false);
     Object.entries(attrs).forEach(([name, value]) => {
       if (value === null) newElement.removeAttribute(name);
       else newElement.setAttribute(name, value);
     });
     return newElement;
   }
   ```
3. In files using both, import each from its new home, adjusting relative depth:
   ```ts
   import { createElement } from '@openscd/scl-lib/dist/foundation/utils.js';
   import { cloneElement } from '../foundation/xml.js';
   ```

## Pitfalls

- The `createElement` deep import path is not declared in scl-lib's public API; it may break if scl-lib adds an `exports` map.
- scl-lib `createElement` accepts `XMLDocument` (not `Document`) — cast if needed.

## Verify

- No `@openscd/xml` imports remain
- `@openscd/xml` not in `package.json`
- `src/foundation/xml.ts` contains only `cloneElement`
- All call sites compile and produce identical DOM output
