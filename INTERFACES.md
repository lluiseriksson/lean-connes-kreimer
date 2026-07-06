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

Current caveat: the raw and legacy names above are `Nonempty` wrappers around
Mathlib structure classes on `RootedTreeProvider.Algebra R P`.  They do not by
themselves pin the Connes-Kreimer admissible-cut coproduct.
`AdmissibleCutData` is the stricter contract shape: it names a coproduct,
counit, linear `B_+` operator, and the `B_+` 1-cocycle equations, while
`hasAdmissibleCutData_iff_nonempty` exposes the definitional nonempty wrapper;
`HasAdmissibleCutCoalgebraContract` is the data-backed contract name for
consumers that want a pinned admissible-cut interface while the legacy
`HasAdmissibleCutCoalgebra` name remains raw;
`hasAdmissibleCutCoalgebraContract_iff_hasAdmissibleCutData` exposes that this
contract is exactly `HasAdmissibleCutData`;
`ConnesKreimer.AdmissibleCutData.graftOperator_forestMonomial` exposes the
coefficient-one `forestMonomial` case of the linear `B_+` operator;
`ConnesKreimer.AdmissibleCutData.graftOperator_smul_forestMonomial` exposes the
same supplied operator on scalar multiples of normalized forest monomials;
`ConnesKreimer.AdmissibleCutData.graftOperator_add_forestMonomial` exposes the
same supplied operator on two-term sums of normalized forest monomials;
`ConnesKreimer.AdmissibleCutData.graftOperator_nsmul_forestMonomial` exposes
the same supplied operator on natural multiples of normalized forest monomials;
`ConnesKreimer.AdmissibleCutData.graftOperator_treeGenerator` exposes the
singleton-tree-generator case via the closed M0 bridge; and
`ConnesKreimer.AdmissibleCutData.graftOperator_one` exposes the empty-forest
unit case;
`ConnesKreimer.AdmissibleCutData.counit_graftOperator_forestMonomial` exposes
the corresponding counit-zero wrapper, while
`ConnesKreimer.AdmissibleCutData.counit_graftOperator_treeGenerator`
specializes that zero wrapper to named tree generators and
`ConnesKreimer.AdmissibleCutData.counit_graftOperator_one` specializes it to
the unit.  The wrapper
`ConnesKreimer.AdmissibleCutData.coproduct_graftOperator_forestMonomial`
exposes the supplied `B_+` 1-cocycle equation on the normalized
forest-monomial output of the graft operator, and
`ConnesKreimer.AdmissibleCutData.coproduct_graftOperator_treeGenerator`
specializes the same equation to named tree generators, while
`ConnesKreimer.AdmissibleCutData.coproduct_graftOperator_one` specializes it
to the unit.  Main still proves no existence theorem for this data.
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
