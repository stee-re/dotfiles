# Shared agent configuration

One source of truth for agent behaviour across Copilot, Codex and OpenCode,
symlinked into each tool's expected location by GNU Stow.

## Why the canonical file isn't called `AGENTS.md`

Each tool looks for a different filename, so the shared file gets a neutral name
and is symlinked into each expected path:

| Tool | Expects | Symlink target |
|---|---|---|
| Codex | `~/.codex/AGENTS.md` | `agent-instructions.md` |
| OpenCode | `~/.config/opencode/AGENTS.md` | `agent-instructions.md` |
| Copilot | `~/.copilot/copilot-instructions.md` | `agent-instructions.md` |

Copilot reads `AGENTS.md` only from a git root or cwd, never from `$HOME` — which
is why that one symlink carries a different name. These are *personal* global
instructions; the `AGENTS.md` files usually discussed are the *repo-level* kind,
committed alongside a project.

## Layout

```
agent-instructions.md   always loaded — universal rules only
skills/
  TEMPLATE.md           the canonical skill shape (no frontmatter, never loaded)
  <name>/SKILL.md       one skill
  <name>/reference/     detail, loaded only on demand
```

## Progressive disclosure

Cost is dominated by what loads *unconditionally*, so content is tiered:

| Tier | Loaded | Budget |
|---|---|---|
| `agent-instructions.md` | every session, every repo | ~400 words |
| Skill `description` | every session, every repo | ≤ 30 words each |
| `SKILL.md` body | when the agent opens that skill | ≤ 300–400 words |
| `reference/*.md` | only when explicitly read | unbounded |

Two rules follow from this:

- **The always-loaded file stays universal.** Anything domain-, stack- or
  repo-specific belongs in a skill. Domain law that loads everywhere is pure
  waste in every session that doesn't need it.
- **A `description` is a routing decision, not a summary.** It answers "should I
  open this?" — nothing else. It is the most expensive text in the system.

## Routing between skills

Every skill declares **Use when** and **Don't use for**, so overlapping skills
resolve unambiguously. Where a skill *sometimes* crosses into another's
territory it declares **Escalate to** — a conditional pointer rather than a
duplicated section or an unconditional load.

The clearest case is `iec-61850`. Nearly every repo here is OpenSCD, but most
tasks in them — CSS, UI migration, tooling, test fixes, code archaeology — need
no IEC 61850 knowledge at all. So the domain law is a skill that SCL-touching
skills escalate to, rather than a permanent tax on every session.

## Adding a skill

Copy `skills/TEMPLATE.md`. It defines the required sections, the body shape for
each kind of skill (reference, recipe, convention, orchestrator), and the word
budgets.
