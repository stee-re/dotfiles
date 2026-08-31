---
name: iec-61850
description: IEC 61850 domain law for SCL. Load before creating, ordering, namespacing or validating SCL elements and attributes, or when an Edition or schema constraint is in question.
---

# IEC 61850 / SCL Domain Law

**Use when** the task touches the *meaning* or *validity* of SCL, not merely the
code around it:

- Creating, moving, reordering or deleting SCL elements
- Reading or writing namespaced attributes
- Anything Edition-dependent (Ed1 / Ed2 / Ed2.1)
- Judging whether a structure is schema-valid
- Reviewing legacy SCL manipulation whose correctness is unclear

**Don't use for** work that merely happens inside an OpenSCD repo. CSS, UI
component migration, tooling, test plumbing and code archaeology need none of
this — being in an SCL codebase does not imply doing SCL semantics. Component
style is `code-structure`; the edit API is `oscd-api`; SCL helper functions are
`scl-lib`.

## Rules

1. **Domain correctness outranks fluency.** A confident wrong answer about IEC
   semantics is worse than an admitted gap.
2. **Never fabricate domain certainty.** If a schema constraint or IEC semantic
   is uncertain, stop and say so plainly — "I can't be certain here because the
   constraint depends on…". Do not guess and do not paper over it.
3. **SCL must be schema-valid**: correct element ordering, required attributes,
   correct namespaces. No speculative or toy structures unless explicitly
   labelled illustrative.
4. **Persist via edits, never direct mutation.** Document changes are expressed
   as edits (see `oscd-api`), not by mutating the DOM in place.
5. **Read namespaced attributes with `getAttributeNS(ns, localName)`**, never
   bare `getAttribute` — bare reads silently return the wrong-namespace value.
   This is a common source of invisible bugs; see
   `reference/namespace-testing.md` for a fixture technique that makes the
   mistake fail loudly.
6. **Generalise across the model.** Before committing to a solution for one
   element, check it holds for others — are you hardcoding LN / DO / DA / IED
   assumptions? Does it hold across Editions? Never design only for the easy
   case.
7. **Assume scale.** Large SCL files (1000+ IEDs, deep nesting, frequent edits)
   are normal. Avoid repeated full-document traversals, hidden quadratic loops,
   and expensive recalculation inside reactive updates. Flag scaling risk
   proactively.

## Verify

- Confirm element ordering and required attributes against the schema for the
  declared Edition before claiming validity.
- Where namespace handling matters, prove it with a decoy fixture
  (`reference/namespace-testing.md`) rather than a fixture that merely happens
  to lack unnamespaced attributes.
- If any of the above cannot be confirmed, state the residual uncertainty in the
  final report instead of omitting it.

## Reference

| File | Read when |
|---|---|
| `reference/namespace-testing.md` | Writing or reviewing tests that touch namespaced SCL attributes |
