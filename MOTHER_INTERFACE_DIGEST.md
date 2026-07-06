# Mother-Facing Interface Digest

Last updated: 2026-07-07.

Audited public HEAD for this digest:
`82b0602f42d395025afcb849a80b6fb2f59eaa7b`
(`add admissible cut nsmul wrapper (#50)`).

Latest observed `main` CI for this HEAD:

* Lean: success, run `28828974960`.
* Heartbeat: success, run `28828974945`.

## Import

Future consumers should use:

```lean
import Interfaces
```

This root import currently re-exports the closed-proof M0 surface:

* `ConnesKreimer.Basic`
* `ConnesKreimer.Grading`
* `ConnesKreimer.Grafting`
* `ConnesKreimer.AdmissibleCutData`
* the explicit frontier hypotheses in `ConnesKreimer.Interfaces`

Consumability oracle: `ConnesKreimer.ImportOracle` is built with the library
and imports only `Interfaces` before checking representative closed M0 names.
It is an internal build check, not an additional consumer-facing import path.
At this audited HEAD, the oracle still checks the documented graft-count guard
names added through PR #41, including
`ConnesKreimer.GraftingProvider.vertices_graft_single`,
`ConnesKreimer.GraftingProvider.vertices_graft_single_pos`,
`ConnesKreimer.GraftingProvider.vertices_graft_ne_zero`,
`ConnesKreimer.GraftingProvider.vertexCount_lt_vertices_graft`,
`ConnesKreimer.GraftingProvider.vertices_graft_eq_one_iff_vertexCount_zero`,
and
`ConnesKreimer.GraftingProvider.vertices_graft_eq_iff_vertexCount_eq`.
It also checks the `AdmissibleCutData` wrappers added through #50, including
`ConnesKreimer.AdmissibleCutData.graftOperator_one`,
`ConnesKreimer.AdmissibleCutData.graftOperator_nsmul_forestMonomial`,
`ConnesKreimer.AdmissibleCutData.counit_graftOperator_one`, and
`ConnesKreimer.AdmissibleCutData.coproduct_graftOperator_one`.

There is still no direct import from THE-ERIKSSON-PROGRAMME into this
satellite, and this satellite should not be imported by the mother repository
until a real counterterm-bookkeeping consumer exists.

## Provider Shape

The repository deliberately defines no rooted-tree datatype.  A consumer or
shared tree package must supply:

```lean
P : ConnesKreimer.RootedTreeProvider
```

with:

* `P.Tree : Type u`
* `P.vertices : P.Tree -> Nat`

For grafting-sensitive statements, it must instead supply:

```lean
P : ConnesKreimer.GraftingProvider
```

with the additional data:

* `P.graft : ConnesKreimer.Forest P.Tree -> P.Tree`
* `P.vertices_graft : forall f, P.vertices (P.graft f) =
    ConnesKreimer.Forest.vertexCount P.vertices f + 1`

Bijectivity of `graft` is not a field on `GraftingProvider`; it remains an
explicit hypothesis for M1 frontier statements.

## Closed M0 Names

Algebra and forests:

* `ConnesKreimer.Forest`
* `ConnesKreimer.CKAlgebra`
* `ConnesKreimer.treeGenerator`
* `ConnesKreimer.forestMonomial`
* `ConnesKreimer.forestMonomial_zero`
* `ConnesKreimer.forestMonomial_add`
* `ConnesKreimer.forestMonomial_single`
* `ConnesKreimer.treeGenerator_eq_forestMonomial_single_one`
* `ConnesKreimer.Forest.vertexCount`
* `ConnesKreimer.IsHomogeneousVertexDegree`

Provider interface:

* `ConnesKreimer.RootedTreeProvider`
* `ConnesKreimer.RootedTreeProvider.Algebra`
* `ConnesKreimer.RootedTreeProvider.Forest`
* `ConnesKreimer.GraftingProvider`

Closed grading lemmas:

