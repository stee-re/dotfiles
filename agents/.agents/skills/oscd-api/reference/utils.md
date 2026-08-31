# Runtime Functions (`@openscd/oscd-api/utils.js`)

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
