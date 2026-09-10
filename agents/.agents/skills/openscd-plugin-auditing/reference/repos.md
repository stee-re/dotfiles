# Known repos and their compliant baselines

Canonical identity only — never hardcode a personal absolute path here, it
won't survive a machine change and can't be shared. At audit time: check the
`~/code/<org>/<repo>` convention first; if not found, ask the user for the
local checkout path rather than cloning speculatively.

For each host below: the properties/events it sets when a plugin is fully
compliant. For what's legacy/extension/unshimmable instead, see
`known-unsupported.md`.

## `openscd/open-scd` → `@openscd/open-scd` / `@compas-oscd/open-scd`

Local checkout convention: `~/code/stee-re/open-scd`. Also contains
`packages/core` (`@openscd/core`), a foundation/utility library, NOT a
plugin-instantiating host — don't confuse the two.

### `@compas-oscd/open-scd@0.35.3`

Used by `com-pas/compas-open-scd`, pinned. Ground truth: the single render
call site instantiating every menu/editor/validator plugin tag,
`packages/openscd/src/addons/Layout.ts:renderPluginContent`. Event ground
truth: `packages/openscd/src/open-scd.ts` and
`packages/openscd/src/addons/Editor.ts:connectedCallback`.

Cross-checked against `sprinteins/open-scd@0.34.0` (pre-rename
`@openscd/open-scd`, same file structure, local checkout convention
`~/code/sprinteins/open-scd`): identical property and event set — this
contract is stable across at least 0.34.0–0.35.3, not new in 0.35.3.

**Compliant properties:** `doc`, `docName`, `docs`, `locale` — all from
`addons/Layout.ts:renderPluginContent`.
`editor` — same site, but typed `XMLEditor`, not `Transactor<EditV2>` (same
name, different shape).

**Compliant events (all `listens`):** `oscd-edit-v2`, `oscd-open` — both from
`addons/Editor.ts:connectedCallback`.

**Note:** this host never sets `docVersion` at all — `editCount` is its only
change counter (see `known-unsupported.md`), not an addition alongside one.

## `com-pas/compas-open-scd`

The monorepo under audit. Pins `@compas-oscd/open-scd@0.35.3` (contract
above). Plugins are scattered across local `src/` (compas-editors, menu,
validators, locamation, addons), an npm dep `@compas-oscd/plugins`, and 11 git
submodules under `packages/external-plugins/` — always find the actual plugin
registry (`compas-plugins.ts`/`oscd-plugins.ts`/`public/js/plugins.js`) rather
than assuming the folder layout is the full list.

## `openscd/open-scd-core` — not fully catalogued

`@openscd/open-scd-core@1.0.1`, separate standalone rewrite (`Plugging`/
`Editing` mixins). Smaller property surface (`doc`/`docName`/`docs`/`locale`/
`editCount`, no `docId`/`pluginId`/`nsdoc`/`plugins`/`oscdApi`). Investigated
and found to reveal nothing beyond `@compas-oscd/open-scd`'s entry above —
don't re-investigate unless a newer major version ships. **Not** a good
reference implementation despite being newer/leaner; see `oscd-shell` below
for one.

## `omicronenergy/oscd-shell` — a compliant reference *implementation*, not the source of truth

**The actual standard is the documented `Plugin` interface in
`@openscd/oscd-api`** (see the `oscd-api` skill for its exact shape —
`doc`/`docName`/`docs`/`locale`/`editor`/`docVersion`). `oscd-shell` is simply
a host that implements it faithfully in practice, which makes it useful for
empirically cross-checking "does a real host actually behave the way the
contract says" — it is not itself the contract, and if it ever drifts from
`@openscd/oscd-api` that drift should be flagged, not treated as correct by
definition.

`@omicronenergy/oscd-shell@0.0.14`. Local checkout convention:
`~/code/stee-re/oscd-shell`. Read directly from `src/oscd-shell.ts`,
`renderPlugin()` (properties) and `connectedCallback()` (event listeners).

Purpose-built to be a strict, current implementation of the `Plugin`
contract — no `docId`/`pluginId`/`nsdoc`/`plugins`/`oscdApi` extension
properties, no `editor-action`/`open-doc`/v1 `oscd-edit` legacy listeners at
all. Use it as a working example when classifying other hosts/plugins, but
classify *against `@openscd/oscd-api`'s documented shape first* — this entry
is corroborating evidence, not the rule itself.

**Properties observed (matching `@openscd/oscd-api`):** `doc`, `docName`,
`docs`, `locale`, `docVersion` (the only host catalogued so far that actually
sets this; incremented in undo/redo and edit handlers) — all from
`src/oscd-shell.ts:renderPlugin`.

**Open gap, even here:** `editor` is concrete type `XMLEditor`
(`@openscd/oscd-editor`), same as legacy hosts — **not confirmed** to
structurally satisfy `Transactor<EditV2>` as documented in `@openscd/oscd-api`.
Don't assume this reference implementation is 100% exact on this point; it's
unverified, not confirmed-compliant.

**Events observed:** `oscd-open`, `oscd-edit-v2` — both grounded in
`@openscd/oscd-api`'s own `OpenEvent`/`EditEventV2` types (`edit-types.md` in
the `oscd-api` skill documents these exact dispatch names). `oscd-rename`,
`oscd-close`, `oscd-undo`, `oscd-redo` are **not** part of `@openscd/oscd-api`
at all — plain string-literal listeners defined by `oscd-shell` itself
(`src/oscd-shell.ts:237-254`). Treat these four as a host convention, not a
contract requirement: a plugin not using them isn't non-compliant, and a
plugin depending on them isn't validated against `@openscd/oscd-api` — only
against this one host's extra behaviour. All from
`src/oscd-shell.ts:connectedCallback`.

**Notes:**
- No `docId`/`pluginId`/`nsdoc`/`plugins`/`oscdApi` anywhere in
  `oscd-shell.ts` — confirmed absent, not just unread by plugins checked so
  far.
- No `editor-action`/`open-doc`/v1-shape `oscd-edit` listeners at all. A
  plugin dispatching only those legacy event names is **silently ignored**
  here — the inverse compatibility risk from the property side: legacy hosts
  mostly tolerate modern plugins, but this host does not translate for
  plugins built only against the legacy event contract.
- `editCount` is deliberately kept as a live alias of `docVersion` here — see
  `known-unsupported.md` for why it's listed as legacy but not actually stuck.

## Other repositories referenced but not (fully) catalogued

| Org/repo | Package | Status |
|---|---|---|
| `omicronenergy/oscd-background-editv1` | `@omicronenergy/oscd-background-editv1` | Shim, see `known-unsupported.md` |
| `omicronenergy/oscd-background-editor-action` | `@omicronenergy/oscd-background-editor-action` | Shim, see `known-unsupported.md`; local checkout location not confirmed — ask the user directly rather than searching broadly |
| `omicronenergy/oscd-background-wizard-events` | `@omicronenergy/oscd-background-wizard-events` | Shim, see `known-unsupported.md` |
| `omicronenergy/oscd-scl-dialogs` | `@omicronenergy/oscd-scl-dialogs` | The modern/compliant dialog pattern; not a shim |
| `transpower-nz/open-scd` | unknown | Known to exist (referenced in a prior scaffold, `~/code/stee-re/oscd-plugins-catalog`) but not read at all |

## Gaps to fill on a future pass

The "sideways" facet (host/DOM reach-through, e.g.
`document.querySelector('open-scd')`, cross-plugin coupling) is in scope but
not yet investigated for any host.