* `ConnesKreimer.Forest.vertexCount_zero`
* `ConnesKreimer.Forest.vertexCount_add`
* `ConnesKreimer.Forest.vertexCount_single`
* `ConnesKreimer.Forest.vertexCount_single_one`
* `ConnesKreimer.isHomogeneousVertexDegree_zero`
* `ConnesKreimer.IsHomogeneousVertexDegree.add`
* `ConnesKreimer.IsHomogeneousVertexDegree.smul`
* `ConnesKreimer.IsHomogeneousVertexDegree.mul`
* `ConnesKreimer.isHomogeneousVertexDegree_treeGenerator`
* `ConnesKreimer.isHomogeneousVertexDegree_forestMonomial`
* `ConnesKreimer.isHomogeneousVertexDegree_one`
* `ConnesKreimer.homogeneousSubmodule`
* `ConnesKreimer.mem_homogeneousSubmodule`
* `ConnesKreimer.treeGenerator_mem_homogeneousSubmodule`
* `ConnesKreimer.forestMonomial_mem_homogeneousSubmodule`
* `ConnesKreimer.isHomogeneousVertexDegree_forestMonomial_mul`
* `ConnesKreimer.forestMonomial_mul_mem_homogeneousSubmodule`
* `ConnesKreimer.one_mem_homogeneousSubmodule`
* `ConnesKreimer.homogeneousSubmodule_mul_mem`

Closed grafting lemmas:

* `ConnesKreimer.GraftingProvider.graftGenerator`
* `ConnesKreimer.GraftingProvider.isHomogeneousVertexDegree_graftGenerator`
* `ConnesKreimer.GraftingProvider.graftGenerator_mem_homogeneousSubmodule`
* `ConnesKreimer.GraftingProvider.isHomogeneousVertexDegree_graftGenerator_single`
* `ConnesKreimer.GraftingProvider.graftGenerator_single_mem_homogeneousSubmodule`
* `ConnesKreimer.GraftingProvider.isHomogeneousVertexDegree_graftGenerator_single_one`
* `ConnesKreimer.GraftingProvider.graftGenerator_single_one_mem_homogeneousSubmodule`
* `ConnesKreimer.GraftingProvider.isHomogeneousVertexDegree_graftGenerator_zero`
* `ConnesKreimer.GraftingProvider.graftGenerator_zero_mem_homogeneousSubmodule`
* `ConnesKreimer.GraftingProvider.vertices_graft_zero`
* `ConnesKreimer.GraftingProvider.vertices_graft_single`
* `ConnesKreimer.GraftingProvider.vertices_graft_single_one`
* `ConnesKreimer.GraftingProvider.vertices_graft_pos`
* `ConnesKreimer.GraftingProvider.vertices_graft_ne_zero`
* `ConnesKreimer.GraftingProvider.vertexCount_lt_vertices_graft`
* `ConnesKreimer.GraftingProvider.vertexCount_ne_vertices_graft`
* `ConnesKreimer.GraftingProvider.vertices_graft_single_pos`
* `ConnesKreimer.GraftingProvider.vertexCount_single_lt_vertices_graft_single`
* `ConnesKreimer.GraftingProvider.vertices_graft_single_ne_zero`
* `ConnesKreimer.GraftingProvider.vertices_graft_single_one_pos`
* `ConnesKreimer.GraftingProvider.vertices_lt_vertices_graft_single_one`
* `ConnesKreimer.GraftingProvider.vertices_graft_single_one_ne_zero`
* `ConnesKreimer.GraftingProvider.vertices_graft_eq_one_iff_vertexCount_zero`
* `ConnesKreimer.GraftingProvider.vertices_graft_single_eq_one_iff_mul_vertices_eq_zero`
* `ConnesKreimer.GraftingProvider.vertices_graft_single_one_eq_one_iff_vertices_eq_zero`
* `ConnesKreimer.GraftingProvider.one_lt_vertices_graft_iff_vertexCount_pos`
* `ConnesKreimer.GraftingProvider.one_lt_vertices_graft_single_iff_mul_vertices_pos`
* `ConnesKreimer.GraftingProvider.one_lt_vertices_graft_single_one_iff_vertices_pos`
* `ConnesKreimer.GraftingProvider.vertices_graft_injective_on_count`
* `ConnesKreimer.GraftingProvider.vertices_graft_eq_iff_vertexCount_eq`

