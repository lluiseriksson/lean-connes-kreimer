# Hypothesis Frontier

Last updated: 2026-07-03 (second iteration).

## Current main branch

* Lean `sorry`: 0.
* Project `axiom`: 0.
* Imported Mathlib axioms: whatever Mathlib imports at pin
  `07642720480157414db592fa85b626dafb71355b`; this repository adds none.
* Direct import from THE-ERIKSSON-PROGRAMME: none.

## Explicit hypotheses exposed by `ConnesKreimer.Interfaces`

Unchanged: `HasAdmissibleCutCoalgebra`, `HasConnesKreimerBialgebra`,
`HasConnesKreimerHopfAlgebra` remain propositions taken as explicit
arguments downstream.

INTERFACE FINDING (flagged, contract untouched): these hypotheses are
`Nonempty` of a structure class, so any coalgebra/bialgebra/Hopf structure
on `MvPolynomial Tree R` witnesses them, not only the admissible-cut one.
The frontier structure `AdmissibleCutData` pins the coproduct by the `B_+`
1-cocycle equation; re-expressing the contract through it requires the
Interface-Change ritual and is the Revisor's call.

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

## Frontier obligations (branch `frontier/M1`, statement-first, sorried)

`Frontier/CutCoproduct.lean`:

* `AdmissibleCutData` (coproduct + counit + linear `B_+`, pinned by the
  1-cocycle equation — the property that characterizes the Connes-Kreimer
  coproduct).
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
