# <Plugin name> migration worklog

Use this template instead of the generic task template. Populate it during
Step 1; remove these authoring directions. Preserve a matching existing log.
Record unknowns honestly and ask questions rather than inventing decisions.

## Goal and scope

- Plugin and requested standalone outcome:
- Behavior and user flows to preserve:
- In scope:
- Out of scope and intentionally deferred changes:
- Agreed migration workspace:
- Planning-document location:
- Approved implementation destination: <not yet approved>
- Read-only source and reference boundaries:

## Resources

Use resolved paths or URLs and revisions. Include everything needed to resume
without repeating the inventory. Locators do not grant additional access.
Mark unavailable resources and their effect on readiness.

| Resource | Location / revision | Role / relevant files or symbols |
|---|---|---|
| Source repository and working-tree state | | |
| Plugin entry point and implementation | | |
| Shared code and package dependencies | | |
| Instructions and applicable skills | | |
| Required oscd-plugin-scafold basis (see [orchestrator](../SKILL.md)) | Local path, revision and working-tree state | Selected editor/menu/both; unused-entry removal plan; tooling |
| Target API/library references | | |
| Existing migration output, if any | | |
| Tests, snapshots and fixtures | | |
| Demo/host and verification configuration | | |

## Technical analysis

### Current behavior and architecture

Describe features, user flows, component/dependency graph, host-provided
properties and services. Cite files and symbols; distinguish facts from
assumptions and intended behavior.

### Migration inventory

Record current implementation and target mappings with evidence. Identify
partial conversions, remaining work, unsupported APIs and domain questions.
Do not schedule completed work again merely because a recipe lists it.

| Area | Current evidence | Target / remaining changes | Dependencies / risks |
|---|---|---|---|
| Package, scaffold and tooling | | | |
| Host contract and reactive properties | | | |
| Edit actions/events and document mutation | | | |
| Foundation/XML helpers and shared code | | | |
| Wizards, dialogs and event routing | | | |
| UI, icons and custom-element registration | | | |
| Translation and source-locale text | | | |
| SCL/domain-sensitive behavior | | | |
| Tests, fixtures and demo | | | |

### Risks, alternatives and preserved defects

Record coupling, behavior-preservation risks, compatibility gaps, scaling
concerns, alternatives and known legacy defects deliberately left unchanged.
Identify which assumptions or source changes would require revising the plan.

## Questions and decisions

Ask each unresolved consequential question and record the user's answer,
rationale, evidence and affected phases. A question listed here is not a
substitute for asking it. Unanswered blockers prevent approval readiness.

| ID | Question / options | Answer / rationale / affected phases | Status |
|---|---|---|---|
| DP-1 | | | open |

## Migration plan

For each phase, include pre-analysis, affected files, concrete changes,
prerequisites, decisions, verification commands and observable exit criteria.
Adapt the outline to inspected evidence while retaining the scaffold check.
Explain already-satisfied conversions; do not claim unperformed verification.

| Step | Goal / changes | Prerequisites / decisions | Verification / exit criteria |
|---|---|---|---|
| 1 | Analysis and populated worklog only | Workspace agreed | Questions resolved; ready for review |
| 2 | Standalone scaffold and initial adaptations | Explicit plan approval; template resolved | Build, type-check, demo and package checks |
| 3 | Remaining deprecated edit actions | Verified scaffold | EditV2; behavior checks |
| 4 | Supported wizard replacements | Relevant edit/API prerequisites | Valid edits; unsupported gaps recorded |
| 5 | Remaining legacy UI | Relevant component prerequisites | Scoped rendering and interaction checks |
| 6 | Host-independent dialog integration | Relevant dialog/UI prerequisites | Embedded dialogs; event routing and regression checks |

### Verification strategy

- Baseline checks actually run, exact commands and outcomes (or not run):
- Build/type-check/install order for implementation:
- Focused tests and fixtures for behavior preservation:
- Runtime flows and supported host/demo checks:
- Artifact/package-content checks:
- Known verification gaps and how they block completion:

## Plan approval

- Plan revision / date:
- Status: pending review
- Unresolved blockers:
- User approval evidence and scope: not yet approved
- Next action: user reviews and approves the plan before implementation.

Planning completion does not authorize copying code, scaffolding, installation
or implementation. Record explicit approval and reconfirm material plan changes.

## Step Status

Use pending, in progress, blocked or done. Explain already-satisfied work with
evidence, not invented completion. Keep planning status separate from approval.

| Step | Status | Evidence / next action |
|---|---|---|
| 1 - Planning | in progress | |
| 2 - Standalone scaffold | blocked | Awaiting plan approval |
| 3 - Edit actions | pending | |
| 4 - Wizards | pending | |
| 5 - UI | pending | |
| 6 - Dialog integration | pending | |

Append `## Step N Completion Summary` entries here as steps finish, using
`worklog-completion-summary`. Record files changed, exact checks/results (or
not run), surprises, decisions applied and deliberately deferred defects.

## Resume and remaining work

- Source/output state last verified:
- Next approved action, or approval needed:
- Deferred work and verification gaps:
- Reusable lessons proposed for the owning instructions or skill:
