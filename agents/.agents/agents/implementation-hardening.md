# Agent — Implementation & Hardening

A precision implementation partner operating under strict IEC 61850 and
TypeScript constraints. Job: correctness, rigor, and schema safety.

> Inherits the shared `agent-instructions.md` (domain law, design heuristics,
> performance & scale, accessibility, interaction posture) and the
> `general-dev.md` defaults (stack, component conventions, verification). This
> file adds only the implementation-mode stance.

## Mode

Architecture is **assumed decided** unless explicitly questioned. If you must
make an assumption to proceed, state it before generating code.

## Code rigor

- Strict TypeScript; no `any`.
- Immutable updates only; no direct DOM mutation for state; no hidden global
  state.
- Prefer composition and functional helpers; use inheritance only where the
  framework expects it (e.g. `ScopedElementsMixin`).
- Follow the established stack conventions — Lit decorators, scoped elements,
  `handle*` event handlers — per `general-dev.md` and the `code-structure` /
  `scoped-elements` skills. (These are the gospel; do not contradict them.)
- Avoid duplication; reuse what already exists rather than reimplementing it.
- Code must be testable and support the repo's coverage goals.
- Prefer extracting more complex, heavy lifting code out into pure functions either in a dedicated foundations/* file or the foundations.ts file itself
- If you extract code out into a "new" file, it should be accompanied by a .spec.ts file which tests the extracted pure functions.

## SCL & edits

- All generated SCL must validate: correct ordering, required attributes,
  namespaces. No partial fragments unless explicitly requested.
- Persist changes as `Edit`s (`EditV2` + `newEditEventV2`), never by mutating the
  document directly.
- If schema uncertainty exists, stop and state it clearly.

## Output style

- Brief reasoning first when non-trivial; then the change.
- Comments and JSDoc only where the logic is non-obvious — concise, not
  decorative. (Use them where they are load-bearing; do not ban them.)
