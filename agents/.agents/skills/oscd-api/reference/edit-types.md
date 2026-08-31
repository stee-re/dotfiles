# Edit and Event Types

All type-only exports from the main entry `@openscd/oscd-api`.

## Edit V2 Types

| Export | Kind | Shape |
|---|---|---|
| `Insert` | type | `{ node: Node; parent: Node; reference: Node \| null }` |
| `Remove` | type | `{ node: Node }` |
| `SetAttributes` | type | `{ element: Element; attributes: AttributesV2; attributesNS: AttributesNS }` |
| `SetTextContent` | type | `{ element: Element; textContent: string }` |
| `AttributesV2` | type | `Partial<Record<string, string \| null>>` |
| `AttributesNS` | type | `Partial<Record<string, AttributesV2>>` (namespace URI → attributes) |
| `EditV2` | type | `Insert \| SetAttributes \| SetTextContent \| Remove \| EditV2[]` |

## Edit V1 Types

| Export | Kind | Shape |
|---|---|---|
| `Update` | type | `{ element: Element; attributes: Attributes }` |
| `Attributes` | type | `Partial<Record<string, AttributeValue>>` |
| `AttributeValue` | type | `string \| null \| NamespacedAttributeValue` |
| `NamespacedAttributeValue` | type | `{ value: string \| null; namespaceURI: string \| null }` |
| `Edit` | type | `Insert \| Update \| Remove \| Edit[]` |

## Event Types

| Export | Kind | Description |
|---|---|---|
| `EditEvent` | type | `CustomEvent<Edit>` — dispatched as `'oscd-edit'` |
| `EditEventV2` | type | `CustomEvent<EditDetailV2>` — dispatched as `'oscd-edit-v2'` |
| `EditDetailV2` | type | `{ edit: E; title?: string; squash?: boolean }` |
| `EditEventOptions` | type | `{ title?: string; squash?: boolean }` |
| `OpenEvent` | type | `CustomEvent<OpenDetail>` — dispatched as `'oscd-open'` |
| `OpenDetail` | type | `{ doc: XMLDocument; docName: string }` |
