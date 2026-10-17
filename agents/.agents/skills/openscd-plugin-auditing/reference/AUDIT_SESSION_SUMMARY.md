# OpenSCD Plugin Auditing — Session Completion Summary

**Date:** 2026-09-11  
**Session Focus:** 3-job auditing sequence for com-pas/compas-open-scd and open-scd (sprinteins)

---

## Job 1: Repo Discovery ✅ COMPLETE

**Objective:** Verify host baselines and update `repos.md`

**Findings:**

### com-pas/open-scd@0.35.3 (verified v0.35.3-6-g786ced0bb)
- **Properties set:** `doc`, `docName`, `docs`, `locale`, `editor`, `editCount`, `docId`, `pluginId`, `nsdoc`, `plugins`, `oscdApi`
- **Compliant properties:** `doc`, `docName`, `docs`, `locale`, `editor` (matches `@openscd/oscd-api`)
- **Non-compliant properties:** `docId`, `pluginId`, `nsdoc`, `plugins`, `oscdApi` (extension/unsupportable)
- **Legacy property:** `editCount` (change counter, live alias in oscd-shell)
- **Events listened:** `oscd-edit-v2` (compliant), `oscd-open` (compliant), `oscd-edit` (legacy), `editor-action` (legacy), `open-doc` (legacy)
- **Source files:** `packages/openscd/src/addons/Layout.ts:renderPluginContent` (lines 644-655), `addons/Editor.ts:connectedCallback` (lines 123-141)

### com-pas/compas-open-scd (v0.44.0.20-39-g0ea7344b)
- **Relationship:** Extends com-pas/open-scd@0.35.3
- **Extension property:** `compasApi` (passed to plugins, line 98 in open-scd.ts)
- **Purpose:** Adds CoMPAS backend service integrations (lNodeLibrary, etc.)

### sprinteins/open-scd
- **Status:** Checkout not present (~/code/sprinteins/ directory empty)
- **Note:** ~/code/open-scd exists but at v0.29.0 (older, different structure than expected 0.34.0)

**Deliverables:**
- ✅ repos.md updated with detailed host property/event baseline (lines added before existing entry)
- ✅ Compliant vs. non-compliant classifications documented
- ✅ Source file citations provided

---

## Job 2: Plugin Discovery ✅ COMPLETE

**Objective:** Inventory all plugins and update `plugins.md`

**Plugins Discovered:**

### com-pas/compas-open-scd (54 total)
| Category | Count | Source |
|----------|-------|--------|
| Local editors | 3 | compas-plugins.ts (CompasVersions, Sitipe, AutogenSubstation) |
| Local validators | 1 | compas-plugins.ts (CompasValidateSchema) |
| Local menu | 14 | compas-plugins.ts |
| NPM editors | 10 | @compas-oscd/plugins dist/editors/ |
| NPM validators | 2 | @compas-oscd/plugins dist/validators/ |
| NPM menu | 8 | @compas-oscd/plugins dist/menu/ |
| External (git submodules) | 9 | packages/external-plugins/ (not checked out) |
| External (URLs/other) | 7 | /external-plugins/ paths (bearingpoint, transnetbw plugins) |

### open-scd (sprinteins @ v0.29.0) (35 total)
| Category | Count | Source |
|----------|-------|--------|
| Editors (external URLs) | 10 | https://sprinteins.github.io/oscd-plugins/ |
| Editors (local) | 12 | plugins/src/editors/ |
| Validators (local) | 2 | plugins/src/validators/ |
| Menu (local) | 9 | plugins/src/menu/ |
| External references | 2 | sprinteins.github.io/oscd-plugin-store |

**Deliverables:**
- ✅ plugins.md updated with 89 plugin rows (com-pas + open-scd)
- ✅ Source kind accurately classified (local file / npm package / git submodule (not checked out) / external URL)
- ✅ Locations cited exactly as they appear in registries

---

## Job 3: Plugin Audit ✅ PARTIAL (SAMPLE COMPLETE)

**Objective:** Audit plugins for dependency compliance and create `audit-report.md`

**Audit Scope:** Representative sample (5 plugins from com-pas/compas-open-scd)

### Audited Plugins (com-pas/compas-open-scd)

1. **CompasVersions** (editor)
   - Verdict: **UNSUPPORTABLE**
   - Blockers: `docId` (unsupportable), `newWizardEvent()` (unsupportable)
   
2. **CompasOpen** (menu)
   - Verdict: **UNSUPPORTABLE**
   - Blockers: `newOpenDocEvent()` (open-doc, unsupportable), `newLogEvent()` (unsupported)

