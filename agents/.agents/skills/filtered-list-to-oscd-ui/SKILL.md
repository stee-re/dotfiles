---
name: filtered-list-to-oscd-ui
description: Replace legacy monorepo filtered-list with oscd-ui filtered list alternative. Covers filter, search, selection, and checklist behavior preservation.
---

# Recipe: Replace Legacy filtered-list With oscd-ui Alternative

## Problem

Legacy plugins use `<filtered-list>` from `@openscd/open-scd/src/filtered-list.ts`. It's monorepo-only and combines:
- Built-in text filter
- Item hiding based on rendered text or value
- Optional "check all" behavior
- Single-select and multi-select modes
- Legacy MWC list semantics

## Detection

- Imports from `@openscd/open-scd/src/filtered-list.js`
- `<filtered-list>` tags in templates
- List code assuming built-in filtering
- Logic depending on items being hidden rather than removed

## Replacement Target

Use the `oscd-ui` alternative. Do NOT assume the API is identical to legacy.

Candidates from oscd-ui: `OscdActionList`, `OscdSelectionList`, `OscdFilterButton`

The replacement must preserve:
- Users can filter long lists quickly
- Selection works in single-select and multi-select flows
- Checklist flows support bulk selection where legacy supported it
- Filtering doesn't drop items or break keyboard navigation

## Required Edits

- Remove legacy `filtered-list` imports
- Add oscd-ui replacement import and scopedElements registration
- Replace `<filtered-list>` tags with modern equivalent
- Map legacy configuration (single-select, multi-select, activatable) to modern API
- Rework filter behavior if new component expects different data structure
- Rework "check all" flows if not provided by new component
- Update event handling if selection events use different names/payloads
- Update tests to assert behavior not implementation details

## Anti-Patterns

- Do NOT copy `@openscd/open-scd/src/filtered-list.ts` into standalone plugin
- Do NOT assume a tag rename is sufficient
- Do NOT mix legacy and modern list semantics in the same screen
- Do NOT reintroduce monorepo helpers through deep imports

## Verification

- No legacy `filtered-list` imports remain
- Filtering narrows visible options correctly
- Selection works for keyboard and pointer
- Multi-select preserves intended selected state
- Bulk-select behavior works where legacy supported it

## Known Exceptions

- Legacy component hides items by rendered content — replacement may need more explicit data wiring
- Legacy includes optional checklist support — may need separate UI for bulk selection
- Legacy inherits MWC list semantics — event names/payloads must be checked
