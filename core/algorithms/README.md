# Algorithms Pure — Haskell

Implementaciones de la [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-) en **Haskell**: ordenamientos elementales, estructuras de datos propias, ordenamientos óptimos y distribuidos, y búsqueda.

Los módulos de esta fase trabajan sobre listas **inmutables** (`[Int]`): ninguna función ordena *in-place*, todas devuelven una lista nueva.

---

## 📂 Módulos / Modules

| Módulo | Especificación | Enfoque | Tests | Estado |
|--------|---------------|---------|:-----:|:------:|
| [`naive_sort/`](naive_sort/) | [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) | `cabal test` + Hspec | 21 | ✅ |

---

## 📁 Estructura / Structure

```text
algorithms/
└── naive_sort/                  # 05_Naive_Sort
    ├── naive-sort.cabal
    ├── lib/
    │   └── NaiveSort.hs         # selectionSort, bubbleSort, insertionSort
    ├── test/
    │   ├── NaiveSortSpec.hs     # 3 bloques × 7 casos = 21 ejemplos
    │   └── RunTests.hs          # Entry point
    ├── CHANGELOG.md
    └── LICENSE
```

---

## 🛠️ Patrón común / Common Pattern

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | GHC 9.10.3 (vía GHCup) |
| **CLI** | `cabal build`, `cabal test` |
| **Manifiesto** | `{modulo}.cabal` — componentes `library` y `test-suite` |
| **Warnings** | `common warnings` con `ghc-options: -Wall`, importado por ambos componentes |
| **Framework de tests** | Hspec (`hspec ^>=2.11.0`) en `build-depends` del test-suite |
| **Entry point** | `test/RunTests.hs`, declarado como `main-is` |
| **Separación** | `lib/` (código) ↔ `test/` (specs + runner) |
| **Descubrimiento** | Manual: `RunTests.hs` compone los `Spec` de cada suite |
| **Iteración** | Recursión y *pattern matching*; listas inmutables |
| **Visibilidad** | `module ... ( ... ) where` — sólo se exportan las funciones del contrato |
| **Naming** | `camelCase` (`selectionSort`), módulos y archivos en `PascalCase` |
| **Indicador de fallo** | No aplica: `[Int]` no admite listas inválidas |
| **Artefactos** | `dist-newstyle/`, `*.o`, `*.hi` — ignorados por el `.gitignore` de la raíz de `haskell/` |

---

## 🚀 Compilación rápida / Quick Build

```bash
# Naive Sort Tests
cd naive_sort
cabal build all --enable-tests
cabal test
```

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

## ▶️ Siguiente / Next

👉 Continúa con los módulos pendientes de esta fase en el [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).
👉 Continue with the pending modules of this phase in the [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).

---

*[← Volver a Core](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
