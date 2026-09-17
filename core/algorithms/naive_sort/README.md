# Naive Sort — Haskell

Implementación de la especificación [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) en **Haskell**, construida con **Cabal** y probada con **Hspec**.

Los tres algoritmos elementales de ordenamiento ($O(n^2)$) — **Selection Sort**, **Bubble Sort** e **Insertion Sort** — trabajan sobre listas inmutables `[Int]` y no invocan ninguna biblioteca de ordenamiento: sólo comparaciones, *pattern matching* y recursión.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`naive-sort.cabal`](naive-sort.cabal) | Manifiesto del paquete — define la librería y el test-suite. |
| [`lib/NaiveSort.hs`](lib/NaiveSort.hs) | Las 3 funciones del contrato + los helpers privados `pickMin`, `bubblePass` e `insert`. |
| [`test/NaiveSortSpec.hs`](test/NaiveSortSpec.hs) | Tests Hspec: 3 bloques `describe`, 21 ejemplos. |
| [`test/RunTests.hs`](test/RunTests.hs) | Punto de entrada: ejecuta la suite. |
| [`CHANGELOG.md`](CHANGELOG.md) | Historial de cambios del paquete. |
| [`LICENSE`](LICENSE) | Texto de la licencia (GPL-3.0). |

**Estructura de directorios esperada:**

```text
naive_sort/
├── lib/
│   └── NaiveSort.hs
├── test/
│   ├── NaiveSortSpec.hs
│   └── RunTests.hs
├── naive-sort.cabal
├── CHANGELOG.md
└── LICENSE
```

A diferencia de `foundations/numbers/`, que reparte sus tres enfoques en tres archivos de spec (`RecursiveSpec`, `RecursiveWithAccSpec`, `IterativeSpec`), aquí los tres algoritmos comparten un único contrato `[Int] -> [Int]` y una única tabla de casos, así que una sola suite `NaiveSortSpec` los recorre con un helper común.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se generó con `cabal init --lib`, que produce el manifiesto `naive-sort.cabal` con los componentes `library` y `test-suite`. Sobre esa base se eliminó el placeholder `MyLib.hs` y se alineó el manifiesto con el módulo hermano `foundations/numbers`: `exposed-modules: NaiveSort`, `other-modules: NaiveSortSpec` y `hspec` en las dependencias del test-suite.

**EN:** The project was generated with `cabal init --lib`, which produces the `naive-sort.cabal` manifest with the `library` and `test-suite` components. On top of that base the `MyLib.hs` placeholder was removed and the manifest was aligned with the sibling module `foundations/numbers`: `exposed-modules: NaiveSort`, `other-modules: NaiveSortSpec` and `hspec` in the test-suite dependencies.

### Inicialización / Initialization

```bash
cabal init --lib
```

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `naive-sort.cabal` – Manifiesto del paquete

**ES:** Define un `common warnings` con `ghc-options: -Wall`, que la librería y el test-suite importan. Ese bloque es el que activa la verificación estática: `cabal build all --enable-tests` compila ambos componentes **sin ningún warning**. El código de la librería vive en `lib/` y el de las pruebas en `test/`.

**EN:** It defines a `common warnings` stanza with `ghc-options: -Wall`, imported by both the library and the test-suite. That stanza enables static verification: `cabal build all --enable-tests` compiles both components **with no warnings at all**. Library code lives in `lib/` and test code in `test/`.

```cabal
common warnings
    ghc-options: -Wall

library
    import:           warnings
    exposed-modules:  NaiveSort
    build-depends:    base ^>=4.20.2.0
    hs-source-dirs:   lib
    default-language: Haskell2010

test-suite naive-sort-test
    import:           warnings
    type:             exitcode-stdio-1.0
    other-modules:
        NaiveSortSpec
    hs-source-dirs:   test
    main-is:          RunTests.hs
    build-depends:
        base ^>=4.20.2.0,
        naive-sort,
        hspec ^>=2.11.0
```

**ES:** No hay `.gitignore` en el módulo: el de la raíz del submódulo `haskell/` ya cubre los artefactos (`dist-*` → `dist-newstyle/`, `*.o`, `*.hi`), verificado con `git check-ignore -v`, igual que en `numbers/`.

**EN:** There is no `.gitignore` in the module: the one at the root of the `haskell/` submodule already covers the artifacts (`dist-*` → `dist-newstyle/`, `*.o`, `*.hi`), verified with `git check-ignore -v`, as in `numbers/`.

