---
name: legacy-foundation-helpers
description: Replace @openscd/open-scd foundation imports with local helpers and @openscd/scl-lib. Covers all six sub-paths of the forbidden monorepo dependency.
---

# Recipe: Replace @openscd/open-scd Foundation Imports

## Problem

Legacy plugins import from six sub-paths of `@openscd/open-scd` (NOT published on npm):

| Sub-path | Symbols |
|---|---|
| `src/foundation.js` | `compareNames`, `getDescriptionAttribute`, `getNameAttribute`, `getSclSchemaVersion`, `identity`, `isPublic`, `minAvailableLogicalNodeInstance`, `newWizardEvent` |
| `src/foundation/ied.js` | `emptyInputsDeleteActions`, `getFcdaReferences` |
| `src/foundation/nsdoc.js` | `Nsdoc` |
| `src/icons/icons.js` | `gooseIcon`, `smvIcon` |
| `src/schemas.js` | `SCL_NAMESPACE` |
| `src/filtered-list.js` | side-effect: registers `<filtered-list>` |

## Replacement Strategy

### Category 1: Use `@openscd/scl-lib`

| Symbol | Replacement |
|---|---|
| `identity` | `import { identity } from '@openscd/scl-lib'` |
| `isPublic` | `import { isPublic } from '@openscd/scl-lib'` |
| `find` (transitive) | `import { find } from '@openscd/scl-lib'` |
| `minAvailableLogicalNodeInstance` | `import { lnInstGenerator } from '@openscd/scl-lib'` (schema-correctness improvement) |
| `controlBlockReference` (local) | `import { controlBlockObjRef } from '@openscd/scl-lib'` (stricter null guard) |

### Category 2: Local foundation modules

Create `src/foundation/scl.ts`:
```ts
export const SCL_NAMESPACE = 'http://www.iec.ch/61850/2003/SCL';
export type SclEdition = '2003' | '2007B' | '2007B4';

export function getSclSchemaVersion(doc: Document): SclEdition {
  const scl = doc.documentElement;
  const edition = (scl.getAttribute('version') ?? '2003') +
    (scl.getAttribute('revision') ?? '') +
    (scl.getAttribute('release') ?? '');
  return edition as SclEdition;
}

export function getNameAttribute(element: Element): string | undefined {
  const name = element.getAttribute('name');
  return name ? name : undefined;
}

export function getDescriptionAttribute(element: Element): string | undefined {
  const name = element.getAttribute('desc');
  return name ? name : undefined;
}

export function compareNames(a: Element | string, b: Element | string): number {
  if (typeof a === 'string' && typeof b === 'string') return a.localeCompare(b);
  if (typeof a === 'object' && typeof b === 'string')
    return (a.getAttribute('name') ?? '').localeCompare(b);
  if (typeof a === 'string' && typeof b === 'object')
    return a.localeCompare(b.getAttribute('name')!);
  if (typeof a === 'object' && typeof b === 'object')
    return (a.getAttribute('name') ?? '').localeCompare(b.getAttribute('name') ?? '');
  return 0;
}
```

Create `src/foundation/ied.ts` (depends on `@openscd/scl-lib` for `identity`/`find` and local deprecated-editor-actions for `Delete` type):
```ts
import { identity, find } from '@openscd/scl-lib';
import type { Delete } from './deprecated-editor-actions.js';

export function getFcdaReferences(element: Element): string {
  return ['ldInst','lnClass','lnInst','prefix','doName','daName']
    .map(ref => element.getAttribute(ref) ? `[${ref}="${element.getAttribute(ref)}"]` : '')
    .join('');
}

export function getControlReferences(extRef: Element): string {
  return ['srcLDInst','srcLNClass','srcLNInst','srcCBName']
    .map(ref => extRef.getAttribute(ref) ? `[${ref}="${extRef.getAttribute(ref)}"]` : '')
    .join('');
}

export function emptyInputsDeleteActions(extRefDeleteActions: Delete[]): Delete[] {
  // See full implementation in the recipe source
  // Bug fix: legacy `value.children.length! == 0` corrected to `=== 0`
}
```

### Category 3: Dedicated recipe skills

| Symbol | Skill to load |
|---|---|
| `Nsdoc` | `$nsdoc-standalone` |
| `gooseIcon`, `smvIcon` | `$scl-icons` |
| `newWizardEvent` | `$scl-dialogs-embedding` (Step 4 replaces wizards) |
| `<filtered-list>` | `$filtered-list-to-oscd-ui` |

### Category 4: Not used — do not copy

`newSubWizardEvent`, `referencePath`, `pathParts`, `crossProduct`, `depth`, `findFCDAs`, `findControlBlocks`, etc.

## Bug Fix Documentation

`emptyInputsDeleteActions` line `value.children.length! == 0`: The `!` is a TypeScript non-null assertion on a number (no-op). Combined with `== 0` (loose equality), runtime was already correct. Fixed to `=== 0` for clarity. This is a code-smell correction, not a behavior change.

## Verification

- No `@openscd/open-scd` imports in any src/ file
- `@openscd/open-scd` not in package.json
- `@openscd/scl-lib` in dependencies
- Local foundation modules compile with strict TypeScript
- No unused symbols imported

## Anti-Patterns

- Adding `@openscd/open-scd` as npm dependency (not published)
- Copying entire 2500-line `foundation.ts`
- Using `@openscd/scl-lib` for symbols it doesn't export
