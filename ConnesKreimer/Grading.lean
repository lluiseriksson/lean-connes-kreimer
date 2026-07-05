import ConnesKreimer.Basic
import Mathlib.Data.Finsupp.Antidiagonal
import Mathlib.Algebra.Module.Submodule.Basic

/-!
# The vertex grading of the Connes-Kreimer algebra

Closes the M0 grading layer, fully parametric in the tree type: additivity of
the forest vertex count, the homogeneity calculus (sums, scalars, products,
generators, monomials, the unit), and the homogeneous submodules together
with the graded-multiplication law
`S m * S n ⊆ S (m + n)`.  No `GradedAlgebra` instance is claimed; this is
exactly the bookkeeping the M1 coproduct and the M2 connected-graded
antipode argument will consume.

References:
* A. Connes and D. Kreimer, 1998, Communications in Mathematical Physics
  199, Section 2 (the grading by the number of vertices).
-/

noncomputable section

namespace ConnesKreimer

universe u v

variable {Tree : Type u} {R : Type v} [CommSemiring R]

namespace Forest

/-- The vertex count is additive on forests. -/
theorem vertexCount_add (vertices : Tree -> Nat) (f g : Forest Tree) :
    Forest.vertexCount vertices (f + g)
      = Forest.vertexCount vertices f + Forest.vertexCount vertices g := by
  unfold Forest.vertexCount
  exact Finsupp.sum_add_index' (fun t => zero_mul (vertices t))
    (fun t m₁ m₂ => add_mul m₁ m₂ (vertices t))

/-- Vertex count of a single-tree forest with multiplicity. -/
theorem vertexCount_single (vertices : Tree -> Nat) (t : Tree) (m : Nat) :
    Forest.vertexCount vertices (Finsupp.single t m) = m * vertices t := by
  unfold Forest.vertexCount
  exact Finsupp.sum_single_index (zero_mul (vertices t))

@[simp]
theorem vertexCount_single_one (vertices : Tree -> Nat) (t : Tree) :
    Forest.vertexCount vertices (Finsupp.single t 1) = vertices t := by
  rw [Forest.vertexCount_single, one_mul]

end Forest

namespace IsHomogeneousVertexDegree

variable {vertices : Tree -> Nat}

theorem add {n : Nat} {p q : CKAlgebra R Tree}
    (hp : IsHomogeneousVertexDegree vertices n p)
    (hq : IsHomogeneousVertexDegree vertices n q) :
    IsHomogeneousVertexDegree vertices n (p + q) := by
  intro f hf
  rw [MvPolynomial.coeff_add] at hf
  by_cases h1 : MvPolynomial.coeff f p ≠ 0
  · exact hp f h1
  · push_neg at h1
    rw [h1, zero_add] at hf
    exact hq f hf

theorem smul {n : Nat} {p : CKAlgebra R Tree} (c : R)
    (hp : IsHomogeneousVertexDegree vertices n p) :
    IsHomogeneousVertexDegree vertices n (c • p) := by
  intro f hf
  rw [MvPolynomial.coeff_smul, smul_eq_mul] at hf
  exact hp f (right_ne_zero_of_mul hf)

/-- **Graded multiplication.**  Products of homogeneous elements are
homogeneous of the summed vertex degree. -/
theorem mul [DecidableEq Tree] {m n : Nat} {p q : CKAlgebra R Tree}
    (hp : IsHomogeneousVertexDegree vertices m p)
    (hq : IsHomogeneousVertexDegree vertices n q) :
    IsHomogeneousVertexDegree vertices (m + n) (p * q) := by
  intro f hf
  rw [MvPolynomial.coeff_mul] at hf
  obtain ⟨x, hx, hne⟩ := Finset.exists_ne_zero_of_sum_ne_zero hf
  have h1 : MvPolynomial.coeff x.1 p ≠ 0 := left_ne_zero_of_mul hne
  have h2 : MvPolynomial.coeff x.2 q ≠ 0 := right_ne_zero_of_mul hne
  have hsum : x.1 + x.2 = f := Finset.mem_antidiagonal.mp hx
  rw [← hsum, Forest.vertexCount_add, hp x.1 h1, hq x.2 h2]

end IsHomogeneousVertexDegree

