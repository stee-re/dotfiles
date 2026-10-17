# Audit report

Actual audit findings. This is a dated snapshot, not durable truth — re-audit
rather than trust an old entry once a host or plugin version has moved on.

## Summary tables

### com-pas/compas-open-scd (Local plugins: 18 total)

#### Compas Editors (3 plugins)

| Plugin name | Class/File | Status | Non-compliant items |
|---|---|---|---|
| CompasVersions | CompasVersions.ts | ❌ Not compliant | `docId`, `newWizardEvent`, `newOpenDocEvent` |
| Sitipe | Sitipe.ts | ❌ Not compliant | `docId` |
| AutogenSubstation | autogen-substation.ts | ❌ Not compliant | `docId` |

#### Compas Menu (14 plugins)

| Plugin name | Class/File | Status | Non-compliant items |
|---|---|---|---|
| CompasOpen | CompasOpen.ts | ❌ Not compliant | `newOpenDocEvent`, `newLogEvent`, `newPendingStateEvent` |
| CompasCimMapping | CompasCimMapping.ts | ❌ Not compliant | `newLogEvent`, `newOpenDocEvent`, `newPendingStateEvent` |
| CompasImportFromApi | CompasImportFromApi.ts | ❌ Not compliant | `newWizardEvent` |
| CompasSave | CompasSave.ts | ❌ Not compliant | `docId`, `editCount`, `newPendingStateEvent` |
| CompasSaveAs | CompasSaveAs.ts | ❌ Not compliant | `editCount`, `newPendingStateEvent` |
| CompasSaveAsVersion | CompasSaveAsVersion.ts | ❌ Not compliant | `editCount`, `newPendingStateEvent` |
| CompasImportIEDs | CompasImportIEDs.ts | ⚠️ Unconfirmed | Inherits from ImportingIedPlugin (parent not audited) |
| CompasMerge | CompasMerge.ts | ❌ Not compliant | `newWizardEvent` |
| CompasUpdateSubstation | CompasUpdateSubstation.ts | ❌ Not compliant | `newWizardEvent` |
| CompasCompareIED | CompasCompareIED.ts | ⚠️ Unconfirmed | Inherits from CompareIEDPlugin (parent not audited) |
| CompasAutoAlignment | CompasAutoAlignment.ts | ❌ Not compliant | `docId`, `editCount`, `newWizardEvent`, `newPendingStateEvent` |
| ExportIEDParams | ExportIEDParams.ts | ✅ Compliant | None — only uses `doc`, `docName` |
| LocamationVMU | LocamationVMU.ts | ❌ Not compliant | `nsdoc`, `newWizardEvent` |
| CompasSettings | CompasSettings.ts | ❌ Not compliant | `newWizardEvent` |

#### Local plugins summary
- ✅ **Compliant:** 1 (ExportIEDParams)
- ❌ **Unsupportable:** 16
- ⚠️ **Unconfirmed:** 1 (awaiting parent class audit)

### open-scd (sprinteins)

| Plugin name | Class/File | Status | Non-compliant items |
|---|---|---|---|
| IED | IED.js | ⚠️ Unconfirmed | Source not directly inspected |
| Substation | external URL | ⚠️ Unauditable | Source not accessible |

**Summary:** Audit incomplete — external URLs and compiled JS require source retrieval

---

## Detailed findings

### com-pas/compas-open-scd

#### CompasVersions

- **Source:** src/compas-editors/CompasVersions.ts
- **Audited against:** `@openscd/oscd-api@1.0.0` `Plugin` interface
  (target host: `com-pas/open-scd@0.35.3`)
- **Date:** 2026-09-11
- **Dependencies found:**
  - `doc` — compliant — @property XMLDocument (line 50)
  - `docName` — compliant — @property string (line 54)
  - `docId` — unsupportable — @property string, used to fetch versions (lines 52, 68, 79)
  - `newWizardEvent` — unsupportable — legacy wizard event dispatched (lines 150, 212, 239)
  - `newOpenDocEvent` — unsupportable — legacy open-doc event
- **Overall verdict:** ❌ unsupportable
- **Notes:** Plugin depends on `docId` (backend document UUID, unsupported by `@openscd/oscd-api`) and dispatches legacy `wizard` events which have no shim bridge. Not compatible with compliant hosts.

#### CompasOpen

- **Source:** src/menu/CompasOpen.ts
- **Audited against:** `@openscd/oscd-api@1.0.0` `Plugin` interface
  (target host: `com-pas/open-scd@0.35.3`)
