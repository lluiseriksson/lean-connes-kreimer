# Hypothesis Frontier

Last updated: 2026-07-03.

## Current main branch

* Lean `sorry`: 0.
* Project `axiom`: 0.
* Imported Mathlib axioms: whatever Mathlib imports at pin
  `07642720480157414db592fa85b626dafb71355b`; this repository adds none.
* Direct import from THE-ERIKSSON-PROGRAMME: none.

## Explicit hypotheses exposed by `ConnesKreimer.Interfaces`

The following are propositions, not assumed globally:

* `HasAdmissibleCutCoalgebra R P`: there is a Mathlib `Coalgebra` structure on
  `CKAlgebra R P.Tree`.
* `HasConnesKreimerBialgebra R P`: there is a Mathlib `Bialgebra` structure on
  `CKAlgebra R P.Tree`.
* `HasConnesKreimerHopfAlgebra R P`: there is a Mathlib `HopfAlgebra`
  structure on `CKAlgebra R P.Tree`.

Any downstream theorem using these must take them as explicit arguments.

## Open mathematical frontier

* Choose or factor a shared rooted-tree type.  This repo intentionally defines
  no tree datatype.
* Define admissible cuts for the chosen tree API.
* Prove the coproduct is finite and lands in the tensor product.
* Prove counit laws and coassociativity for admissible cuts.
* Prove compatibility of the coproduct with multiplication, yielding a
  bialgebra over `MvPolynomial Tree R`.
* Formalize the connected graded bialgebra argument or reuse/upstream a
  Mathlib theorem to construct the recursive antipode.
* Add any Birkhoff/BPHZ demo only after the Hopf structure exists.

## Honest distance to the goal

The repository currently reaches only an M0 scaffold.  It formalizes the free
commutative algebra of forests and the bookkeeping predicate for vertex-degree
homogeneity.  It does not yet define admissible cuts, a coproduct, a bialgebra,
or an antipode.
