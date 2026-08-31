---
name: test-hardening
description: Load when @open-wc/testing specs time out, hang, or flake — especially around DOM assertions, sendMouse coordinates, scoped element upgrades, or visual regression diffs.
---

# Test Hardening

**Use when** a `@web/test-runner` spec times out, hangs with no error, or flakes
between local and CI, and when writing new specs that touch shadow DOM.

**Don't use for** test *placement*, which is `code-structure` ("Test
Co-location"): tests live beside the code they exercise, and a parent's spec
tests orchestration only, never child internals.

## Problem

Two root causes account for most silent timeouts:

1. **DOM serialization crash.** When `expect(domElement)` fails, the harness
   tries to serialize the node for the error message and throws *outside* the
   test. The runner then hangs until timeout, with no useful output.
2. **`sendMouse` coordinate fragility.** Hardcoded pixel positions drift when
   layout, scoped element sizing, or viewport differs between CI and local. A
   missed click raises nothing — it just leaves unexpected state that times out
   later.

## Procedure

1. Add `deepQuery` / `waitForElement` helpers at the top of the spec if needed.
2. Replace every `expect(domNode)` with an assertion on an extracted primitive —
   boolean, string, or count.
3. Replace arbitrary `aTimeout` waits with `updateComplete` or polling on
   `:defined`. Scoped elements do not always upgrade synchronously after
   `fixture()`.
4. Fix only `sendMouse` calls that are actually broken, by computing position
   from `getBoundingClientRect()`. **Do not refactor passing `sendMouse` calls** —
   the behavioural risk outweighs the tidiness.
5. Re-run the single spec to confirm.

## Pitfalls

- Raising the timeout to "fix" a timeout — it masks the real fault.
- `try`/`catch` around a test to swallow the error.
- Skipping a flaky test without finding the cause.
- `aTimeout(0)` used as a substitute for real async waiting.
- **Updating visual regression baselines locally.** VTR baselines are CI-owned:
  never regenerate or commit them. Local diffs are diagnostic only, and are not
  release-blocking unless CI reproduces them.

## Verify

```
npx wtr --files src/the-file.spec.ts --playwright --browsers chromium
```

Passes with no timeouts; no DOM objects reach `expect()`; no arbitrary delays
remain; previously-passing `sendMouse` calls are untouched.

## Reference

| File | Read when |
|---|---|
| `reference/patterns.md` | You need the dangerous→safe assertion table, or worked examples for polling and dynamic mouse coordinates |
