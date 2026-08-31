# Calculator — Haskell

Implementación de la especificación [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) en **Haskell**, construida con **Cabal** y probada con **Hspec**.

Implementa 5 operaciones aritméticas (`addition`, `subtraction`, `multiplication`, `division`, `modulus`) usando únicamente `+` y `-` como operaciones primitivas.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`calculator.cabal`](calculator.cabal) | Manifiesto del paquete — define la librería y el test-suite. |
| [`src/Calculator.hs`](src/Calculator.hs) | Implementación de las 5 operaciones aritméticas. |
| [`test/Spec.hs`](test/Spec.hs) | Suite de tests con Hspec (5 tests). |
| [`CHANGELOG.md`](CHANGELOG.md) | Historial de cambios del paquete. |
| [`LICENSE`](LICENSE) | Texto de la licencia (GPL-3.0). |

**Estructura de directorios esperada:**

```text
calculator/
├── calculator.cabal              # Manifiesto del paquete Cabal
├── src/
│   └── Calculator.hs             # Módulo Calculator: 5 operaciones aritméticas
├── test/
│   └── Spec.hs                   # 5 tests con Hspec
├── CHANGELOG.md                  # Historial de cambios
├── LICENSE                       # Licencia GPL-3.0
├── README.md                     # Este archivo
└── dist-newstyle/                # Artefactos de compilación (generado por cabal)
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa **Cabal** como sistema de construcción y **Hspec** como framework de tests. Sigue la convención estándar de la comunidad Haskell: el código de la librería vive en `src/` (no `lib/`), el módulo principal se llama igual que el paquete (`Calculator`) y el test-suite se declara como componente separado en el `.cabal`.

Características:
- **5 operaciones**: `addition`, `subtraction`, `multiplication`, `division`, `modulus`.
- **Implementación minimalista**: `multiplication`, `division` y `modulus` se construyen usando solo `+` y `-` como operaciones primitivas, sin usar `*`, `/` ni `%`.
- **Recursión con acumulador**: los bucles se implementan con funciones locales `loop` (en cláusulas `where`) que acumulan el resultado mediante recursión, evitando la mutación de estado.
- **Framework de tests**: `hspec` — el framework de testing más usado en la comunidad Haskell.

**EN:** This project uses **Cabal** as the build system and **Hspec** as the test framework. It follows the standard Haskell community convention: library code lives in `src/` (not `lib/`), the main module is named after the package (`Calculator`), and the test suite is declared as a separate component in the `.cabal` file.

Features:
- **5 operations**: `addition`, `subtraction`, `multiplication`, `division`, `modulus`.
- **Minimalist implementation**: `multiplication`, `division` and `modulus` are built using only `+` and `-` as primitive operations, without using `*`, `/` or `%`.
- **Recursion with accumulator**: loops are implemented with local `loop` functions (in `where` clauses) that accumulate the result via recursion, avoiding state mutation.
- **Test framework**: `hspec` — the most widely used test framework in the Haskell community.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `calculator.cabal` — Manifiesto del paquete

**ES:** Define el paquete `calculator` con dos componentes: una `library` (que expone el módulo `Calculator` desde `src/`) y un `test-suite` (`calculator-test`, que ejecuta `test/Spec.hs` y depende de la librería y de `hspec`).

**EN:** Defines the `calculator` package with two components: a `library` (exposing the `Calculator` module from `src/`) and a `test-suite` (`calculator-test`, which runs `test/Spec.hs` and depends on the library and `hspec`).

```cabal
name:               calculator
version:            0.1.0.0
license:            GPL-3.0-only
build-type:         Simple

library
    exposed-modules:  Calculator
    hs-source-dirs:   src
    build-depends:    base ^>=4.20.2.0
    default-language: Haskell2010

test-suite calculator-test
    type:             exitcode-stdio-1.0
    main-is:          Spec.hs
    hs-source-dirs:   test
    build-depends:
        base ^>=4.20.2.0,
        calculator,
        hspec
    default-language: Haskell2010
```

| Elemento | Propósito |
|----------|-----------|
| `library` | Componente de librería — compila `src/` y expone `Calculator`. |
| `exposed-modules` | Módulos visibles para quien dependa del paquete. |
| `hs-source-dirs` | Directorio(s) donde Cabal busca los módulos. |
| `test-suite` | Componente de tests — compila y ejecuta `test/Spec.hs`. |
| `main-is: Spec.hs` | Punto de entrada del test-suite (módulo `Main`). |
| `build-depends` | Dependencias de cada componente (`base`, `calculator`, `hspec`). |

### `src/Calculator.hs` — Implementación

**ES:** Las 5 operaciones como funciones del módulo `Calculator`. Cada una lleva su firma de tipos explícita. `multiplication` y `division` usan una función local recursiva `loop` con acumulador, y `modulus` reutiliza ambas.

**EN:** The 5 operations as functions of the `Calculator` module. Each carries an explicit type signature. `multiplication` and `division` use a local recursive `loop` function with an accumulator, and `modulus` reuses both.

```haskell
module Calculator (addition, subtraction, multiplication, division, modulus) where

addition :: Int -> Int -> Int
addition a b = a + b

subtraction :: Int -> Int -> Int
subtraction a b = a - b

multiplication :: Int -> Int -> Int
multiplication a b = loop 0 b
  where
    loop acc count
      | count <= 0 = acc
      | otherwise = loop (addition acc a) (subtraction count 1)

