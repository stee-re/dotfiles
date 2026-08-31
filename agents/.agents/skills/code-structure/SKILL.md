---
name: code-structure
description: Read before writing or reviewing a `.ts` scoped web component — member order, naming, imports, CSS order, bindings, spec placement.
---

# Code Structure & Conventions

**Use when** authoring or reviewing a component/module file in migrated plugin
code; placing a member, style rule, or `.spec.ts`.

**Don't use for** — `scoped-elements` (mixin setup, registration),
`test-hardening` (test reliability), `oscd-ui`/`oscd-api` (which components and
APIs to call). This skill governs file shape.

## Rules

- **File name** = kebab-case of the CamelCase class name.
- **Import groups**, blank-line separated: external, relative, type-only.
- **Exports**: one default export per component file (the class); named for
  types, interfaces, utilities — child utilities export named only.
- **Decorators** on their own line above the declaration.
- **Control flow**: no one-liner `if`; the `if` line always ends with `{`.
- **Bindings**: `.property=${value}` over `attribute="${value}"`; `@event` in
  templates, not `addEventListener` (unless the target is outside it).
- **Event dispatch**: cross-component state changes use
  `this.dispatchEvent(new CustomEvent(...))`, never DOM manipulation;
  `{ bubbles: true, composed: true }` absent a specific reason.
- **Type assertions**: type guards or narrowing over `as`.
- **Naming**: handlers `handle<What>`; sub-renderers `render<What>`.
- **Spelling**: code always uses American English — identifiers, types, file
  and directory names, symbols, comments — even when prose around it is
  British. Markdown prose exempt.
- **Boolean checks**: explicit for nullability (`element !== null`,
  `items.length > 0`); bare `if (isValid)` fine for booleans.
- **Template conditionals**: ternary with `nothing`, never `if` in templates.
- **Test co-location**: each component owns a sibling `.spec.ts`; a parent spec
  tests its own orchestration only, never child internals; extracted code takes
  its tests.

### Class member order

1. `static scopedElements`
2. `@property` (public reactive)
3. `@state` (private reactive)
4. `@query`
5. `@queryAll`
6. Constructor
7. Lifecycle methods, in lifecycle order
8. Handlers (`handle*`)
9. Private methods (logic, helpers)
10. Sub-renderers (`render*`)
11. `render()`
12. `static styles`

### CSS order in `static styles`

1. `*` — variable overrides and declarations
2. Host/container — `:host`, `.container`, layout
3. Top-to-bottom UI order — what the user sees first
4. Specific/nested rules, roughly in visual order

## Verify

- `npm run lint`, `npx tsc --noEmit`, `npm test` pass.
- Ordering, naming, spelling are not lint-enforced — re-read the changed file
  against both lists; confirm each component has a sibling spec.

## Reference

| File | Read when |
|---|---|
| [`reference/examples.md`](reference/examples.md) | A rule is disputed: correct/wrong examples, annotated member-order block, rationale. |
