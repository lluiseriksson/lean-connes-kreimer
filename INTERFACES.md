# Public Interfaces

Import surface for the mother repository:

```lean
import Interfaces
```

Internal implementation import:

```lean
import ConnesKreimer.Interfaces
```

This is the file a future consumer should import.  There is currently no direct
THE-ERIKSSON-PROGRAMME import.

## Stable names

* `ConnesKreimer.Forest (Tree : Type u) : Type u`
* `ConnesKreimer.CKAlgebra (R : Type v) (Tree : Type u) [CommSemiring R]`
* `ConnesKreimer.treeGenerator`
* `ConnesKreimer.forestMonomial`
* `ConnesKreimer.Forest.vertexCount`
* `ConnesKreimer.IsHomogeneousVertexDegree`
* `ConnesKreimer.RootedTreeProvider`
* `ConnesKreimer.RootedTreeProvider.Algebra`
* `ConnesKreimer.RootedTreeProvider.Forest`
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