---

## 🚀 Compilación y ejecución / Build & Run

### Compilar / Build

```bash
cabal build
```

### Ejecutar pruebas unitarias / Run tests

```bash
cabal test
```

**Salida real / Actual output:**

```text
$ cabal build all --enable-tests
Building library for naive-sort-0.1.0.0...
[1 of 1] Compiling NaiveSort        ( lib/NaiveSort.hs, ... )
Building test suite 'naive-sort-test' for naive-sort-0.1.0.0...
[1 of 2] Compiling NaiveSortSpec    ( test/NaiveSortSpec.hs, ... )
[2 of 2] Compiling Main             ( test/RunTests.hs, ... )
[3 of 3] Linking ...

$ cabal test --test-show-details=direct
Running 1 test suites...
Test suite naive-sort-test: RUNNING...

selection_sort
  selection_sort should sort an unsorted array [✔]
  selection_sort should sort an already sorted array [✔]
  selection_sort should sort a reverse ordered array [✔]
  selection_sort should sort an array of identical elements [✔]
  selection_sort should sort an array with negative numbers [✔]
  selection_sort should sort a single element array [✔]
  selection_sort should sort an empty array [✔]
bubble_sort
  bubble_sort should sort an unsorted array [✔]
  bubble_sort should sort an already sorted array [✔]
  bubble_sort should sort a reverse ordered array [✔]
  bubble_sort should sort an array of identical elements [✔]
  bubble_sort should sort an array with negative numbers [✔]
  bubble_sort should sort a single element array [✔]
  bubble_sort should sort an empty array [✔]
insertion_sort
  insertion_sort should sort an unsorted array [✔]
  insertion_sort should sort an already sorted array [✔]
  insertion_sort should sort a reverse ordered array [✔]
  insertion_sort should sort an array of identical elements [✔]
  insertion_sort should sort an array with negative numbers [✔]
  insertion_sort should sort a single element array [✔]
  insertion_sort should sort an empty array [✔]

Finished in 0.0008 seconds
21 examples, 0 failures
Test suite naive-sort-test: PASS
1 of 1 test suites (1 of 1 test cases) passed.
```

> **ES:** `-Wall` no reporta nada en `lib/` ni en `test/`. La suite ejecuta **21 ejemplos**: 3 algoritmos × 7 casos de la especificación.
>
> **EN:** `-Wall` reports nothing in `lib/` or `test/`. The suite runs **21 examples**: 3 algorithms × 7 specification cases.

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Algoritmo | Estrategia | Complejidad | In-place |
|-----------|------------|-------------|:--------:|
| `selectionSort` | Extrae el mínimo y el resto en una sola pasada (`pickMin`) y lo antepone al resultado | $O(n^2)$ siempre | ❌ |
| `bubbleSort` | Una pasada con `bubblePass` que devuelve si hubo intercambio; repite mientras lo haya (**salida temprana**) | $O(n^2)$ peor/promedio, $O(n)$ mejor | ❌ |
| `insertionSort` | Ordena la cola recursivamente e inserta la cabeza en su posición con `insert` | $O(n^2)$ peor/promedio, $O(n)$ mejor | ❌ |

### Casos cubiertos / Covered cases

| Caso | Entrada | Salida esperada |
|------|---------|-----------------|
| Lista estándar desordenada | `[5, 2, 9, 1, 5, 6]` | `[1, 2, 5, 5, 6, 9]` |
| Lista ya ordenada | `[1, 2, 3, 4, 5]` | `[1, 2, 3, 4, 5]` |
| Lista en orden inverso | `[5, 4, 3, 2, 1]` | `[1, 2, 3, 4, 5]` |
| Elementos idénticos | `[7, 7, 7, 7]` | `[7, 7, 7, 7]` |
| Con números negativos | `[3, -1, 4, -5, 0]` | `[-5, -1, 0, 3, 4]` |
| Un solo elemento | `[42]` | `[42]` |
| Lista vacía | `[]` | `[]` |

---

## 📝 Notas de implementación / Implementation Notes

### 🧬 Inmutabilidad en lugar de `swap` *in-place* / Immutability instead of in-place swap

**ES:** El pseudocódigo ordena el propio array con `swap(arr, i, j)`. En Haskell `[Int]` es una lista **inmutable**, así que el `swap` no es representable: los tres algoritmos construyen listas nuevas con `:` y *pattern matching*. Los casos base `[]` y `[x]` del pseudocódigo (`if n <= 1 return arr`) se resuelven con ecuaciones separadas.

