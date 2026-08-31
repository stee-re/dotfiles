# Proving namespace correctness with decoy fixtures

## The problem

`getAttribute('x')` and `getAttributeNS(ns, 'x')` return the same value on a
fixture that contains only the namespaced attribute. A test built on such a
fixture passes whether the code under test is correct or not — the namespace bug
is invisible.

## The technique

In fixtures, inject an **unnamespaced twin** of every namespaced attribute,
holding a poison value:

```xml
<!-- real attribute alongside its decoy -->
<SomeElement x="DECOY" ns:x="3" />
```

Now the two reads diverge:

- Correct code reading `getAttributeNS(ns, 'x')` still sees `"3"` and passes.
- Buggy code reading `getAttribute('x')` sees `"DECOY"` and fails loudly — a
  wrong assertion, a `NaN` from numeric coercion, or a thrown parse error.

## Why it is worth the noise in fixtures

It converts a silent, easily-missed namespace mistake into an immediate,
self-pointing test failure. The failure message points at the exact read that
dropped the namespace, instead of surfacing much later as wrong SCL output.

Apply it wherever namespace misuse is a genuine risk — typically any attribute
carried in a non-default namespace, or any code path handling both namespaced
and unnamespaced documents.
