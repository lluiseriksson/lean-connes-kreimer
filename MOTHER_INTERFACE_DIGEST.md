# Mother-Facing Interface Digest

Last updated: 2026-07-04.

Base public HEAD before this digest refresh:
`de8cbbce607eea9f70ac47c50c76fd7cea1dde53`.

## Import

Future consumers should use:

```lean
import Interfaces
```

This root import currently re-exports the closed-proof M0 surface:

* `ConnesKreimer.Basic`
* `ConnesKreimer.Grading`
* `ConnesKreimer.Grafting`
* the explicit frontier hypotheses in `ConnesKreimer.Interfaces`

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
* `ConnesKreimer.homogeneousSubmodule_mul_mem`

Closed grafting lemmas:

* `ConnesKreimer.GraftingProvider.graftGenerator`
* `ConnesKreimer.GraftingProvider.isHomogeneousVertexDegree_graftGenerator`
* `ConnesKreimer.GraftingProvider.isHomogeneousVertexDegree_graftGenerator_zero`
* `ConnesKreimer.GraftingProvider.vertices_graft_zero`
* `ConnesKreimer.GraftingProvider.vertices_graft_single_one`
* `ConnesKreimer.GraftingProvider.vertices_graft_pos`
* `ConnesKreimer.GraftingProvider.vertices_graft_injective_on_count`

## Local Assumptions Needed by Lemmas

Most definitions need only `[CommSemiring R]`.  Lemmas using polynomial
coefficients of named monomials or antidiagonals require `[DecidableEq Tree]`
or `[DecidableEq P.Tree]`; this is explicit in the theorem signatures.

## Frontier Hypotheses

The following are explicit hypotheses, not proved structures:

* `ConnesKreimer.HasAdmissibleCutCoalgebra`
* `ConnesKreimer.HasConnesKreimerBialgebra`
* `ConnesKreimer.HasConnesKreimerHopfAlgebra`

Current interface caveat: these are `Nonempty` wrappers around Mathlib
structure classes on the polynomial algebra.  They do not by themselves
characterize the admissible-cut coproduct.  The statement-first branch
`frontier/M1` contains `AdmissibleCutData` as the proposed stricter contract,
but that branch is not a consumable mainline interface.

## What the Mother Repository Can Consume Today

Today the useful payload is bookkeeping infrastructure: forests as polynomial
monomials, vertex grading, homogeneous components, and the provider-level
grafting degree shift, including the closed empty-forest value
`ConnesKreimer.GraftingProvider.vertices_graft_zero` and the singleton graft
count `ConnesKreimer.GraftingProvider.vertices_graft_single_one`.  There is no
coproduct on `main`, no bialgebra, no Hopf algebra, and no Yang-Mills
renormalization claim.
