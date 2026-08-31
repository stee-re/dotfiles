---
name: oscd-api
description: Read before writing OpenSCD edit events, type guards, or Plugin/Transactor properties (newEditEventV2, EditV2, Insert, docVersion), or replacing @openenergytools/open-scd-core.
---

# @openscd/oscd-api API Reference

**Use when**

- Checking the shape of an edit, event detail, or attribute type.
- Dispatching `oscd-edit-v2` / `oscd-open`, or narrowing an edit with an `is*` guard.
- Declaring `Plugin` properties or calling `Transactor` methods.
- Replacing `@openenergytools/open-scd-core` imports or migrating `editCount` to `docVersion`.

**Don't use for** — converting deprecated `Create`/`Delete`/`Move`/`Update`/`ComplexAction` actions: use `editv1-to-editv2`. Supplying those deprecated types in Step 2: use `deprecated-editor-actions`. SCL document helpers: use `scl-lib`.

**Escalate to** — `iec-61850` when the edit changes SCL element structure or namespaced attributes; not needed for event plumbing alone.

## Package

`@openscd/oscd-api` v0.1.6 — edit API and plugin interface contract for standalone OpenSCD plugins.

| Specifier | Contains |
|---|---|
| `@openscd/oscd-api` | Type-only exports (interfaces, type aliases) |
| `@openscd/oscd-api/utils.js` | Runtime functions (event factories, type guards) |

## Import convention

Types from the package root via `import type`. Runtime functions from `@openscd/oscd-api/utils.js` — the `.js` extension is required.

## Symbol index

| Symbols | Documented in |
|---|---|
| `Insert`, `Remove`, `SetAttributes`, `SetTextContent`, `AttributesV2`, `AttributesNS`, `EditV2`, `Update`, `Attributes`, `AttributeValue`, `NamespacedAttributeValue`, `Edit`, `EditEvent`, `EditEventV2`, `EditDetailV2`, `EditEventOptions`, `OpenEvent`, `OpenDetail` | `reference/edit-types.md` |
| `Plugin` (`editor`, `docs`, `doc`, `docName`, `docVersion`, `locale`), `Transactor` (`commit`, `undo`, `redo`, `subscribe`, `past`, `future`) | `reference/plugin-interface.md` |
| `newEditEventV2`, `newEditEvent`, `newOpenEvent`, `convertEdit`, `isInsert`, `isRemove`, `isSetAttributes`, `isSetTextContent`, `isUpdate`, `isEdit`, `isEditV2`, `isComplexEdit`, `isComplexEditV2` | `reference/utils.md` |

## Verify

Run `npx tsc --noEmit`; every signature here is compiler-checked. Then assert the dispatched event name is `'oscd-edit-v2'`, not `'oscd-edit'`.

## Reference

| File | Read when |
|---|---|
| `reference/edit-types.md` | You need the exact shape of an edit, event detail, or attribute type. |
| `reference/plugin-interface.md` | You declare plugin properties or call the editor transaction API. |
| `reference/utils.md` | You dispatch edit/open events or narrow an edit with a type guard. |
| `reference/legacy-mapping.md` | You migrate from `@openenergytools/open-scd-core`, deprecated `@openscd/core/foundation/deprecated/editor.js` actions, or `editCount`. |
