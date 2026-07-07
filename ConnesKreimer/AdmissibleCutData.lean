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

/-- Data-backed admissible-cut coalgebra contract.

This is the explicit replacement target for consumers that need a pinned
admissible-cut interface instead of the legacy raw `HasAdmissibleCutCoalgebra`
placeholder.  It is only a data hypothesis: main still proves no existence
theorem and constructs no Mathlib `Coalgebra` instance. -/
abbrev HasAdmissibleCutCoalgebraContract
    (R : Type v) [CommRing R] (P : GraftingProvider.{u}) : Prop :=
  HasAdmissibleCutData R P

/-- The data-bearing admissible-cut hypothesis is exactly nonemptiness of the
explicit `AdmissibleCutData` contract. -/
theorem hasAdmissibleCutData_iff_nonempty
    (R : Type v) [CommRing R] (P : GraftingProvider.{u}) :
    HasAdmissibleCutData R P ↔ Nonempty (AdmissibleCutData P R) :=
  Iff.rfl

/-- The data-backed admissible-cut coalgebra contract is exactly the explicit
`HasAdmissibleCutData` hypothesis. -/
theorem hasAdmissibleCutCoalgebraContract_iff_hasAdmissibleCutData
    (R : Type v) [CommRing R] (P : GraftingProvider.{u}) :
    HasAdmissibleCutCoalgebraContract R P ↔ HasAdmissibleCutData R P :=
  Iff.rfl

namespace AdmissibleCutData

/-- The linear graft operator sends the normalized forest monomial to the
corresponding graft generator.

This is a consumer-facing wrapper around `graftOperator_monomial` for the
coefficient-one monomial supplied by `forestMonomial`. -/
@[simp]
theorem graftOperator_forestMonomial {P : GraftingProvider.{u}}
    (D : AdmissibleCutData P R) (f : ConnesKreimer.Forest P.Tree) :
    D.graftOperator (forestMonomial R f) = P.graftGenerator R f := by
  simpa [forestMonomial] using D.graftOperator_monomial f (1 : R)

/-- The linear graft operator sends scalar multiples of normalized forest
monomials to the same scalar multiple of the graft generator.

This is a consumer-facing wrapper around linearity plus
`graftOperator_forestMonomial`; downstream code can keep coefficient-scaled
forest monomials normalized without unfolding `MvPolynomial.monomial`. -/
@[simp]
theorem graftOperator_smul_forestMonomial {P : GraftingProvider.{u}}
    (D : AdmissibleCutData P R) (a : R) (f : ConnesKreimer.Forest P.Tree) :
    D.graftOperator (a • forestMonomial R f) = a • P.graftGenerator R f := by
  rw [map_smul, D.graftOperator_forestMonomial f]

/-- The linear graft operator sends sums of normalized forest monomials to sums
of the corresponding graft generators.

This is a consumer-facing wrapper around linearity plus
`graftOperator_forestMonomial`; downstream code can handle two-term forest
bookkeeping without unfolding the supplied linear map. -/
@[simp]
theorem graftOperator_add_forestMonomial {P : GraftingProvider.{u}}
    (D : AdmissibleCutData P R) (f g : ConnesKreimer.Forest P.Tree) :
    D.graftOperator (forestMonomial R f + forestMonomial R g)
      = P.graftGenerator R f + P.graftGenerator R g := by
  rw [map_add, D.graftOperator_forestMonomial f,
    D.graftOperator_forestMonomial g]

/-- The linear graft operator sends natural multiples of normalized forest
monomials to the same natural multiple of the graft generator.

This is a consumer-facing wrapper around linearity plus
`graftOperator_forestMonomial`; downstream code can keep repeated forest
monomials normalized without unfolding the supplied linear map. -/
@[simp]
theorem graftOperator_nsmul_forestMonomial {P : GraftingProvider.{u}}
    (D : AdmissibleCutData P R) (n : Nat) (f : ConnesKreimer.Forest P.Tree) :
    D.graftOperator (n • forestMonomial R f) = n • P.graftGenerator R f := by
  rw [map_nsmul, D.graftOperator_forestMonomial f]

/-- The linear graft operator sends zero to zero.

This is a consumer-facing wrapper around linearity; downstream code can use the
supplied graft operator's zero case without unfolding the linear map. -/
@[simp]
theorem graftOperator_zero {P : GraftingProvider.{u}}
    (D : AdmissibleCutData P R) :
    D.graftOperator (0 : CKAlgebra R P.Tree) = 0 := by
  exact map_zero D.graftOperator

/-- The linear graft operator sends a tree generator to the graft generator
for the singleton forest containing that tree.

This is a consumer-facing wrapper combining `graftOperator_forestMonomial` with
the closed M0 bridge from tree generators to singleton forest monomials. -/
@[simp]
theorem graftOperator_treeGenerator {P : GraftingProvider.{u}}
    (D : AdmissibleCutData P R) (t : P.Tree) :
    D.graftOperator (treeGenerator R t)
      = P.graftGenerator R (Finsupp.single t 1 : ConnesKreimer.Forest P.Tree) := by
  rw [treeGenerator_eq_forestMonomial_single_one]
  exact D.graftOperator_forestMonomial (Finsupp.single t 1)

