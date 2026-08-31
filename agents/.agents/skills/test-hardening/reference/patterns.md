# Test hardening patterns

Worked examples and replacement tables for the rules in `SKILL.md`.

## Rule 1: Never Pass DOM Objects to `expect()`

Extract the primitive value BEFORE asserting:

```typescript
// WRONG — if assertion fails, serialization of element crashes the runner
expect(element.doc.documentElement).to.have.attribute('xmlns:eosld');
expect(element.shadowRoot!.querySelector('sld-editor')).to.exist;
expect(container.querySelector('Bay[name="B1"]')).to.not.be.null;

// CORRECT — assert on primitive values only
const eosldAttr = element.doc.documentElement.getAttribute('xmlns:eosld');
expect(eosldAttr).to.not.be.null;

const sldEditor = element.shadowRoot!.querySelector('sld-editor');
expect(sldEditor).to.not.be.null; // CAUTION: Still risky — sldEditor is a DOM node!

// SAFEST — convert to boolean or string before expect
const hasSldEditor = !!element.shadowRoot!.querySelector('sld-editor');
expect(hasSldEditor).to.be.true;

const bayName = container.querySelector('Bay')?.getAttribute('name');
expect(bayName).to.equal('B1');
```

### Patterns to Find and Fix

| Dangerous Pattern | Safe Replacement |
|---|---|
| `expect(el).to.exist` | `expect(!!el).to.be.true` |
| `expect(el).to.not.be.null` | `expect(!!el).to.be.true` |
| `expect(el).to.have.attribute('x')` | `expect(el?.getAttribute('x')).to.not.be.null` or `expect(el?.hasAttribute('x')).to.be.true` |
| `expect(el).to.have.attribute('x', 'v')` | `expect(el?.getAttribute('x')).to.equal('v')` |
| `expect(el.property).to.equal(...)` | Safe IF `.property` returns a primitive — verify it isn't a DOM node |
| `expect(queryResult).to.equal(otherElement)` | `expect(queryResult === otherElement).to.be.true` |
| `expect(el).to.have.class('active')` | `expect(el?.classList.contains('active')).to.be.true` |

### Edge Case: Arrays of Elements

```typescript
// WRONG
expect(element.querySelectorAll('Bay')).to.have.length(3);

// CORRECT
const bayCount = element.querySelectorAll('Bay').length;
expect(bayCount).to.equal(3);
```

## Rule 2: Prefer Selector-Based Interactions Over sendMouse

Where practical, query the target element through the shadow DOM and call `.click()` directly. However, **do not refactor existing sendMouse usage** during migration — it's not worth the risk of introducing new behavioral differences in tests.

For new tests or when a sendMouse call is causing issues, prefer:

```typescript
// Preferred for new code
const fab = deepQuery<HTMLElement>(element, 'oscd-fab[title="Add Bay"]');
fab!.click();
await element.updateComplete;
```

### When sendMouse is Kept (Most Cases)

If existing tests use `sendMouse` and are passing, leave them. If they're failing due to coordinate drift (layout changed during migration), fix by calculating positions dynamically from element bounds:

```typescript
const rect = targetElement.getBoundingClientRect();
const x = Math.round(rect.left + rect.width / 2);
const y = Math.round(rect.top + rect.height / 2);
await sendMouse({ type: 'click', position: [x, y] });
```

## Rule 3: Wait for Scoped Element Upgrades

Scoped custom elements may not upgrade synchronously after `fixture()`. Use polling instead of fixed timeouts:

```typescript
// WRONG — arbitrary delay, may be too short or too long
await aTimeout(200);
const editor = element.shadowRoot!.querySelector('sld-editor');

// CORRECT — poll until the element is upgraded and ready
async function waitForElement<T extends Element>(
  root: Element | ShadowRoot,
  selector: string,
  timeout = 5000
): Promise<T> {
  const start = Date.now();
  while (Date.now() - start < timeout) {
    const el = (root.shadowRoot ?? root).querySelector(selector);
    if (el && el.matches(':defined')) return el as T;
    await new Promise(r => requestAnimationFrame(r));
  }
  throw new Error(`Timed out waiting for "${selector}" to be defined`);
}

// Usage
const sldEditor = await waitForElement<SldEditor>(element, 'sld-editor');
```
