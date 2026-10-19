---
name: worklog-completion-summary
description: Load when recording completion of a task step or phase in a worklog, including planning; not for creating the initial plan.
---

# Worklog Completion Summary

**Use when** finishing a step, phase, or discrete unit of work that must be
recorded in a task worklog (e.g. `worklog.md`, `<plugin-name>.md` or
`REFACTORING.md`) so a later session or reviewer can pick up without
re-deriving what happened.

**Don't use for** initial worklog creation or overall structure; use the owning
task skill's template, otherwise `~/.agents/reference/worklog-template.md`.

## Rules

Append one `## Step N Completion Summary` heading per completed step, directly
after the worklog's `## Step Status` list, and flip that step's status line to
`done` in the same edit. Preserve existing filename and layout. Completing a
planning step does not approve implementation; keep approval separate.

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
