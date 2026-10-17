# Audit report template

## Structure

1. **Summary tables** at the top (one per repo)
2. **Detailed findings** organized by repo, then plugin

## Summary table format

```markdown
| Plugin name | Class/File | Status | Non-compliant items |
|---|---|---|---|
| <plugin name> | <ClassName.ts or file.js> | ✅ Compliant / ❌ Not compliant / ⚠️ Unconfirmed | <property/event list, or blank if compliant> |
```

Status values:
- `✅ Compliant` — uses only `doc`, `docName`, `docs`, `locale`, `editor`, `docVersion`, `oscd-edit-v2`
- `❌ Not compliant` — depends on unsupported/legacy properties/events
- `⚠️ Unconfirmed` — source not directly accessible or audit incomplete
- `⚠️ Unauditable` — external URL or no source code access

After the table, add a one-line summary: `**Summary:** X compliant, Y shimmable, Z unsupportable`

## Detailed finding format

For each plugin, use this shape:

```markdown
#### <plugin name>

- **Source:** <file path or URL>
- **Audited against:** `@openscd/oscd-api@<version>` `Plugin` interface
  (target host: `<org/repo@version>`)
- **Date:** <ISO date>
- **Dependencies found:**
  - `<property or event name>` — <compliant | shimmable-reliable | shimmable-unproven | unsupportable> — <one-line evidence + exact source line/function in the plugin>
- **Overall verdict:** <✅ compliant | ❌ unsupportable | ⚠️ unconfirmed>
- **Notes:** <anything that doesn't fit, e.g. ambiguous indirection needing a second look>
```

## Rules

- **One dependency = one bucket.** A plugin's overall verdict is the worst
  bucket among its dependencies (unsupportable beats shimmable-unproven beats
  shimmable-reliable beats compliant).
- **Every dependency row must cite the exact line/function in the *plugin*
  source** — not just the host-side catalogue entry it matched.
- **Re-audit and overwrite** an entry (with a new date) rather than appending
  a second stale one for the same plugin.
- **Summary table row must match a detailed finding section** — no orphaned
  rows.
- Use emoji status indicators for quick scannability (✅/❌/⚠️).
