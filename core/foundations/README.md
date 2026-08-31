# 🚀 Foundations — Haskell

Implementaciones de la [Fase 0 — Fundamentos](https://yorche3.github.io/programming_languages/ROADMAP/#fase-0--fundamentos--foundations--completada) en **Haskell**: `helloworld`, `hellouser`, `unit_test/calculator` y `numbers`.

---

## 📁 Estructura / Structure

```text
foundations/
├── helloworld/                # 01_Hello_World — manual (archivo autocontenido)
│   ├── HelloWorld.hs
│   └── README.md
├── hellouser/                 # 02_Hello_User — manual (archivo autocontenido)
│   ├── hellouser.hs
│   └── README.md
├── unit_test/
│   └── calculator/            # 03_Unit_Test_Calculator — lib + tests (Cabal + Hspec)
│       ├── src/
│       ├── test/
│       ├── calculator.cabal
│       └── README.md
└── numbers/                   # 04_Numbers — lib + tests (Cabal + Hspec)
    ├── lib/
    ├── test/
    ├── numbers.cabal
    └── README.md
```

---

## 📖 Módulos / Modules

| Módulo | Especificación | Enfoque | Estado |
|--------|---------------|---------|--------|
| `helloworld` | [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) | Manual (`.hs` autocontenido, sin build tool) | ✅ |
| `hellouser` | [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) | Manual (`.hs` autocontenido, sin build tool) | ✅ |
| `unit_test/calculator` | [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) | Cabal (`library` + `test-suite`) + Hspec | ✅ |
| `numbers` | [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) | Cabal (`library` + `test-suite`) + Hspec | ✅ |

> **ES:** `helloworld` y `hellouser` no usan Cabal: son scripts `.hs` autocontenidos ejecutables con `runghc`, sin dependencias externas. `calculator` y `numbers` sí usan Cabal, con el código fuente en `src/`/`lib/` y las pruebas en `test/` como componentes separados del `.cabal`.
> **EN:** `helloworld` and `hellouser` don't use Cabal: they are self-contained `.hs` scripts runnable with `runghc`, with no external dependencies. `calculator` and `numbers` do use Cabal, with source code in `src/`/`lib/` and tests in `test/` as separate components of the `.cabal` file.

---

## ▶️ Siguiente / Next

👉 Después de fundamentos, continúa con [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-).
👉 After foundations, continue with [Phase 1 — Algorithms Pure](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-).

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*[← Volver a Haskell](../../README.md)*
