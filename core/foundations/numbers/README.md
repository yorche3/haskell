# Numbers — Haskell

Implementación de la especificación [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) en **Haskell**, construida con **Cabal** y probada con **Hspec**.

Implementa suma de los primeros n números, factorial, Fibonacci, MCD y MCM en tres enfoques progresivos (`_rec`, `_acc`, `_ite`).

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`numbers.cabal`](numbers.cabal) | Manifiesto del paquete — define la librería y el test-suite. |
| [`lib/Numbers.hs`](lib/Numbers.hs) | Los 5 algoritmos en los 3 enfoques (`_rec`, `_acc`, `_ite`). |
| [`test/RecursiveSpec.hs`](test/RecursiveSpec.hs) | Tests Hspec del enfoque `_rec`. |
| [`test/RecursiveWithAccSpec.hs`](test/RecursiveWithAccSpec.hs) | Tests Hspec del enfoque `_acc`. |
| [`test/IterativeSpec.hs`](test/IterativeSpec.hs) | Tests Hspec del enfoque `_ite`. |
| [`test/RunTests.hs`](test/RunTests.hs) | Punto de entrada: combina las tres suites. |
| [`CHANGELOG.md`](CHANGELOG.md) | Historial de cambios del paquete. |
| [`LICENSE`](LICENSE) | Texto de la licencia (GPL-3.0). |

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Cabal + Hspec, siguiendo la convención de este repositorio de separar las pruebas por enfoque (`RecursiveSpec`, `RecursiveWithAccSpec`, `IterativeSpec`), todas ejercitando el mismo módulo `Numbers`.

**EN:** Cabal + Hspec, following this repo's convention of splitting tests per approach (`RecursiveSpec`, `RecursiveWithAccSpec`, `IterativeSpec`), all exercising the same `Numbers` module.

---

## 📝 Notas de implementación / Implementation Notes

### 🔁 Sobre recursión con acumulador y Tail Call Optimization (TCO) / On recursion with accumulator and Tail Call Optimization (TCO)

**ES:** Tail recursion ocurre cuando la llamada recursiva es la última acción de una función: no queda trabajo pendiente en la pila tras la llamada. La recursión con acumulador (`_acc`) consigue esto pasando el estado previo como parámetro en cada llamada.

**En Haskell (GHC), este patrón sí se optimiza en la práctica**: para funciones auto-recursivas y estrictas en su acumulador (como `sumFirstHelp`, `factorialHelp`, `fibonacciHelp` en `_acc`, o `greatestCommonDivisorAcc`), GHC las compila a un bucle en código máquina con pila constante O(1). Esto **no es una garantía formal del Haskell Report** (a diferencia de, por ejemplo, Scheme), pero sí es un comportamiento fiable del compilador para este tipo de recursión de cola simple.

**Consecuencia práctica:** la versión `_ite` (implementada aquí con `foldl'` y `until`, ambas de la biblioteca estándar) **no ofrece una ventaja real de memoria o rendimiento sobre `_acc`** en este lenguaje — `foldl'` y `until` son en sí mismas recursión de cola estricta bajo el capó, así que ambas compilan a estructuras equivalentes. La diferencia entre `_acc` e `_ite` en Haskell es de **estilo/idioma**, no de eficiencia: `_acc` escribe la recursión a mano con un parámetro acumulador, mientras `_ite` reutiliza combinadores de `Prelude`/`Data.List` que se asemejan visualmente al bucle imperativo del pseudocódigo de la especificación.

Por esta razón se mantienen las tres implementaciones (progresión pedagógica de la especificación) **y las tres suites de prueba**, ya que aquí `_acc` sí se beneficia de TCO práctico y no aplica la excepción de "no probar el acumulador" reservada para lenguajes sin TCO.

**EN:** Tail recursion happens when the recursive call is the last action a function performs: no work is left pending on the stack after the call. Accumulator-based recursion (`_acc`) achieves this by passing the previous state as a parameter on each call.

**In Haskell (GHC), this pattern is optimized in practice**: for self-recursive functions that are strict in their accumulator (like `sumFirstHelp`, `factorialHelp`, `fibonacciHelp` in `_acc`, or `greatestCommonDivisorAcc`), GHC compiles them to a machine-code loop with constant O(1) stack. This is **not a formal guarantee of the Haskell Report** (unlike, e.g., Scheme), but it is reliable compiler behavior for this kind of simple tail recursion.

**Practical consequence:** the `_ite` version (implemented here with `foldl'` and `until`, both from the standard library) **does not provide a real memory or performance advantage over `_acc`** in this language — `foldl'` and `until` are themselves strict tail recursion under the hood, so both compile to equivalent structures. The difference between `_acc` and `_ite` in Haskell is one of **style/idiom**, not efficiency: `_acc` hand-writes the recursion with an accumulator parameter, while `_ite` reuses `Prelude`/`Data.List` combinators that visually resemble the spec's imperative loop pseudocode.

For this reason all three implementations are kept (pedagogical progression of the spec) **and all three test suites**, since here `_acc` does benefit from practical TCO and the "don't test the accumulator" exception (reserved for languages without TCO) does not apply.

---

## 🚀 Compilación y ejecución / Build & Run

```bash
cd core/foundations/numbers
cabal build
cabal test
```

**Salida esperada / Expected output:**

```text
33 examples, 0 failures
```
