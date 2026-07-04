import Interfaces

/-!
# Import oracle for the public interface

This file intentionally proves no new public mathematics.  It compiles only if
the root import `Interfaces` exposes the closed M0 names documented for future
consumers.
-/

noncomputable section

namespace ConnesKreimer

universe u v

variable {Tree : Type u} {R : Type v} [CommSemiring R] [DecidableEq Tree]

example (t : Tree) :
    treeGenerator R t = forestMonomial R (Finsupp.single t 1 : Forest Tree) :=
  treeGenerator_eq_forestMonomial_single_one (R := R) t

example (vertices : Tree -> Nat) (t : Tree) :
    IsHomogeneousVertexDegree (R := R) vertices (vertices t) (treeGenerator R t) :=
  isHomogeneousVertexDegree_treeGenerator (R := R) vertices t

example (vertices : Tree -> Nat) (f : Forest Tree) :
    IsHomogeneousVertexDegree (R := R) vertices (Forest.vertexCount vertices f)
      (forestMonomial R f) :=
  isHomogeneousVertexDegree_forestMonomial (R := R) vertices f

example (vertices : Tree -> Nat) (t : Tree) :
    treeGenerator R t ∈ homogeneousSubmodule vertices R (vertices t) :=
  treeGenerator_mem_homogeneousSubmodule (R := R) vertices t

example (vertices : Tree -> Nat) (f : Forest Tree) :
    forestMonomial R f ∈ homogeneousSubmodule vertices R
      (Forest.vertexCount vertices f) :=
  forestMonomial_mem_homogeneousSubmodule (R := R) vertices f

example (vertices : Tree -> Nat) :
    (1 : CKAlgebra R Tree) ∈ homogeneousSubmodule vertices R 0 :=
  one_mem_homogeneousSubmodule (R := R) vertices

example (P : GraftingProvider.{u}) [DecidableEq P.Tree] (f : Forest P.Tree) :
    IsHomogeneousVertexDegree (R := R) P.vertices
      (Forest.vertexCount P.vertices f + 1) (P.graftGenerator R f) :=
  P.isHomogeneousVertexDegree_graftGenerator (R := R) f

example (P : GraftingProvider.{u}) [DecidableEq P.Tree] (f : Forest P.Tree) :
    P.graftGenerator R f ∈ homogeneousSubmodule P.vertices R
      (Forest.vertexCount P.vertices f + 1) :=
  P.graftGenerator_mem_homogeneousSubmodule (R := R) f

example (P : GraftingProvider.{u}) [DecidableEq P.Tree] :
    P.graftGenerator R (0 : Forest P.Tree) ∈ homogeneousSubmodule P.vertices R 1 :=
  P.graftGenerator_zero_mem_homogeneousSubmodule (R := R)

example (P : GraftingProvider.{u}) (t : P.Tree) (m : Nat) :
    P.vertices (P.graft (Finsupp.single t m : Forest P.Tree))
      = m * P.vertices t + 1 :=
  P.vertices_graft_single t m

example (P : GraftingProvider.{u}) (f : Forest P.Tree) :
    P.vertices (P.graft f) = 1 ↔ Forest.vertexCount P.vertices f = 0 :=
  P.vertices_graft_eq_one_iff_vertexCount_zero f

end ConnesKreimer
