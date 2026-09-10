# Plugin inventory

Pure discovery inventory: which plugins exist, where. **No verdicts here** —
compliance results belong in `audit-report.md`. Populated/maintained by the
plugin-discovery job (`job-plugin-discovery.md`); consumed by the audit job.

| Repo | Plugin name | Location | Source kind |
|---|---|---|---|
| _(none inventoried yet)_ | | | |

Source kind values: `local file` / `npm package` / `git submodule (not
checked out)` / `git submodule (checked out)`.

## `com-pas/compas-open-scd`

Not yet inventoried plugin-by-plugin against the actual registry
(`compas-plugins.ts` / `oscd-plugins.ts` / `public/js/plugins.js`) this pass.
Known from earlier exploration: local plugins scattered across
`src/compas-editors`, `src/menu`, `src/validators`, `src/locamation`,
`src/addons`; an npm dependency `@compas-oscd/plugins`; and 11 git submodules
under `packages/external-plugins/` (not checked out). Run the
plugin-discovery job (`job-plugin-discovery.md`) to turn this into real rows.
