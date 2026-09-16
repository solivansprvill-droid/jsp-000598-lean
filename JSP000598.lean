/-
  The Justin Sun Prize — JSP-000598
  ------------------------------------------------------------------
  Problem: Can two distinct central binomial coefficients have
  exactly the same prime divisors?

  Status in the problem bank: Solved (GPT Pro / Liam Price) —
  but "Lean proof: No". The classical finite witness already
  appears in Erdős–Graham–Ruzsa–Straus 1975:

        n = 87, m = 88

  i.e. C(174, 87) and C(176, 88) have identical prime support.
  That pair answers the recorded yes/no question. (The infinitude
  strengthening is a different claim and is out of scope here.)

  Criterion (Kummer / Lucas): an odd prime p divides C(2n, n)
  iff doubling n in base p produces a carry, equivalently iff
  some base-p digit d of n satisfies 2d ≥ p. For p = 2 the same
  test holds (2d ≥ 2 iff some digit is at least 1, i.e. n > 0).
  A prime p > 2n cannot divide C(2n, n), so it is enough to
  inspect primes p ≤ 2 · 88 = 176.

  VERIFICATION STATUS
  (a) Arithmetic: Kummer supports of n=87 and n=88 computed
      independently; they are equal (28 primes) with empty
      symmetric difference.
  (b) Predicate semantics: isPrimeB agrees for n in 1..20000;
      dividesCentralB agrees with an independent Kummer
      implementation for every n in 1..200 and every prime
      p ≤ 2n, zero mismatches.
  (c) The Lean code itself has NOT been run through the kernel.
-/

namespace JSP000598

def isPrimeB (n : Nat) : Bool :=
  if n < 2 then false
  else (List.range (Nat.sqrt n + 1)).all (fun d => d == 0 || d == 1 || n % d != 0)

/-- Base-`p` digits of `n`, least significant first. Fuel is `n+1`, which
    is enough because each step strictly decreases `x` while `x > 0`. -/
def digitsAux : Nat → Nat → Nat → List Nat
  | 0, _, _ => []
  | fuel + 1, x, p =>
    if x == 0 then []
    else (x % p) :: digitsAux fuel (x / p) p

def digitsB (n p : Nat) : List Nat :=
  if p < 2 then [] else digitsAux (n + 1) n p

/-- `p` divides the central binomial `C(2n, n)`, via the Kummer carry test.
    `2 * d ≥ p` is encoded as `!(2 * d < p)` so the predicate stays Bool. -/
def dividesCentralB (n p : Nat) : Bool :=
  (digitsB n p).any (fun d => !(2 * d < p))

/-- Prime support of `C(2n, n)`, represented as a Bool predicate on `p`. -/
def inSupportB (n p : Nat) : Bool :=
  isPrimeB p && dividesCentralB n p

theorem same_support_87_88 :
    (List.range 177).all (fun p => inSupportB 87 p == inSupportB 88 p) = true := by
  native_decide

theorem distinct_indices : 87 ≠ 88 := by native_decide

end JSP000598
