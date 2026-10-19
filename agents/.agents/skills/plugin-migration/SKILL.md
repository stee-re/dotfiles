---
name: plugin-migration
description: Load when analysing, planning, starting or resuming a legacy OpenSCD plugin migration into a standalone package, including requests to plan without implementing.
---

# Plugin Migration Orchestrator

**Use when** planning or executing a legacy OpenSCD plugin migration.

**Don't use for** individual transformations; the linked recipes own those.

**Escalate to** `iec-61850` when SCL semantics or schema correctness are unclear.

## Sequence

1. **Establish the workspace.** Read its designated worklog, `worklog.md` or
   `<plugin-name>.md`; confirm it matches the request. Ask about mismatches or
   competing logs. In an empty folder, ask whether it is the migration
   destination. Resolve other ambiguous layouts with the user. Do not assume
   `migrations/`, `legacy/`, `libs/`, `template/` or `output/`.
2. **Analyse and document; no implementation.** Follow `reference/step-1.md`.
   Create the agreed worklog using `reference/migration-worklog-template.md`,
   not the generic template; preserve suitable existing logs. Inventory only
   the selected plugin and its dependencies. Record resources, source state,
   technical findings, decisions and phased verification. Load `scl-lib`,
   `oscd-api` and `oscd-ui` for relevant API questions. Ask unresolved questions
   one at a time and record answers. Use
   [oscd-plugin-scafold](https://github.com/OMICRONEnergyOSS/oscd-plugin-scafold)
   as the target basis; see `reference/step-2.md`.
3. **Approval gate.** Save the full technical analysis and plan. Tell the user
   where it is and to review and approve it. Stop. Record explicit approval
   and its scope before implementation; material revisions need renewed approval.
4. **Implement approved phases only**, preserving behavior without unrelated
   logic changes and recording legacy defects separately:

   | Phase | Guidance | Exit |
   |---|---|---|
   | Standalone scaffold/adaptations | `reference/step-2.md` | Builds/renders; unused plugin purged |
   | Deprecated actions | `editv1-to-editv2`, `oscd-api` | EditV2; behavior preserved |
   | Supported wizards | `scl-dialogs-embedding` | Gaps recorded; valid edits |
   | Legacy UI | `mwc-to-oscd-ui`, `oscd-ui` | Replaced; renders |
   | Host-independent dialogs | `scl-dialogs-embedding` | Embedded; events contained |

   Reconcile partial prior conversions before scheduling work. Update Step
   Status and use `worklog-completion-summary` after each phase.

## Verify

Planning: the populated worklog exists; resources resolve or are explicitly
blocked; questions and answers are recorded; prerequisites and exit criteria
are concrete; approval is pending, not inferred. No code was copied, migrated
or scaffolded, and no dependencies were installed.

Implementation: follow the approved phase checks, including
`npm i` -> `npx tsc --noEmit` -> `npm run build` after structural changes.
Verify applicable tests and demo behavior, and that `dist/` contains only
intended build artifacts (`rootDir: ./src`). Record outcomes before proceeding.

## Reference

| File | Read when |
|---|---|
| `reference/step-1.md` | Starting analysis or reconciling a migration plan |
| `reference/migration-worklog-template.md` | Creating or checking the migration worklog |
| `reference/step-2.md` | Planning or executing standalone scaffolding |
| `reference/anti-patterns.md` | Checking phase readiness or investigating a migration failure |
