import ConnesKreimer.Grafting
import Mathlib.RingTheory.TensorProduct.Basic

/-!
# Data contract for the admissible-cut coproduct

This file introduces only a data-bearing interface for M1.  It does not assert
that such data exist for any provider, and it does not build a bialgebra or
Hopf algebra.
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

/-- Admissible-cut coproduct data on a grafting provider.

The coproduct is pinned by the `B_+` 1-cocycle equation on grafted generators.
Supplying this structure is stronger than the raw `HasRawCoalgebra` placeholder:
it names the coproduct, counit, linear graft operator, and the equations needed
to identify the intended Connes-Kreimer admissible-cut interface. -/
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

/-- Data-bearing M1 frontier hypothesis.

This is intentionally separate from the legacy raw coalgebra aliases until the
interface-change in issue #29 decides whether those aliases should be replaced
or kept permanently raw. -/
abbrev HasAdmissibleCutData (R : Type v) [CommRing R] (P : GraftingProvider.{u}) :
    Prop :=
  Nonempty (AdmissibleCutData P R)

end ConnesKreimer
