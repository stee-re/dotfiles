# Skill template

Copy this shape when adding a skill. It deliberately has no frontmatter, so it
is never loaded as a skill itself and costs nothing at runtime.

Skills are **progressively disclosed** across three cost tiers:

| Tier | Loaded | Budget |
|---|---|---|
| `description` | always, every session | ≤ 30 words |
| `SKILL.md` body | when the agent opens the skill | ≤ 300 words (≤ 400 for convention skills) |
| `reference/*.md` | only when explicitly read | unbounded |

Push bulk lookup material down a tier. A `description` that summarises contents
instead of stating a trigger wastes the most expensive tokens in the system.

---

```markdown
---
name: <kebab-case, must equal the directory name>
description: <One sentence answering "should I open this?". Names concrete
  triggers — package specifiers, symbols, file patterns, task types. Not a
  summary of contents.>
---

# <Human-readable title>

**Use when** — concrete trigger conditions.

**Don't use for** — the neighbouring skills that cover adjacent ground, and what
they cover instead. Makes routing unambiguous and prevents overlap.

**Escalate to** — `<other-skill>` if <condition>. Optional. Use where a
conditional dependency exists: this skill mostly stands alone, but some tasks
cross into another skill's territory. Cheaper than duplicating that content or
loading it unconditionally.

## <body — see kinds below>

## Verify

Exact commands, exit criteria, or checks that confirm the work is correct.
Never omit. For a pure reference skill, state how to confirm correct usage
(e.g. `npx tsc --noEmit`).

## Reference

| File | Read when |
|---|---|
| `reference/foo.md` | <specific condition> |

Omit only if the skill has no reference files.
```

## Body shape by kind

Section order is always: title → Use when → Don't use for → Escalate to
(optional) → body → Verify → Reference. Only the body varies.

| Kind | Body sections | Example |
|---|---|---|
| **Reference** | `## Package` → `## Import convention` → `## Symbol index` | `oscd-api`, `scl-lib` |
| **Recipe** | `## Problem` → `## Procedure` → `## Pitfalls` | `editv1-to-editv2` |
| **Convention** | `## Rules` | `code-structure`, `iec-61850` |
| **Orchestrator** | `## Sequence` (per step: goal, skills to load, exit criteria) | `plugin-migration` |

## Rules for authors

- Rules live in `SKILL.md`; examples justifying them live in `reference/`.
- Every `reference/` link states *when* to read it, not what it contains.
- One fact, one home. If two skills need it, one owns it and the other links by
  relative path.
- Terse and imperative. No filler, no restating the task back.
