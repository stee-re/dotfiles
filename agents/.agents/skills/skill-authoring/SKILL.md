---
name: skill-authoring
description: Creating a new SKILL.md, or restructuring/renaming an existing one or its reference files. Enforces ~/.agents/skills/TEMPLATE.md's shape and word budgets as hard gates, not style guidance.
---

# Authoring Skills

**Use when** creating a new skill directory, editing an existing SKILL.md's
structure/frontmatter, or adding/moving `reference/*.md` files.

**Don't use for** — using an existing skill's content to perform a task; this
only governs authoring the skill files themselves.

## Rules

1. Read `../TEMPLATE.md` in full before writing anything, every time. It has
   no frontmatter by design, so nothing auto-surfaces it — you must open it
   yourself, not rely on having seen it before.
2. Match its section order and its "kind" (Reference/Recipe/Convention/
   Orchestrator) body shape exactly — don't invent a different shape.
3. Its two numeric limits are hard gates, not soft guidance: `description`
   ≤30 words; `SKILL.md` body (Use-when through Pitfalls/Rules, excluding
   Verify/Reference) ≤300 words (≤400 only for Convention-kind skills).
4. Imitating a sibling skill's shape is not proof of compliance — siblings may
   already be in budget without showing you the limit. Always re-check the
   numbers yourself.
5. Push bulk material, examples, and long tables into `reference/*.md`; keep
   `SKILL.md` terse.

## Verify

Run before presenting the skill as done, not after being asked:

```
grep "^description:" SKILL.md | sed 's/^description: //' | wc -w   # <= 30
awk '/^## (Use when|Problem|Rules|Sequence)/,/^## Verify/' SKILL.md \
  | sed '/^## Verify/d' | wc -w                                     # <= 300 (400 convention)
```

Then re-read every rule in `TEMPLATE.md` line by line against the produced
file — don't rely on memory of having followed it once.
