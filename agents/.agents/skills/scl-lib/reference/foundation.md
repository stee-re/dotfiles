# Foundation, Utilities and Generators

## Foundation / Utilities

| Export | Kind | Description |
|---|---|---|
| `find` | function | `(root: Document, tagName: string, identity: string) => Element \| null` |
| `getReference` | function | Gets the reference node for ordered insertion |
| `getChildren` | function | Gets child elements |
| `identity` | function | `(element: Element) => string \| number` — unique identity string for SCL elements |
| `isPublic` | function | `(element: Element) => boolean` — checks if element is in the public section |
| `TreeSelection` | type | Tree selection state |

## Generators

| Export | Kind | Description |
|---|---|---|
| `macAddressGenerator` | generator | Yields unique MAC addresses |
| `appIdGenerator` | generator | Yields unique APP IDs |
| `lnInstGenerator` | generator | `(lDevice: Element, tag: 'LN') => (lnClass: string) => string` — yields next inst number scoped to an LDevice |

## Deep Import (not in public index)

| Export | Path | Description |
|---|---|---|
| `createElement` | `@openscd/scl-lib/dist/foundation/utils.js` | `(doc: XMLDocument, tag: string, attrs: Record<string, string \| null \| undefined>) => Element` |

**Warning:** `createElement` is accessed via a deep import path not declared in `exports`. If scl-lib adds an `exports` map, this path may break.
