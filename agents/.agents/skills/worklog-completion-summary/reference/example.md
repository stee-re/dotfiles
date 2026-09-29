# Worked example

Source:
`plugin-migration-workspace/migrations/subscriber-goose-data-binding.md`
(Step 2 and Step 3 Completion Summaries, abridged).

```markdown
## Step Status

- Step 1 Planning: done
- Step 2 Initial Migration: done
- Step 3 EditV2 Migration: done

## Step 2 Completion Summary

All Step 2 exit criteria met (see `steps/step2-initial-migration.md` for the
generic checklist).

### Runtime issues found during user testing (all fixed)

Three issues were discovered when the plugin was loaded in the standalone
demo shell. All three have been fed back into the step and recipe
documentation so they won't recur in future migrations:

1. **Translations not working**: `lit-translate` `get()` returned raw keys
   because no host initialized the translation runtime. Fixed by replacing
   all `get('key')` calls with `@lit/localize` `msg('English text')`,
   resolving each key against `legacy/.../translations/en.ts`.

2. **mwc-* components not rendering**: With `ScopedElementsMixin` and the
   scoped registry polyfill, side-effect `import '@material/mwc-icon'` only
   registers on the global registry, which scoped shadow roots do not
   consult. Fixed by importing mwc-* classes directly and registering in
   each component's `scopedElements`.

### Files created (foundation modules)
- `src/foundation/scl.ts` — `compareNames`, `getSclSchemaVersion`,
  `getNameAttribute`, `getDescriptionAttribute`, `SCL_NAMESPACE`
- `src/foundation/nsdoc.ts` — standalone Nsdoc implementation

### scl-lib replacements applied
- `identity` — from `@openscd/scl-lib` (replaces
  `@openscd/open-scd/src/foundation.js`)
- `lnInstGenerator` — from `@openscd/scl-lib` (replaces local
  `minAvailableLogicalNodeInstance`, schema-correctness improvement: scoped
  to LDevice per IEC 61850)

### Bug fixes / code-smell corrections
- `emptyInputsDeleteActions` line 96: `value.children.length! == 0` →
  `value.children.length === 0` (non-null assertion on number, no behavior
  change)

### Known legacy bugs preserved (flagged for review)
- `complexAction.actions.concat(supervisionActions)` in
  goose/subscriber-list.ts — return value not assigned, supervision actions
  silently dropped (not in this plugin's scope but noted for MSG binding
  migrations)

## Step 3 Completion Summary

Replaced deprecated editor actions (`ComplexAction`, `Create`, `Delete`,
`newActionEvent`) with `EditV2` via `scl-lib.subscribe()`/`unsubscribe()` +
`newEditEventV2()`:

- **ext-ref-ln-binding-list.ts**: `subscribe()` and `unsubscribe()` rewritten
  to use `scl-lib.subscribe()` and `scl-lib.unsubscribe()`, dispatched via
  `newEditEventV2()`.

### Dead code after Step 3
- **`xml.ts`**: No imports reference it from any source file. Harmless dead
  code, can be removed in a later cleanup pass.

### Build and type-check results
- `npx tsc --noEmit`: passes (zero errors)
- `npm run build`: succeeds (zero errors, zero warnings)
- No deprecated editor action types remain in source
```

Notes on why this works:
- Each bullet names a file/symbol first, so the entry is grep-able.
- "Issues found" entries explain root cause, not just the symptom — the next
  session can tell whether a similar bug elsewhere shares the cause.
- "Known legacy bugs preserved" explicitly says *why* it wasn't fixed, so a
  reviewer doesn't mistake omission for an oversight.
