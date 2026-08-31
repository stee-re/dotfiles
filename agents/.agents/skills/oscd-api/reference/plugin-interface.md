# Plugin and Transactor Interfaces

Type-only exports from the main entry `@openscd/oscd-api`.

## Plugin Interface

| Property | Type | Description |
|---|---|---|
| `editor` | `Transactor<EditV2>` | Transaction manager |
| `docs` | `Record<string, XMLDocument>` | All open documents |
| `doc` | `XMLDocument` | Current SCL document |
| `docName` | `string` | Current document name |
| `docVersion` | `unknown` | Change counter (replaces legacy `editCount`) |
| `locale` | `string` | Current locale |

## Transactor Interface

| Method/Property | Type | Description |
|---|---|---|
| `commit` | `(edit: EditV2, options?: CommitOptions) => void` | Apply edit |
| `undo` | `() => void` | Undo last commit |
| `redo` | `() => void` | Redo last undo |
| `subscribe` | `(cb: TransactedCallback) => () => void` | Listen for commits |
| `past` | `Commit[]` | Undo stack |
| `future` | `Commit[]` | Redo stack |
