# Hypothesis Frontier

Last updated: 2026-07-06.

## Current main branch

* Lean `sorry`: 0.
* Project `axiom`: 0.
* Imported Mathlib axioms: whatever Mathlib imports at pin
  `07642720480157414db592fa85b626dafb71355b`; this repository adds none.
* Direct import from THE-ERIKSSON-PROGRAMME: none.

## Explicit hypotheses exposed by `ConnesKreimer.Interfaces`

Raw placeholders: `HasRawCoalgebra`, `HasRawBialgebra`, and
`HasRawHopfAlgebra` are propositions taken as explicit arguments downstream
when an unspecified Mathlib structure class is all that is being assumed.

Compatibility aliases: `HasAdmissibleCutCoalgebra`,
`HasConnesKreimerBialgebra`, and `HasConnesKreimerHopfAlgebra` currently expand
to the corresponding raw placeholders.  The helpers
`hasAdmissibleCutCoalgebra_iff_hasRawCoalgebra`,
`hasConnesKreimerBialgebra_iff_hasRawBialgebra`, and
`hasConnesKreimerHopfAlgebra_iff_hasRawHopfAlgebra` expose those definitional
alias relationships as public Lean theorems.

INTERFACE FINDING (tracked by issue #29): all six names above are `Nonempty`
of a structure class, so any coalgebra/bialgebra/Hopf structure on
`MvPolynomial Tree R` witnesses them, not only the admissible-cut one.  The
mainline structure `AdmissibleCutData` pins the coproduct by the `B_+`
1-cocycle equation as data; proving that such data exist remains frontier work.
Re-expressing the legacy contract through it remains the next Interface-Change
decision.

## Closed facts on `main`

M0 scaffold (previous iteration): `Forest`, `CKAlgebra`, `treeGenerator`,
`forestMonomial`, `Forest.vertexCount`, `IsHomogeneousVertexDegree`.

Grading layer (`Grading.lean`), fully parametric in the tree type:

* `Forest.vertexCount_add`, `Forest.vertexCount_single`.
* `IsHomogeneousVertexDegree.{add, smul, mul}` — in particular graded
  multiplication: degree `m` times degree `n` is degree `m + n`.
* `isHomogeneousVertexDegree_{treeGenerator, forestMonomial, one}`.
* `homogeneousSubmodule` (the degree-`n` component as a `Submodule R`)
  with `homogeneousSubmodule_mul_mem` (the graded-monoid law).

Grafting layer (`Grafting.lean`):

* `GraftingProvider`: provider extension carrying `B_+` and the vertex law
  `|B_+(f)| = |f| + 1`; bijectivity of `B_+` deliberately NOT required.
* `graftGenerator` and the degree shift
  `isHomogeneousVertexDegree_graftGenerator`: `B_+` raises the vertex degree
  by exactly one.
* `vertices_graft_pos`, `vertices_graft_injective_on_count`.
* `AdmissibleCutData` and `HasAdmissibleCutData` (data contract only: coproduct,
  counit, linear `B_+`, and the `B_+` 1-cocycle equations; no existence theorem).

## Frontier obligations (branch `frontier/M1`, statement-first, sorried)

`Frontier/CutCoproduct.lean`:

* `exists_admissibleCutData` under `Function.Bijective graft` (the
  universal property of rooted trees).
* `hasAdmissibleCutCoalgebra_of_bijective_graft` (contract form).
* `hasHopf_of_connected_graded` (M2; the general connected-graded-implies-
  Hopf theorem is a candidate for upstream Mathlib).

## Open mathematical frontier

* Choose or factor a shared rooted-tree type (unchanged; the grafting
  provider now specifies exactly which API that type must export: `graft`
  and the vertex law, plus bijectivity for M1).
* Prove the coproduct lands in the tensor product with finite supports.
* Coassociativity for admissible cuts (the hard proof).
* Bialgebra compatibility; connected graded antipode; Birkhoff/BPHZ demo
  only after the Hopf structure exists.

## Honest distance to the goal

The repository now has real M0 mathematics (the full grading calculus and
the graded `B_+` interface) but still no coproduct, no bialgebra, no
antipode, and no consumer in the mother repository.  The tree-type decision
remains open and is the single blocker for instantiating `GraftingProvider`.
