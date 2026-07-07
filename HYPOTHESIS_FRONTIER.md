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
The helper `hasAdmissibleCutData_iff_nonempty` exposes only that
`HasAdmissibleCutData` is the nonempty wrapper around this data contract.
The alias `HasAdmissibleCutCoalgebraContract` is the data-backed contract name
for consumers that need the pinned admissible-cut interface while legacy
`HasAdmissibleCutCoalgebra` remains raw; the helper
`hasAdmissibleCutCoalgebraContract_iff_hasAdmissibleCutData` exposes that it is
exactly `HasAdmissibleCutData`.
The wrapper `AdmissibleCutData.graftOperator_forestMonomial` exposes only the
coefficient-one `forestMonomial` case of the data field `graftOperator_monomial`.
The wrapper `AdmissibleCutData.graftOperator_add_forestMonomial` exposes only
the two-term additivity consequence of the supplied linear graft operator on
normalized forest monomials.
The wrapper `AdmissibleCutData.graftOperator_nsmul_forestMonomial` exposes
only the natural-multiple consequence of the supplied linear graft operator on
normalized forest monomials.
The wrapper `AdmissibleCutData.graftOperator_zero` exposes only the zero case
of the supplied linear graft operator.
The wrapper `AdmissibleCutData.graftOperator_treeGenerator` exposes the
singleton tree-generator case derived from that field and the closed M0 bridge.
The wrapper `AdmissibleCutData.counit_graftOperator_forestMonomial` combines
that normalized graft-operator case with the supplied `counit_graft` field.
The wrapper `AdmissibleCutData.coproduct_graftOperator_forestMonomial` combines
the normalized graft-operator case with the supplied `cocycle` field.
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
* `hasAdmissibleCutData_iff_nonempty` (definitional audit for the data wrapper).
* `HasAdmissibleCutCoalgebraContract` (data-backed admissible-cut contract alias).
* `hasAdmissibleCutCoalgebraContract_iff_hasAdmissibleCutData` (definitional audit
  for the data-backed contract alias).
* `AdmissibleCutData.graftOperator_forestMonomial` (closed wrapper for the
  normalized forest-monomial case of the graft operator field).
* `AdmissibleCutData.graftOperator_smul_forestMonomial` (closed wrapper for
  scalar multiples of normalized forest monomials under the graft operator).
* `AdmissibleCutData.graftOperator_add_forestMonomial` (closed wrapper for
  two-term sums of normalized forest monomials under the graft operator).
* `AdmissibleCutData.graftOperator_nsmul_forestMonomial` (closed wrapper for
  natural multiples of normalized forest monomials under the graft operator).
* `AdmissibleCutData.graftOperator_zero` (closed wrapper for the zero case of
  the graft operator).
* `AdmissibleCutData.graftOperator_treeGenerator` (closed wrapper for the
  singleton tree-generator case of the graft operator field).
* `AdmissibleCutData.counit_graftOperator_forestMonomial` (closed wrapper for
  the counit-zero consequence on normalized forest monomials).
* `AdmissibleCutData.coproduct_graftOperator_forestMonomial` (closed wrapper
  for the supplied `B_+` 1-cocycle equation on normalized forest monomials).

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
