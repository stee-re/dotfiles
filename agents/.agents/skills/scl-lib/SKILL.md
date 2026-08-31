---
name: scl-lib
description: Read before calling any @openscd/scl-lib v2 SCL helper (find, identity, createGSEControl, subscribe, createElement) or replacing @openenergytools/scl-lib or open-scd foundation imports.
---

# @openscd/scl-lib API Reference

**Use when**

- Calling an scl-lib helper and needing its exact name, signature, or import path.
- Creating or editing control blocks, DataSets, FCDAs, ExtRef subscriptions, supervisions, IEDs, Substation structure, or DataTypeTemplates.
- Replacing `@openenergytools/scl-lib`, `@openscd/open-scd/src/foundation.js`, or `@openscd/xml` imports.

**Don't use for** — edit/event type shapes: use `oscd-api`. Step-by-step foundation or xml import replacement: use `legacy-foundation-helpers` and `legacy-xml-helpers`.

**Escalate to** — `iec-61850` before creating, reordering, or namespacing SCL elements, or whenever you are unsure the resulting structure is schema-valid.

## Package

`@openscd/scl-lib` v2.0.0 — SCL (IEC 61850) document manipulation for standalone OpenSCD plugins. Entry: `main: ./dist/index.js`. Depends on `@openscd/oscd-api` for edit types, documented in `../oscd-api/reference/edit-types.md`.

## Import convention

Import every symbol below from the package root `@openscd/scl-lib`, except `createElement`, which needs the deep import `@openscd/scl-lib/dist/foundation/utils.js` (see `reference/foundation.md`).

## Symbol index

| Symbols | Documented in |
|---|---|
| `find`, `getReference`, `getChildren`, `identity`, `isPublic`, `TreeSelection`, `macAddressGenerator`, `appIdGenerator`, `lnInstGenerator`, `createElement` (deep import) | `reference/foundation.md` |
| `createGSEControl`, `updateGSEControl`, `createSampledValueControl`, `updateSampledValueControl`, `createReportControl`, `updateReportControl`, `removeControlBlock`, `findControlBlockSubscription`, `controlBlockObjRef`, `controlBlockGseOrSmv`, `createDataSet`, `removeDataSet`, `updateDataSet`, `CreateDataSetOptions`, `removeFCDA`, `canAddFCDA`, `maxAttributes`, `fcdaBaseTypes`, `createGSE`, `changeGSEContent`, `createSMV`, `changeSMVContent` | `reference/control-blocks.md` |
| `subscribe`, `unsubscribe`, `matchDataAttributes`, `matchSrcAttributes`, `extRefTypeRestrictions`, `doesFcdaMeetExtRefRestrictions`, `sourceControlBlock`, `isSubscribed`, `canInstantiateSubscriptionSupervision`, `instantiateSubscriptionSupervision`, `insertSubscriptionSupervisions`, `removeSupervision` | `reference/subscription.md` |
| `insertIed`, `updateIED`, `removeIED`, `updateSubstation`, `updateVoltageLevel`, `updateBay`, `removeProcessElement`, `nsdToJson`, `insertSelectedLNodeType`, `removeDataType`, `importLNodeType`, `updateLNodeType`, `lNodeTypeToSelection` | `reference/structure.md` |

## Verify

Run `npx tsc --noEmit`; v1 → v2 signature drift surfaces there. Since these helpers return edits, assert the resulting SCL against the expected document in a test rather than trusting the call shape.

## Reference

| File | Read when |
|---|---|
| `reference/foundation.md` | You need identity/lookup helpers, generators, or the `createElement` deep-import warning. |
| `reference/control-blocks.md` | You create or edit GSEControl/SampledValueControl/ReportControl, DataSet, FCDA, or GSE/SMV addresses. |
| `reference/subscription.md` | You work on ExtRef subscription or supervision LNs. |
| `reference/structure.md` | You edit IEDs, Substation/Process structure, or DataTypeTemplates/NSD. |
| `reference/legacy-mapping.md` | You migrate from `@openenergytools/scl-lib`, `@openscd/open-scd/src/foundation.js`, or `@openscd/xml`. |
