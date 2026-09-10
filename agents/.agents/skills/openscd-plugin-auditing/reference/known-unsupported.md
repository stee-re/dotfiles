# Known-unsupported / legacy / shimmable vocabulary

Everything a plugin might depend on that is *not* part of the documented
`@openscd/oscd-api` `Plugin` contract (the actual standard — see the
`oscd-api` skill for its exact shape), what bucket it falls into, and — where
a bridge exists — how reliable that bridge actually is. `omicronenergy/oscd-shell`
is used throughout as a compliant reference *implementation* for empirical
cross-checking (does a real host really behave this way), not as the
standard itself — don't cite it as the rule, cite `@openscd/oscd-api`. Never
average shim reliability across shims; state each one's status explicitly.

Buckets: **compliant** (matches the `@openscd/oscd-api` `Plugin` contract) /
**shimmable-reliable** (deployed, proven bridge) / **shimmable-unproven** (a
bridge exists in principle, never deployed) / **unsupportable** (no bridge is
possible at all).

## Extension properties (host-specific, no equivalent in `@openscd/oscd-api`)

Confirmed absent from `oscd-shell.ts` directly (not just unread by plugins
checked so far) — consistent with them having no place in `@openscd/oscd-api`'s
documented `Plugin` interface either: `docId`, `pluginId`, `nsdoc`, `plugins`,
`oscdApi` — all present in `@compas-oscd/open-scd`'s render call site
(`addons/Layout.ts:renderPluginContent`). A plugin depending on any of these
is **unsupportable** without a rewrite: no shim path exists.

| Property | Meaning | Bucket |
|---|---|---|
| `docId` | CoMPAS backend document UUID | unsupportable |
| `pluginId` | Plugin's own `src`, self-identification | unsupportable |
| `nsdoc` | Parsed `*.nsdoc` data + label-extraction helper | unsupportable |
| `plugins` | Full list of configured plugins, passed to every instance | unsupportable |
| `oscdApi` | Per-plugin `OscdApi` instance; not observed in use locally | unsupportable |

## `editCount` — legacy name, not actually stuck

Special case: on legacy hosts, `editCount` is the *only* change counter
(`docVersion`, the property `@openscd/oscd-api` actually documents, is never
set at all). `oscd-shell` (checked) deliberately keeps `editCount` as a
**live alias of `docVersion`** (`.editCount=${this.docVersion}` right next to
`.docVersion=${this.docVersion}` in `src/oscd-shell.ts:renderPlugin`) — not
dropped, not stale. A plugin reading only `editCount` (and nothing else
non-portable) is not a compliance violation on a host that keeps this alias
live — don't flag it as a problem on its own, but note it's the legacy name,
not the documented one.

## Edit-event generations

| Generation | Event | Builder function | Source | Bucket |
|---|---|---|---|---|
| Current (EditV2) | `oscd-edit-v2` | `newEditEventV2` | `@openscd/oscd-api/utils.js` (also `packages/core/foundation/edit-event.ts` in the legacy lineage) | compliant — every host checked listens for this |
| Previous (EditV1) | `oscd-edit` | `newEditEvent`, explicitly `@deprecated` in source | `packages/core/foundation/deprecated/edit-event.ts` | shimmable-reliable via `oscd-background-editv1` |
| Very old (EditorAction) | `editor-action` | `newActionEvent`, types `Create`/`Delete`/`Move`/`Replace`/`Update`/`SimpleAction`/`ComplexAction` | `@omicronenergy/oscd-background-editor-action` | shimmable-unproven via `oscd-background-editor-action` |

`oscd-shell` listens only for `oscd-edit-v2` — `oscd-edit` and `editor-action`
only work there if the corresponding shim plugin is installed alongside the
legacy plugin.

## Wizard / dialog mechanisms

| Mechanism | Builder(s) | Shape | Bucket |
|---|---|---|---|
| Legacy `wizard` event | `newWizardEvent` (`foundation.ts`, openscd/open-scd lineage) | Detail carries a `WizardFactory` (`() => WizardPage[]`) — executable render content the host must reproduce inline, not a data contract | **unsupportable** — no shim can bridge this generically |
| `oscd-create-wizard-request` / `oscd-edit-wizard-request` / `oscd-close-wizard-request` | `newCreateWizardEvent` / `newEditWizardEvent` / `newCloseWizardEvent` (`@omicronenergy/oscd-background-wizard-events`) | Data-only requests | shimmable-reliable via `oscd-background-wizard-events` |
| Plugin uses `@omicronenergy/oscd-scl-dialogs` directly | n/a | Plugin owns its own dialog rendering, no host mechanism involved | **compliant** — the pattern to recommend |

## Host-convention-only events (outside `@openscd/oscd-api`'s scope)

`oscd-rename`, `oscd-close`, `oscd-undo`, `oscd-redo` — observed as plain
string-literal listeners in `oscd-shell.ts` (`src/oscd-shell.ts:237-254`),
**not** exported or typed anywhere in `@openscd/oscd-api` (see `edit-types.md`
in the `oscd-api` skill for the package's complete event list). Don't classify
these the same way as `oscd-edit-v2`/`oscd-open` — a plugin using them is
depending on one host's convention, not on the documented contract. Support
on other hosts is unconfirmed; check before assuming portability.

## Shims (compatibility bridge plugins)

| Shim | Bridges | Bridges to | Reliability |
|---|---|---|---|
| `oscd-background-editv1` | `oscd-edit` | `oscd-edit-v2` | **reliable** — deployed and well-supported (see also the `editv1-to-editv2` skill for the exact conversion mapping) |
| `oscd-background-editor-action` | `editor-action` | `oscd-edit-v2` | **unproven** — documented (see `deprecated-editor-actions` skill) but never tested/deployed in production; a back-pocket option only |
| `oscd-background-wizard-events` | `oscd-create-wizard-request`, `oscd-edit-wizard-request`, `oscd-close-wizard-request` | rendered dialog (host-side) | **reliable**; does NOT bridge the legacy `wizard` event |

Legacy events not listed as bridgeable by any shim above have no shim — a
plugin depending on them is unsupportable, full stop.

## Other legacy/extension events seen in `@compas-oscd/open-scd`

None of these are part of `@openscd/oscd-api`'s documented contract.

| Event | Bucket | Notes |
|---|---|---|
| `open-doc` | unsupportable | Deprecated, superseded by `oscd-open`; converted internally by the legacy host, but not part of `@openscd/oscd-api` and not translated by `oscd-shell` (checked) — unsupportable unless a dedicated shim is confirmed to exist |
| `add-external-plugin` | legacy | Superseded by `oscd-configure-plugin` |
| `reset-plugins`, `oscd-configure-plugin`, `set-plugins` | extension | CoMPAS-specific plugin-management events, no equivalent in `@openscd/oscd-api` and not translated by `oscd-shell` (checked) |

Not yet catalogued: `newLogEvent`/`newValidateEvent`/`newPendingStateEvent`/
`newSettingsUIEvent` referenced in `open-scd.ts`/`Editor.ts` — worth a
follow-up pass. Also not yet investigated: the "sideways" host/DOM
reach-through facet (see `repos.md`'s gaps section).
