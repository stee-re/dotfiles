---
name: editv1-to-editv2
description: Step 3 conversion of Create/Delete/Move/Update/ComplexAction and newActionEvent to EditV2 Insert/Remove/SetAttributes and newEditEventV2 from @openscd/oscd-api.
---

# Convert Deprecated Editor Actions to EditV2

**Use when**
- A plugin still imports deprecated action types or `newActionEvent` from `@omicronenergy/oscd-background-editor-action`.
- Step 3 of a migration: removing the editor-action bridge and dispatching `newEditEventV2`.

**Don't use for** — Step 2, where deprecated actions are still correct: `$deprecated-editor-actions` covers sourcing those types and the background bridge.

**Escalate to** — `iec-61850` if a converted `Insert` reference/parent choice or `SetAttributes` payload affects SCL element ordering, required attributes, or namespaces.

## Problem

Deprecated V1 editor actions must become `EditV2` operations dispatched with `newEditEventV2`, without changing document behavior.

## Procedure

1. Map each action using `reference/type-mapping.md`.
2. Swap imports to `@openscd/oscd-api` (see `reference/type-mapping.md`).
3. For `Insert` nodes, replace legacy `createElement(doc, tagName, attributes)` with `doc.createElementNS(SCL_NAMESPACE, tagName)` plus direct attribute sets, or `createElement` from `@openscd/scl-lib/dist/foundation/utils.js`.
4. Update parent-child edit propagation paths; replace `editCount`-driven refresh with `docVersion` response.
5. Update tests to verify resulting document behavior.
6. Remove `@omicronenergy/oscd-background-editor-action` from `package.json` and the background plugin from `demo/plugins.js`.

## Pitfalls

- Half-converted edit paths where some changes still use deprecated actions.
- Converting the event type but silently changing business logic.
- Preserving deprecated helper structures without proving they are still needed.
- Updating tests to match implementation details instead of document behavior.
- Temporary local DOM updates that never persist into the SCL document are NOT `EditV2`; document the distinction if both patterns exist.

## Verify

- No deprecated editor action imports remain
- Persistent document edits flow through `newEditEventV2`
- Behavior remains identical to legacy
- `@omicronenergy/oscd-background-editor-action` removed from `package.json`
- Background plugin removed from `demo/plugins.js`

## Reference

| File | Read when |
|---|---|
| `reference/type-mapping.md` | Mapping a deprecated action to its EditV2 form, or rewriting imports |
