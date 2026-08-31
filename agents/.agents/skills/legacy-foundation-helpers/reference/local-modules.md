# Category 2: local foundation modules

## `src/foundation/scl.ts`

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

## `src/foundation/ied.ts`

Depends on `@openscd/scl-lib` for `identity` / `find`, and on local deprecated-editor-actions for the `Delete` type.

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

## Bug fix documentation

`emptyInputsDeleteActions` line `value.children.length! == 0`: the `!` is a TypeScript non-null assertion on a number (no-op). Combined with `== 0` (loose equality), runtime was already correct. Fixed to `=== 0` for clarity. This is a code-smell correction, not a behavior change.