/-- The linear graft operator sends the unit, viewed as the empty forest
monomial, to the graft generator of the empty forest. -/
@[simp]
theorem graftOperator_one {P : GraftingProvider.{u}}
    (D : AdmissibleCutData P R) :
    D.graftOperator (1 : CKAlgebra R P.Tree)
      = P.graftGenerator R (0 : ConnesKreimer.Forest P.Tree) := by
  simpa using D.graftOperator_forestMonomial (0 : ConnesKreimer.Forest P.Tree)

/-- The counit kills the linear graft operator on normalized forest monomials.

This is a consumer-facing wrapper combining `graftOperator_forestMonomial` with
the supplied `counit_graft` field; it does not assert that such data exist. -/
@[simp]
theorem counit_graftOperator_forestMonomial {P : GraftingProvider.{u}}
    (D : AdmissibleCutData P R) (f : ConnesKreimer.Forest P.Tree) :
    D.counit (D.graftOperator (forestMonomial R f)) = 0 := by
  rw [D.graftOperator_forestMonomial f]
  exact D.counit_graft f

/-- The counit kills the linear graft operator on tree generators.

This is the singleton-tree-generator specialization of
`counit_graftOperator_forestMonomial`, with the same data-only status. -/
@[simp]
theorem counit_graftOperator_treeGenerator {P : GraftingProvider.{u}}
    (D : AdmissibleCutData P R) (t : P.Tree) :
    D.counit (D.graftOperator (treeGenerator R t)) = 0 := by
  rw [D.graftOperator_treeGenerator t]
  exact D.counit_graft (Finsupp.single t 1)

/-- The counit kills the graft operator on the unit, equivalently on the
empty-forest monomial. -/
@[simp]
theorem counit_graftOperator_one {P : GraftingProvider.{u}}
    (D : AdmissibleCutData P R) :
    D.counit (D.graftOperator (1 : CKAlgebra R P.Tree)) = 0 := by
  rw [D.graftOperator_one]
  exact D.counit_graft (0 : ConnesKreimer.Forest P.Tree)

/-- The counit kills the graft operator on zero. -/
@[simp]
theorem counit_graftOperator_zero {P : GraftingProvider.{u}}
    (D : AdmissibleCutData P R) :
    D.counit (D.graftOperator (0 : CKAlgebra R P.Tree)) = 0 := by
  rw [D.graftOperator_zero]
  exact map_zero D.counit

/-- The supplied coproduct satisfies the `B_+` 1-cocycle equation on the
normalized forest-monomial output of the graft operator.

This is a consumer-facing wrapper combining `graftOperator_forestMonomial` with
the supplied `cocycle` field; it does not assert that such data exist. -/
theorem coproduct_graftOperator_forestMonomial {P : GraftingProvider.{u}}
    (D : AdmissibleCutData P R) (f : ConnesKreimer.Forest P.Tree) :
    D.coproduct (D.graftOperator (forestMonomial R f))
      = (D.graftOperator (forestMonomial R f)) ⊗ₜ[R] 1
        + (TensorProduct.map LinearMap.id D.graftOperator)
            (D.coproduct (forestMonomial R f)) := by
  rw [D.graftOperator_forestMonomial f]
  exact D.cocycle f

/-- The supplied coproduct satisfies the `B_+` 1-cocycle equation on the
normalized tree-generator output of the graft operator.

This is the singleton-tree-generator specialization of
`coproduct_graftOperator_forestMonomial`, with no existence claim for the
underlying admissible-cut data. -/
theorem coproduct_graftOperator_treeGenerator {P : GraftingProvider.{u}}
    (D : AdmissibleCutData P R) (t : P.Tree) :
    D.coproduct (D.graftOperator (treeGenerator R t))
      = (D.graftOperator (treeGenerator R t)) ⊗ₜ[R] 1
        + (TensorProduct.map LinearMap.id D.graftOperator)
            (D.coproduct (treeGenerator R t)) := by
  rw [treeGenerator_eq_forestMonomial_single_one]
  exact D.coproduct_graftOperator_forestMonomial (Finsupp.single t 1)

/-- The supplied coproduct satisfies the `B_+` 1-cocycle equation on the
graft-operator output of the unit, equivalently the empty-forest monomial. -/
theorem coproduct_graftOperator_one {P : GraftingProvider.{u}}
    (D : AdmissibleCutData P R) :
    D.coproduct (D.graftOperator (1 : CKAlgebra R P.Tree))
      = (D.graftOperator (1 : CKAlgebra R P.Tree)) ⊗ₜ[R] 1
        + (TensorProduct.map LinearMap.id D.graftOperator)
            (D.coproduct (1 : CKAlgebra R P.Tree)) := by
  simpa using
    D.coproduct_graftOperator_forestMonomial
      (0 : ConnesKreimer.Forest P.Tree)

/-- The supplied coproduct sends the graft-operator output of zero to zero. -/
@[simp]
theorem coproduct_graftOperator_zero {P : GraftingProvider.{u}}
    (D : AdmissibleCutData P R) :
    D.coproduct (D.graftOperator (0 : CKAlgebra R P.Tree)) = 0 := by
  rw [D.graftOperator_zero]
  exact map_zero D.coproduct

end AdmissibleCutData

end ConnesKreimer
