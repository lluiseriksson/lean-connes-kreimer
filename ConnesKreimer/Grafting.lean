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

theorem graftGenerator_mem_homogeneousSubmodule
    [DecidableEq P.Tree]
    (f : ConnesKreimer.Forest P.Tree) :
    P.graftGenerator R f ∈ homogeneousSubmodule P.vertices R
      (Forest.vertexCount P.vertices f + 1) :=
  P.isHomogeneousVertexDegree_graftGenerator (R := R) f

/-- Singleton forests give graft generators in the explicitly computed
degree `m * vertices t + 1`. -/
theorem isHomogeneousVertexDegree_graftGenerator_single
    [DecidableEq P.Tree]
    (t : P.Tree) (m : Nat) :
    IsHomogeneousVertexDegree (R := R) P.vertices (m * P.vertices t + 1)
      (P.graftGenerator R (Finsupp.single t m : ConnesKreimer.Forest P.Tree)) := by
  have h := P.isHomogeneousVertexDegree_graftGenerator (R := R)
    (Finsupp.single t m : ConnesKreimer.Forest P.Tree)
  rw [Forest.vertexCount_single] at h
  exact h

theorem graftGenerator_single_mem_homogeneousSubmodule
    [DecidableEq P.Tree]
    (t : P.Tree) (m : Nat) :
    P.graftGenerator R (Finsupp.single t m : ConnesKreimer.Forest P.Tree)
      ∈ homogeneousSubmodule P.vertices R (m * P.vertices t + 1) :=
  P.isHomogeneousVertexDegree_graftGenerator_single (R := R) t m

/-- A singleton-source graft generator with multiplicity one has degree
`vertices t + 1`. -/
theorem isHomogeneousVertexDegree_graftGenerator_single_one
    [DecidableEq P.Tree]
    (t : P.Tree) :
    IsHomogeneousVertexDegree (R := R) P.vertices (P.vertices t + 1)
      (P.graftGenerator R (Finsupp.single t 1 : ConnesKreimer.Forest P.Tree)) := by
  simpa using P.isHomogeneousVertexDegree_graftGenerator_single (R := R) t 1

theorem graftGenerator_single_one_mem_homogeneousSubmodule
    [DecidableEq P.Tree]
    (t : P.Tree) :
    P.graftGenerator R (Finsupp.single t 1 : ConnesKreimer.Forest P.Tree)
      ∈ homogeneousSubmodule P.vertices R (P.vertices t + 1) :=
  P.isHomogeneousVertexDegree_graftGenerator_single_one (R := R) t

/-- Grafting the empty forest produces a one-vertex generator. -/
theorem isHomogeneousVertexDegree_graftGenerator_zero [DecidableEq P.Tree] :
    IsHomogeneousVertexDegree (R := R) P.vertices 1
      (P.graftGenerator R (0 : ConnesKreimer.Forest P.Tree)) := by
  have h := P.isHomogeneousVertexDegree_graftGenerator (R := R)
    (0 : ConnesKreimer.Forest P.Tree)
  rw [Forest.vertexCount_zero, zero_add] at h
  exact h

theorem graftGenerator_zero_mem_homogeneousSubmodule [DecidableEq P.Tree] :
    P.graftGenerator R (0 : ConnesKreimer.Forest P.Tree)
      ∈ homogeneousSubmodule P.vertices R 1 :=
  P.isHomogeneousVertexDegree_graftGenerator_zero (R := R)

@[simp]
theorem vertices_graft_zero :
    P.vertices (P.graft (0 : ConnesKreimer.Forest P.Tree)) = 1 := by
  rw [P.vertices_graft (0 : ConnesKreimer.Forest P.Tree),
    Forest.vertexCount_zero, zero_add]

@[simp]
theorem vertices_graft_single (t : P.Tree) (m : Nat) :
    P.vertices (P.graft (Finsupp.single t m : ConnesKreimer.Forest P.Tree))
      = m * P.vertices t + 1 := by
  rw [P.vertices_graft (Finsupp.single t m : ConnesKreimer.Forest P.Tree),
    Forest.vertexCount_single]

@[simp]
theorem vertices_graft_single_one (t : P.Tree) :
    P.vertices (P.graft (Finsupp.single t 1 : ConnesKreimer.Forest P.Tree))
      = P.vertices t + 1 := by
  rw [P.vertices_graft_single, one_mul]

/-- The graft of a forest never has zero vertices: the new root counts. -/
theorem vertices_graft_pos (f : ConnesKreimer.Forest P.Tree) :
    0 < P.vertices (P.graft f) := by
  rw [P.vertices_graft f]
  exact Nat.succ_pos _

/-- The graft of any forest has nonzero vertex count. -/
theorem vertices_graft_ne_zero (f : ConnesKreimer.Forest P.Tree) :
    P.vertices (P.graft f) ≠ 0 :=
  Nat.ne_of_gt (P.vertices_graft_pos f)

