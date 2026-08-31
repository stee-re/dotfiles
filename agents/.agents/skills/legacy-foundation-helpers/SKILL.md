---
name: legacy-foundation-helpers
description: Replace @openscd/open-scd imports (foundation.js, foundation/ied.js, nsdoc.js, icons.js, schemas.js, filtered-list.js) with @openscd/scl-lib or local foundation modules.
---

# Replace @openscd/open-scd Foundation Imports

**Use when**
- Any `@openscd/open-scd/src/...` import appears in a plugin being made standalone.
- Symbols such as `identity`, `isPublic`, `compareNames`, `getNameAttribute`, `getSclSchemaVersion`, `SCL_NAMESPACE`, `getFcdaReferences`, or `emptyInputsDeleteActions` need a home.

**Don't use for** — the sub-paths with their own recipes: `$nsdoc-standalone` (`Nsdoc`), `$scl-icons` (`gooseIcon`, `smvIcon`), `$scl-dialogs-embedding` (`newWizardEvent`), `$filtered-list-to-oscd-ui` (`<filtered-list>`), `$legacy-xml-helpers` (`@openscd/xml`).

**Escalate to** — `iec-61850` if a replacement touches SCL semantics: schema version/Edition detection, `SCL_NAMESPACE`, or LN instance numbering.

## Problem

Legacy plugins import from six sub-paths of `@openscd/open-scd`, which is not published on npm, so a standalone plugin cannot depend on it. Each symbol must move to `@openscd/scl-lib`, a small local module, or a dedicated recipe.

## Procedure

1. Inventory every `@openscd/open-scd` import; classify each symbol using `reference/symbol-map.md`.
2. Category 1 — repoint to `@openscd/scl-lib` (`identity`, `isPublic`, `find`, `lnInstGenerator`, `controlBlockObjRef`).
3. Category 2 — create `src/foundation/scl.ts` and `src/foundation/ied.ts` from `reference/local-modules.md`.
4. Category 3 — load the dedicated skill for that symbol.
5. Category 4 — unused symbols: do not copy them.
6. Remove `@openscd/open-scd` from `package.json`; add `@openscd/scl-lib` to dependencies.

## Pitfalls

- Adding `@openscd/open-scd` as an npm dependency (not published).
- Copying the entire 2500-line `foundation.ts`.
- Using `@openscd/scl-lib` for symbols it doesn't export.

## Verify

- No `@openscd/open-scd` imports in any `src/` file
- `@openscd/open-scd` not in `package.json`
- `@openscd/scl-lib` in dependencies
- Local foundation modules compile with strict TypeScript
- No unused symbols imported

## Reference

| File | Read when |
|---|---|
| `reference/symbol-map.md` | Classifying a symbol or sub-path into categories 1-4 |
| `reference/local-modules.md` | Writing `src/foundation/scl.ts` or `ied.ts`, or checking the `emptyInputsDeleteActions` bug fix |
