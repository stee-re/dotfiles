# Step 1 - Analysis and documented planning

## Establish context

Resolve the workspace and worklog as directed by `../SKILL.md`. Confirm the
selected plugin, source checkout and migration destination; do not recreate
the historical multi-plugin workspace layout. Keep the source and reference
checkouts read-only. Record implementation write locations separately from
the worklog location; the destination may be the current folder containing
the worklog, not a new output subfolder.

Read an existing matching log and reconcile it against available evidence.
Preserve its filename and useful content; add missing sections rather than
replacing human edits. If absent, populate `migration-worklog-template.md` as
`worklog.md` in the agreed workspace. Do not create both a generic and migration
worklog.

## Bound the investigation

Start with the entry point, package manifest, host contract, direct imports,
tests and fixtures. Trace shared dependencies as needed for this plugin.
Do not inventory unrelated plugins or migrate shared packages opportunistically.
Record exact source revision and relevant working-tree changes; do not switch
branches, pull, reset or otherwise alter the source.

Inspect current code rather than assuming every legacy conversion remains.
Differentiate source repositories, applications consuming published packages,
deployment artifacts and existing standalone output. Missing output does not
prove earlier work was never performed.

Resolve the required `oscd-plugin-scafold` repository named/linked in
`../SKILL.md`, its local location and revision, and inspect its current tooling.
Record whether the target needs editor, menu or both; plan removal of the unused
example and all references. Read `step-2.md` for the removal checklist and exit
criteria. Record missing resources as blockers and ask rather than substituting
another template, fetching without authorization or inventing replacements.
Inspecting the scaffold during analysis does not authorize copying it.

## Populate the worklog

Use the migration-specific template. Document:

- Resources with paths, revisions, relevant files/symbols and access boundaries.
- Feature behavior, component graph, host coupling and shared dependencies.
- Edit events and document mutation, wizard/dialog flows, UI registrations,
  translation, domain-sensitive logic and already-completed conversions.
- Tests/fixtures, known coverage gaps, and validation commands with expected
  outcomes; distinguish commands merely proposed from checks actually run.
- Alternatives, assumptions, risks, preserved legacy defects and questions.
- Ordered phases, prerequisites, per-phase exit checks and approval state.

Use API skills when needed to validate mappings; do not preload every recipe.
Ask unresolved questions one at a time and record answers, rationale and plan
impact. Blocking decisions must be resolved before claiming readiness for
approval; if unanswered, persist partial analysis with a blocked status.

## Stop at the planning boundary

Only planning documents may be created or updated. Do not copy plugin code,
scaffold, transform source, install packages or run commands with source-writing
hooks. Record baseline checks only when safe and relevant.

Read back the populated worklog. Confirm no analysis is stranded only in the
conversation, resources are usable or explicitly blocked, and proposed phases
account for partial conversions. When planning is complete, mark Step 1 done
and record its summary using `worklog-completion-summary`; keep plan approval
pending and implementation blocked. Explain what was documented, identify the
file and outstanding blockers, and state: review and approve the plan before
implementation can start. Stop; do not interpret completion of Step 1 as
approval for Step 2.
