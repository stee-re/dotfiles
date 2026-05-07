---
name: lit-translate-to-lit-localize
description: Replace lit-translate runtime key lookup with lit-localize msg() using resolved English source strings. MUST be done in Step 2 initial migration.
---

# Recipe: Replace lit-translate With lit-localize msg

## Timing

**MUST be done in Step 2** — without this, the plugin renders raw translation keys instead of English text because the standalone runtime has no host to initialize `lit-translate`.

## Problem

Legacy plugins use `get('translation.key')` from `lit-translate`. The host application initialized translations globally — plugins never called `registerTranslateConfig()`. In standalone form, `get()` returns raw keys.

## Detection

- `import { get } from 'lit-translate'`
- `get('some.translation.key')`
- `get('some.translation.key', { ...params })`

## Replacement

```ts
// Before
import { get } from 'lit-translate';
html`${get('subscription.none')}`

// After
import { msg } from '@lit/localize';
html`${msg('None')}`
```

`msg()` works without initialization — for the source locale (English), it returns its argument as-is.

## Procedure

1. Replace `import { get } from 'lit-translate'` with `import { msg } from '@lit/localize'`
2. Look up each key in `./legacy/compas-open-scd/packages/openscd/src/translations/en.ts`
3. Replace `get('key')` with `msg('Resolved English string')`
4. For dynamic keys, create a typed lookup object:

```ts
// Before
get(`subscription.${this.controlTag}.controlBlockList.title`)

// After
const controlBlockListTitle: Record<string, string> = {
  GSEControl: 'GOOSE Messages',
  SampledValueControl: 'Sampled Value Messages',
};
${controlBlockListTitle[this.controlTag]}
```

5. Remove `lit-translate` from package.json
6. Add `@lit/localize` to package.json

## Anti-Patterns

- Keeping `lit-translate` in a standalone plugin
- Leaving unresolved translation keys
- Rewriting English strings manually when they exist in `en.ts`
- Converting parameterized translations into string concatenation

## Verification

- No `lit-translate` imports remain
- `@lit/localize` imported where needed
- Each message matches the English source string from `en.ts`
- Parameterized messages render correct dynamic values
- Labels, headings, and empty states show English text (not raw keys)

## Known Exceptions

- Deeply nested keys need careful resolution from `en.ts`
- If a key cannot be resolved, document it and stop — do not guess
