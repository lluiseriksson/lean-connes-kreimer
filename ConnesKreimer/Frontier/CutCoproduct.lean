import ConnesKreimer.Grafting
import ConnesKreimer.Interfaces
import Mathlib.RingTheory.TensorProduct.Basic

/-!
# Frontier: the admissible-cut coproduct via the `B₊` cocycle

Statement-first targets for M1/M2.  Every `sorry` is a frontier obligation
tracked in `HYPOTHESIS_FRONTIER.md`; this file must NEVER be merged to
`main`.

INTERFACE FINDING (for the Revisor, no contract file touched): the frontier
hypotheses `HasAdmissibleCutCoalgebra` / `HasConnesKreimerBialgebra` /
`HasConnesKreimerHopfAlgebra` are `Nonempty` of a structure CLASS, so ANY
coalgebra/bialgebra/Hopf structure on the polynomial algebra witnesses them
— including ones unrelated to admissible cuts (e.g. the standard
`AddMonoidAlgebra`-style structures if present at the pin).  The structure
`AdmissibleCutData` below pins the coproduct by the `B₊` 1-cocycle equation,
which is the property that actually characterizes the Connes-Kreimer
coproduct.  Proposed (ritual required): re-express the contract hypotheses
through `AdmissibleCutData`.

References:
* A. Connes and D. Kreimer, 1998, Communications in Mathematical Physics
  199, eq. (10) (the cocycle property of `B₊`).
* D. Manchon, 2008, "Hopf algebras, from basics to applications to
  renormalization", Sections 3-4 (connected graded implies Hopf).
-/

noncomputable section

namespace ConnesKreimer

open scoped TensorProduct

universe u v

variable {R : Type v} [CommRing R]

local instance instTensorSemiring (P : GraftingProvider.{u}) :
    Semiring (CKAlgebra R P.Tree ⊗[R] CKAlgebra R P.Tree) :=
  Algebra.TensorProduct.instSemiring

local instance instTensorAlgebra (P : GraftingProvider.{u}) :
    Algebra R (CKAlgebra R P.Tree ⊗[R] CKAlgebra R P.Tree) :=
  Algebra.TensorProduct.leftAlgebra

/-- Admissible-cut coproduct data: an algebra-map coproduct and counit on
the Connes-Kreimer algebra, with the coproduct pinned by the `B₊`
1-cocycle equation `Δ(B₊ f) = B₊ f ⊗ 1 + (id ⊗ B₊)(Δ f)` on grafted
generators.  The linear extension `graftOperator` of `B₊` is part of the
data, pinned on monomials. -/
structure AdmissibleCutData (P : GraftingProvider.{u}) (R : Type v) [CommRing R] where
  coproduct : CKAlgebra R P.Tree →ₐ[R] (CKAlgebra R P.Tree ⊗[R] CKAlgebra R P.Tree)
  counit : CKAlgebra R P.Tree →ₐ[R] R
  graftOperator : CKAlgebra R P.Tree →ₗ[R] CKAlgebra R P.Tree
  graftOperator_monomial : ∀ (f : ConnesKreimer.Forest P.Tree) (a : R),
    graftOperator (MvPolynomial.monomial f a) = a • P.graftGenerator R f
  cocycle : ∀ f : ConnesKreimer.Forest P.Tree,
    coproduct (P.graftGenerator R f)
      = (P.graftGenerator R f) ⊗ₜ[R] 1
        + (TensorProduct.map LinearMap.id graftOperator)
            (coproduct (forestMonomial R f))
  counit_graft : ∀ f : ConnesKreimer.Forest P.Tree,
    counit (P.graftGenerator R f) = 0

/-- M1 target: when grafting is bijective (the universal property of rooted
trees), the admissible-cut data exist and induce a Mathlib `Coalgebra`. -/
theorem exists_admissibleCutData (P : GraftingProvider.{u})
    (hbij : Function.Bijective P.graft) :
    Nonempty (AdmissibleCutData P R) := by
  sorry

/-- M1 target, contract form. -/
theorem hasAdmissibleCutCoalgebra_of_bijective_graft (P : GraftingProvider.{u})
    (hbij : Function.Bijective P.graft) :
    HasAdmissibleCutCoalgebra R P.toRootedTreeProvider := by
  sorry

/-- M2 target: a bialgebra that is connected in vertex degree zero has an
antipode (connected graded implies Hopf).  Candidate for upstream Mathlib:
the general connected-graded-bialgebra theorem. -/
theorem hasHopf_of_connected_graded (P : GraftingProvider.{u})
    (hb : HasConnesKreimerBialgebra R P.toRootedTreeProvider)
    (hconn : ∀ p : CKAlgebra R P.Tree,
      IsHomogeneousVertexDegree P.vertices 0 p -> ∃ c : R, p = MvPolynomial.C c) :
    HasConnesKreimerHopfAlgebra R P.toRootedTreeProvider := by
  sorry

end ConnesKreimer