## Local Assumptions Needed by Lemmas

Most definitions need only `[CommSemiring R]`.  Lemmas using polynomial
coefficients of named monomials or antidiagonals require `[DecidableEq Tree]`
or `[DecidableEq P.Tree]`; this is explicit in the theorem signatures.

## Frontier Hypotheses

The following are explicit hypotheses, not proved structures:

* `ConnesKreimer.HasRawCoalgebra`
* `ConnesKreimer.HasRawBialgebra`
* `ConnesKreimer.HasRawHopfAlgebra`
* `ConnesKreimer.HasAdmissibleCutCoalgebra`
* `ConnesKreimer.HasConnesKreimerBialgebra`
* `ConnesKreimer.HasConnesKreimerHopfAlgebra`
* `ConnesKreimer.hasAdmissibleCutCoalgebra_iff_hasRawCoalgebra`
* `ConnesKreimer.hasConnesKreimerBialgebra_iff_hasRawBialgebra`
* `ConnesKreimer.hasConnesKreimerHopfAlgebra_iff_hasRawHopfAlgebra`
* `ConnesKreimer.AdmissibleCutData`
* `ConnesKreimer.HasAdmissibleCutData`
* `ConnesKreimer.HasAdmissibleCutCoalgebraContract`
* `ConnesKreimer.hasAdmissibleCutData_iff_nonempty`
* `ConnesKreimer.hasAdmissibleCutCoalgebraContract_iff_hasAdmissibleCutData`
* `ConnesKreimer.AdmissibleCutData.graftOperator_forestMonomial`
* `ConnesKreimer.AdmissibleCutData.graftOperator_smul_forestMonomial`
* `ConnesKreimer.AdmissibleCutData.graftOperator_add_forestMonomial`
* `ConnesKreimer.AdmissibleCutData.graftOperator_nsmul_forestMonomial`
* `ConnesKreimer.AdmissibleCutData.graftOperator_treeGenerator`
* `ConnesKreimer.AdmissibleCutData.graftOperator_one`
* `ConnesKreimer.AdmissibleCutData.counit_graftOperator_forestMonomial`
* `ConnesKreimer.AdmissibleCutData.counit_graftOperator_treeGenerator`
* `ConnesKreimer.AdmissibleCutData.counit_graftOperator_one`
* `ConnesKreimer.AdmissibleCutData.coproduct_graftOperator_forestMonomial`
* `ConnesKreimer.AdmissibleCutData.coproduct_graftOperator_treeGenerator`
* `ConnesKreimer.AdmissibleCutData.coproduct_graftOperator_one`

