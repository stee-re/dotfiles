---
name: nsdoc-standalone
description: Replace host-provided nsdoc property with a local standalone nsdoc module. Load when migrating plugins that use Nsdoc for LN/data descriptions.
---

# Recipe: Replace Host nsdoc With Local Standalone Module

## Problem

Legacy plugins depend on a host-provided `nsdoc: Nsdoc` property. In standalone form, no host sets this — it will be `undefined` and crash when child components call `this.nsdoc.getDataDescription(...)`.

## Detection

- `import { Nsdoc } from '@openscd/open-scd/src/foundation/nsdoc.js'`
- `@property() nsdoc!: Nsdoc;`
- `.nsdoc=${...}` passed into child components
- Calls to `nsdoc.getDataDescription(...)`

## Replacement

Create `src/foundation/nsdoc.ts` exporting both the `Nsdoc` interface and an `initializeNsdoc()` factory.

### Entry point initialization (CRITICAL)

```ts
import { Nsdoc, initializeNsdoc } from './foundation/nsdoc.js';

@property({ attribute: false })
nsdoc: Nsdoc = initializeNsdoc();
```

**Do NOT use `nsdoc!: Nsdoc` with no default** — in standalone form no host sets this, so it will be `undefined` and crash.

### Requirements

- Keep `Nsdoc` interface compatible with legacy callers expecting `getDataDescription(element, ancestors?)`
- Plugin must be resilient when nsdoc content is unavailable (fallback labels)
- Pass the locally initialized object to child components that need it

## Verification

- No imports from `@openscd/open-scd/src/foundation/nsdoc.js`
- Plugin doesn't require host to provide `.nsdoc`
- LN and data descriptions render correctly when local data available
- UI behaves acceptably with missing description data (fallback labels)
- Tests cover initialization and label rendering paths

## Anti-Patterns

- Keeping `nsdoc` as undocumented host requirement
- Deep-importing legacy monorepo nsdoc module
- Removing nsdoc-driven labels without checking fallback behavior
- Inventing narrower interface if shared code expects full legacy Nsdoc contract
