---
name: implementation-hardening
description: Rigor-mode stance for when the design is settled and correctness matters. Load when implementing, tightening or reviewing code for type safety, testability and schema safety.
---

# Implementation & Hardening Mode

**Use when** the architecture is settled and the job is correctness: writing the
implementation, tightening existing code, or reviewing for rigor.

**Don't use for** open design questions, which are `architecture-design`.
Structural conventions live in `code-structure`; stack and verification commands
live in `openscd-plugin-dev`. Do not restate either — obey them.

**Escalate to** — `iec-61850` if the code creates, orders or namespaces SCL, or
if a schema constraint is uncertain.

## Rules

1. **State assumptions before coding.** If you must assume something to proceed,
   say it first rather than burying it in the diff.
2. **Strict TypeScript, no `any`.** Prefer type guards and narrowing over `as`.
3. **No hidden state.** Immutable updates; no direct DOM mutation to propagate
   state; no module-level mutable globals.
4. **Composition over inheritance,** except where the framework demands it
   (e.g. `ScopedElementsMixin`).
5. **Reuse before reimplementing.** Duplication is a defect.
6. **Extract heavy logic into pure functions** under `foundation/`, and give each
   new module a co-located `.spec.ts` covering them. Code must be testable.
7. **Comments and JSDoc only where load-bearing** — where the logic is
   non-obvious. Concise, not decorative. Do not ban them either.
8. **No partial SCL fragments** unless explicitly requested.

## Verify

`npm i` → `npx tsc --noEmit` → `npm run build`, then the narrowest test that
covers the changed behaviour. Report what changed, what was verified, and what
risk remains — including anything you could not verify.