Current interface caveat: the three `HasRaw...` names and the three legacy
compatibility names are `Nonempty` wrappers around Mathlib structure classes on
the polynomial algebra.  The `HasRaw...` names are the preferred exact names
when this rawness matters.  The legacy
Connes-Kreimer/admissible-cut names remain compatibility aliases, but they do
not by themselves characterize the admissible-cut coproduct.  Issue #29 tracks
whether the legacy names should eventually be tied to the data-bearing
contract.  `ConnesKreimer.AdmissibleCutData` is now the consumable stricter
shape, but it is only a data contract: main does not prove that such data exist.
The three `..._iff_hasRaw...` helpers expose this alias relationship directly
and are covered by the import oracle.  The data-contract helper
`ConnesKreimer.hasAdmissibleCutData_iff_nonempty` similarly exposes that
`ConnesKreimer.HasAdmissibleCutData R P` is exactly nonemptiness of
`ConnesKreimer.AdmissibleCutData P R`.  The data-backed contract alias
`ConnesKreimer.HasAdmissibleCutCoalgebraContract` is the explicit pinned
replacement target for consumers that need admissible-cut data rather than the
legacy raw `HasAdmissibleCutCoalgebra` placeholder, and
`ConnesKreimer.hasAdmissibleCutCoalgebraContract_iff_hasAdmissibleCutData`
exposes that it is exactly `HasAdmissibleCutData`.  The wrapper
`ConnesKreimer.AdmissibleCutData.graftOperator_forestMonomial` exposes that the
linear graft operator sends the normalized forest monomial to the corresponding
graft generator.  The wrapper
`ConnesKreimer.AdmissibleCutData.graftOperator_smul_forestMonomial` exposes the
same supplied operator on scalar multiples of normalized forest monomials.  The
wrapper
`ConnesKreimer.AdmissibleCutData.graftOperator_add_forestMonomial` exposes the
same supplied operator on two-term sums of normalized forest monomials.  The
wrapper `ConnesKreimer.AdmissibleCutData.graftOperator_nsmul_forestMonomial`
exposes the same supplied operator on natural multiples of normalized forest
monomials.  The
wrapper
`ConnesKreimer.AdmissibleCutData.graftOperator_treeGenerator` exposes the
same supplied linear graft operator on a named tree generator by using the
closed singleton forest bridge.  The wrapper
`ConnesKreimer.AdmissibleCutData.graftOperator_one` exposes the same supplied
operator on the unit, viewed as the empty-forest monomial.  The wrapper
`ConnesKreimer.AdmissibleCutData.counit_graftOperator_forestMonomial` exposes
that the supplied counit kills that normalized graft-operator output; the
singleton-tree and unit cases are exposed by
`ConnesKreimer.AdmissibleCutData.counit_graftOperator_treeGenerator` and
`ConnesKreimer.AdmissibleCutData.counit_graftOperator_one`.  The wrapper
`ConnesKreimer.AdmissibleCutData.coproduct_graftOperator_forestMonomial`
exposes the supplied `B_+` 1-cocycle equation on the same normalized output;
the singleton-tree and unit cases are exposed by
`ConnesKreimer.AdmissibleCutData.coproduct_graftOperator_treeGenerator` and
`ConnesKreimer.AdmissibleCutData.coproduct_graftOperator_one`.

## Current Interface Blocker

Issue #29 is the active interface-change blocker.  The exact current source is
`ConnesKreimer/Interfaces.lean`, where
`ConnesKreimer.HasAdmissibleCutCoalgebra`,
`ConnesKreimer.HasConnesKreimerBialgebra`, and
`ConnesKreimer.HasConnesKreimerHopfAlgebra` are compatibility aliases for the
raw placeholders
`ConnesKreimer.HasRawCoalgebra`,
`ConnesKreimer.HasRawBialgebra`, and
`ConnesKreimer.HasRawHopfAlgebra`.
The import oracle covers only that alias relation via
`ConnesKreimer.hasAdmissibleCutCoalgebra_iff_hasRawCoalgebra`,
`ConnesKreimer.hasConnesKreimerBialgebra_iff_hasRawBialgebra`, and
`ConnesKreimer.hasConnesKreimerHopfAlgebra_iff_hasRawHopfAlgebra`.

The missing mathematical payload for M1 is an existence theorem and downstream
contract decision for the data-bearing admissible-cut API.  Main now exposes
`ConnesKreimer.AdmissibleCutData` and `ConnesKreimer.HasAdmissibleCutData` as
the shape to satisfy, plus
`ConnesKreimer.hasAdmissibleCutData_iff_nonempty` and
`ConnesKreimer.HasAdmissibleCutCoalgebraContract` and
`ConnesKreimer.hasAdmissibleCutCoalgebraContract_iff_hasAdmissibleCutData` and
`ConnesKreimer.AdmissibleCutData.graftOperator_forestMonomial` and
`ConnesKreimer.AdmissibleCutData.graftOperator_smul_forestMonomial` and
`ConnesKreimer.AdmissibleCutData.graftOperator_add_forestMonomial` and
`ConnesKreimer.AdmissibleCutData.graftOperator_nsmul_forestMonomial` and
`ConnesKreimer.AdmissibleCutData.graftOperator_treeGenerator` and
`ConnesKreimer.AdmissibleCutData.graftOperator_one` and
`ConnesKreimer.AdmissibleCutData.counit_graftOperator_forestMonomial` and
`ConnesKreimer.AdmissibleCutData.counit_graftOperator_treeGenerator` and
`ConnesKreimer.AdmissibleCutData.counit_graftOperator_one` and
`ConnesKreimer.AdmissibleCutData.coproduct_graftOperator_forestMonomial` and
`ConnesKreimer.AdmissibleCutData.coproduct_graftOperator_treeGenerator` and
`ConnesKreimer.AdmissibleCutData.coproduct_graftOperator_one` as wrapper
audits.  The raw aliases remain explicitly raw; consumers that want a pinned
admissible-cut interface should use
`HasAdmissibleCutCoalgebraContract`, not the legacy raw alias.