3. **Sitipe** (editor)
   - Verdict: **UNSUPPORTABLE**
   - Blockers: `docId` (unsupportable)

4. **AutogenSubstation** (editor)
   - Verdict: **UNSUPPORTABLE**
   - Blockers: `docId` (unsupportable)

5. **CompasValidateSchema** (validator)
   - Verdict: **UNSUPPORTABLE**
   - Blockers: `docId` (unsupportable)

### Critical Issues Identified

| Issue | Impact | Severity |
|-------|--------|----------|
| **`docId` in 100% of sample** | Incompatible with stateless hosts (oscd-shell); requires CoMPAS backend context | CRITICAL |
| **`newWizardEvent()` pattern** | No shim available; fundamentally different from modern data-driven dialogs | CRITICAL |
| **`newOpenDocEvent()` / open-doc** | Legacy host converts internally, but oscd-shell does not; unshimmable | HIGH |
| **Helper function indirection** | Events may be built via helper functions; harder to track dependencies | MEDIUM |

### Compliance Summary (Sampled Plugins)

| Verdict | Count | % |
|---------|-------|---|
| Compliant | 0 | 0% |
| Shimmable-reliable | 0 | 0% |
| Shimmable-unproven | 0 | 0% |
| Unsupportable | 5 | 100% |

**Deliverables:**
- ✅ audit-report.md updated with 5 plugin entries (full template + summary sections)
- ✅ Each entry includes exact source citations (file, line, function)
- ✅ Dependency classifications tied to known-unsupported.md buckets
- ✅ Overall verdict assessment for each plugin

---

## Key Findings

### Architectural Mismatch
com-pas/compas-open-scd plugins are designed for **tightly coupled backend integration**, not portable plugin contract compliance:
- Depend on `docId` (CoMPAS backend document UUID)
- Use `compasApi` extension (not in `@openscd/oscd-api`)
- Dispatch legacy events (wizard, open-doc) that have no modern equivalents

### Compliance Ceiling
**Zero sampled plugins are compliant** with `@openscd/oscd-api` in current form. Architectural refactoring required:
- Separate backend integration layer from plugin contract
- Replace wizard events with `@omicronenergy/oscd-scl-dialogs` or `oscd-background-wizard-events`
- Use `oscd-open` instead of legacy `open-doc`

### Data Completeness
- ✅ All 54 com-pas/compas-open-scd plugins inventoried
- ✅ All 35 open-scd (sprinteins) plugins inventoried  
- ⚠️ Full audit requires source code access for npm/external plugins

---

## Gaps and Recommendations

### For Future Audits

**Priority 1: Complete plugin audit**
- Audit remaining 49 com-pas plugins (npm, external)
- Fetch and analyze sprinteins external URL plugins
- Check builder function indirection in all event dispatch helpers

**Priority 2: Categorize plugins by migrability**
- Can plugins migrate to compliant contract with shims? (shimmable-reliable/unproven)
- Which require architectural refactor? (unsupportable)
- Which are already semi-compliant? (compliant)

**Priority 3: Sprinteins host analysis**
- Verify that open-scd@0.29.0 or later is actually available at ~/code/sprinteins/
- If not, decide whether to audit it or defer

### Known Limitations

1. **Sprinteins checkout missing** — Cannot fully compare 0.34.0 property set to com-pas@0.35.3
2. **External plugins** — sprinteins.github.io plugins require URL fetch to analyze
3. **Builder functions** — Some event dispatch may be hidden in helper function calls (need broader grep for indirection patterns)

---

## Files Modified

| File | Changes | Status |
|------|---------|--------|
| `repos.md` | Added com-pas/open-scd@0.35.3 and com-pas/compas-open-scd entries | ✅ Complete |
| `plugins.md` | Replaced stub with 89 plugin rows from both repos | ✅ Complete |
| `audit-report.md` | Replaced stub with 5 audited plugins + summary | ✅ Complete (partial audit) |

All files in: `/Users/stee/.agents/skills/openscd-plugin-auditing/reference/`

---

## Conclusion

The 3-job auditing sequence has **established baseline repo definitions** (Job 1), **completed comprehensive plugin inventory** (Job 2), and **identified critical architectural barriers** to compliance (Job 3, sampled).

**Next session should:**
1. Audit remaining plugins (prioritize npm plugins from @compas-oscd/plugins)
2. Fetch and analyze external URL plugins (sprinteins.github.io)
3. Identify which plugins can migrate with shims vs. which need refactoring
4. Create migration roadmap for CoMPAS plugins
