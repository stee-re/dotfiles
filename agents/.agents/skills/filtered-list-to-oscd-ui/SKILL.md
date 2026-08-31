---
name: filtered-list-to-oscd-ui
description: Replace monorepo <filtered-list> from @openscd/open-scd/src/filtered-list.js with oscd-ui lists, preserving filter, search, single/multi-select, and check-all behavior.
---

# Replace Legacy filtered-list With oscd-ui Alternative

**Use when**
- Imports from `@openscd/open-scd/src/filtered-list.js` or `<filtered-list>` tags appear in a plugin.
- List code assumes built-in filtering, or depends on items being hidden rather than removed.

**Don't use for** — other `@openscd/open-scd` sub-paths (`$legacy-foundation-helpers`), other deprecated MWC components (`$mwc-to-oscd-ui`), or oscd-ui API details (`$oscd-ui`).

## Problem

`<filtered-list>` from `@openscd/open-scd/src/filtered-list.ts` is monorepo-only and bundles a built-in text filter, item hiding by rendered text or value, optional "check all", single- and multi-select modes, and legacy MWC list semantics.

## Procedure

1. Remove legacy `filtered-list` imports and tags.
2. Pick the oscd-ui replacement — candidates: `OscdActionList`, `OscdSelectionList`, `OscdFilterButton`. Do NOT assume its API matches legacy.
3. Add the import plus a `scopedElements` registration.
4. Map legacy configuration (single-select, multi-select, activatable) to the modern API.
5. Rework filter behavior if the new component expects a different data structure, and "check all" flows if it provides none.
6. Update event handling where selection event names or payloads differ.
7. Update tests to assert behavior, not implementation details.

## Pitfalls

- Copying `@openscd/open-scd/src/filtered-list.ts` into the standalone plugin.
- Assuming a tag rename suffices, or mixing legacy and modern list semantics on one screen.
- Reintroducing monorepo helpers through deep imports.
- Legacy hides items by rendered content — the replacement may need explicit data wiring.
- Legacy checklist support may require a separate bulk-selection UI.
- Legacy inherits MWC list semantics — verify event names and payloads.

## Verify

- No legacy `filtered-list` imports remain
- Filtering narrows visible options correctly and drops no items
- Selection works for keyboard and pointer, without breaking keyboard navigation
- Multi-select preserves intended selected state
- Bulk-select behavior works where legacy supported it
