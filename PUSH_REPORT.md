# Informe de sesión — lean-connes-kreimer (empuje M0-grading)

## Plantilla §B2

```
HECHO:
  Rama push/m0-grading (candidato a main, 0 sorry, 0 axiom):
    Grading.lean — capa de graduación de M0 completa y paramétrica en el
      tipo de árbol: aditividad del conteo de vértices; cálculo de
      homogeneidad (suma, escalar, PRODUCTO — la ley graduada
      deg(p·q) = deg p + deg q); homogeneidad de generadores, monomios y
      unidad; homogeneousSubmodule con la ley de monoide graduado.
    Grafting.lean — GraftingProvider: extensión del proveedor con B₊ y la
      ley de vértices |B₊(f)| = |f| + 1 (biyectividad deliberadamente NO
      exigida: aparece como hipótesis explícita donde hace falta);
      desplazamiento de grado de B₊ (+1 exacto); positividad e
      inyectividad-en-conteo.
    HYPOTHESIS_FRONTIER.md actualizado. Barrel extendido solo aditivamente.
  Rama frontier/M1 (statements-first, sorried, NUNCA a main):
    Frontier/CutCoproduct.lean — AdmissibleCutData (coproducto + counit +
      B₊ lineal, FIJADO por la ecuación de 1-cociclo de Connes-Kreimer);
      existencia bajo biyectividad de graft; forma-contrato; y
      hasHopf_of_connected_graded (candidato a upstream Mathlib: el teorema
      general "conexo graduado ⇒ Hopf").
SIGUIENTE: verificar CI en push/m0-grading; luego decisión de tipo de árbol
  (único bloqueador para instanciar GraftingProvider) — el proveedor ya
  especifica exactamente qué API debe exportar ese tipo: graft, la ley de
  vértices, y biyectividad para M1.
BLOQUEOS: ninguno nuevo. La reutilización del tipo de árbol de
  lean-rooted-tree-polymer-expansion sigue pendiente de decisión humana
  (añadir dependencia cruzada toca lakefile + manifest: no lo hago a ciegas).
IMPACTO-INTERFAZ: contrato INTACTO. HALLAZGO para el Revisor:
  HasAdmissibleCutCoalgebra/Bialgebra/HopfAlgebra son `Nonempty` de una
  CLASE de estructuras — cualquier coálgebra sobre MvPolynomial las
  atestigua, no solo la de admissible cuts (p.ej. estructuras estilo
  AddMonoidAlgebra si existen en el pin). AdmissibleCutData del frontier
  fija el coproducto por el cociclo de B₊, que es la propiedad que de
  verdad caracteriza el coproducto CK. Propuesta: re-expresar las hipótesis
  del contrato a través de AdmissibleCutData. Requiere ritual; decisión
  humana. NO lo he explotado ni tocado.
HONESTIDAD: (1) Ningún enunciado debilitado; la decisión de diseño del T0
  (sin tipo de árbol propio) se respeta al 100%: todo paramétrico.
  (2) Verificación local posterior al apply: `lake --rehash build
  ConnesKreimer` compila verde. Se corrigieron dos ajustes mecánicos del
  primer build: hipótesis explícitas `[DecidableEq Tree]` solo en los lemas
  que usan coeficientes/antidiagonal, e import de `ConnesKreimer.Interfaces`
  para `RootedTreeProvider` en `Grafting.lean`. (3) Sin consumidor real en
  el madre todavía: sigue dicho así, sin cambios.
```

## Verificación local posterior al apply

* `lake --rehash build ConnesKreimer`: verde.
* `rg -n "\bsorry\b|^\s*axiom\b" -g "*.lean" .`: sin resultados en
  `push/m0-grading`.
* `lake exe cache get`: no reintentado en esta segunda pasada; el T0 ya
  registró que se cuelga localmente, y CI sigue siendo el juez remoto.

## Cómo aplicar

```bash
git fetch origin
git checkout -b push/m0-grading origin/main
git am 0001-*.patch
git push -u origin push/m0-grading      # CI juzga; si verde → PR a main
git checkout -b frontier/M1
git am 0002-*.patch
git push -u origin frontier/M1
```

## VERIFICATION — puntos de riesgo del primer build (orden de probabilidad)

1. `MvPolynomial.coeff_X'` (coeff con `if Finsupp.single t 1 = f`): si el
   nombre u orientación del ite difiere en el pin, localizar con
   `grep -rn "coeff_X" .lake/packages/mathlib/Mathlib/Algebra/MvPolynomial/Basic.lean`
   y ajustar el `split at hf` (dos ramas: `← h` / `absurd rfl hf`).
   Lo mismo para `coeff_monomial` (`if n = m`) y `coeff_one` (`if 0 = m`).
2. `Finsupp.sum_add_index'`: orden de los argumentos (h_zero, h_add); si el
   pin solo tiene `sum_add_index` (con hipótesis de membership), usar esa
   variante con `fun t _ => zero_mul _`.
3. `Finset.exists_ne_zero_of_sum_ne_zero` y `Finset.mem_antidiagonal` (la
   antidiagonal de Finsupp entra por `Mathlib.Data.Finsupp.Antidiagonal`);
   si la ruta del import cambió: `find .lake/packages/mathlib -name "Antidiagonal.lean" -path "*Finsupp*"`.
4. `MvPolynomial.coeff_smul`: si devuelve `c • coeff` en vez de con
   `smul_eq_mul` directo, el `rw` ya lo contempla; si el nombre difiere,
   alternativa `MvPolynomial.smul_eq_C_mul` + `coeff_C_mul`.
5. En `GraftingProvider`, los campos usan `toRootedTreeProvider.Tree`
   explícito; si el elaborador prefiere los abridores de `extends`,
   sustituir por `Tree`/`vertices` a secas (el azúcar de parent projection).
6. `Submodule` estructura: los campos `add_mem'`/`smul_mem'` toman
   argumentos implícitos con perfiles que han cambiado alguna vez; si
   protesta, envolver en lambdas explícitas `fun {p q} hp hq => hp.add hq`.
7. Frontier: `import Mathlib` global + `TensorProduct.map` +
   `⊗ₜ[R]` — solo compila en la rama frontier con cache completa;
   deliberado.

## Qué gana el madre con este empuje

La graduación por vértices deja de ser un predicado decorativo: es un
cálculo cerrado (con la ley multiplicativa, que es la mitad algebraica de
"bialgebra graduada") más una especificación exacta de qué debe aportar el
tipo de árbol compartido del ecosistema: B₊ con su ley de vértices y, para
M1, su biyectividad — que es literalmente la propiedad universal de los
árboles enraizados. Y el hallazgo de interfaz evita que un futuro
"HasConnesKreimerHopfAlgebra" se satisfaga con una estructura Hopf que no
es la de Connes-Kreimer.
