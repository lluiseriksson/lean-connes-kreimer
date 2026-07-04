import ConnesKreimer.Grading
import ConnesKreimer.Interfaces

/-!
# The grafting operator `B₊` at the provider level

`B₊` takes a forest and grows a new common root: it is the operator whose
1-cocycle property defines the admissible-cut coproduct (Connes-Kreimer
1998, eq. (10)).  Faithful to the M0 decision, no tree type is chosen: the
grafting map and its vertex law are provider data, and everything provable
from the law alone is closed here.

References:
* A. Connes and D. Kreimer, 1998, Communications in Mathematical Physics
  199, Section 2.
-/

noncomputable section

namespace ConnesKreimer

universe u v

/-- A rooted-tree provider equipped with grafting: `graft f` is the tree
obtained by attaching all trees of the forest `f` to a new root, and it has
exactly one more vertex than `f`.  Bijectivity of `graft` is the universal
property of rooted trees and is deliberately NOT required here; it appears
as an explicit hypothesis where needed. -/
structure GraftingProvider extends RootedTreeProvider.{u} where
  graft : ConnesKreimer.Forest toRootedTreeProvider.Tree -> toRootedTreeProvider.Tree
  vertices_graft : ∀ f, toRootedTreeProvider.vertices (graft f)
    = Forest.vertexCount toRootedTreeProvider.vertices f + 1

namespace GraftingProvider

variable {R : Type v} [CommSemiring R] (P : GraftingProvider.{u})

/-- The generator obtained by grafting a forest. -/
def graftGenerator (R : Type v) [CommSemiring R]
    (f : ConnesKreimer.Forest P.Tree) : CKAlgebra R P.Tree :=
  treeGenerator R (P.graft f)

/-- **Degree shift.**  Grafting raises the vertex degree by exactly one:
`B₊` maps the degree-`n` monomial layer into the degree-`n+1` generator
layer.  This is the grading compatibility that the cocycle formula for the
coproduct will need. -/
theorem isHomogeneousVertexDegree_graftGenerator
    [DecidableEq P.Tree]
    (f : ConnesKreimer.Forest P.Tree) :
    IsHomogeneousVertexDegree (R := R) P.vertices
      (Forest.vertexCount P.vertices f + 1) (P.graftGenerator R f) := by
  have h := isHomogeneousVertexDegree_treeGenerator (R := R)
    P.vertices (P.graft f)
  rw [P.vertices_graft f] at h
  exact h

/-- Grafting the empty forest produces a one-vertex generator. -/
theorem isHomogeneousVertexDegree_graftGenerator_zero [DecidableEq P.Tree] :
    IsHomogeneousVertexDegree (R := R) P.vertices 1
      (P.graftGenerator R (0 : ConnesKreimer.Forest P.Tree)) := by
  have h := P.isHomogeneousVertexDegree_graftGenerator (R := R)
    (0 : ConnesKreimer.Forest P.Tree)
  rw [Forest.vertexCount_zero, zero_add] at h
  exact h

@[simp]
theorem vertices_graft_zero :
    P.vertices (P.graft (0 : ConnesKreimer.Forest P.Tree)) = 1 := by
  rw [P.vertices_graft (0 : ConnesKreimer.Forest P.Tree),
    Forest.vertexCount_zero, zero_add]

/-- The graft of a forest never has zero vertices: the new root counts. -/
theorem vertices_graft_pos (f : ConnesKreimer.Forest P.Tree) :
    0 < P.vertices (P.graft f) := by
  rw [P.vertices_graft f]
  exact Nat.succ_pos _

/-- Grafting is degree-injective on vertex counts: forests of different
vertex counts graft to trees of different vertex counts. -/
theorem vertices_graft_injective_on_count
    {f g : ConnesKreimer.Forest P.Tree}
    (h : P.vertices (P.graft f) = P.vertices (P.graft g)) :
    Forest.vertexCount P.vertices f = Forest.vertexCount P.vertices g := by
  rw [P.vertices_graft f, P.vertices_graft g] at h
  exact Nat.succ_injective h

end GraftingProvider

end ConnesKreimer
