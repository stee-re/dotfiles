# Exported symbols of `@omicronenergy/oscd-background-editor-action`

## Types (import type)

| Symbol | Shape |
|---|---|
| `Create` | `{ new: { parent: Node; element: Node; reference?: Node \| null }; derived?: boolean }` |
| `Delete` | `{ old: { parent: Node; element: Node; reference?: Node \| null }; derived?: boolean }` |
| `Move` | `{ old: { parent: Node; element: Node; reference?: Node \| null }; new: { parent: Node; reference?: Node \| null } }` |
| `Replace` | `{ old: { element: Element }; new: { element: Element } }` |
| `Update` | `{ element: Element; oldAttributes: Record<string, string \| null>; newAttributes: Record<string, string \| null> }` |
| `SimpleAction` | `Create \| Delete \| Move \| Replace \| Update` |
| `ComplexAction` | `{ actions: SimpleAction[]; title: string; derived?: boolean }` |
| `EditorAction` | `SimpleAction \| ComplexAction` |

## Usage in migrated plugins

```ts
import type { ComplexAction, Delete } from '@omicronenergy/oscd-background-editor-action';
import { newActionEvent } from '@omicronenergy/oscd-background-editor-action';
```

## Runtime

| Symbol | Purpose |
|---|---|
| `newActionEvent` | Dispatches `'editor-action'` CustomEvent `{ bubbles: true, composed: true }` |

## Default export

| Symbol | Purpose |
|---|---|
| `OscdBackgroundEditorAction` | Background plugin element (register in demo) |

## Event flow

```
Plugin dispatches 'editor-action' (deprecated)
  → document listener (oscd-background-editor-action)
  → Converts EditorAction → V1 Edit → V2 EditV2 (via convertEdit)
  → Dispatches newEditEventV2(editV2)
  → oscd-shell 'oscd-edit-v2' handler
  → XMLEditor.commit(editV2) → docVersion += 1 → re-render
```

## Demo setup

```js
// demo/plugins.js
import OscdBackgroundEditorAction from '@omicronenergy/oscd-background-editor-action';
registry.define('oscd-background-editor-action', OscdBackgroundEditorAction);

// Add to background array:
{ name: 'Legacy Editor Action Bridge', icon: 'none', requireDoc: true, tagName: 'oscd-background-editor-action' }
```
