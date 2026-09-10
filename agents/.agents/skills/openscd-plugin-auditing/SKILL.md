---
name: openscd-plugin-auditing
description: Audit a plugin's compliance with the documented @openscd/oscd-api Plugin interface. Can first refresh its own prebaked repo/plugin/legacy-term catalogue if asked or needed. Not for edit conversion or new host code.
---

# OpenSCD Plugin Auditing Orchestrator

**Use when** auditing a plugin's compliance with the documented
`@openscd/oscd-api` `Plugin` interface — what properties/events beyond
`doc`/`docName`/`docs`/`locale`/`editor`/`docVersion`/`oscd-edit-v2` it
depends on, and whether a shim bridges the gap. Also refreshes its prebaked
repo/plugin/legacy-term catalogue first, on request or when something
needed isn't catalogued yet.

**Don't use for** — EditV1→EditV2 conversion: `editv1-to-editv2`. Deprecated
action types in migration Step 2: `deprecated-editor-actions`. The contract
shape itself: `oscd-api`.

**Escalate to** — `iec-61850` if a flagged mechanism changes SCL structure
in a way whose correctness is unclear.

## Before starting

Hosts accumulate host-specific properties and legacy event/wizard support
over time; compliance can't be inferred by pattern-matching plugin code.
Auditing is the job; the other three exist only to keep repeat audits
cheap — pick one first; `ask_user` if unclear. Default to Audit. A
standalone plugin repo (not in `repos.md`) declares its expected host via
its own `demo/` folder (e.g. `demo/plugins.js`).

## Sequence

| Job | Goal | Load |
|---|---|---|
| Update repos | New/changed host or repo entry | `reference/job-repo-discovery.md` |
| Update plugin inventory | Matches real plugin registry | `reference/job-plugin-discovery.md` |
| Refresh legacy terms | Vocabulary matches current behaviour | `reference/job-legacy-refresh.md` |
| Audit (default) | Bucketed, cited verdict | see below |

**Audit:** confirm repo/plugin are catalogued (else run that job); classify
each dependency — compliant / shimmable-reliable / shimmable-unproven /
unsupportable — against `known-unsupported.md`, whose standard is
`@openscd/oscd-api`'s `Plugin` interface, not any one host (`oscd-shell` is
only a compliant implementation for cross-checking). Check builder-function
indirection too. Record per `audit-report-template.md`.

## Rules

- Grep only literal `dispatchEvent(` and you will miss helper indirection.
- Same name across hosts is not proof of same shape or type.
- State shim reliability explicitly — never average.
- Load only the current job's reference doc, not all four.

## Verify

Every property/event classification cites the exact host **and** plugin
source file/function it was read from. A claim with no citation is a guess
and must be re-derived.

## Reference

| File | Read when |
|---|---|
| `reference/job-repo-discovery.md` | Job = update repos |
| `reference/job-plugin-discovery.md` | Job = update plugin inventory |
| `reference/job-legacy-refresh.md` | Job = refresh legacy terms |
| `reference/repos.md` | Any job — locating a monorepo/host and its observed baseline |
| `reference/plugins.md` | Any job — the plugin inventory |
| `reference/known-unsupported.md` | Audit job — classifying a property/event/builder/shim |
| `reference/audit-report-template.md` | Audit job — the exact shape to record a finding in |
| `reference/audit-report.md` | Audit job — prior findings and where to append/update |