- **Date:** 2026-09-11
- **Dependencies found:**
  - `newOpenDocEvent` — unsupportable — legacy open-doc event dispatched (line 37)
  - `newLogEvent` — legacy/unsupported — logging event (line 35)
  - `newPendingStateEvent` — unsupported — internal host utility (line 54)
- **Overall verdict:** ❌ unsupportable
- **Notes:** Plugin dispatches legacy `open-doc` event which is not part of `@openscd/oscd-api` contract. While it's "internally converted" by the legacy host, `oscd-shell` does not translate this event.

#### Sitipe

- **Source:** src/compas-editors/Sitipe.ts
- **Audited against:** `@openscd/oscd-api@1.0.0` `Plugin` interface
  (target host: `com-pas/open-scd@0.35.3`)
- **Date:** 2026-09-11
- **Dependencies found:**
  - `doc` — compliant — @property XMLDocument
  - `docId` — unsupportable — @property string
- **Overall verdict:** ❌ unsupportable
- **Notes:** Small editor plugin that depends on `docId` for version/backend service lookups.

#### AutogenSubstation

- **Source:** src/compas-editors/autogen-substation.ts
- **Audited against:** `@openscd/oscd-api@1.0.0` `Plugin` interface
  (target host: `com-pas/open-scd@0.35.3`)
- **Date:** 2026-09-11
- **Dependencies found:**
  - `doc` — compliant — XMLDocument property
  - `docId` — unsupportable — used for backend API calls
- **Overall verdict:** ❌ unsupportable
- **Notes:** Autogeneration tool that requires `docId` to interact with CoMPAS backend.

#### CompasValidateSchema

- **Source:** src/validators/CompasValidateSchema.ts
- **Audited against:** `@openscd/oscd-api@1.0.0` `Plugin` interface
  (target host: `com-pas/open-scd@0.35.3`)
- **Date:** 2026-09-11
- **Dependencies found:**
  - `doc` — compliant — XMLDocument property
  - `docId` — unsupportable — used for validator queries
- **Overall verdict:** ❌ unsupportable
- **Notes:** Validator that depends on `docId` to access schema validation rules from backend.

#### CompasCimMapping

- **Source:** src/menu/CompasCimMapping.ts
- **Audited against:** `@openscd/oscd-api@1.0.0` `Plugin` interface
  (target host: `com-pas/open-scd@0.35.3`)
- **Date:** 2026-09-11
- **Dependencies found:**
  - `newLogEvent()` — unsupportable — imported line 4, dispatched line 50
  - `newOpenDocEvent()` — unsupportable — imported line 5, dispatched line 51
  - `newPendingStateEvent()` — unsupportable — imported line 6
- **Overall verdict:** ❌ unsupportable
- **Notes:** Dispatches 3 legacy event types that are not part of the documented Plugin interface. Requires full rewrite using `oscd-edit-v2` and `oscd-open`.

#### CompasImportFromApi

- **Source:** src/menu/CompasImportFromApi.ts
- **Audited against:** `@openscd/oscd-api@1.0.0` `Plugin` interface
  (target host: `com-pas/open-scd@0.35.3`)
- **Date:** 2026-09-11
- **Dependencies found:**
  - `newWizardEvent()` — unsupportable — imported line 7, dispatched line 25
- **Overall verdict:** ❌ unsupportable
- **Notes:** Relies on legacy wizard event model. Must be rewritten to use OpenSCD wizard protocols or replaced with compliant alternative.

#### CompasSave

- **Source:** src/menu/CompasSave.ts
- **Audited against:** `@openscd/oscd-api@1.0.0` `Plugin` interface
  (target host: `com-pas/open-scd@0.35.3`)
- **Date:** 2026-09-11
- **Dependencies found:**
  - `doc` — compliant — property line 23
  - `docName` — compliant — property line 25
  - `docId` — unsupportable — property line 27, passed to child line 53
  - `editCount` — unsupportable — property line 29, passed to child line 54
  - `newPendingStateEvent()` — unsupportable — imported line 14, dispatched line 68
- **Overall verdict:** ❌ unsupportable
- **Notes:** Declares 2 unsupported properties (`docId`, `editCount`) and dispatches legacy `newPendingStateEvent`. Child component `<compas-save>` receives these properties.

#### CompasSaveAs

- **Source:** src/menu/CompasSaveAs.ts
- **Audited against:** `@openscd/oscd-api@1.0.0` `Plugin` interface
  (target host: `com-pas/open-scd@0.35.3`)