**EN:** The pseudocode sorts the array itself with `swap(arr, i, j)`. In Haskell `[Int]` is an **immutable** list, so the swap is not representable: all three algorithms build new lists with `:` and pattern matching. The pseudocode's `[]` and `[x]` base cases (`if n <= 1 return arr`) are resolved with separate equations.

### 🆗 Indicador de fallo no representable / Failure indicator not representable

**ES:** La especificación pide devolver el indicador de fallo del lenguaje ante una entrada nula o inválida. Haskell no tiene `null` y `[Int]` no admite listas inválidas, así que el caso nulo **no es representable** y se omite, igual que en **F#** y **Gleam**. Se conservan los 7 casos de la especificación, y como las listas son inmutables cada caso puede usar la constante compartida sin riesgo de contaminar los siguientes.

**EN:** The specification requires returning the language's failure indicator for a null or invalid input. Haskell has no `null` and `[Int]` does not admit invalid lists, so the null case **is not representable** and is omitted, as in **F#** and **Gleam**. The 7 specification cases are kept, and since lists are immutable each case can use the shared constant without any risk of contaminating the following ones.

### 🔁 La bandera `swapped` viaja dentro de un par / The `swapped` flag travels inside a pair

**ES:** El criterio de aceptación exige conservar la optimización de salida temprana. Sin variables mutables, `bubblePass :: [Int] -> (Bool, [Int])` devuelve un par: la lista tras una pasada y si esa pasada hizo algún intercambio. `bubbleSort` repite la pasada sólo mientras la bandera sea `True`, de modo que una lista ya ordenada se resuelve en **una sola pasada** y la bandera nunca se pierde. Es la misma solución que en **Erlang**, **F#**, **Gleam** y **Grain**. En la rama en que ya se ha intercambiado (`x > y`) el resultado de la recursión se descarta en la posición de la bandera, porque esa rama devuelve `True` de forma incondicional.

**EN:** The acceptance criteria require preserving the early-exit optimization. With no mutable variables, `bubblePass :: [Int] -> (Bool, [Int])` returns a pair: the list after one pass and whether that pass performed any swap. `bubbleSort` repeats the pass only while the flag is `True`, so an already sorted list is resolved in **a single pass** and the flag is never lost. This is the same solution as in **Erlang**, **F#**, **Gleam** and **Grain**. In the branch where a swap has already happened (`x > y`) the recursion's result is discarded in the flag position, because that branch returns `True` unconditionally.

### ➿ Cota del bucle interno de `bubblePass` / `bubblePass` inner-loop bound

**ES:** El pseudocódigo acorta la pasada con `for j = 0 to n - 2 - i`, mientras que `bubblePass` recorre siempre la lista completa. El comportamiento observable y la complejidad prometida no cambian —el mejor caso sigue siendo $O(n)$ por la bandera—; sólo se hacen algunas comparaciones de más que el algoritmo ya ordenado no necesita. Se mantiene así por legibilidad, igual que en **Groovy**.

**EN:** The pseudocode shortens the pass with `for j = 0 to n - 2 - i`, whereas `bubblePass` always walks the whole list. The observable behaviour and the promised complexity are unchanged —the best case is still $O(n)$ thanks to the flag—; it only performs a few extra comparisons the sorted algorithm does not need. It is kept this way for readability, as in **Groovy**.

### 🔀 Estabilidad e inserción desde la cola / Stability and tail-first insertion

**ES:** `insert` desplaza mientras `x <= y` es falso, es decir, inserta antes del primer elemento estrictamente mayor; un elemento igual no desplaza al ya colocado, así que la ordenación es **estable**. La recursión avanza desde el final de la lista (`insertionSort (x:xs) = insert x (insertionSort xs)`) en lugar de acumular un prefijo ordenado de izquierda a derecha como el pseudocódigo: el resultado y la complejidad son los mismos, y es la dirección natural para una lista enlazada.

**EN:** `insert` shifts while `x <= y` is false, that is, it inserts before the first strictly greater element; an equal element does not displace the one already placed, so the sort is **stable**. The recursion advances from the end of the list (`insertionSort (x:xs) = insert x (insertionSort xs)`) instead of accumulating a sorted left-to-right prefix as the pseudocode does: the result and the complexity are the same, and it is the natural direction for a linked list.

### ➕ `pickMin` fusiona buscar y extraer / `pickMin` fuses lookup and extraction

