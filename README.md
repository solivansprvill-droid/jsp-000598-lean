# JSP-000598 — Lean formalization of equal prime supports of C(174,87) and C(176,88)

**Problem (Justin Sun Prize problem bank, JSP-000598):**
> Can two distinct central binomial coefficients have exactly the same prime divisors?

The problem bank records this as **Solved** with **Lean proof: No**. The classical finite witness already appears in Erdős–Graham–Ruzsa–Straus 1975 (and OEIS A129515): `n = 87`, `m = 88`. That pair answers the recorded yes/no question. The infinitude strengthening (Erdős problem #730) is a different claim and is out of scope here.

## The witness

Kummer's theorem: an odd prime `p` divides `C(2n,n)` iff doubling `n` in base `p` produces a carry, i.e. some base-`p` digit `d` of `n` satisfies `2d ≥ p`. The same test covers `p = 2`. A prime `p > 2n` cannot divide `C(2n,n)`, so it is enough to inspect primes `p ≤ 2·88 = 176`.

Independent computation: both supports equal

```
{2, 3, 5, 7, 11, 13, 19, 23, 31, 47, 53, 89, 97, 101, 103, 107, 109,
 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173}
```

(28 primes; empty symmetric difference).

## Contents

| File | Purpose |
| --- | --- |
| `JSP000598.lean` | The formalization. Lean core only, no Mathlib. |
| `lakefile.toml` | Library target. |
| `lean-toolchain` | Pins `leanprover/lean4:v4.34.0`. |

## Verification status

- Arithmetic: settled by an independent Kummer implementation.
- Predicate semantics: `isPrimeB` agrees for `n` in 1..20000; `dividesCentralB` agrees for every `n` in 1..200 and every prime `p ≤ 2n`; zero mismatches.
- **Lean kernel check: not yet performed.** If `native_decide` is unavailable, replace it with `decide`.

Run with `lake build`.