- **Date:** 2026-09-11
- **Dependencies found:**
  - `doc` — compliant — property line 23
  - `docName` — compliant — property line 25
  - `editCount` — unsupportable — property line 27, passed to child line 51
  - `newPendingStateEvent()` — unsupportable — imported line 14, dispatched line 65
- **Overall verdict:** ❌ unsupportable
- **Notes:** Declares unsupported `editCount` property and dispatches legacy `newPendingStateEvent`. Similar to CompasSave but without `docId`.

#### CompasSaveAsVersion

- **Source:** src/menu/CompasSaveAsVersion.ts
- **Audited against:** `@openscd/oscd-api@1.0.0` `Plugin` interface
  (target host: `com-pas/open-scd@0.35.3`)
- **Date:** 2026-09-11
- **Dependencies found:**
  - `doc` — compliant — property line 34
  - `docName` — compliant — property line 36
  - `editCount` — unsupportable — property line 38
  - `newPendingStateEvent()` — unsupportable — imported line 15, dispatched line 62
- **Overall verdict:** ❌ unsupportable
- **Notes:** Unsupported `editCount` property and dispatches legacy `newPendingStateEvent`.

#### CompasImportIEDs

- **Source:** src/menu/CompasImportIEDs.ts
- **Audited against:** `@openscd/oscd-api@1.0.0` `Plugin` interface
  (target host: `com-pas/open-scd@0.35.3`)
- **Date:** 2026-09-11
- **Dependencies found:**
  - Inherits from `ImportingIedPlugin` — parent class compliance unknown
  - Uses `compas-open` custom element with `doc-retrieved` event
- **Overall verdict:** ⚠️ unconfirmed
- **Notes:** Extends parent class `ImportingIedPlugin` which may use legacy properties/events. Cannot confirm compliance without inspecting parent class from `@compas-oscd/plugins`.

#### CompasMerge

- **Source:** src/menu/CompasMerge.ts
- **Audited against:** `@openscd/oscd-api@1.0.0` `Plugin` interface
  (target host: `com-pas/open-scd@0.35.3`)
- **Date:** 2026-09-11
- **Dependencies found:**
  - `doc` — compliant — property line 15
  - `newWizardEvent()` — unsupportable — imported line 5, dispatched lines 26, 33, 47
- **Overall verdict:** ❌ unsupportable
- **Notes:** Dispatches `newWizardEvent` multiple times. Stores parent reference and dispatches events on parent. Requires full refactor to use standard plugin events.

#### CompasUpdateSubstation

- **Source:** src/menu/CompasUpdateSubstation.ts
- **Audited against:** `@openscd/oscd-api@1.0.0` `Plugin` interface
  (target host: `com-pas/open-scd@0.35.3`)
- **Date:** 2026-09-11
- **Dependencies found:**
  - `doc` — compliant — property line 16
  - `newWizardEvent()` — unsupportable — imported line 5, dispatched lines 27, 41
- **Overall verdict:** ❌ unsupportable
- **Notes:** Similar pattern to CompasMerge. Dispatches legacy `newWizardEvent`. Requires refactor to compliant event handling.

#### CompasCompareIED

- **Source:** src/menu/CompasCompareIED.ts
- **Audited against:** `@openscd/oscd-api@1.0.0` `Plugin` interface
  (target host: `com-pas/open-scd@0.35.3`)
- **Date:** 2026-09-11
- **Dependencies found:**
  - Inherits from `CompareIEDPlugin` — parent class compliance unknown
  - Uses `compas-open` custom element with `doc-retrieved` event
- **Overall verdict:** ⚠️ unconfirmed
- **Notes:** Parent class from `@compas-oscd/plugins` compliance unknown. Cannot confirm without inspecting parent.

#### CompasAutoAlignment

- **Source:** src/menu/CompasAutoAlignment.ts
- **Audited against:** `@openscd/oscd-api@1.0.0` `Plugin` interface
  (target host: `com-pas/open-scd@0.35.3`)
- **Date:** 2026-09-11
- **Dependencies found:**
  - `doc` — compliant — property line 16
  - `docName` — compliant — property line 17
  - `docId` — unsupportable — property line 18, passed to child line 54
  - `editCount` — unsupportable — property line 20, passed to child line 55
  - `newWizardEvent()` — unsupportable — imported line 6, dispatched line 65
  - `newPendingStateEvent()` — unsupportable — imported line 4, dispatched line 35
- **Overall verdict:** ❌ unsupportable
- **Notes:** Declares 2 unsupported properties and dispatches 2 legacy event types. Passes properties to child component `<compas-auto-alignment>`.