/-- Grafting strictly increases the source forest vertex count by adding the
new root. -/
theorem vertexCount_lt_vertices_graft (f : ConnesKreimer.Forest P.Tree) :
    Forest.vertexCount P.vertices f < P.vertices (P.graft f) := by
  rw [P.vertices_graft f]
  exact Nat.lt_succ_self _

/-- A graft target cannot have the same vertex count as its source forest. -/
theorem vertexCount_ne_vertices_graft (f : ConnesKreimer.Forest P.Tree) :
    Forest.vertexCount P.vertices f ≠ P.vertices (P.graft f) :=
  ne_of_lt (P.vertexCount_lt_vertices_graft f)

/-- Singleton-source grafts have positive vertex count. -/
theorem vertices_graft_single_pos (t : P.Tree) (m : Nat) :
    0 < P.vertices (P.graft (Finsupp.single t m : ConnesKreimer.Forest P.Tree)) :=
  P.vertices_graft_pos (Finsupp.single t m : ConnesKreimer.Forest P.Tree)

/-- Singleton-source grafts strictly increase the source forest vertex count. -/
theorem vertexCount_single_lt_vertices_graft_single (t : P.Tree) (m : Nat) :
    m * P.vertices t
      < P.vertices (P.graft (Finsupp.single t m : ConnesKreimer.Forest P.Tree)) := by
  rw [P.vertices_graft_single]
  exact Nat.lt_succ_self _

/-- Singleton-source grafts never have zero vertices. -/
theorem vertices_graft_single_ne_zero (t : P.Tree) (m : Nat) :
    P.vertices (P.graft (Finsupp.single t m : ConnesKreimer.Forest P.Tree)) ≠ 0 :=
  Nat.ne_of_gt (P.vertices_graft_single_pos t m)

/-- Multiplicity-one singleton-source grafts have positive vertex count. -/
theorem vertices_graft_single_one_pos (t : P.Tree) :
    0 < P.vertices (P.graft (Finsupp.single t 1 : ConnesKreimer.Forest P.Tree)) :=
  P.vertices_graft_single_pos t 1

/-- Multiplicity-one singleton-source grafts strictly increase tree vertex
count. -/
theorem vertices_lt_vertices_graft_single_one (t : P.Tree) :
    P.vertices t
      < P.vertices (P.graft (Finsupp.single t 1 : ConnesKreimer.Forest P.Tree)) := by
  rw [P.vertices_graft_single_one]
  exact Nat.lt_succ_self _

/-- Multiplicity-one singleton-source grafts never have zero vertices. -/
theorem vertices_graft_single_one_ne_zero (t : P.Tree) :
    P.vertices (P.graft (Finsupp.single t 1 : ConnesKreimer.Forest P.Tree)) ≠ 0 :=
  Nat.ne_of_gt (P.vertices_graft_single_one_pos t)

/-- A graft has exactly one vertex precisely when the source forest has
vertex count zero. -/
theorem vertices_graft_eq_one_iff_vertexCount_zero
    (f : ConnesKreimer.Forest P.Tree) :
    P.vertices (P.graft f) = 1 ↔ Forest.vertexCount P.vertices f = 0 := by
  rw [P.vertices_graft f]
  constructor
  · intro h
    exact Nat.succ.inj (by simpa [Nat.succ_eq_add_one] using h)
  · intro h
    rw [h]

/-- A graft has more than the new root precisely when its source forest has
positive vertex count. -/
theorem one_lt_vertices_graft_iff_vertexCount_pos
    (f : ConnesKreimer.Forest P.Tree) :
    1 < P.vertices (P.graft f) ↔ 0 < Forest.vertexCount P.vertices f := by
  rw [P.vertices_graft f]
  constructor
  · intro h
    exact Nat.succ_lt_succ_iff.mp (by simpa [Nat.succ_eq_add_one] using h)
  · intro h
    simpa [Nat.succ_eq_add_one] using Nat.succ_lt_succ h

/-- Grafting is degree-injective on vertex counts: forests of different
vertex counts graft to trees of different vertex counts. -/
theorem vertices_graft_injective_on_count
    {f g : ConnesKreimer.Forest P.Tree}
    (h : P.vertices (P.graft f) = P.vertices (P.graft g)) :
    Forest.vertexCount P.vertices f = Forest.vertexCount P.vertices g := by
  rw [P.vertices_graft f, P.vertices_graft g] at h
  exact Nat.succ_injective h

/-- Two grafted forests have the same vertex count exactly when their source
forests have the same vertex count. -/
theorem vertices_graft_eq_iff_vertexCount_eq
    {f g : ConnesKreimer.Forest P.Tree} :
    P.vertices (P.graft f) = P.vertices (P.graft g)
      ↔ Forest.vertexCount P.vertices f = Forest.vertexCount P.vertices g := by
  constructor
  · exact P.vertices_graft_injective_on_count
  · intro h
    rw [P.vertices_graft f, P.vertices_graft g, h]

end GraftingProvider

end ConnesKreimer
