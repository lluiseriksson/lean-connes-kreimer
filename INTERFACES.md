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
* `ConnesKreimer.GraftingProvider.vertices_graft_single_pos`
* `ConnesKreimer.GraftingProvider.vertexCount_single_lt_vertices_graft_single`
* `ConnesKreimer.GraftingProvider.vertices_graft_single_ne_zero`
* `ConnesKreimer.GraftingProvider.vertices_graft_single_one_pos`
* `ConnesKreimer.GraftingProvider.vertices_lt_vertices_graft_single_one`
* `ConnesKreimer.GraftingProvider.vertices_graft_single_one_ne_zero`
* `ConnesKreimer.GraftingProvider.vertices_graft_eq_one_iff_vertexCount_zero`
* `ConnesKreimer.GraftingProvider.vertices_graft_injective_on_count`

### Explicit frontier hypotheses

* `ConnesKreimer.HasAdmissibleCutCoalgebra`
* `ConnesKreimer.HasConnesKreimerBialgebra`
* `ConnesKreimer.HasConnesKreimerHopfAlgebra`

## Breaking-change policy

Changing any name above, changing universe parameters, or replacing explicit
hypotheses by typeclass assumptions is breaking.  Such changes must be called
out in a PR and reflected in this file.

## Current consumer status

No consumer exists today.  If `hRpoly` evolves into genuine multiscale
counterterm bookkeeping, this interface may become useful to THE-ERIKSSON-
PROGRAMME.  Until then, no Yang-Mills renormalization claim is made.
