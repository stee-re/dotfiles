# Pitfalls, Audit Steps & Known Exceptions

## scopedElements Audit

After all replacements, for every file with `scopedElements`:

1. Extract all hyphenated tags from `render()` and sub-render methods
2. Confirm each tag appears as a key in `scopedElements`
3. For classes extending a base class, also check tags used in the base's renderers — the subclass must register those too

```typescript
// CORRECT — key matches template tag
static scopedElements = {
  'oscd-action-list': OscdActionList,  // template uses <oscd-action-list>
};

// WRONG — key doesn't match template tag
static scopedElements = {
  'action-list': OscdActionList,  // but template uses <oscd-action-list> → won't resolve!
};
```

## Anti-Patterns

- Big-bang replacement without intermediate verification
- Mixing deprecated mwc-* and new oscd-* in the same component tree
- Preserving deprecated UI because styling is inconvenient
- Ignoring accessibility or keyboard regressions

## Known Exceptions

- If oscd-ui does not expose a needed equivalent, keep current implementation and record gap
- `mwc-check-list-item` has no 1:1 equivalent — `OscdSelectionList` has different API
- `mwc-formfield` has no equivalent — use plain `<label>` wrapping
- `mwc-snackbar` has no oscd-ui equivalent — keep `@material/mwc-snackbar` temporarily
