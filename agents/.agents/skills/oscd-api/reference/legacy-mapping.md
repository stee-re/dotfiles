# Legacy Mapping

## From `@openenergytools/open-scd-core`

| Legacy import | Replacement |
|---|---|
| `import { newEditEvent } from '@openenergytools/open-scd-core'` | `import { newEditEventV2 } from '@openscd/oscd-api/utils.js'` |
| `import type { Insert, Remove, SetAttributes } from '@openenergytools/open-scd-core'` | `import type { Insert, Remove, SetAttributes } from '@openscd/oscd-api'` |

The type shapes (`Insert`, `Remove`, `SetAttributes`) are identical between old and new packages.

The event name changes from `'oscd-edit'` to `'oscd-edit-v2'` — the shell must handle the new event name.

## From deprecated `@openscd/core/foundation/deprecated/editor.js`

| Deprecated type | EditV2 equivalent | Notes |
|---|---|---|
| `Create` | `Insert` | `Create.new.element` → `Insert.node`, `Create.new.parent` → `Insert.parent` |
| `Delete` | `Remove` | `Delete.old.element` → `Remove.node` |
| `Update` (attributes) | `SetAttributes` | Attribute-level changes on an existing element |
| `Move` | `Remove` + `Insert` | Remove from old parent, insert into new parent at reference |
| `ComplexAction` | `EditV2[]` | Array of edits replaces `ComplexAction.actions` |
| `newActionEvent(action)` | `newEditEventV2(edit)` | Event dispatch replacement |

## editCount → docVersion

| Legacy | Standalone |
|---|---|
| `@property({ type: Number }) editCount = -1;` | `@property({ attribute: false }) docVersion?: unknown;` |
| `editCount="${this.editCount}"` (attribute binding) | `.docVersion=${this.docVersion}` (property binding) |

The `Plugin` interface defines `docVersion: unknown` — this is the standalone contract for change detection.
