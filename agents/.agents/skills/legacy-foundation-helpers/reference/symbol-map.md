# `@openscd/open-scd` sub-paths and their replacements

## Sub-paths used by legacy plugins (package NOT published on npm)

| Sub-path | Symbols |
|---|---|
| `src/foundation.js` | `compareNames`, `getDescriptionAttribute`, `getNameAttribute`, `getSclSchemaVersion`, `identity`, `isPublic`, `minAvailableLogicalNodeInstance`, `newWizardEvent` |
| `src/foundation/ied.js` | `emptyInputsDeleteActions`, `getFcdaReferences` |
| `src/foundation/nsdoc.js` | `Nsdoc` |
| `src/icons/icons.js` | `gooseIcon`, `smvIcon` |
| `src/schemas.js` | `SCL_NAMESPACE` |
| `src/filtered-list.js` | side-effect: registers `<filtered-list>` |

## Category 1: use `@openscd/scl-lib`

| Symbol | Replacement |
|---|---|
| `identity` | `import { identity } from '@openscd/scl-lib'` |
| `isPublic` | `import { isPublic } from '@openscd/scl-lib'` |
| `find` (transitive) | `import { find } from '@openscd/scl-lib'` |
| `minAvailableLogicalNodeInstance` | `import { lnInstGenerator } from '@openscd/scl-lib'` (schema-correctness improvement) |
| `controlBlockReference` (local) | `import { controlBlockObjRef } from '@openscd/scl-lib'` (stricter null guard) |

## Category 3: dedicated recipe skills

| Symbol | Skill to load |
|---|---|
| `Nsdoc` | `$nsdoc-standalone` |
| `gooseIcon`, `smvIcon` | `$scl-icons` |
| `newWizardEvent` | `$scl-dialogs-embedding` (Step 4 replaces wizards) |
| `<filtered-list>` | `$filtered-list-to-oscd-ui` |

## Category 4: not used — do not copy

`newSubWizardEvent`, `referencePath`, `pathParts`, `crossProduct`, `depth`, `findFCDAs`, `findControlBlocks`, etc.
