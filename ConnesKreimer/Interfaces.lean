import ConnesKreimer.Basic
import Mathlib.RingTheory.Bialgebra.Basic
import Mathlib.RingTheory.HopfAlgebra.Basic

/-!
# Public interfaces for downstream consumers

The future THE-ERIKSSON-PROGRAMME consumer should import this file only after a
real counterterm-accounting use case exists.  The current interface is generic
in the tree type and carries every unproved Hopf-algebra milestone as an
explicit hypothesis.
-/

noncomputable section

namespace ConnesKreimer

universe u v

/-- M0 provider: a tree type together with its vertex count.

No tree type is defined here.  This structure is the handshake point for
`mathlib-plane-tree-catalan`, `lean-rooted-tree-polymer-expansion`, or a future
common package.
-/
structure RootedTreeProvider where
  Tree : Type u
  vertices : Tree -> Nat

namespace RootedTreeProvider

/-- The Connes-Kreimer algebra attached to a provider. -/
abbrev Algebra (R : Type v) [CommSemiring R] (P : RootedTreeProvider.{u}) :
    Type (max u v) :=
  CKAlgebra R P.Tree

/-- The forest type attached to a provider. -/
abbrev Forest (P : RootedTreeProvider.{u}) : Type u :=
  ConnesKreimer.Forest P.Tree

end RootedTreeProvider

/-- Raw frontier hypothesis for an unspecified Mathlib coalgebra structure.

This deliberately does not identify the structure with the admissible-cut
coproduct.  It is useful as a precise name for the current raw M1 placeholder
while the admissible-cut contract remains frontier work. -/
abbrev HasRawCoalgebra (R : Type v) [CommSemiring R]
    (P : RootedTreeProvider.{u}) : Prop :=
  Nonempty (Coalgebra R (RootedTreeProvider.Algebra R P))

/-- Raw frontier hypothesis for an unspecified Mathlib bialgebra structure. -/
abbrev HasRawBialgebra (R : Type v) [CommSemiring R]
    (P : RootedTreeProvider.{u}) : Prop :=
  Nonempty (Bialgebra R (RootedTreeProvider.Algebra R P))

/-- Raw frontier hypothesis for an unspecified Mathlib Hopf algebra structure. -/
abbrev HasRawHopfAlgebra (R : Type v) [CommSemiring R]
    (P : RootedTreeProvider.{u}) : Prop :=
  Nonempty (HopfAlgebra R (RootedTreeProvider.Algebra R P))

/-- Legacy name for the raw coalgebra placeholder.

This is not yet a pinned admissible-cut contract: any Mathlib `Coalgebra` on
the polynomial algebra witnesses it.  Use `HasRawCoalgebra` when that rawness
matters explicitly; reserve a future data-bearing admissible-cut contract for
the M1 interface-change tracked in issue #29. -/
abbrev HasAdmissibleCutCoalgebra (R : Type v) [CommSemiring R]
    (P : RootedTreeProvider.{u}) : Prop :=
  HasRawCoalgebra R P

/-- Legacy name for the raw Connes-Kreimer bialgebra placeholder.

This packages counit, admissible-cut coproduct, coassociativity, and algebra
compatibility only if the supplied Mathlib `Bialgebra` is known separately to
be the Connes-Kreimer one. -/
abbrev HasConnesKreimerBialgebra (R : Type v) [CommSemiring R]
    (P : RootedTreeProvider.{u}) : Prop :=
  HasRawBialgebra R P

/-- Legacy name for the raw Connes-Kreimer Hopf-algebra placeholder. -/
abbrev HasConnesKreimerHopfAlgebra (R : Type v) [CommSemiring R]
    (P : RootedTreeProvider.{u}) : Prop :=
  HasRawHopfAlgebra R P

/-- The legacy admissible-cut coalgebra name is exactly the raw coalgebra
placeholder on `main`; it does not add a pinned admissible-cut coproduct. -/
theorem hasAdmissibleCutCoalgebra_iff_hasRawCoalgebra
    (R : Type v) [CommSemiring R] (P : RootedTreeProvider.{u}) :
    HasAdmissibleCutCoalgebra R P ↔ HasRawCoalgebra R P :=
  Iff.rfl

/-- The legacy Connes-Kreimer bialgebra name is exactly the raw bialgebra
placeholder on `main`; it does not add bialgebra compatibility data. -/
theorem hasConnesKreimerBialgebra_iff_hasRawBialgebra
    (R : Type v) [CommSemiring R] (P : RootedTreeProvider.{u}) :
    HasConnesKreimerBialgebra R P ↔ HasRawBialgebra R P :=
  Iff.rfl

/-- The legacy Connes-Kreimer Hopf-algebra name is exactly the raw Hopf
placeholder on `main`; it does not add antipode construction data. -/
theorem hasConnesKreimerHopfAlgebra_iff_hasRawHopfAlgebra
    (R : Type v) [CommSemiring R] (P : RootedTreeProvider.{u}) :
    HasConnesKreimerHopfAlgebra R P ↔ HasRawHopfAlgebra R P :=
  Iff.rfl

end ConnesKreimer
