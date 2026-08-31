---
name: nsdoc-standalone
description: Use when a plugin declares a host-provided nsdoc property, imports Nsdoc from @openscd/open-scd, or calls getDataDescription for LN/data labels.
---

# Replace Host nsdoc With a Local Standalone Module

**Use when**
- `import { Nsdoc } from '@openscd/open-scd/src/foundation/nsdoc.js'`
- `@property() nsdoc!: Nsdoc;` or `.nsdoc=${...}` passed into children
- Calls to `nsdoc.getDataDescription(...)`

**Don't use for** — other `@openscd/open-scd` foundation imports (`legacy-foundation-helpers`) or SCL document operations (`scl-lib`).

**Escalate to** — `iec-61850` if resolving which logical-node or data-object description applies, since NSDoc content is Edition-sensitive (Ed1 / Ed2 / Ed2.1).

## Problem

Legacy plugins depend on a host-provided `nsdoc: Nsdoc` property. In standalone form no host sets it, so it is `undefined` and crashes when child components call `this.nsdoc.getDataDescription(...)`.

## Procedure

1. Create `src/foundation/nsdoc.ts` exporting both the `Nsdoc` interface and an `initializeNsdoc()` factory.
2. Keep the `Nsdoc` interface compatible with legacy callers expecting `getDataDescription(element, ancestors?)`.
3. Initialize at the entry point with a default value:

```ts
import { Nsdoc, initializeNsdoc } from './foundation/nsdoc.js';

@property({ attribute: false })
nsdoc: Nsdoc = initializeNsdoc();
```

Do NOT use `nsdoc!: Nsdoc` with no default.

4. Pass the locally initialized object to child components that need it.
5. Make the plugin resilient when nsdoc content is unavailable (fallback labels).

## Pitfalls

- Keeping `nsdoc` as an undocumented host requirement.
- Deep-importing the legacy monorepo nsdoc module.
- Removing nsdoc-driven labels without checking fallback behavior.
- Inventing a narrower interface when shared code expects the full legacy `Nsdoc` contract.

## Verify

- No imports from `@openscd/open-scd/src/foundation/nsdoc.js`.
- Plugin does not require the host to provide `.nsdoc`.
- LN and data descriptions render when local data is available; fallback labels render when it is not.
- Tests cover initialization and label rendering paths.
