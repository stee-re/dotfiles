---
name: lit-translate-to-lit-localize
description: Use when code imports get() from lit-translate, or renders raw translation keys like subscription.none; replaces it with @lit/localize msg().
---

# Replace lit-translate With lit-localize msg()

**Use when**
- `import { get } from 'lit-translate'`
- `get('some.translation.key')` or `get('some.key', { ...params })`
- MUST be done in Step 2 of initial migration — otherwise the plugin renders raw keys.

**Don't use for** — UI component swaps (`mwc-to-oscd-ui`), scoped registration (`scoped-elements`), or code layout/naming conventions (`code-structure`).

## Problem

Legacy plugins call `get('translation.key')`. The host application initialized translations globally — plugins never called `registerTranslateConfig()`. The standalone runtime has no host, so `get()` returns raw keys.

## Procedure

1. Replace `import { get } from 'lit-translate'` with `import { msg } from '@lit/localize'`. `msg()` needs no initialization — for the source locale (English) it returns its argument as-is.
2. Look up each key in `./legacy/compas-open-scd/packages/openscd/src/translations/en.ts`.
3. Replace `get('subscription.none')` with `msg('None')`.
4. For dynamic keys, build a typed lookup instead of concatenating:

```ts
// Before: get(`subscription.${this.controlTag}.controlBlockList.title`)
const controlBlockListTitle: Record<string, string> = {
  GSEControl: 'GOOSE Messages',
  SampledValueControl: 'Sampled Value Messages',
};
html`${controlBlockListTitle[this.controlTag]}`;
```

5. Remove `lit-translate` from package.json; add `@lit/localize`.

## Pitfalls

- Keeping `lit-translate` in a standalone plugin.
- Leaving unresolved keys, or rewriting English strings by hand when `en.ts` has them.
- Converting parameterized translations into string concatenation.
- Deeply nested keys need careful resolution. If a key cannot be resolved, document it and stop — do not guess.

## Verify

- No `lit-translate` imports remain; `@lit/localize` imported where needed.
- Each message matches the English source string in `en.ts`.
- Parameterized messages render correct dynamic values.
- Labels, headings, and empty states show English text, not raw keys.
