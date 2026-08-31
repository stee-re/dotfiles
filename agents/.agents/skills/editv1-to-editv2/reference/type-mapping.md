# Deprecated action → EditV2 mapping

| Deprecated type | EditV2 equivalent | Notes |
|---|---|---|
| `Create` | `Insert` | `Create.new.element` → `Insert.node`, `Create.new.parent` → `Insert.parent` |
| `Delete` | `Remove` | `Delete.old.element` → `Remove.node` |
| `Update` (attributes) | `SetAttributes` | `{ element, attributes, attributesNS }` |
| `Move` | `Remove` + `Insert` | Remove from old parent, insert into new parent at reference |
| `ComplexAction` | `EditV2[]` | Array of edits replaces `ComplexAction.actions` |
| `newActionEvent(action)` | `newEditEventV2(edit)` | Import from `@openscd/oscd-api/utils.js` |

## Import changes

```ts
// Before
import type { ComplexAction, Create, Delete } from '@omicronenergy/oscd-background-editor-action';
import { newActionEvent } from '@omicronenergy/oscd-background-editor-action';

// After
import type { Insert, Remove, SetAttributes, EditV2 } from '@openscd/oscd-api';
import { newEditEventV2 } from '@openscd/oscd-api/utils.js';
```
