# Mathlib Audit

Last updated: 2026-07-03.

## Pins checked

* THE-ERIKSSON-PROGRAMME HEAD checked: `7a71754b93da6f447544211af51fd513a90b086c`.
* Mother repository toolchain: `leanprover/lean4:v4.29.0-rc6`.
* Mother repository Mathlib pin:
  `07642720480157414db592fa85b626dafb71355b`.
* This repository uses the same toolchain and Mathlib pin.

## Existing Mathlib material to reuse

* `Mathlib.Algebra.MvPolynomial.Basic`:
  `MvPolynomial sigma R` is implemented as `AddMonoidAlgebra R (Finsupp sigma Nat)`.
  This is the right free commutative algebra for forests indexed by rooted
  trees, so M0 should not define a bespoke polynomial algebra.
* `Mathlib.Data.Finsupp.Basic`:
  finitely supported functions `Finsupp Tree Nat` are the natural representation of
  forests as finite multiplicity maps.
* `Mathlib.Data.Tree.Basic`:
  Mathlib has binary trees `Tree alpha` with `Tree.numNodes`.
* `Mathlib.Combinatorics.Enumerative.Catalan`:
  Mathlib enumerates binary trees by node count via `Tree.treesOfNumNodesEq`.
* `Mathlib.RingTheory.Coalgebra.Basic`:
  provides `CoalgebraStruct`, `Coalgebra`, `Coalgebra.comul`, and
  `Coalgebra.counit`.
* `Mathlib.RingTheory.Bialgebra.Basic`:
  provides `Bialgebra`, `Bialgebra.mk'`, `Bialgebra.counitAlgHom`, and
  `Bialgebra.comulAlgHom`.
* `Mathlib.RingTheory.HopfAlgebra.Basic`:
  provides `HopfAlgebraStruct`, `HopfAlgebra`, and `HopfAlgebra.antipode`.

## Repositories checked for tree APIs

* `lluiseriksson/mathlib-plane-tree-catalan` at
  `77adbc66fc7bcaae062fcd6c982fb3f580852775` contains
  `Mathlib/Combinatorics/Enumerative/PlaneTree.lean`, defining:
  `PlaneTree`, `PlaneTree.children`, `PlaneTree.numNodes`,
  `PlaneTree.forestNumNodes`, equivalences with `Tree Unit`, and Catalan
  enumeration.  It is not currently a standalone Lake dependency and is not
  present in the pinned Mathlib checkout, so this repo does not copy it.
* `lluiseriksson/lean-rooted-tree-polymer-expansion` at
  `e2e0dc7bea894b646422c924b58666ec815e15d1` is a `MarkedRootedClosure`
  package depending on THE-ERIKSSON-PROGRAMME.  A generic reusable rooted-tree
  datatype was not found in its public Lean files.

## Design consequence

The initial Connes-Kreimer layer is parametric in a tree type.  The package
exports `RootedTreeProvider` with a type and vertex-count function, and exposes
future coalgebra/bialgebra/Hopf assumptions as explicit hypotheses over that
provider.  This avoids duplicating tree datatypes and leaves room to factor a
shared package later.
