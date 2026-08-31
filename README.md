# Haskell

Proyectos en **Haskell**, ejecutados con **GHC** (instalado vía **GHCup**). Para scripts simples se usa `runghc` directamente; para proyectos con pruebas unitarias se usa **Cabal** como sistema de construcción y **Hspec** como framework de testing.

---

## 📦 Requisitos / Requirements

| Herramienta | Instalación |
|-------------|-------------|
| [GHC](https://www.haskell.org/ghc/) | Incluido en GHCup — no requiere instalación separada |
| [Cabal](https://www.haskell.org/cabal/) | Incluido en GHCup — no requiere instalación separada |
| [GHCup](https://www.haskell.org/ghcup/) | `curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh` |

```bash
# Verificar instalación
ghc --version && cabal --version
```

---

## 🏗️ Tipos de proyecto / Project Types

### 1. Script simple (archivo único)

**ES:** Un único archivo fuente `.hs`, sin dependencias externas, ejecutado directamente con `runghc`. Ideal para `helloworld` y `hellouser`.

**EN:** A single `.hs` source file, no external dependencies, executed directly with `runghc`. Ideal for `helloworld` and `hellouser`.

```bash
runghc <script>.hs
```

### 2. Proyecto con pruebas unitarias (Cabal + Hspec)

**ES:** Para proyectos que requieren pruebas unitarias, se utiliza **Cabal** como sistema de construcción, con **Hspec** como framework de testing. El código de la librería vive en `src/` (o `lib/`) y las pruebas en `test/`, declaradas como componentes separados en el archivo `.cabal`.

**EN:** For projects that require unit tests, **Cabal** is used as the build system with **Hspec** as the testing framework. Library code lives in `src/` (or `lib/`) and tests in `test/`, declared as separate components in the `.cabal` file.

```bash
cabal test
```

---

## 📂 Módulos / Modules

| Módulo | Descripción |
|--------|-------------|
| [`core/foundations/`](core/foundations/) | **Fase 0 — Fundamentos**: `helloworld`, `hellouser`, `unit_test/calculator`, `numbers` |

---

### ▶️ Comenzar / Getting Started

```bash
# Hello, World!
cd core/foundations/helloworld
runghc HelloWorld.hs

# Hello, User!
cd core/foundations/hellouser
runghc hellouser.hs

# Calculator Tests
cd core/foundations/unit_test/calculator
cabal test

# Numbers Tests
cd core/foundations/numbers
cabal test
```

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*