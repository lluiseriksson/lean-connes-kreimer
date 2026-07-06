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

example :
    forestMonomial R (0 : Forest Tree) = 1 :=
  forestMonomial_zero (R := R)

example (f g : Forest Tree) :
    forestMonomial R (f + g) = forestMonomial R f * forestMonomial R g :=
  forestMonomial_add (R := R) f g

example (t : Tree) (m : Nat) :
    forestMonomial R (Finsupp.single t m : Forest Tree) = treeGenerator R t ^ m :=
  forestMonomial_single (R := R) t m

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

example (vertices : Tree -> Nat) (f g : Forest Tree) :
    IsHomogeneousVertexDegree (R := R) vertices
      (Forest.vertexCount vertices f + Forest.vertexCount vertices g)
      (forestMonomial R f * forestMonomial R g) :=
  isHomogeneousVertexDegree_forestMonomial_mul (R := R) vertices f g

example (vertices : Tree -> Nat) (f g : Forest Tree) :
    forestMonomial R f * forestMonomial R g ∈ homogeneousSubmodule vertices R
      (Forest.vertexCount vertices f + Forest.vertexCount vertices g) :=
  forestMonomial_mul_mem_homogeneousSubmodule (R := R) vertices f g

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

example (P : GraftingProvider.{u}) [DecidableEq P.Tree] (t : P.Tree) (m : Nat) :
    IsHomogeneousVertexDegree (R := R) P.vertices (m * P.vertices t + 1)
      (P.graftGenerator R (Finsupp.single t m : Forest P.Tree)) :=
  P.isHomogeneousVertexDegree_graftGenerator_single (R := R) t m

example (P : GraftingProvider.{u}) [DecidableEq P.Tree] (t : P.Tree) (m : Nat) :
    P.graftGenerator R (Finsupp.single t m : Forest P.Tree)
      ∈ homogeneousSubmodule P.vertices R (m * P.vertices t + 1) :=
  P.graftGenerator_single_mem_homogeneousSubmodule (R := R) t m

example (P : GraftingProvider.{u}) [DecidableEq P.Tree] (t : P.Tree) :
    IsHomogeneousVertexDegree (R := R) P.vertices (P.vertices t + 1)
      (P.graftGenerator R (Finsupp.single t 1 : Forest P.Tree)) :=
  P.isHomogeneousVertexDegree_graftGenerator_single_one (R := R) t

example (P : GraftingProvider.{u}) [DecidableEq P.Tree] (t : P.Tree) :
    P.graftGenerator R (Finsupp.single t 1 : Forest P.Tree)
      ∈ homogeneousSubmodule P.vertices R (P.vertices t + 1) :=
  P.graftGenerator_single_one_mem_homogeneousSubmodule (R := R) t

example (P : GraftingProvider.{u}) [DecidableEq P.Tree] :
    P.graftGenerator R (0 : Forest P.Tree) ∈ homogeneousSubmodule P.vertices R 1 :=
  P.graftGenerator_zero_mem_homogeneousSubmodule (R := R)

example (P : GraftingProvider.{u}) (t : P.Tree) (m : Nat) :
    P.vertices (P.graft (Finsupp.single t m : Forest P.Tree))
      = m * P.vertices t + 1 :=
  P.vertices_graft_single t m

example (P : GraftingProvider.{u}) (t : P.Tree) (m : Nat) :
    0 < P.vertices (P.graft (Finsupp.single t m : Forest P.Tree)) :=
  P.vertices_graft_single_pos t m

example (P : GraftingProvider.{u}) (f : Forest P.Tree) :
    P.vertices (P.graft f) ≠ 0 :=
  P.vertices_graft_ne_zero f

example (P : GraftingProvider.{u}) (f : Forest P.Tree) :
    Forest.vertexCount P.vertices f < P.vertices (P.graft f) :=
  P.vertexCount_lt_vertices_graft f

example (P : GraftingProvider.{u}) (f : Forest P.Tree) :
    Forest.vertexCount P.vertices f ≠ P.vertices (P.graft f) :=
  P.vertexCount_ne_vertices_graft f

example (P : GraftingProvider.{u}) (t : P.Tree) (m : Nat) :
    m * P.vertices t
      < P.vertices (P.graft (Finsupp.single t m : Forest P.Tree)) :=
  P.vertexCount_single_lt_vertices_graft_single t m

example (P : GraftingProvider.{u}) (t : P.Tree) :
    P.vertices t
      < P.vertices (P.graft (Finsupp.single t 1 : Forest P.Tree)) :=
  P.vertices_lt_vertices_graft_single_one t

example (P : GraftingProvider.{u}) (t : P.Tree) :
    P.vertices (P.graft (Finsupp.single t 1 : Forest P.Tree)) ≠ 0 :=
  P.vertices_graft_single_one_ne_zero t

example (P : GraftingProvider.{u}) (f : Forest P.Tree) :
    P.vertices (P.graft f) = 1 ↔ Forest.vertexCount P.vertices f = 0 :=
  P.vertices_graft_eq_one_iff_vertexCount_zero f

example (P : GraftingProvider.{u}) (t : P.Tree) (m : Nat) :
    P.vertices (P.graft (Finsupp.single t m : Forest P.Tree)) = 1
      ↔ m * P.vertices t = 0 :=
  P.vertices_graft_single_eq_one_iff_mul_vertices_eq_zero t m

example (P : GraftingProvider.{u}) (t : P.Tree) :
    P.vertices (P.graft (Finsupp.single t 1 : Forest P.Tree)) = 1
      ↔ P.vertices t = 0 :=
  P.vertices_graft_single_one_eq_one_iff_vertices_eq_zero t

example (P : GraftingProvider.{u}) (f : Forest P.Tree) :
    1 < P.vertices (P.graft f) ↔ 0 < Forest.vertexCount P.vertices f :=
  P.one_lt_vertices_graft_iff_vertexCount_pos f

example (P : GraftingProvider.{u}) (t : P.Tree) (m : Nat) :
    1 < P.vertices (P.graft (Finsupp.single t m : Forest P.Tree))
      ↔ 0 < m * P.vertices t :=
  P.one_lt_vertices_graft_single_iff_mul_vertices_pos t m

example (P : GraftingProvider.{u}) (t : P.Tree) :
    1 < P.vertices (P.graft (Finsupp.single t 1 : Forest P.Tree))
      ↔ 0 < P.vertices t :=
  P.one_lt_vertices_graft_single_one_iff_vertices_pos t

example (P : GraftingProvider.{u}) (f g : Forest P.Tree) :
    P.vertices (P.graft f) = P.vertices (P.graft g)
      ↔ Forest.vertexCount P.vertices f = Forest.vertexCount P.vertices g :=
  P.vertices_graft_eq_iff_vertexCount_eq

end ConnesKreimer
