---
name: worklog-completion-summary
description: Structure for a "Step N Completion Summary" worklog entry. Use when finishing a unit of multi-step work and recording it in a repo worklog (REFACTORING.md, a migration brief, etc.).
---

# Worklog Completion Summary

**Use when** finishing a step, phase, or discrete unit of work that must be
recorded in a repo worklog (e.g. `REFACTORING.md`, a migration brief under
`migrations/*.md`) so a later session or reviewer can pick up without
re-deriving what happened.

**Don't use for** the worklog's overall structure (Metadata, Step Status, plan
sections) — those are repo-specific; this skill only shapes the per-step
summary block appended once a step is done.

## Rules

Append one `## Step N Completion Summary` heading per completed step, directly
after the worklog's `## Step Status` list, and flip that step's status line to
`done` in the same edit.

Break the summary into `###` subsections, using only the ones that apply —
never force an empty one:

- **Issues found** — `### <Category> found during <activity> (all fixed)`.
  Numbered list; each item bold-names the symptom, then explains root cause
  and fix in prose. Use for anything discovered by running/testing that
  wasn't visible from reading code alone.
- **Files created / copied / transformed** — one subsection per category,
  bullets as `` `path` — one-line description of role or transformation ``.
- **`<X>` replacements applied** — bullets as
  `` `symbol` — from `source` (replaces `old`, reason if non-obvious) ``. Use
  when swapping libraries or APIs.
- **Bug fixes / code-smell corrections** — bullets as
  `` `location`: `before` → `after` (why, and confirm no behaviour change) ``.
- **Known legacy bugs preserved (flagged for review)** — bullets naming the
  bug, its location, and why it's out of scope now. Never silently fix what
  you were asked to preserve.
- **Dead code after Step N** — bullets naming the file or symbol and why it's
  now unreferenced.
- **Verification** / **Build and type-check results** — the exact commands
  run and their pass/fail outcome. Never omit if any command was run.
- **Decision points applied** — reference decision labels (e.g. `DP-1`)
  defined elsewhere in the worklog, naming which option was chosen.

Write each bullet as a fact a future session can act on without re-reading the
diff: what changed, where, and why — not narration of the process.

## Verify

The entry is complete if a reader who has not seen the diff could answer, from
the summary alone: what files changed, what was verified (commands + results),
and what was deliberately left broken or deferred.

## Reference

| File | Read when |
|---|---|
| `reference/example.md` | Want a concrete worked example before writing the first entry in a new worklog |
