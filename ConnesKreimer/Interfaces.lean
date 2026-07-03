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

/-- Explicit frontier hypothesis for the admissible-cut coalgebra laws.

Supplying this is stronger than giving a raw comultiplication: it must already
be a Mathlib `Coalgebra` on the polynomial algebra. -/
abbrev HasAdmissibleCutCoalgebra (R : Type v) [CommSemiring R]
    (P : RootedTreeProvider.{u}) : Prop :=
  Nonempty (Coalgebra R (RootedTreeProvider.Algebra R P))

/-- Explicit frontier hypothesis for the Connes-Kreimer bialgebra laws.

This packages counit, admissible-cut coproduct, coassociativity, and algebra
compatibility using Mathlib's `Bialgebra`. -/
abbrev HasConnesKreimerBialgebra (R : Type v) [CommSemiring R]
    (P : RootedTreeProvider.{u}) : Prop :=
  Nonempty (Bialgebra R (RootedTreeProvider.Algebra R P))

/-- Explicit frontier hypothesis for the antipode/Hopf structure. -/
abbrev HasConnesKreimerHopfAlgebra (R : Type v) [CommSemiring R]
    (P : RootedTreeProvider.{u}) : Prop :=
  Nonempty (HopfAlgebra R (RootedTreeProvider.Algebra R P))

end ConnesKreimer