/-- Tree generators are homogeneous of their vertex degree. -/
theorem isHomogeneousVertexDegree_treeGenerator [DecidableEq Tree]
    (vertices : Tree -> Nat) (t : Tree) :
    IsHomogeneousVertexDegree (R := R) vertices (vertices t) (treeGenerator R t) := by
  intro f hf
  rw [treeGenerator, MvPolynomial.coeff_X'] at hf
  split at hf
  · next h =>
      rw [← h, Forest.vertexCount_single, one_mul]
  · exact absurd rfl hf

/-- Forest monomials are homogeneous of the forest's vertex count. -/
theorem isHomogeneousVertexDegree_forestMonomial [DecidableEq Tree] (vertices : Tree -> Nat)
    (f : Forest Tree) :
    IsHomogeneousVertexDegree (R := R) vertices (Forest.vertexCount vertices f)
      (forestMonomial R f) := by
  intro g hg
  rw [forestMonomial, MvPolynomial.coeff_monomial] at hg
  split at hg
  · next h => rw [← h]
  · exact absurd rfl hg

/-- The unit is homogeneous of degree zero: connectedness in degree 0. -/
theorem isHomogeneousVertexDegree_one [DecidableEq Tree] (vertices : Tree -> Nat) :
    IsHomogeneousVertexDegree (R := R) vertices 0 (1 : CKAlgebra R Tree) := by
  intro f hf
  rw [MvPolynomial.coeff_one] at hf
  split at hf
  · next h => rw [← h, Forest.vertexCount_zero]
  · exact absurd rfl hf

/-- The homogeneous component of vertex degree `n`, as a submodule. -/
def homogeneousSubmodule (vertices : Tree -> Nat) (R : Type v) [CommSemiring R]
    (n : Nat) : Submodule R (CKAlgebra R Tree) where
  carrier := {p | IsHomogeneousVertexDegree vertices n p}
  add_mem' := fun hp hq => hp.add hq
  zero_mem' := isHomogeneousVertexDegree_zero vertices n
  smul_mem' := fun c _ hp => hp.smul c

@[simp]
theorem mem_homogeneousSubmodule (vertices : Tree -> Nat) (n : Nat)
    (p : CKAlgebra R Tree) :
    p ∈ homogeneousSubmodule vertices R n
      ↔ IsHomogeneousVertexDegree vertices n p :=
  Iff.rfl

theorem treeGenerator_mem_homogeneousSubmodule [DecidableEq Tree]
    (vertices : Tree -> Nat) (t : Tree) :
    treeGenerator R t ∈ homogeneousSubmodule vertices R (vertices t) :=
  isHomogeneousVertexDegree_treeGenerator (R := R) vertices t

theorem forestMonomial_mem_homogeneousSubmodule [DecidableEq Tree]
    (vertices : Tree -> Nat) (f : Forest Tree) :
    forestMonomial R f ∈ homogeneousSubmodule vertices R
      (Forest.vertexCount vertices f) :=
  isHomogeneousVertexDegree_forestMonomial (R := R) vertices f

theorem isHomogeneousVertexDegree_forestMonomial_mul [DecidableEq Tree]
    (vertices : Tree -> Nat) (f g : Forest Tree) :
    IsHomogeneousVertexDegree (R := R) vertices
      (Forest.vertexCount vertices f + Forest.vertexCount vertices g)
      (forestMonomial R f * forestMonomial R g) :=
  (isHomogeneousVertexDegree_forestMonomial (R := R) vertices f).mul
    (isHomogeneousVertexDegree_forestMonomial (R := R) vertices g)

theorem forestMonomial_mul_mem_homogeneousSubmodule [DecidableEq Tree]
    (vertices : Tree -> Nat) (f g : Forest Tree) :
    forestMonomial R f * forestMonomial R g ∈ homogeneousSubmodule vertices R
      (Forest.vertexCount vertices f + Forest.vertexCount vertices g) :=
  isHomogeneousVertexDegree_forestMonomial_mul (R := R) vertices f g

theorem one_mem_homogeneousSubmodule [DecidableEq Tree] (vertices : Tree -> Nat) :
    (1 : CKAlgebra R Tree) ∈ homogeneousSubmodule vertices R 0 :=
  isHomogeneousVertexDegree_one (R := R) vertices

/-- The graded-monoid law for the vertex grading: the product of the degree
`m` and degree `n` components lands in degree `m + n`. -/
theorem homogeneousSubmodule_mul_mem [DecidableEq Tree] (vertices : Tree -> Nat) {m n : Nat}
    {p q : CKAlgebra R Tree}
    (hp : p ∈ homogeneousSubmodule vertices R m)
    (hq : q ∈ homogeneousSubmodule vertices R n) :
    p * q ∈ homogeneousSubmodule vertices R (m + n) :=
  hp.mul hq

end ConnesKreimer
