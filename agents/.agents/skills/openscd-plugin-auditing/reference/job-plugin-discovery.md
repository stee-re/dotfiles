# Job: plugin discovery

Inventory the actual plugins inside an already-catalogued OpenSCD repo,
updating `plugins.md` — resolving registries, submodules and npm-dep plugins
vs. lookalike app-shell or service files.

## Problem

A monorepo's plugin list rarely matches its folder layout 1:1 — plugins can
be local files, an npm dependency, or git submodules, and files that merely
look like plugins (service modules, app-shell components) often sit alongside
them undetected unless the actual registry is checked.

## Procedure

1. Find the repo's actual plugin registry (e.g. `*-plugins.ts`, `plugins.js`)
   — the file the host reads to know what to render — rather than assuming a
   folder's contents are all plugins.
2. For each registry entry, confirm it resolves to a real custom element
   definition, not a service/utility module coincidentally exported nearby.
3. Note the plugin's source kind: local file, npm package, or git submodule
   (submodules may not be checked out locally — record "not checked out"
   rather than skipping silently).
4. Record each as a row in `./plugins.md`: repo, plugin name, file path (or
   package + export), source kind. No verdict column — that belongs to
   `audit-report.md`.

## Pitfalls

- Assuming folder contents equal the plugin list.
- Recording a service module or app-shell component as a plugin.
- Silently skipping an uncontacted git submodule instead of noting it.

## Exit criteria

Every row in `plugins.md` resolves to an actual registry entry, not a guess
from folder structure. If the repo itself isn't in `repos.md` yet, run the
repo-discovery job first.
