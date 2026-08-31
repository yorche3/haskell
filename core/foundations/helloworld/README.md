# Hello World — Haskell

Implementación de la especificación [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) en **Haskell**, con un enfoque manual y minimalista.

---

## 📂 Archivos y estructura / Files & Structure

El proyecto consiste en un único archivo fuente, sin configuración de build ni dependencias externas.

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| `HelloWorld.hs`  | Código fuente principal que imprime el saludo. |

**Estructura de directorios esperada:**

```text
haskell/
└── core/
    └── foundations/
        └── helloworld/
            └── HelloWorld.hs
```

No se requieren directorios adicionales de compilación, pruebas ni archivos de proyecto.  
El archivo `.hs` es autocontenido y puede ejecutarse directamente con `runghc` o compilarse con GHC.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente, sin herramientas de scaffolding (como `cabal init` o `stack new`), para controlar cada detalle y mantener la máxima sencillez.

**EN:** The project was created manually, without scaffolding tools (like `cabal init` or `stack new`), to control every detail and maintain maximum simplicity.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p haskell/core/foundations/helloworld
   ```

2. Escribir el archivo `HelloWorld.hs` con el código fuente.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build (como `*.cabal` o `stack.yaml`) ni archivos `.gitignore` específicos, dado que Haskell puede ejecutar código fuente directamente con `runghc`.

Si se desea ignorar artefactos de compilación, se puede agregar un `.gitignore` con:

```gitignore
*.hi
*.o
*.exe
```

Sin embargo, en este módulo no se utiliza compilación previa.

---

## 🚀 Compilación y ejecución / Build & Run

### Ejecutar programa principal / Run main program

```bash
runghc HelloWorld.hs
```

Si se prefiere compilar a un ejecutable nativo y luego ejecutar:

```bash
ghc -o helloworld HelloWorld.hs
./helloworld
```

### Salida esperada / Expected output:

```text
Hello, World! from Haskell!
```

---

## 📝 Notas de implementación / Implementation Notes

### Sencillez y ejecución directa / Simplicity and direct execution

**ES:** Haskell permite ejecutar código fuente directamente con `runghc`, sin necesidad de compilar manualmente. Un programa Haskell se define mediante una función `main` que ejecuta acciones de entrada/salida (`IO`). El saludo se imprime con la función `putStrLn`, que escribe una cadena seguida de un salto de línea en la salida estándar. Esta simplicidad hace que un _"Hello, World!"_ en Haskell sea conciso y fácil de probar.

**EN:** Haskell allows running source code directly with `runghc`, without the need to compile manually. A Haskell program is defined by a `main` function that executes input/output actions (`IO`). The greeting is printed with the `putStrLn` function, which writes a string followed by a newline to standard output. This simplicity makes a _"Hello, World!"_ in Haskell concise and easy to test.

### Paradigma funcional puro / Pure functional paradigm

**ES:** Haskell es un lenguaje funcional puro, lo que significa que las funciones no tienen efectos secundarios observables. Sin embargo, el saludo por pantalla es un efecto secundario necesario; por eso `putStrLn` devuelve un valor de tipo `IO ()`, encapsulando la acción de escritura dentro del sistema de tipos. Esto permite separar las partes puras (cálculos) de las impuras (entrada/salida), una característica distintiva de Haskell.

**EN:** Haskell is a purely functional language, meaning that functions have no observable side effects. However, printing to the screen is a necessary side effect; that is why `putStrLn` returns a value of type `IO ()`, encapsulating the writing action within the type system. This allows separating pure parts (computations) from impure ones (input/output), a distinctive feature of Haskell.

---

Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para ver todas las versiones.

🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)