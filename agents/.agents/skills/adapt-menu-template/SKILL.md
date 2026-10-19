---
name: adapt-menu-template
description: Load when selecting, pruning or renaming editor/menu entries from oscd-plugin-scafold, or adapting an older menu-only starter during a standalone migration.
---

# Adapt the Plugin Scaffold

**Use when** selecting and adapting the editor/menu starter in an approved
standalone migration.

**Don't use for** initial migration planning (`plugin-migration`), forbidden
monorepo imports (`legacy-foundation-helpers`), translation
(`lit-translate-to-lit-localize`) or general registration (`scoped-elements`).

## Problem

The required basis is `oscd-plugin-scafold`, named/linked by
`../plugin-migration/SKILL.md`. It contains two independent plugins; most
targets need one. The existing skill name remains for compatibility, not as
an instruction to convert every editor from a menu.

## Procedure

1. Read the approved worklog's destination, scaffold revision and required
   plugin kind. Follow `../plugin-migration/reference/step-2.md` for
   materialization and complete unused-plugin removal.
2. Start editors from `src/oscd-editor-scafold.ts`, menus from
   `src/oscd-menu-scafold.ts`; retain both only when required by the plan.
   For a previously approved older menu-only workspace, reconcile its state
   before replacing files; do not discard existing work.
3. Replace retained example behavior with the selected legacy implementation.
   Apply relevant source transformations from `reference/transformations.md`;
   do not repeat conversions already present.
4. Rename files, identifiers, exports, bundles, tests and demo references
   together using `reference/rename-and-demo.md`. Replace placeholder tests
   with behavior checks; editor specs must not call menu-only `run()`.

## Pitfalls

- Leaving the unused source/spec, export, bundle, demo entry or README reference.
- Dropping the multi-entry override while filenames still differ from the
  shared tooling's package-basename convention.
- Replacing Source Editor instead of retaining it alongside the local plugin.
- Treating this recipe as approval to implement during planning.

## Verify

- No discarded plugin or stale starter names in active source, demo, metadata,
  configuration, docs or package artifacts; worklog provenance may retain names.
- Retained components use scoped elements, `docVersion`, Lit 3 and relative
  `.js` imports; no runtime global registration or legacy `editCount`.
- `npm install`, `npx tsc --noEmit`, `npm run build`, `npm run bundle`,
  `npm test` and `npm run lint` pass; retained demo plugins render/run.

## Reference

| File | Read when |
|---|---|
| `reference/transformations.md` | Adapting the retained legacy entry point |
| `reference/rename-and-demo.md` | Renaming entries and wiring tests/demo |
