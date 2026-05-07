---
name: scl-lib
description: API reference and legacy mapping for @openscd/scl-lib v2. Load when working with SCL document operations, replacing @openenergytools/scl-lib imports, or replacing @openscd/open-scd foundation helpers.
---

# @openscd/scl-lib v2.0.0

SCL (IEC 61850) document manipulation library for standalone OpenSCD plugins.

**Package:** `@openscd/scl-lib`
**Entry:** `main: ./dist/index.js`
**Dependency:** `@openscd/oscd-api` (for edit types)

## Foundation / Utilities

| Export | Kind | Description |
|---|---|---|
| `find` | function | `(root: Document, tagName: string, identity: string) => Element \| null` |
| `getReference` | function | Gets the reference node for ordered insertion |
| `getChildren` | function | Gets child elements |
| `identity` | function | `(element: Element) => string \| number` — unique identity string for SCL elements |
| `isPublic` | function | `(element: Element) => boolean` — checks if element is in the public section |
| `TreeSelection` | type | Tree selection state |

## Control Blocks

| Export | Kind | Description |
|---|---|---|
| `createGSEControl` | function | Creates a GSEControl with associated DataSet and GSE |
| `updateGSEControl` | function | Updates GSEControl attributes |
| `createSampledValueControl` | function | Creates SampledValueControl with associated DataSet and SMV |
| `updateSampledValueControl` | function | Updates SampledValueControl attributes |
| `createReportControl` | function | Creates a ReportControl with associated DataSet |
| `updateReportControl` | function | Updates ReportControl attributes |
| `removeControlBlock` | function | Removes a control block element |
| `findControlBlockSubscription` | function | Finds subscriptions for a control block |
| `controlBlockObjRef` | function | `(element: Element) => string \| null` — builds object reference string |
| `controlBlockGseOrSmv` | function | Finds associated GSE/SMV communication element |

## DataSet

| Export | Kind | Description |
|---|---|---|
| `createDataSet` | function | Creates a DataSet element |
| `removeDataSet` | function | Removes a DataSet element |
| `updateDataSet` | function | Updates DataSet attributes |
| `CreateDataSetOptions` | type | Options for createDataSet |

## FCDA

| Export | Kind | Description |
|---|---|---|
| `removeFCDA` | function | Removes an FCDA element |
| `canAddFCDA` | function | Checks if FCDA can be added |
| `maxAttributes` | function | Max attributes for FCDA |
| `fcdaBaseTypes` | function | Base types for FCDA |

## Subscription (ExtRef)

| Export | Kind | Description |
|---|---|---|
| `subscribe` | function | Creates subscription (ExtRef) edits |
| `unsubscribe` | function | Creates unsubscription edits |
| `matchDataAttributes` | function | Matches FCDA data attributes to ExtRef |
| `matchSrcAttributes` | function | Matches source control block attributes |
| `extRefTypeRestrictions` | function | Gets type restrictions for ExtRef |
| `doesFcdaMeetExtRefRestrictions` | function | Checks FCDA compatibility |
| `sourceControlBlock` | function | Finds the source control block for an ExtRef |
| `isSubscribed` | function | Checks if an ExtRef is subscribed |

## Supervision

| Export | Kind | Description |
|---|---|---|
| `canInstantiateSubscriptionSupervision` | function | Checks if supervision LN can be added |
| `instantiateSubscriptionSupervision` | function | Creates supervision LN edits |
| `insertSubscriptionSupervisions` | function | Inserts supervision LNs |
| `removeSupervision` | function | Removes a supervision LN |

## IED

| Export | Kind | Description |
|---|---|---|
| `insertIed` | function | Inserts an IED from an ICD/CID |
| `updateIED` | function | Updates IED attributes |
| `removeIED` | function | Removes an IED and cleans up references |

## Communication (GSE/SMV addresses)

| Export | Kind | Description |
|---|---|---|
| `createGSE` | function | Creates a GSE communication element |
| `changeGSEContent` | function | Updates GSE address content |
| `createSMV` | function | Creates an SMV communication element |
| `changeSMVContent` | function | Updates SMV address content |

## Substation / Process

| Export | Kind | Description |
|---|---|---|
| `updateSubstation` | function | Updates Substation attributes |
| `updateVoltageLevel` | function | Updates VoltageLevel attributes |
| `updateBay` | function | Updates Bay attributes |
| `removeProcessElement` | function | Removes a process structure element |

## DataTypeTemplates / NSD

| Export | Kind | Description |
|---|---|---|
| `nsdToJson` | function | Parses NSD XML to JSON structure |
| `insertSelectedLNodeType` | function | Inserts an LNodeType from selection |
| `removeDataType` | function | Removes a data type template element |
| `importLNodeType` | function | Imports an LNodeType from another document |
| `updateLNodeType` | function | Updates LNodeType attributes |
| `lNodeTypeToSelection` | function | Converts LNodeType to tree selection |

## Generators

| Export | Kind | Description |
|---|---|---|
| `macAddressGenerator` | generator | Yields unique MAC addresses |
| `appIdGenerator` | generator | Yields unique APP IDs |
| `lnInstGenerator` | generator | `(lDevice: Element, tag: 'LN') => (lnClass: string) => string` — yields next inst number scoped to an LDevice |

## Deep Import (not in public index)

| Export | Path | Description |
|---|---|---|
| `createElement` | `@openscd/scl-lib/dist/foundation/utils.js` | `(doc: XMLDocument, tag: string, attrs: Record<string, string \| null \| undefined>) => Element` |

**Warning:** `createElement` is accessed via a deep import path not declared in `exports`. If scl-lib adds an `exports` map, this path may break.

## Legacy Mapping

### From `@openenergytools/scl-lib`

Same API, only the package name changes:

```ts
// Before
import { find, identity, createGSEControl, removeControlBlock } from '@openenergytools/scl-lib';
// After
import { find, identity, createGSEControl, removeControlBlock } from '@openscd/scl-lib';
```

**Risk:** The legacy uses `@openenergytools/scl-lib` v1.x. The new `@openscd/scl-lib` is v2.0.0. Function signatures should be verified for breaking changes on a per-function basis.

### From `@openscd/open-scd/src/foundation.js`

| Legacy symbol | Replacement | Notes |
|---|---|---|
| `identity` | `import { identity } from '@openscd/scl-lib'` | Identical behavior |
| `isPublic` | `import { isPublic } from '@openscd/scl-lib'` | Identical behavior |
| `minAvailableLogicalNodeInstance` | `import { lnInstGenerator } from '@openscd/scl-lib'` | Schema-correctness improvement: scoped to LDevice, not entire IED |
| `find` (used transitively) | `import { find } from '@openscd/scl-lib'` | Signature: `(root: Document, tagName: string, identity: string) => Element \| null` |

### From `@openscd/xml`

| Legacy symbol | Replacement | Notes |
|---|---|---|
| `createElement` | `import { createElement } from '@openscd/scl-lib/dist/foundation/utils.js'` | Superset signature (accepts `XMLDocument`, attrs accept `undefined`) |
| `cloneElement` | Local copy required (`src/foundation/xml.ts`) | Not available in scl-lib |

### controlBlockObjRef (replaces local controlBlockReference)

The legacy `controlBlockReference` function is replaced by `controlBlockObjRef` from scl-lib. Both produce `${iedName}${ldInst}/${prefix}${lnClass}${lnInst}.${cbName}`. The scl-lib version is stricter (returns `null` when ANY required attribute is missing vs. only when ALL are missing).

### lnInstGenerator (replaces minAvailableLogicalNodeInstance)

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