#### ExportIEDParams

- **Source:** src/menu/ExportIEDParams.ts
- **Audited against:** `@openscd/oscd-api@1.0.0` `Plugin` interface
  (target host: `com-pas/open-scd@0.35.3`)
- **Date:** 2026-09-11
- **Dependencies found:**
  - `doc` — compliant — property line 28, used lines 32, 40, 53, 55
  - `docName` — compliant — property line 29, used line 96
- **Overall verdict:** ✅ compliant
- **Notes:** Only uses 2 documented compliant properties (`doc`, `docName`). No event dispatches detected. Pure export utility plugin with no state modifications. **Reference implementation for compliant plugins.**

#### LocamationVMU

- **Source:** src/menu/LocamationVMU.ts
- **Audited against:** `@openscd/oscd-api@1.0.0` `Plugin` interface
  (target host: `com-pas/open-scd@0.35.3`)
- **Date:** 2026-09-11
- **Dependencies found:**
  - `doc` — compliant — property line 11, passed to helper line 16
  - `nsdoc` — unsupported — property line 12 (not in documented Plugin interface)
  - `newWizardEvent()` — unsupportable — imported line 3, dispatched line 15
- **Overall verdict:** ❌ unsupportable
- **Notes:** Dispatches legacy `newWizardEvent`. Uses `nsdoc` property which is not documented in `@openscd/oscd-api` Plugin interface.

#### CompasSettings

- **Source:** src/menu/CompasSettings.ts
- **Audited against:** `@openscd/oscd-api@1.0.0` `Plugin` interface
  (target host: `com-pas/open-scd@0.35.3`)
- **Date:** 2026-09-11
- **Dependencies found:**
  - `newWizardEvent()` — unsupportable — imported line 5, dispatched line 16
- **Overall verdict:** ❌ unsupportable
- **Notes:** Minimal plugin that only dispatches legacy `newWizardEvent`. No property dependencies. Simplest refactor candidate among unsupportable plugins.

### open-scd (sprinteins)

#### IED (local editor)

- **Source:** plugins/src/editors/IED.js
- **Audited against:** `@openscd/oscd-api@1.0.0` `Plugin` interface
  (target host: `open-scd@0.29.0`)
- **Date:** 2026-09-11
- **Dependencies found:**
  - `doc` — compliant — XMLDocument property
  - (Event dependencies unknown without source code inspection)
- **Overall verdict:** ⚠️ unconfirmed (likely compliant, needs source inspection)
- **Notes:** Source files not directly inspected (JS in external plugin source). Listed for audit completeness.

#### Substation (npm plugin)

- **Source:** https://sprinteins.github.io/oscd-plugins/communication-explorer/index.js (external URL)
- **Audited against:** `@openscd/oscd-api@1.0.0` `Plugin` interface
  (target host: `open-scd@0.29.0`)
- **Date:** 2026-09-11
- **Dependencies found:**
  - (Cannot audit external URL plugins without cloning/fetching source)
- **Overall verdict:** ⚠️ unauditable
- **Notes:** External URL plugins require source code retrieval for inspection. Not yet implemented.

---

## Key findings

### com-pas/compas-open-scd

**Local plugins (18 total):**
- ✅ **Compliant:** 1 (ExportIEDParams)
- ❌ **Unsupportable:** 16
- ⚠️ **Unconfirmed:** 1 (awaiting parent class audit)

**Compliance rate:** 5.6% (1 of 18 plugins)

**Critical blockers identified:**
1. **Legacy event usage is pervasive (14 plugins):**
   - `newWizardEvent` — 7 plugins
   - `newPendingStateEvent` — 5 plugins
   - `newOpenDocEvent`, `newLogEvent` — 3 plugins combined

2. **Unsupported properties declared:**
   - `docId` — 5 plugins (backend coupling)
   - `editCount` — 4 plugins (legacy change tracking)
   - `nsdoc` — 1 plugin (undocumented property)

3. **Parent class dependencies (2 plugins unconfirmed):**
   - CompasImportIEDs extends ImportingIedPlugin
   - CompasCompareIED extends CompareIEDPlugin
   - Both parent classes from `@compas-oscd/plugins` — compliance unknown

**Architectural issue:** Almost all unsupported plugins depend on `docId` or legacy event dispatch patterns. CoMPAS backend integration via `docId` is incompatible with stateless plugin hosts.

### open-scd (sprinteins)

**Status:** Audit not yet performed. Source code for most plugins not directly accessible (external URLs, compiled JS).
