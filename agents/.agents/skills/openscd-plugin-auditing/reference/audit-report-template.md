# Audit report template

Skeleton for a single audit finding. Copy this shape into `audit-report.md`
under the relevant repo's section — don't invent a different shape per entry.

```
### <plugin name>

- **Repo:** <org/repo>
- **Source:** <file path>
- **Audited against:** `@openscd/oscd-api@<version>` `Plugin` interface
  (target host if known, e.g. `omicronenergy/oscd-shell@0.0.14`, for context only)
- **Date:** <ISO date>
- **Dependencies found:**
  - `<property or event name>` — <compliant | shimmable-reliable | shimmable-unproven | unsupportable> — <one-line evidence + exact source line/function in the plugin>
- **Overall verdict:** <the worst bucket among dependencies found>
- **Notes:** <anything that doesn't fit the table, e.g. ambiguous indirection that needs a second look>
```

Rules:
- One dependency = one bucket. A plugin's overall verdict is the worst bucket
  among its dependencies (unsupportable beats shimmable-unproven beats
  shimmable-reliable beats compliant).
- Every dependency row must cite the exact line/function in the *plugin*
  source it was found in — not just the host-side catalogue entry it matched.
- Re-audit and overwrite an entry (with a new date) rather than appending a
  second stale one for the same plugin.
