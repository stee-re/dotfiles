---
name: editv1-to-editv2
description: Convert deprecated Create/Delete/Move/Update/ComplexAction editor actions to EditV2 types and newEditEventV2 dispatch. Load during Step 3 migration.
---

# Recipe: Convert Deprecated Editor Actions to EditV2

## Type Mapping

| Deprecated type | EditV2 equivalent | Notes |
|---|---|---|
| `Create` | `Insert` | `Create.new.element` → `Insert.node`, `Create.new.parent` → `Insert.parent` |
| `Delete` | `Remove` | `Delete.old.element` → `Remove.node` |
| `Update` (attributes) | `SetAttributes` | `{ element, attributes, attributesNS }` |
| `Move` | `Remove` + `Insert` | Remove from old parent, insert into new parent at reference |
| `ComplexAction` | `EditV2[]` | Array of edits replaces `ComplexAction.actions` |
| `newActionEvent(action)` | `newEditEventV2(edit)` | Import from `@openscd/oscd-api/utils.js` |

## Import Changes

```ts
// Before
import type { ComplexAction, Create, Delete } from '@omicronenergy/oscd-background-editor-action';
import { newActionEvent } from '@omicronenergy/oscd-background-editor-action';

// After
import type { Insert, Remove, SetAttributes, EditV2 } from '@openscd/oscd-api';
import { newEditEventV2 } from '@openscd/oscd-api/utils.js';
```

## createElement Usage

When building `Insert` nodes, legacy code uses `createElement(doc, tagName, attributes)`. Use `doc.createElementNS(SCL_NAMESPACE, tagName)` and set attributes directly, or use `createElement` from `@openscd/scl-lib/dist/foundation/utils.js`.

## Required Edits

- Map each deprecated action to the equivalent EditV2 operation
- Replace event dispatch with `newEditEventV2`
- Update parent-child edit propagation paths
- Replace `editCount`-driven refresh with `docVersion` response
- Update tests to verify resulting document behavior

## Anti-Patterns

- Leaving half-converted edit paths where some changes still use deprecated actions
- Converting the event type but silently changing business logic
- Preserving deprecated helper structures without proving they are still needed
- Updating tests to match implementation details instead of document behavior

## Verification

- No deprecated editor action imports remain
- Persistent document edits flow through `newEditEventV2`
- Behavior remains identical to legacy
- `@omicronenergy/oscd-background-editor-action` removed from package.json
- Background plugin removed from demo/plugins.js

## Known Exceptions

- Temporary local DOM updates that do not persist into the SCL document are NOT `EditV2`; document the distinction if both patterns exist.
