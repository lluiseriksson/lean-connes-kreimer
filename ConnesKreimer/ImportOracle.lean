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

example (P : GraftingProvider.{u}) [DecidableEq P.Tree] (f : Forest P.Tree) :
    IsHomogeneousVertexDegree (R := R) P.vertices
      (Forest.vertexCount P.vertices f + 1) (P.graftGenerator R f) :=
  P.isHomogeneousVertexDegree_graftGenerator (R := R) f

end ConnesKreimer
