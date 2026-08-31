---
name: scl-dialogs-embedding
description: Use when a plugin opens legacy SCL wizards or dispatches oscd-scl-dialogs-edit events that need a plugin-local <oscd-scl-dialogs> host.
---

# Embed oscd-scl-dialogs & Replace Legacy Wizards

**Use when**
- Code opens a legacy wizard or wizard-like SCL editing dialog (Step 4).
- Plugin dispatches `'oscd-scl-dialogs-edit'` with no host-level handler (Step 6).

**Don't use for** — generic UI component swaps (`mwc-to-oscd-ui`), edit-action conversion (`editv1-to-editv2`), or flaky dialog tests (`test-hardening`).

**Escalate to** — `iec-61850` if deciding whether a dialog's emitted edit is schema-valid for the target element, since these dialogs produce SCL edits.

## Problem

Plugins dispatch `'oscd-scl-dialogs-edit'` events that bubble to a host-level handler. Without host infrastructure the edit button silently fails.

## Procedure

1. Identify the legacy wizard's target element type and check the supported tag matrix: GSEControl, SampledValueControl, ReportControl, DataSet, GSE, SMV, SmvOpts. Replace only if behavior matches; keep unsupported cases local.
2. Import via the subpath export — the bare specifier `@omicronenergy/oscd-scl-dialogs` resolves to `foundation.js` (types only, no default export):

```typescript
import OscdSclDialogs from '@omicronenergy/oscd-scl-dialogs/OscdSclDialogs.js';
```

3. Register synchronously, never lazily/asynchronously:

```typescript
static scopedElements = { 'oscd-scl-dialogs': OscdSclDialogs };
```

4. Render `<oscd-scl-dialogs></oscd-scl-dialogs>` as a sibling of the container div, and add `@query('oscd-scl-dialogs') private sclDialogs!: OscdSclDialogs;`.
5. Intercept the event at the plugin root:

```typescript
connectedCallback() {
  super.connectedCallback();
  this.addEventListener('oscd-scl-dialogs-edit', this.handleEditDialogEvent);
}
disconnectedCallback() {
  this.removeEventListener('oscd-scl-dialogs-edit', this.handleEditDialogEvent);
  super.disconnectedCallback();
}
private handleEditDialogEvent = (event: Event) => {
  event.stopPropagation();
  this.sclDialogs.edit((event as CustomEvent).detail);
};
```

## Pitfalls

- Child components need NO changes; they keep dispatching `newEditDialogEditEvent(element)`.
- If the host also renders `<oscd-scl-dialogs>` globally, `stopPropagation()` prevents double handling.

## Verify

- Dialog opens when an edit action is triggered.
- `'oscd-scl-dialogs-edit'` does not escape the plugin root shadow boundary.
- Dialog fields render and produce valid EditV2 on save.
- Plugin works without a host-level `<oscd-scl-dialogs>`.
