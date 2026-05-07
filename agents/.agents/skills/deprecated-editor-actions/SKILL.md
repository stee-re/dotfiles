---
name: deprecated-editor-actions
description: Shared background plugin providing deprecated Create/Delete/Move/Update/ComplexAction types and editor-action event bridge for Step 2. Temporary until Step 3 converts to EditV2.
---

# Recipe: Deprecated Editor Actions via Shared Background Plugin

## Architecture

`@omicronenergy/oscd-background-editor-action` provides:

1. **Exported deprecated types and `newActionEvent`** — plugins import these directly
2. **Background plugin element** — listens on `document` for `'editor-action'`, converts to EditV2, dispatches `newEditEventV2`

## Exported Symbols

### Types (import type)

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

### Runtime

| Symbol | Purpose |
|---|---|
| `newActionEvent` | Dispatches `'editor-action'` CustomEvent `{ bubbles: true, composed: true }` |

### Default export

| Symbol | Purpose |
|---|---|
| `OscdBackgroundEditorAction` | Background plugin element (register in demo) |

## Usage in Migrated Plugins

```ts
import type { ComplexAction, Delete } from '@omicronenergy/oscd-background-editor-action';
import { newActionEvent } from '@omicronenergy/oscd-background-editor-action';
```

Do NOT create local `src/foundation/deprecated-editor-actions.ts`.

## Demo Setup

```js
// demo/plugins.js
import OscdBackgroundEditorAction from '@omicronenergy/oscd-background-editor-action';
registry.define('oscd-background-editor-action', OscdBackgroundEditorAction);

// Add to background array:
{ name: 'Legacy Editor Action Bridge', icon: 'none', requireDoc: true, tagName: 'oscd-background-editor-action' }
```

## Event Flow

```
Plugin dispatches 'editor-action' (deprecated)
  → document listener (oscd-background-editor-action)
  → Converts EditorAction → V1 Edit → V2 EditV2 (via convertEdit)
  → Dispatches newEditEventV2(editV2)
  → oscd-shell 'oscd-edit-v2' handler
  → XMLEditor.commit(editV2) → docVersion += 1 → re-render
```

## Lifecycle

**Temporary for Step 2 only.** Removed in Step 3 when all code converts to EditV2:
- Remove `@omicronenergy/oscd-background-editor-action` from package.json
- Remove background plugin from demo/plugins.js
- Add `@openscd/oscd-api` as direct dependency

## Verification

- No `@openscd/core` imports remain
- No local `deprecated-editor-actions.ts` exists
- Background plugin registered in demo/plugins.js
- Edit events dispatch as `'editor-action'` and bridge applies changes
- Subscribe/unsubscribe operations update document and UI

## Anti-Patterns

- Adding `@openscd/core` as npm dependency
- Adding `@openscd/oscd-api` to plugin during Step 2 (use background plugin)
- Creating local deprecated type definitions
- Embedding conversion logic in each plugin
- Using `any` as placeholder for these types
- Converting to EditV2 during Step 2 (that's Step 3)
