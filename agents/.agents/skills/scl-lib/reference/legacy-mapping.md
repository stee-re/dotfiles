# Legacy Mapping

## From `@openenergytools/scl-lib`

Same API, only the package name changes:

```ts
// Before
import { find, identity, createGSEControl, removeControlBlock } from '@openenergytools/scl-lib';
// After
import { find, identity, createGSEControl, removeControlBlock } from '@openscd/scl-lib';
```

**Risk:** The legacy uses `@openenergytools/scl-lib` v1.x. The new `@openscd/scl-lib` is v2.0.0. Function signatures should be verified for breaking changes on a per-function basis.

## From `@openscd/open-scd/src/foundation.js`

| Legacy symbol | Replacement | Notes |
|---|---|---|
| `identity` | `import { identity } from '@openscd/scl-lib'` | Identical behavior |
| `isPublic` | `import { isPublic } from '@openscd/scl-lib'` | Identical behavior |
| `minAvailableLogicalNodeInstance` | `import { lnInstGenerator } from '@openscd/scl-lib'` | Schema-correctness improvement: scoped to LDevice, not entire IED |
| `find` (used transitively) | `import { find } from '@openscd/scl-lib'` | Signature: `(root: Document, tagName: string, identity: string) => Element \| null` |

## From `@openscd/xml`

| Legacy symbol | Replacement | Notes |
|---|---|---|
| `createElement` | `import { createElement } from '@openscd/scl-lib/dist/foundation/utils.js'` | Superset signature (accepts `XMLDocument`, attrs accept `undefined`) |
| `cloneElement` | Local copy required (`src/foundation/xml.ts`) | Not available in scl-lib |

## controlBlockObjRef (replaces local controlBlockReference)

The legacy `controlBlockReference` function is replaced by `controlBlockObjRef` from scl-lib. Both produce `${iedName}${ldInst}/${prefix}${lnClass}${lnInst}.${cbName}`. The scl-lib version is stricter (returns `null` when ANY required attribute is missing vs. only when ALL are missing).

## lnInstGenerator (replaces minAvailableLogicalNodeInstance)

```ts
// Legacy (over-conservative — scans entire IED)
const inst = minAvailableLogicalNodeInstance(
  Array.from(subscriberIED.querySelectorAll(`LN[lnClass="${supervisionType}"]`))
);

// Standalone (correct — scoped to LDevice per IEC 61850)
const targetLDevice = subscriberIED.querySelector(
  `LN[lnClass="${supervisionType}"]`
)?.parentElement;
if (!targetLDevice) return null;
const instNumber = lnInstGenerator(targetLDevice, 'LN')(supervisionType);
```
