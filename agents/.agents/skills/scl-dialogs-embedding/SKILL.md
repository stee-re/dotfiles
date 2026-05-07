---
name: scl-dialogs-embedding
description: Embed oscd-scl-dialogs in plugin root for self-contained dialog functionality. Replace legacy wizard openings with oscd-scl-dialogs where supported.
---

# Recipe: Embed oscd-scl-dialogs & Replace Legacy Wizards

## Part 1: Replace Legacy Wizard Openings (Step 4)

### When to use
- Code opens legacy wizard or wizard-like SCL editing dialog
- `oscd-scl-dialogs` supports the target element type

### Procedure
1. Identify the exact legacy wizard target element type
2. Verify support against oscd-scl-dialogs' supported tag matrix
3. Replace only if behavior matches; keep unsupported cases local

### Supported element types (verified)
- GSEControl, SampledValueControl, ReportControl
- DataSet, GSE, SMV, SmvOpts

## Part 2: Embed in Plugin Root (Step 6)

### Problem
Plugins dispatch `'oscd-scl-dialogs-edit'` events that bubble to a host-level handler. Without host infrastructure, the edit button silently fails.

### Required Edits

1. **Import** using the subpath export (NOT bare specifier):
```typescript
import OscdSclDialogs from '@omicronenergy/oscd-scl-dialogs/OscdSclDialogs.js';
```
The bare specifier `@omicronenergy/oscd-scl-dialogs` resolves to `foundation.js` (types only, no default export).

2. **Register synchronously** in scopedElements:
```typescript
static scopedElements = {
  'oscd-scl-dialogs': OscdSclDialogs,
};
```
Do NOT use lazy/async registration.

3. **Render** in template:
```typescript
render() {
  return html`
    <div class="container"><!-- children --></div>
    <oscd-scl-dialogs></oscd-scl-dialogs>
  `;
}
```

4. **Add @query reference:**
```typescript
@query('oscd-scl-dialogs')
private sclDialogs!: OscdSclDialogs;
```

5. **Intercept events** (stopPropagation prevents escape to host):
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
  const detail = (event as CustomEvent).detail;
  this.sclDialogs.edit(detail);
};
```

### Child components need NO changes
They continue dispatching `newEditDialogEditEvent(element)` — the plugin root catches it.

## Verification

- Dialog opens when edit action triggered
- `'oscd-scl-dialogs-edit'` event does NOT escape plugin root shadow boundary
- Dialog fields render correctly and produce valid EditV2 on save
- Plugin works without host-level `<oscd-scl-dialogs>`

## Known Exceptions

- If host also renders `<oscd-scl-dialogs>` globally, `stopPropagation()` prevents double handling
- Unsupported element types must stay as local implementations
