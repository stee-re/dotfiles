---
name: deprecated-editor-actions
description: Source deprecated Create/Delete/Move/Update/ComplexAction types and newActionEvent from @omicronenergy/oscd-background-editor-action in Step 2, not @openscd/core or local copies.
---

# Deprecated Editor Actions via Shared Background Plugin

**Use when**
- Step 2 code needs `Create`, `Delete`, `Move`, `Replace`, `Update`, `SimpleAction`, `ComplexAction`, `EditorAction`, or `newActionEvent`.
- Those symbols come from `@openscd/core` or a local `deprecated-editor-actions.ts`.
- Wiring the demo so `'editor-action'` reaches the document.

**Don't use for** — Step 3 conversion to EditV2: `$editv1-to-editv2` covers the type mapping, `newEditEventV2` dispatch, and removing this package.

**Escalate to** — `iec-61850` if an action's parent/reference placement or attributes affect SCL element ordering, required attributes, or namespaces.

## Problem

`@openscd/core` is not an acceptable plugin dependency, and per-plugin copies of the deprecated action types drift. `@omicronenergy/oscd-background-editor-action` exports those types plus a background element that listens on `document` for `'editor-action'`, converts it to EditV2, and dispatches `newEditEventV2`.

## Procedure

1. Depend on `@omicronenergy/oscd-background-editor-action` and import from it directly — types via `import type`, `newActionEvent` as a value (see `reference/api.md`).
2. Do NOT create `src/foundation/deprecated-editor-actions.ts`.
3. Register `OscdBackgroundEditorAction` in the `background` array of `demo/plugins.js` — snippet in `reference/api.md`.
4. Step 3 removal: drop the package from `package.json` and the background plugin from `demo/plugins.js`; add `@openscd/oscd-api` as a direct dependency.

## Pitfalls

- Adding `@openscd/core`, or `@openscd/oscd-api` during Step 2 (use the background plugin).
- Local deprecated type definitions, or per-plugin conversion logic.
- Using `any` as a placeholder for these types.
- Converting to EditV2 during Step 2 (that is Step 3).

## Verify

- No `@openscd/core` imports remain
- No local `deprecated-editor-actions.ts` exists
- Background plugin registered in `demo/plugins.js`
- Edit events dispatch as `'editor-action'`; bridge applies changes
- Subscribe/unsubscribe operations update document and UI

## Reference

| File | Read when |
|---|---|
| `reference/api.md` | Exact exported type shapes, event flow, or demo registration snippet |
