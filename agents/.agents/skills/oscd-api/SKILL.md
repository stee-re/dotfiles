---
name: oscd-api
description: API reference and legacy mapping for @openscd/oscd-api. Load when migrating edit events, understanding Plugin interface properties, or replacing legacy @openenergytools/open-scd-core imports.
---

# @openscd/oscd-api v0.1.6

The edit API and plugin interface contract for standalone OpenSCD plugins.

## Package Entry Points

| Specifier | Contains |
|---|---|
| `@openscd/oscd-api` | Type-only exports (interfaces, type aliases) |
| `@openscd/oscd-api/utils.js` | Runtime functions (event factories, type guards) |

## Edit V2 Types (main entry)

| Export | Kind | Shape |
|---|---|---|
| `Insert` | type | `{ node: Node; parent: Node; reference: Node \| null }` |
| `Remove` | type | `{ node: Node }` |
| `SetAttributes` | type | `{ element: Element; attributes: AttributesV2; attributesNS: AttributesNS }` |
| `SetTextContent` | type | `{ element: Element; textContent: string }` |
| `AttributesV2` | type | `Partial<Record<string, string \| null>>` |
| `AttributesNS` | type | `Partial<Record<string, AttributesV2>>` (namespace URI → attributes) |
| `EditV2` | type | `Insert \| SetAttributes \| SetTextContent \| Remove \| EditV2[]` |

## Edit V1 Types (main entry)

| Export | Kind | Shape |
|---|---|---|
| `Update` | type | `{ element: Element; attributes: Attributes }` |
| `Attributes` | type | `Partial<Record<string, AttributeValue>>` |
| `AttributeValue` | type | `string \| null \| NamespacedAttributeValue` |
| `NamespacedAttributeValue` | type | `{ value: string \| null; namespaceURI: string \| null }` |
| `Edit` | type | `Insert \| Update \| Remove \| Edit[]` |

## Event Types (main entry)

| Export | Kind | Description |
|---|---|---|
| `EditEvent` | type | `CustomEvent<Edit>` — dispatched as `'oscd-edit'` |
| `EditEventV2` | type | `CustomEvent<EditDetailV2>` — dispatched as `'oscd-edit-v2'` |
| `EditDetailV2` | type | `{ edit: E; title?: string; squash?: boolean }` |
| `EditEventOptions` | type | `{ title?: string; squash?: boolean }` |
| `OpenEvent` | type | `CustomEvent<OpenDetail>` — dispatched as `'oscd-open'` |
| `OpenDetail` | type | `{ doc: XMLDocument; docName: string }` |

## Plugin Interface (main entry)

| Property | Type | Description |
|---|---|---|
| `editor` | `Transactor<EditV2>` | Transaction manager |
| `docs` | `Record<string, XMLDocument>` | All open documents |
| `doc` | `XMLDocument` | Current SCL document |
| `docName` | `string` | Current document name |
| `docVersion` | `unknown` | Change counter (replaces legacy `editCount`) |
| `locale` | `string` | Current locale |

## Transactor Interface (main entry)

| Method/Property | Type | Description |
|---|---|---|
| `commit` | `(edit: EditV2, options?: CommitOptions) => void` | Apply edit |
| `undo` | `() => void` | Undo last commit |
| `redo` | `() => void` | Redo last undo |
| `subscribe` | `(cb: TransactedCallback) => () => void` | Listen for commits |
| `past` | `Commit[]` | Undo stack |
| `future` | `Commit[]` | Redo stack |

## Runtime Functions (`@openscd/oscd-api/utils.js`)

| Export | Kind | Description |
|---|---|---|
| `newEditEventV2` | function | `(edit: EditV2, options?: EditEventOptions) => EditEventV2` |
| `newEditEvent` | function | `(edit: Edit) => EditEvent` (v1) |
| `newOpenEvent` | function | `(doc: XMLDocument, docName: string) => OpenEvent` |
| `convertEdit` | function | `(edit: Edit) => EditV2` — converts v1 Edit to v2 EditV2 |
| `isInsert` | type guard | `(edit: unknown) => edit is Insert` |
| `isRemove` | type guard | `(edit: unknown) => edit is Remove` |
| `isSetAttributes` | type guard | `(edit: unknown) => edit is SetAttributes` |
| `isSetTextContent` | type guard | `(edit: unknown) => edit is SetTextContent` |
| `isUpdate` | type guard | `(edit: unknown) => edit is Update` (v1) |
| `isEdit` | type guard | `(edit: unknown) => edit is Edit` (v1) |
| `isEditV2` | type guard | `(edit: unknown) => edit is EditV2` |
| `isComplexEdit` | type guard | `(edit: unknown) => edit is Edit[]` (v1) |
| `isComplexEditV2` | type guard | `(edit: unknown) => edit is EditV2[]` |

## Legacy Mapping

### From `@openenergytools/open-scd-core`

| Legacy import | Replacement |
|---|---|
| `import { newEditEvent } from '@openenergytools/open-scd-core'` | `import { newEditEventV2 } from '@openscd/oscd-api/utils.js'` |
| `import type { Insert, Remove, SetAttributes } from '@openenergytools/open-scd-core'` | `import type { Insert, Remove, SetAttributes } from '@openscd/oscd-api'` |

The type shapes (`Insert`, `Remove`, `SetAttributes`) are identical between old and new packages.

The event name changes from `'oscd-edit'` to `'oscd-edit-v2'` — the shell must handle the new event name.

### From deprecated `@openscd/core/foundation/deprecated/editor.js`

| Deprecated type | EditV2 equivalent | Notes |
|---|---|---|
| `Create` | `Insert` | `Create.new.element` → `Insert.node`, `Create.new.parent` → `Insert.parent` |
| `Delete` | `Remove` | `Delete.old.element` → `Remove.node` |
| `Update` (attributes) | `SetAttributes` | Attribute-level changes on an existing element |
| `Move` | `Remove` + `Insert` | Remove from old parent, insert into new parent at reference |
| `ComplexAction` | `EditV2[]` | Array of edits replaces `ComplexAction.actions` |
| `newActionEvent(action)` | `newEditEventV2(edit)` | Event dispatch replacement |

### editCount → docVersion

| Legacy | Standalone |
|---|---|
| `@property({ type: Number }) editCount = -1;` | `@property({ attribute: false }) docVersion?: unknown;` |
| `editCount="${this.editCount}"` (attribute binding) | `.docVersion=${this.docVersion}` (property binding) |

The `Plugin` interface defines `docVersion: unknown` — this is the standalone contract for change detection.
