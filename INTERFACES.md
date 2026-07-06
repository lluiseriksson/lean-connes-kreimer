# Public Interfaces

Import surface for the mother repository:

```lean
import Interfaces
```

Internal implementation imports include:

```lean
import ConnesKreimer.Interfaces
import ConnesKreimer.Grading
import ConnesKreimer.Grafting
```

This is the file a future consumer should import.  There is currently no direct
THE-ERIKSSON-PROGRAMME import.

See `MOTHER_INTERFACE_DIGEST.md` for the current mother-facing consumption
digest.

## Stable names

### Core M0

* `ConnesKreimer.Forest (Tree : Type u) : Type u`
* `ConnesKreimer.CKAlgebra (R : Type v) (Tree : Type u) [CommSemiring R]`
* `ConnesKreimer.treeGenerator`
* `ConnesKreimer.forestMonomial`
* `ConnesKreimer.forestMonomial_zero`
* `ConnesKreimer.forestMonomial_add`
* `ConnesKreimer.forestMonomial_single`
* `ConnesKreimer.treeGenerator_eq_forestMonomial_single_one`
* `ConnesKreimer.Forest.vertexCount`
* `ConnesKreimer.IsHomogeneousVertexDegree`

### Grading

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

### Providers

* `ConnesKreimer.RootedTreeProvider`
* `ConnesKreimer.RootedTreeProvider.Algebra`
* `ConnesKreimer.RootedTreeProvider.Forest`
* `ConnesKreimer.GraftingProvider`
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

### Explicit frontier hypotheses

Raw Mathlib-structure placeholders:

* `ConnesKreimer.HasRawCoalgebra`
* `ConnesKreimer.HasRawBialgebra`
* `ConnesKreimer.HasRawHopfAlgebra`

Legacy compatibility names for the same raw placeholders:

* `ConnesKreimer.HasAdmissibleCutCoalgebra`
* `ConnesKreimer.HasConnesKreimerBialgebra`
* `ConnesKreimer.HasConnesKreimerHopfAlgebra`

Alias-audit helpers:

* `ConnesKreimer.hasAdmissibleCutCoalgebra_iff_hasRawCoalgebra`
* `ConnesKreimer.hasConnesKreimerBialgebra_iff_hasRawBialgebra`
* `ConnesKreimer.hasConnesKreimerHopfAlgebra_iff_hasRawHopfAlgebra`

Data-bearing admissible-cut contract:

* `ConnesKreimer.AdmissibleCutData`
* `ConnesKreimer.HasAdmissibleCutData`
* `ConnesKreimer.hasAdmissibleCutData_iff_nonempty`
* `ConnesKreimer.AdmissibleCutData.graftOperator_forestMonomial`
* `ConnesKreimer.AdmissibleCutData.counit_graftOperator_forestMonomial`

Current caveat: the raw and legacy names above are `Nonempty` wrappers around
Mathlib structure classes on `RootedTreeProvider.Algebra R P`.  They do not by
themselves pin the Connes-Kreimer admissible-cut coproduct.
`AdmissibleCutData` is the stricter contract shape: it names a coproduct,
counit, linear `B_+` operator, and the `B_+` 1-cocycle equations, while
`hasAdmissibleCutData_iff_nonempty` exposes the definitional nonempty wrapper;
`ConnesKreimer.AdmissibleCutData.graftOperator_forestMonomial` exposes the
coefficient-one `forestMonomial` case of the linear `B_+` operator; and
`ConnesKreimer.AdmissibleCutData.counit_graftOperator_forestMonomial` exposes
the corresponding counit-zero wrapper.  Main still proves no existence theorem
for this data.
Issue #29 tracks whether legacy aliases should eventually depend on this data
or remain permanently raw.

## Breaking-change policy

Changing any name above, changing universe parameters, or replacing explicit
hypotheses by typeclass assumptions is breaking.  Such changes must be called
out in a PR and reflected in this file.

## Current consumer status

No consumer exists today.  If `hRpoly` evolves into genuine multiscale
counterterm bookkeeping, this interface may become useful to THE-ERIKSSON-
PROGRAMME.  Until then, no Yang-Mills renormalization claim is made.
