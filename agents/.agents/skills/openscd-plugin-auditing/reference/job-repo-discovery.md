# Job: repo discovery

Find or vet OpenSCD monorepo/host forks to add to `repos.md`, distinguishing
a real plugin-hosting host from a lookalike utility package.

## Problem

New OpenSCD forks/hosts appear over time and aren't always obviously
"OpenSCD" by name — some are the same repo republished under a renamed
package, some are foundation/utility libraries (e.g. `@openscd/core`) that
look related but never instantiate a plugin. Miscataloguing a lookalike as a
host wastes an entire pass.

## Procedure

1. Check `~/code/<org>/*` for candidates before searching the network; only
   clone if the user confirms it's needed.
2. Confirm it's a genuine plugin-hosting host, not a utility library: look for
   a render call site instantiating plugin custom elements (grep
   `unsafeStatic`/`staticHtml`/`renderPluginContent`) and a document
   event-listener setup. A package with only type/utility exports is not a
   host.
3. Record: org/repo, published package name(s) (note renames), version read,
   local checkout convention, and its compliant property/event baseline —
   append to `./repos.md` following its existing table shape.
4. Cross-check against forks of the same lineage before re-deriving a
   contract already confirmed elsewhere — note "identical to X", don't
   duplicate.

## Pitfalls

- Treating a foundation/utility package as a host.
- Hardcoding a personal absolute path into `repos.md`.
- Adding a repo without noting the exact version read — contracts drift.

## Exit criteria

New entry in `repos.md` cites the exact file(s) its contract was read from,
and contains no personal absolute path.
