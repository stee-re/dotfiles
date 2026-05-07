---
name: legacy-xml-helpers
description: Replace @openscd/xml imports (createElement, cloneElement) with scl-lib deep import and local copy. Load during Step 2 initial migration.
---

# Recipe: Replace @openscd/xml With scl-lib createElement and Local cloneElement

## Problem

Legacy plugins import `createElement` and `cloneElement` from `@openscd/xml` (NOT published on npm).

## Replacements

### `createElement`

Use `@openscd/scl-lib/dist/foundation/utils.js`:

```ts
// Before
import { createElement } from '@openscd/xml';
// After
import { createElement } from '@openscd/scl-lib/dist/foundation/utils.js';
```

Signature: `(doc: XMLDocument, tag: string, attrs: Record<string, string | null | undefined>) => Element`

**Warning:** Deep import path not declared in scl-lib's public API. May break if scl-lib adds an `exports` map.

### `cloneElement`

Local copy in `src/foundation/xml.ts`:

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

## Required Edits

For files importing both:
```ts
import { createElement } from '@openscd/scl-lib/dist/foundation/utils.js';
import { cloneElement } from '../foundation/xml.js';
```

Adjust relative path depth to match importing file's location.

## Verification

- No `@openscd/xml` imports remain
- `@openscd/xml` not in package.json
- `src/foundation/xml.ts` contains only `cloneElement`
- All call sites compile and produce identical DOM output

## Known Risks

- `createElement` deep import may break if scl-lib adds `exports` map
- scl-lib `createElement` accepts `XMLDocument` (not `Document`) — cast if needed
