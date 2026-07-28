# Hello User — Haskell

Implementación de la especificación [Hello, User!](https://github.com/yorche3/programming_languages) en **Haskell**, con un enfoque manual y minimalista.

---

## 📂 Archivos y estructura / Files & Structure

El proyecto consiste en un único archivo fuente, sin configuración de build ni dependencias externas.

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| `hellouser.hs`  | Código fuente que solicita el nombre y saluda. |

**Estructura de directorios esperada:**

```text
haskell/
└── core/
    └── foundations/
        └── hellouser/
            └── hellouser.hs
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
   mkdir -p haskell/core/foundations/hellouser
   ```

2. Escribir el archivo `hellouser.hs` con el código fuente.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build (como `*.cabal` o `stack.yaml`). El script es un programa Haskell autocontenido.

Si se desea ignorar artefactos de compilación, se puede agregar un `.gitignore` con:

```gitignore
*.hi
*.o
*.exe
```

---

## 🚀 Compilación y ejecución / Build & Run

### Ejecutar programa principal / Run main program

```bash
runghc hellouser.hs
```

Al ejecutarlo, el programa pedirá un nombre y responderá con el saludo.

Si se prefiere compilar a un ejecutable nativo y luego ejecutar:

```bash
ghc -o hellouser hellouser.hs
./hellouser
```

### Salida esperada / Expected output:

```text
Enter your name:
(usuario escribe "Ada")
Hello, Ada!
```

---

## 📝 Notas de implementación / Implementation Notes

### Manejo de entrada/salida / Input/Output handling

**ES:** El programa utiliza `do`-notation para secuenciar acciones de entrada/salida. `putStrLn` imprime una cadena con salto de línea, y `getLine` lee una línea completa desde la entrada estándar. El resultado se captura con la flecha `<-` dentro del bloque `do`, permitiendo usar el nombre ingresado en la concatenación final.

**EN:** The program uses `do`-notation to sequence input/output actions. `putStrLn` prints a string with a newline, and `getLine` reads a full line from standard input. The result is captured with the arrow `<-` inside the `do` block, allowing the entered name to be used in the final concatenation.

### Paradigma funcional puro / Pure functional paradigm

**ES:** Aunque el programa interactúa con el mundo exterior (lectura y escritura), las acciones están encapsuladas en el tipo `IO`. La lógica de concatenación `"Hello, " ++ name ++ "!"` es pura y podría probarse de forma aislada. Esta separación entre lógica pura y efectos sigue el diseño típico de Haskell.

**EN:** Although the program interacts with the outside world (reading and writing), the actions are encapsulated in the `IO` type. The concatenation logic `"Hello, " ++ name ++ "!"` is pure and could be tested in isolation. This separation between pure logic and effects follows typical Haskell design.

---

Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para ver todas las versiones.

🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)