## What the Mother Repository Can Consume Today

Today the useful payload is bookkeeping infrastructure: forests as polynomial
monomials, vertex grading, homogeneous components with direct membership
lemmas for generators, monomials, the unit, and provider-level graft
generators.  The closed monomial wrappers
`ConnesKreimer.forestMonomial_zero` and
`ConnesKreimer.forestMonomial_add` expose that the empty forest maps to the
unit and that forest addition maps to multiplication in `CKAlgebra`.  These
are the direct M0 bookkeeping facts a downstream counterterm ledger would need
before any coproduct API exists.
The closed singleton-power wrapper
`ConnesKreimer.forestMonomial_single` exposes
`forestMonomial R (Finsupp.single t m) = treeGenerator R t ^ m`, so a
downstream ledger can rewrite repeated occurrences of one tree between forest
notation and powers of the corresponding polynomial generator without
unfolding `MvPolynomial`.
The closed product-degree wrappers
`ConnesKreimer.isHomogeneousVertexDegree_forestMonomial_mul` and
`ConnesKreimer.forestMonomial_mul_mem_homogeneousSubmodule` expose that the
product of forest monomials for `f` and `g` lies in vertex degree
`ConnesKreimer.Forest.vertexCount vertices f +
ConnesKreimer.Forest.vertexCount vertices g`, without requiring a downstream
consumer to unfold the generic homogeneous multiplication lemma.
Singleton-source graft generators have direct
homogeneous degree and homogeneous-submodule wrappers,
`ConnesKreimer.GraftingProvider.isHomogeneousVertexDegree_graftGenerator_single`
and
`ConnesKreimer.GraftingProvider.graftGenerator_single_mem_homogeneousSubmodule`,
at the computed degree `m * P.vertices t + 1`.  The multiplicity-one
specializations
`ConnesKreimer.GraftingProvider.isHomogeneousVertexDegree_graftGenerator_single_one`
and
`ConnesKreimer.GraftingProvider.graftGenerator_single_one_mem_homogeneousSubmodule`
give the direct degree `P.vertices t + 1` surface.  The empty graft still has
degree-1 homogeneous-submodule membership via
`ConnesKreimer.GraftingProvider.graftGenerator_zero_mem_homogeneousSubmodule`,
plus the provider-level grafting degree shift, including the closed
empty-forest value
`ConnesKreimer.GraftingProvider.vertices_graft_zero`, the single-tree
multiplicity formula
`ConnesKreimer.GraftingProvider.vertices_graft_single`, and the singleton
graft count `ConnesKreimer.GraftingProvider.vertices_graft_single_one`.
For downstream guards that need positivity rather than an exact degree formula,
the generic wrapper
`ConnesKreimer.GraftingProvider.vertices_graft_ne_zero` and the singleton
wrappers
`ConnesKreimer.GraftingProvider.vertices_graft_single_pos`,
`ConnesKreimer.GraftingProvider.vertices_graft_single_ne_zero`,
`ConnesKreimer.GraftingProvider.vertices_graft_single_one_pos`, and
`ConnesKreimer.GraftingProvider.vertices_graft_single_one_ne_zero` expose the
nonzero new-root fact without unfolding the provider law.  The strict
new-root increment wrappers
`ConnesKreimer.GraftingProvider.vertexCount_lt_vertices_graft`,
`ConnesKreimer.GraftingProvider.vertexCount_ne_vertices_graft`,
`ConnesKreimer.GraftingProvider.vertexCount_single_lt_vertices_graft_single`,
and
`ConnesKreimer.GraftingProvider.vertices_lt_vertices_graft_single_one`
expose that the graft target has more vertices than its source forest or
single-tree source.  The
criterion
`ConnesKreimer.GraftingProvider.vertices_graft_eq_one_iff_vertexCount_zero`
isolates the one-vertex graft case using only the provider vertex-count law.
Its singleton specializations
`ConnesKreimer.GraftingProvider.vertices_graft_single_eq_one_iff_mul_vertices_eq_zero`
and
`ConnesKreimer.GraftingProvider.vertices_graft_single_one_eq_one_iff_vertices_eq_zero`
give that boundary guard directly for one named source.  The complementary
criterion
`ConnesKreimer.GraftingProvider.one_lt_vertices_graft_iff_vertexCount_pos`
exposes the complementary guard that a graft has more than the new root exactly
when the source forest has positive vertex count.  Its singleton
specializations
`ConnesKreimer.GraftingProvider.one_lt_vertices_graft_single_iff_mul_vertices_pos`
and
`ConnesKreimer.GraftingProvider.one_lt_vertices_graft_single_one_iff_vertices_pos`
give the same guard directly for one named source with arbitrary multiplicity
and for multiplicity one.  Meanwhile,
`ConnesKreimer.GraftingProvider.vertices_graft_eq_iff_vertexCount_eq`
packages the matching equality criterion for two grafted forests.
The bridge lemma `ConnesKreimer.treeGenerator_eq_forestMonomial_single_one`
lets a consumer rewrite a named tree generator as the corresponding singleton
forest monomial.  If a downstream consumer supplies an
`AdmissibleCutData` value, the wrapper
`ConnesKreimer.AdmissibleCutData.graftOperator_forestMonomial` rewrites its
linear graft operator on `forestMonomial R f` to `P.graftGenerator R f` without
unfolding the coefficient-one monomial field.  The wrapper
`ConnesKreimer.AdmissibleCutData.graftOperator_smul_forestMonomial` rewrites
the same supplied operator on `a • forestMonomial R f` to
`a • P.graftGenerator R f`, so coefficient-scaled forest monomials remain a
direct consumer-facing form.  The wrapper
`ConnesKreimer.AdmissibleCutData.graftOperator_add_forestMonomial` rewrites
the same supplied operator on
`forestMonomial R f + forestMonomial R g` to the corresponding sum of graft
generators.  The wrapper
`ConnesKreimer.AdmissibleCutData.graftOperator_nsmul_forestMonomial` rewrites
the same supplied operator on `n • forestMonomial R f` to the corresponding
natural multiple of the graft generator.  The wrapper
`ConnesKreimer.AdmissibleCutData.graftOperator_treeGenerator` rewrites the same
operator on `treeGenerator R t` to the graft generator for the singleton
forest `Finsupp.single t 1`, without unfolding the singleton bridge.  The
unit wrapper `ConnesKreimer.AdmissibleCutData.graftOperator_one` rewrites the
same operator on `1 : CKAlgebra R P.Tree` to the empty-forest graft generator.
The wrapper
`ConnesKreimer.AdmissibleCutData.counit_graftOperator_forestMonomial` then
rewrites the supplied counit on that graft-operator output to zero, again
without unfolding the data fields.  The singleton-tree wrapper
`ConnesKreimer.AdmissibleCutData.counit_graftOperator_treeGenerator` gives the
same counit-zero fact directly for `treeGenerator R t`, and
`ConnesKreimer.AdmissibleCutData.counit_graftOperator_one` gives it directly
for the unit.  The wrapper
`ConnesKreimer.AdmissibleCutData.coproduct_graftOperator_forestMonomial`
rewrites the supplied coproduct on that same normalized output to the supplied
`B_+` 1-cocycle right-hand side, and
`ConnesKreimer.AdmissibleCutData.coproduct_graftOperator_treeGenerator` gives
the same equation directly for `treeGenerator R t`.
`ConnesKreimer.AdmissibleCutData.coproduct_graftOperator_one` gives the same
equation directly for the unit.  There is no proved admissible-cut data
existence theorem on `main`, no bialgebra, no Hopf algebra, and no Yang-Mills
renormalization claim.
