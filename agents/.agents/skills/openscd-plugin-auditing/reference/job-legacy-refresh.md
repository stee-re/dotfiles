# Job: legacy term refresh

Re-derive a host's actual property/event contract from its instantiation and
listener source and update `known-unsupported.md` — for when a host version
bumps or a new mechanism is suspected.

## Problem

Host contracts drift silently across versions. Re-verifying "is this still
true" is cheap compared to the cost of an audit trusting a stale catalogue
entry and misclassifying a plugin.

## Procedure

1. Re-read the host's plugin-instantiation call site and event-listener setup
   exactly as before (see `./repos.md` for the prior citation) — diff against
   what's recorded, don't assume it's unchanged.
2. If a plugin uses a property/event/builder function not yet in
   `./known-unsupported.md`, trace it to its source package or file,
   determine whether it dispatches inline, and classify it: compliant /
   shimmable-reliable / shimmable-unproven / unsupportable — citing evidence
   for any reliability claim (deployed? tested? "back pocket only"?).
3. Update `known-unsupported.md`'s relevant table; update `repos.md`'s
   version/citation too if the host itself changed.

## Pitfalls

- Marking a shim "reliable" without evidence it's deployed and tested.
- Overwriting a prior citation without checking whether the underlying source
  actually changed.

## Exit criteria

Every new or changed row cites the exact source file/function it was
re-derived from. If the change concerns the official contract shape itself
rather than a legacy/extension mechanism, escalate to the `oscd-api` skill
instead.