**ES:** El pseudocódigo dedica el bucle interno a localizar `min_idx` y luego intercambia. Aquí `pickMin :: [Int] -> (Int, [Int])` recorre la lista una sola vez con un acumulador `acc` y devuelve a la vez el mínimo y el resto ya sin él, de modo que `selectionSort` no necesita un segundo recorrido para eliminar el elemento extraído. La guarda `pickMin [] = error ...` es **inalcanzable desde la API exportada**, porque `selectionSort` resuelve antes los casos `[]` y `[x]`; ninguna de las tres funciones del contrato lanza excepciones.

**EN:** The pseudocode spends its inner loop locating `min_idx` and then swaps. Here `pickMin :: [Int] -> (Int, [Int])` walks the list once with an `acc` accumulator and returns both the minimum and the remainder without it, so `selectionSort` needs no second traversal to remove the extracted element. The `pickMin [] = error ...` guard is **unreachable from the exported API**, because `selectionSort` matches the `[]` and `[x]` cases first; none of the three contract functions throws exceptions.

### 🏷️ Naming y visibilidad / Naming and visibility

**ES:** La especificación nombra las funciones en `snake_case` (`selection_sort`); Haskell usa `camelCase`, así que la API es `selectionSort`, `bubbleSort` e `insertionSort`. El módulo exporta sólo esas tres; `pickMin`, `bubblePass` e `insert` se declaran sin exportar y por tanto son privados al módulo, igual que en `numbers/`.

**EN:** The specification names the functions in `snake_case` (`selection_sort`); Haskell uses `camelCase`, so the API is `selectionSort`, `bubbleSort` and `insertionSort`. The module exports only those three; `pickMin`, `bubblePass` and `insert` are declared without exporting and are therefore private to the module, as in `numbers/`.

### 🧪 Estructura de los tests / Test structure

**ES:** La suite `NaiveSortSpec` es un `Spec` de Hspec con el mismo patrón que los demás lenguajes:

- **Constantes con nombre** para cada entrada y salida esperada (`standardInput`, `standardOutput`, `reverseInput`, …), sin duplicar literales.
- Una **tabla de casos** (`cases :: [(String, [Int], [Int])]`) con descripción, entrada y salida esperada.
- Un **helper compartido** `assertSortsAllCases :: ([Int] -> [Int]) -> String -> Spec` que recibe la función a probar y el nombre del algoritmo, y genera un ejemplo por caso con la descripción `"{algorithm} should sort {description}"`.
- **Un bloque por función** del contrato: `describe "selection_sort" $ assertSortsAllCases selectionSort "selection_sort"`, y lo mismo para `bubble_sort` e `insertion_sort`.
- La aserción es `shouldBe`, de modo que un fallo muestra la entrada y el valor obtenido frente al esperado.

**EN:** The `NaiveSortSpec` suite is an Hspec `Spec` following the same pattern as the other languages:

- **Named constants** for every input and expected output (`standardInput`, `standardOutput`, `reverseInput`, …), with no duplicated literals.
- A **case table** (`cases :: [(String, [Int], [Int])]`) with description, input and expected output.
- A **shared helper** `assertSortsAllCases :: ([Int] -> [Int]) -> String -> Spec` that receives the function under test and the algorithm name, and generates one example per case with the description `"{algorithm} should sort {description}"`.
- **One block per contract function**: `describe "selection_sort" $ assertSortsAllCases selectionSort "selection_sort"`, and likewise for `bubble_sort` and `insertion_sort`.
- The assertion is `shouldBe`, so a failure shows the input and the obtained value against the expected one.

### 📍 Desviaciones respecto a la ubicación esperada / Deviations from the expected location

| Especificación | Implementación | Motivo |
|----------------|----------------|--------|
| `src/naive_sort.ext` | `lib/NaiveSort.hs` | `cabal init --lib` usa `lib/` por defecto y el módulo se nombra en `PascalCase`, igual que `Numbers.hs` en `numbers/`. |
| `test/naive_sort_test.ext` | `test/NaiveSortSpec.hs` | Convención de Cabal/Hspec del repositorio: el directorio es `test/` y el sufijo de las suites es `Spec`, como `RecursiveSpec.hs`. |
| `test/run_tests.ext` | `test/RunTests.hs` | El punto de entrada existe y usa la extensión `.hs`; se declara como `main-is` del test-suite. |

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

*[← Volver a Algoritmos Puros](../README.md) · [↑ Volver a Core](../../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
