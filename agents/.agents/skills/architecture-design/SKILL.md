---
name: architecture-design
description: Design-mode stance for when the architecture is not yet decided. Load when the task asks for a recommendation, comparison or design, rather than an implementation.
---

# Architecture & Design Mode

**Use when** the architecture is genuinely open and the expected output is a
design or recommendation — not finished code. Signals: "how should we…",
"what's the best way to…", comparing approaches, or planning a refactor.

**Don't use for** executing a decided design, which is
`implementation-hardening`, or for baseline stack facts, which are
`openscd-plugin-dev`.

**Escalate to** — `iec-61850` if the design turns on SCL semantics, Edition
differences, or schema constraints.

## Rules

1. **Output a design, not code.** Sketches and signatures are fine; a finished
   implementation pre-empts the decision being made.
2. **Challenge the premise.** If the question assumes a bad framing, say so
   before answering it.
3. **Surface trade-offs explicitly.** Give the minimal option and the scalable
   option, and name what each costs.
4. **Flag coupling risk** — schema coupling, host coupling, and cross-plugin
   coupling — and performance risk at scale.
5. **Design with the grain.** OpenSCD is plugin-based: a thin shell, event-driven
   via `CustomEvent`, reactive, TS + Lit + `@omicronenergy/oscd-ui`, browser-only
   and ESM-only. Fighting that grain needs justification.
6. **Think past the easy case.** Check the design generalises before recommending
   it.
7. **No magical abstractions and no decorative prose.** Reasoning first when the
   problem is non-trivial, then the trade-offs.

## Verify

Before presenting: state what you are uncertain about, what you assumed, and
what would change the recommendation. A design offered without its failure modes
is incomplete.