division :: Int -> Int -> Int
division a b = loop a 0
  where
    loop remaining quotient
      | remaining < b = quotient
      | otherwise = loop (subtraction remaining b) (addition quotient 1)

modulus :: Int -> Int -> Int
modulus a b = subtraction a (multiplication b (division a b))
```

| Elemento | Propósito |
|----------|-----------|
| `module Calculator (...) where` | Declara el módulo y las funciones exportadas. |
| `addition :: Int -> Int -> Int` | Firma de tipo explícita (dos `Int` de entrada, uno de salida). |
| `loop acc count` | Función local recursiva (en `where`) que acumula el resultado. |
| `\| count <= 0 = acc` | Guard: caso base que detiene la recursión. |
| `modulus a b` | Reutiliza `division` y `multiplication` para obtener el residuo. |

> **ES:** Haskell no tiene bucles `for`/`while`: toda iteración se expresa con recursión. Las funciones `loop` están en cláusulas `where`, por lo que son locales a cada operación y no se exportan.
> **EN:** Haskell has no `for`/`while` loops: all iteration is expressed via recursion. The `loop` functions live in `where` clauses, so they are local to each operation and are not exported.

### `test/Spec.hs` — Pruebas Hspec

**ES:** 5 tests con Hspec. El bloque `describe` agrupa los ejemplos y `it ... `shouldBe`` define cada aserción.

**EN:** 5 tests with Hspec. The `describe` block groups the examples and `it ... `shouldBe`` defines each assertion.

```haskell
module Main (main) where

import Calculator
import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "Calculator" $ do
    it "addition" $ addition 2 3 `shouldBe` 5
    it "subtraction" $ subtraction 5 3 `shouldBe` 2
    it "multiplication" $ multiplication 4 3 `shouldBe` 12
    it "division" $ division 10 3 `shouldBe` 3
    it "modulus" $ modulus 10 3 `shouldBe` 1
```

| Elemento | Propósito |
|----------|-----------|
| `import Calculator` | Importa el módulo a testear. |
| `import Test.Hspec` | Importa el framework Hspec. |
| `hspec $ do ...` | Punto de entrada: ejecuta la suite. |
| `describe "Calculator"` | Agrupa los tests bajo un nombre común. |
| `it "addition" $ ...` | Define un ejemplo de test con su descripción. |
| `` `shouldBe` `` | Aserción de igualdad de Hspec (expected `shouldBe` actual). |

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener GHC y Cabal instalados (vía GHCup)

```bash
# GHCup (instala GHC + cabal-install + HLS)
# https://www.haskell.org/ghcup/
ghc --version
cabal --version
```

### Compilar / Build

```bash
cd core/foundations/unit_test/calculator
cabal build
```

### Ejecutar pruebas / Run tests

```bash
cabal test
```

**Salida esperada / Expected output:**

```text
Calculator
  addition [✔]
  subtraction [✔]
  multiplication [✔]
  division [✔]
  modulus [✔]

Finished in 0.0002 seconds
5 examples, 0 failures
Test suite calculator-test: PASS
```

### Abrir el REPL / Open the REPL

```bash
cabal repl
```

```haskell
import Calculator
addition 2 3
-- 5
```

---

## 🧠 Algoritmos / operaciones

| Operación | Implementación | Primitivas usadas |
|-----------|---------------|-------------------|
| `addition(a, b)` | `a + b` | `+` |
| `subtraction(a, b)` | `a - b` | `-` |
| `multiplication(a, b)` | Suma repetitiva de `a`, `b` veces | `+`, `-` |
| `division(a, b)` | Resta repetitiva, cuenta cociente | `+`, `-` |
| `modulus(a, b)` | `a - (cociente * b)` | `+`, `-` |

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Haskell es un lenguaje **puro y perezoso** (lazy): las expresiones se evalúan solo cuando se necesitan. La iteración se expresa con recursión, no con bucles imperativos.
- **EN:** Haskell is a **pure and lazy** language: expressions are evaluated only when needed. Iteration is expressed via recursion, not imperative loops.
- **ES:** Las funciones `loop` usan **estilo acumulador** (tail recursion): la llamada recursiva es la última acción, pasando el estado acumulado como parámetro. GHC optimiza estas llamadas de cola.
- **EN:** The `loop` functions use the **accumulator style** (tail recursion): the recursive call is the last action, passing the accumulated state as a parameter. GHC optimizes these tail calls.
- **ES:** Las firmas de tipo (`:: Int -> Int -> Int`) son explícitas, una buena práctica en Haskell para documentar la API y facilitar la inferencia de errores.
- **EN:** Type signatures (`:: Int -> Int -> Int`) are explicit, a Haskell best practice to document the API and improve error messages.
- **ES:** `multiplication` y `division` solo manejan enteros no negativos (`Int`), siguiendo el enunciado del módulo; no hay manejo de división por cero.
- **EN:** `multiplication` and `division` only handle non-negative integers (`Int`), following the module statement; there is no division-by-zero handling.
- **ES:** El paquete usa `src/` en lugar de `lib/`, la convención mayoritaria en Hackage/Stackage, y el módulo se llama `Calculator` en lugar del `MyLib` que genera `cabal init` por defecto.
- **EN:** The package uses `src/` instead of `lib/`, the predominant convention on Hackage/Stackage, and the module is named `Calculator` instead of the `MyLib` that `cabal init` generates by default.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
