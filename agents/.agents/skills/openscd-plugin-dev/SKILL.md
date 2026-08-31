---
name: openscd-plugin-dev
description: Baseline stack and verification for standalone OpenSCD plugin work. Load at the start of any implementation task in a plugin repo, before choosing an approach.
---

# OpenSCD Plugin Development

**Use when** implementing, debugging or reviewing anything in a standalone
OpenSCD plugin repo — the default playbook for repo work.

**Don't use for** code layout and naming, which is `code-structure`; custom
element registration, which is `scoped-elements`; or migrating a legacy plugin,
which is `plugin-migration`.

**Escalate to** — `iec-61850` if the task turns on SCL element ordering,
namespaced attributes, Edition differences, or schema validity. Most plugin work
does not.

## Rules

**First pass.** Read `package.json`, `tsconfig.json`, the test config and nearby
source before choosing an approach. Search with `rg` / `rg --files`. Prefer
existing local patterns over new abstractions.

**Stack.** TypeScript `strict: true`, no `any`. ESM with explicit `.js`
extensions on relative runtime imports. Lit 3 + `lit/decorators.js`.
`ScopedElementsMixin` from `@open-wc/scoped-elements/lit-element.js`.
`@omicronenergy/oscd-ui` for UI. `@openscd/oscd-api` for edits,
`@openscd/scl-lib` for SCL helpers, `@lit/localize` `msg()` for source-locale
text. Web Test Runner, Playwright, ESLint, Prettier, Rollup.

**Forbidden in standalone code:** `@openscd/open-scd`, `@openscd/xml`,
`@openscd/core`, `lit-translate`, and MWC / `@scopedelement/material-web`
imports where an `oscd-ui` replacement exists.

**Edits.** Persist document changes as `EditV2` dispatched via `newEditEventV2`
(`@openscd/oscd-api/utils.js`) — never by mutating the document. Use
`docVersion`, not the legacy `editCount`. Prefer an existing `@openscd/scl-lib`
helper over copied foundation logic.

**Scale.** Assume large documents. Avoid repeated full-document traversals,
hidden quadratic loops, and expensive recalculation inside reactive updates.
Call out scaling risk proactively.

**Accessibility.** Interactive elements must be keyboard reachable; keep ARIA
roles and attributes correct. Changes to interaction behaviour must preserve or
improve accessibility. If this adds real complexity, say so rather than
silently skipping it.

**Extraction.** Move heavy logic into pure functions under `foundation/`. A new
module gets a co-located `.spec.ts` covering those functions.

## Verify

Use repo scripts first: `npm run build`, `npm run test`, `npm run lint`,
`npm run start`. Focused unit run after a build:

```
npx wtr --files dist/path/to/spec.js --playwright --browsers chromium
```

Run `npm i` → `npx tsc --noEmit` → `npm run build` in that order after any
structural change. Report what changed, what was verified, and what risk remains.
