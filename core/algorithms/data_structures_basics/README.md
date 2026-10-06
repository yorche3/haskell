# Data Structures Basics — Haskell

Implementación de la especificación [06_Data_Structures_Basics](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) en **Haskell**, con gestión de dependencias mediante **Cabal** y el framework de pruebas **HUnit**.

Cuatro estructuras de datos construidas desde cero sobre un único tipo `Node` compartido: **Node** (celda enlazada), **LinkedList** (lista enlazada con punteros a cabeza y cola), **Stack** (pila LIFO) y **Queue** (cola FIFO). Cada ADT gestiona independientemente sus punteros y contador; no hay delegación de unas estructuras en otras ni uso de colecciones de la biblioteca estándar.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| `src/DataStructuresBasics.hs` | Implementación de `Node`, `LinkedList`, `Stack` y `Queue` sobre el mismo tipo de celda enlazada. |
| `test/DataStructuresBasicsSpec.hs` | Suite de pruebas: 15 casos que cubren los pasos de la especificación para cada estructura. |
| `test/RunTests.hs` | Punto de entrada que ejecuta la suite. |
| `data-structures-basics.cabal` | Configuración del paquete Cabal y dependencias. |
| `CHANGELOG.md` | Registro de cambios. |
| `dist-newstyle/` | Artefactos de compilación (ignorado en `.gitignore`). |

Con relación a la implementación base en **Ada**, que separa especificación (`data_structures_basics.ads`) e implementación (`data_structures_basics.adb`), Haskell reúne contrato y código en un único archivo. Haskell usa **Cabal** como gestor de paquetes y **HUnit** como framework de pruebas, así que no hace falta un `Makefile` ni un framework personalizado.

**Estructura de directorios esperada:**

```text
data_structures_basics/              # Módulo Haskell
├── src/
│   └── DataStructuresBasics.hs      # Node, LinkedList, Stack, Queue
├── test/
│   ├── DataStructuresBasicsSpec.hs  # 15 casos × pasos de la especificación
│   └── RunTests.hs                  # Punto de entrada
├── data-structures-basics.cabal     # Configuración del paquete
├── CHANGELOG.md                     # Registro de cambios
└── README.md                        # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó con `cabal init`, que genera la estructura básica y el archivo `.cabal`. A diferencia de **Go** (que usa `go mod init`), Cabal requiere un archivo de configuración explícito con las dependencias y los puntos de entrada.

**EN:** The project was created with `cabal init`, which generates the basic structure and the `.cabal` file. Unlike **Go** (which uses `go mod init`), Cabal requires an explicit configuration file with dependencies and entry points.

### Inicialización / Initialization

```bash
# 1. Inicializar el paquete / Initialize the package
cabal init

# 2. Agregar HUnit como dependencia de prueba / Add HUnit as test dependency
# (editar data-structures-basics.cabal y agregar: test-suite data-structures-basics-test
#  build-depends: base, HUnit, data-structures-basics)
```

---

## 📄 Configuración clave / Key Configuration

| Archivo / File | Propósito / Purpose |
|----------------|---------------------|
| `data-structures-basics.cabal` | Declara el paquete, versión (0.1.0.0), dependencias (`base`, `HUnit`) y puntos de entrada (`src/`, `test/`). |
| `CHANGELOG.md` | Registro de cambios del paquete. |

No se usan archivos de configuración adicionales. El código fuente vive en `src/` (módulo `DataStructuresBasics`) y las pruebas en `test/` (módulos `DataStructuresBasicsSpec` y `RunTests`).

---

## 🚀 Compilación y ejecución / Build & Run

```bash
# Compilar el paquete / Build the package
cabal build

# Ejecutar las pruebas / Run tests
cabal test
```

**Salida real / Actual output:**

```text
Build profile: -w ghc-9.10.3 -O1
In order, the following will be built (use -v for more details):
 - data-structures-basics-0.1.0.0 (lib) (configuration changed)
 - data-structures-basics-0.1.0.0 (test:data-structures-basics-test) (configuration changed)
Configuring library for data-structures-basics-0.1.0.0...
Preprocessing library for data-structures-basics-0.1.0.0...
Building library for data-structures-basics-0.1.0.0...
Configuring test suite 'data-structures-basics-test' for data-structures-basics-0.1.0.0...
Preprocessing test suite 'data-structures-basics-test' for data-structures-basics-0.1.0.0...
Building test suite 'data-structures-basics-test' for data-structures-basics-0.1.0.0...
Running 1 test suites...
Test suite data-structures-basics-test: RUNNING...

Node
  initialize and observe value/link
    get_value should return 10 [✔]
    get_next should be absent [✔]
  initialize another node, link and traverse
    get_value(get_next(a)) should return 20 [✔]
    the next of b should be absent [✔]
linked_list
  empty state
    is_empty should return True [✔]
    size should return 0 [✔]
    get_head should return -1 [✔]
  insert at both ends
    size should return 4 [✔]
    get_head should return 5 [✔]
  delete first occurrence
    delete(10) should report success [✔]
    get_head should still return 5 [✔]
    size should return 3 [✔]
  absent value
    delete(99) should report failure [✔]
    get_head should not change (5) [✔]
    size should not change (3) [✔]
  empty the list
    delete(5) should report success [✔]
    delete(20) should report success [✔]
    delete(10) should report success [✔]
    is_empty should return True [✔]
    size should return 0 [✔]
    get_head should return -1 [✔]
stack
  empty state and failed removal
    is_empty should return True [✔]
    size should return 0 [✔]
    peek should return -1 [✔]
    pop should return -1 [✔]
    the stack should stay empty after the failed pop [✔]
  LIFO and non-mutating peek
    peek should return 30 [✔]
    size should return 3 [✔]
  removal and reuse
    the first pop should return 30 [✔]
    the second pop should return 40 [✔]
    the third pop should return 20 [✔]
    the fourth pop should return 10 [✔]
    is_empty should return True [✔]
    size should return 0 [✔]
  empty after removal
    pop should return -1 [✔]
    is_empty should stay True [✔]
queue
  empty state and failed removal
    is_empty should return True [✔]
    size should return 0 [✔]
    peek should return -1 [✔]
    dequeue should return -1 [✔]
    the queue should stay empty after the failed dequeue [✔]
  FIFO and non-mutating peek
    peek should return 10 [✔]
    size should return 3 [✔]
  removal and reuse
    the first dequeue should return 10 [✔]
    the second dequeue should return 20 [✔]
    the third dequeue should return 30 [✔]
    the fourth dequeue should return 40 [✔]
    is_empty should return True [✔]
    size should return 0 [✔]
  empty after removal
    dequeue should return -1 [✔]
    is_empty should stay True [✔]

Finished in 0.0025 seconds
51 examples, 0 failures
Test suite data-structures-basics-test: PASS
Test suite logged to:
~/programming_languages/haskell/core/algorithms/data_structures_basics/./dist-newstyle/build/x86_64-linux/ghc-9.10.3/data-structures-basics-0.1.0.0/t/data-structures-basics-test/test/data-structures-basics-0.1.0.0-data-structures-basics-test.log
1 of 1 test suites (1 of 1 test cases) passed.
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

### Node

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `newNode :: Int -> Node` | `Int → Node` | `O(1)` | Crea un nodo con valor `v` y enlace `Nothing`. Equivalente a `init(value)`. |
| `nodeWithNext :: Node -> Node -> Node` | `Node, Node → Node` | `O(1)` | Devuelve un nodo nuevo enlazado con `next`. Equivalente a `set_next(next)`. |

### LinkedList

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `newLinkedList :: LinkedList` | `→ LinkedList` | `O(1)` | Lista vacía: `llHead=Nothing`, `llTail=Nothing`, `llCount=0`. Equivalente a `init()`. |
| `linkedListHead :: LinkedList -> Int` | `LinkedList → Int` | `O(1)` | Devuelve el valor de la cabeza o `-1` si la lista está vacía. Equivalente a `get_head()`. |
| `linkedListInsertHead :: Int -> LinkedList -> LinkedList` | `Int, LinkedList → LinkedList` | `O(1)` | Inserta al principio. Equivalente a `insert_head(value)`. |
| `linkedListInsertTail :: Int -> LinkedList -> LinkedList` | `Int, LinkedList → LinkedList` | `O(n)` | Inserta al final. Equivalente a `insert_tail(value)`. **Adaptación**: Haskell es inmutable, así que se reconstruye el camino hasta la cola. |
| `linkedListDelete :: Int -> LinkedList -> (Bool, LinkedList)` | `Int, LinkedList → (Bool, LinkedList)` | `O(n)` | Elimina la primera aparición de `value`. Devuelve `(True, lista)` si lo eliminó, `(False, misma lista)` si no está. Equivalente a `delete(value)`. |
| `linkedListIsEmpty :: LinkedList -> Bool` | `LinkedList → Bool` | `O(1)` | Devuelve `True` si la lista está vacía. Equivalente a `is_empty()`. |
| `linkedListSize :: LinkedList -> Int` | `LinkedList → Int` | `O(1)` | Devuelve el número de nodos. Equivalente a `size()`. |

### Stack

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `newStack :: Stack` | `→ Stack` | `O(1)` | Pila vacía: `stTop=Nothing`, `stCount=0`. Equivalente a `init()`. |
| `stackPush :: Int -> Stack -> Stack` | `Int, Stack → Stack` | `O(1)` | Apila un valor. Equivalente a `push(value)`. |
| `stackPop :: Stack -> (Int, Stack)` | `Stack → (Int, Stack)` | `O(1)` | Desapila y devuelve `(valor, pila)`; si la pila está vacía, `(-1, misma pila)`. Equivalente a `pop()`. |
| `stackPeek :: Stack -> Int` | `Stack → Int` | `O(1)` | Devuelve el tope sin extraerlo, o `-1` si la pila está vacía. Equivalente a `peek()`. |
| `stackIsEmpty :: Stack -> Bool` | `Stack → Bool` | `O(1)` | Devuelve `True` si la pila está vacía. Equivalente a `is_empty()`. |
| `stackSize :: Stack -> Int` | `Stack → Int` | `O(1)` | Devuelve el número de elementos. Equivalente a `size()`. |

### Queue

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `newQueue :: Queue` | `→ Queue` | `O(1)` | Cola vacía: `qFront=Nothing`, `qRear=Nothing`, `qCount=0`. Equivalente a `init()`. |
| `queueEnqueue :: Int -> Queue -> Queue` | `Int, Queue → Queue` | `O(n)` | Encola un valor al final. Equivalente a `enqueue(value)`. **Adaptación**: Haskell es inmutable, así que se reconstruye el camino hasta el `rear`. |
| `queueDequeue :: Queue -> (Int, Queue)` | `Queue → (Int, Queue)` | `O(1)` | Desencola y devuelve `(valor, cola)`; si la cola está vacía, `(-1, misma cola)`. Equivalente a `dequeue()`. |
| `queuePeek :: Queue -> Int` | `Queue → Int` | `O(1)` | Devuelve el frente sin extraerlo, o `-1` si la cola está vacía. Equivalente a `peek()`. |
| `queueIsEmpty :: Queue -> Bool` | `Queue → Bool` | `O(1)` | Devuelve `True` si la cola está vacía. Equivalente a `is_empty()`. |
| `queueSize :: Queue -> Int` | `Queue → Int` | `O(1)` | Devuelve el número de elementos. Equivalente a `size()`. |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Un único tipo `Node` compartido por las tres estructuras | Tipos de nodo separados para cada ADT | La especificación exige un único `Node` compartido; cada ADT gestiona sus propios punteros (`llHead`/`llTail`, `stTop`, `qFront`/`qRear`) y contador. |
| Funciones puras que devuelven valores nuevos | Mutación de la instancia recibida | Haskell es inmutable; no hay mutación de estado. Cada operación devuelve una estructura nueva con los cambios. |
| `Maybe Node` para representar la ausencia de enlace | Usar `-1` o un centinela | Haskell tiene tipos algebraicos; `Maybe Node` con `Just node` y `Nothing` es la representación idiomática de ausencia. |
| Tuplas `(Bool, LinkedList)` y `(Int, Stack/Queue)` para operaciones que extraen | Excepciones o resultados separados | Haskell no tiene excepciones para errores de negocio; las tuplas permiten devolver el valor y la estructura resultante en una sola operación, conservando la inmutabilidad. |
| Recursión para `appendNode`, `removeFirst`, `lastNode` | Iteración con acumuladores | Haskell usa recursión en lugar de bucles; la recursión de cola es segura gracias a la optimización del compilador. |
| Cabal como gestor de paquetes | Stack o GHC directamente | Cabal es el gestor de paquetes estándar de Haskell; proporciona `cabal build`, `cabal test` y gestión de dependencias. |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `init()` para inicializar cada estructura | Funciones `newLinkedList`, `newStack`, `newQueue` que devuelven la estructura vacía | Haskell es inmutable; no hay constructores ni mutación. Las funciones `new*` devuelven una nueva instancia con los campos en su estado inicial. |
| `Node.init(value)` | `newNode :: Int -> Node` | Haskell usa funciones puras en lugar de métodos de instancia. `newNode` devuelve un nuevo `Node` con el valor y el enlace ausente. |
| `get_value()`, `get_next()`, `get_head()` | `value`, `next`, `linkedListHead` | Haskell usa record syntax; los campos son funciones accesoras automáticas. `value` y `next` son funciones generadas automáticamente por el record syntax. |
| `set_next(next)` | `nodeWithNext :: Node -> Node -> Node` | Haskell es inmutable; no se puede mutar un nodo. `nodeWithNext` devuelve un nodo nuevo con el enlace actualizado usando record update syntax. |
| `delete(value)` | `linkedListDelete :: Int -> LinkedList -> (Bool, LinkedList)` | Haskell es inmutable; la función devuelve una tupla con el éxito y la lista resultante, no muta la instancia recibida. |
| `pop()`, `dequeue()` | `stackPop :: Stack -> (Int, Stack)` y `queueDequeue :: Queue -> (Int, Queue)` | Haskell es inmutable; las funciones devuelven una tupla con el valor extraído y la estructura resultante. |
| `insert_tail(value)` y `enqueue(value)` con complejidad `O(1)` | Implementación con complejidad `O(n)` | Haskell es inmutable; para insertar al final, se reconstruye el camino hasta la cola usando recursión (`appendNode`). No hay mutación en el sitio. |
| Entrada nula o inválida | No se modela explícitamente | La especificación no exige manejar entradas nulas para este módulo; las estructuras se inicializan con las funciones `new*`. |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `linkedListHead()` | Lista vacía | `-1` | `linkedListHead ll` devuelve `-1` cuando `linkedListIsEmpty ll` es `True`. |
| `stackPop()` | Pila vacía | `(-1, misma pila)` | `stackPop s` devuelve `(-1, s)` cuando `stackIsEmpty s` es `True`. |
| `stackPeek()` | Pila vacía | `-1` | `stackPeek s` devuelve `-1` cuando `stackIsEmpty s` es `True`. |
| `queueDequeue()` | Cola vacía | `(-1, misma cola)` | `queueDequeue q` devuelve `(-1, q)` cuando `queueIsEmpty q` es `True`. |
| `queuePeek()` | Cola vacía | `-1` | `queuePeek q` devuelve `-1` cuando `queueIsEmpty q` es `True`. |
| `linkedListDelete()` | Valor no está en la lista | `(False, misma lista)` | `linkedListDelete 99 l` devuelve `(False, l)` si `99` no existe en la lista. |
| `next` (campo de Node) | Enlace ausente | `Nothing` | `next node` devuelve `Nothing` cuando el nodo no tiene enlace. |

**ES:** El indicador de fallo es `-1` para operaciones que devuelven `Int`, `Nothing` para campos `Maybe Node`, y `False` para operaciones que devuelven `Bool`. Haskell tiene tipos algebraicos; `Maybe` con `Just value` y `Nothing` es la representación idiomática de ausencia.

**EN:** The failure indicator is `-1` for operations returning `Int`, `Nothing` for `Maybe Node` fields, and `False` for operations returning `Bool`. Haskell has algebraic types; `Maybe` with `Just value` and `Nothing` is the idiomatic representation of absence.

---

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| **Node**: Inicializar y observar valor/enlace | Sí | `Node/initialize and observe value/link` | Crea `a` con `newNode 10`, verifica `value a = 10` y `next a = Nothing`. |
| **Node**: Inicializar otro nodo, enlazar y recorrer | Sí | `Node/initialize another node, link and traverse` | Crea `b` con `newNode 20`, enlaza `a→b`, verifica `value (fromJust (next a)) = 20` y `next b = Nothing`. |
| **LinkedList**: Estado vacío | Sí | `linked_list/empty state` | Verifica `linkedListIsEmpty = True`, `linkedListSize = 0`, `linkedListHead = -1`. |
| **LinkedList**: Insertar por ambos extremos | Sí | `linked_list/insert at both ends` | Inserta `10, 20` al final y `5` al principio; verifica `linkedListSize = 4`, `linkedListHead = 5`. |
| **LinkedList**: Eliminar primera aparición | Sí | `linked_list/delete first occurrence` | Elimina `10` (primera aparición); verifica `delete = True`, `linkedListHead = 5`, `linkedListSize = 3`. |
| **LinkedList**: Valor ausente | Sí | `linked_list/absent value` | Intenta eliminar `99`; verifica `delete = False`, `linkedListHead = 5`, `linkedListSize = 3`. |
| **LinkedList**: Vaciar | Sí | `linked_list/empty the list` | Elimina `5, 20, 10`; verifica `linkedListIsEmpty = True`, `linkedListSize = 0`, `linkedListHead = -1`. |
| **Stack**: Estado vacío y extracción fallida | Sí | `stack/empty state and failed removal` | Verifica `stackIsEmpty = True`, `stackSize = 0`, `stackPeek = -1`, `stackPop = -1`. |
| **Stack**: LIFO y `peek` no mutante | Sí | `stack/LIFO and non-mutating peek` | Apila `10, 20, 30`; verifica `stackPeek = 30`, `stackSize = 3`. |
| **Stack**: Extracción y reutilización | Sí | `stack/removal and reuse` | Desapila `30`, apila `40`, desapila `40, 20, 10`; verifica `stackIsEmpty = True`, `stackSize = 0`. |
| **Stack**: Vacío tras extracción | Sí | `stack/empty after removal` | Desapila de pila vacía; verifica `stackPop = -1`, `stackIsEmpty = True`. |
| **Queue**: Estado vacío y extracción fallida | Sí | `queue/empty state and failed removal` | Verifica `queueIsEmpty = True`, `queueSize = 0`, `queuePeek = -1`, `queueDequeue = -1`. |
| **Queue**: FIFO y `peek` no mutante | Sí | `queue/FIFO and non-mutating peek` | Encola `10, 20, 30`; verifica `queuePeek = 10`, `queueSize = 3`. |
| **Queue**: Extracción y reutilización | Sí | `queue/removal and reuse` | Desencola `10`, encola `40`, desencola `20, 30, 40`; verifica `queueIsEmpty = True`, `queueSize = 0`. |
| **Queue**: Vacío tras extracción | Sí | `queue/empty after removal` | Desencola de cola vacía; verifica `queueDequeue = -1`, `queueIsEmpty = True`. |

**Total de pruebas:** 15 casos con 51 aserciones (4 para `Node`, 18 para `LinkedList`, 15 para `Stack`, 14 para `Queue`).

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| `linkedListInsertTail` y `queueEnqueue` tienen complejidad `O(n)` en lugar de `O(1)` | Inserciones al final más lentas en listas grandes | Haskell es inmutable; no hay mutación en el sitio. Para mantener la inmutabilidad, se reconstruye el camino hasta la cola usando recursión (`appendNode`). |
| No hay mutación en el sitio | Cada operación crea una estructura nueva | Es una limitación inherente de los lenguajes funcionales puros. El compilador puede optimizar la creación de estructuras nuevas mediante sharing y lazy evaluation. |

---

## 📝 Notas de implementación / Implementation Notes

**ES:** Haskell es un lenguaje funcional puro con inmutabilidad garantizada y evaluación perezosa. Las operaciones no mutan la instancia recibida; cada función devuelve una estructura nueva con los cambios. Esto elimina la necesidad de sincronización o bloqueo, pero requiere reconstruir las estructuras en cada operación.

Los tipos algebraicos `Maybe Node` con `Just node` y `Nothing` permiten representar la ausencia de enlace de forma segura, sin `null` ni centinelas. Las tuplas `(Bool, LinkedList)` y `(Int, Stack/Queue)` permiten devolver el valor y la estructura resultante en una sola operación, conservando la inmutabilidad.

La recursión se usa en `appendNode`, `removeFirst` y `lastNode` para recorrer y reconstruir las cadenas de nodos. Haskell garantiza la optimización de recursión de cola (TCO) en muchos casos, así que estas funciones son seguras para listas de cualquier tamaño.

El record syntax de Haskell genera automáticamente funciones accesoras para los campos de los tipos de datos, así que `value` y `next` son funciones que se pueden aplicar directamente a un `Node`. El record update syntax (`node { next = Just link }`) permite crear una copia de un nodo con un campo modificado.

Cabal es el gestor de paquetes estándar de Haskell; proporciona `cabal build`, `cabal test` y gestión de dependencias. HUnit es el framework de pruebas estándar, que proporciona aserciones y organización de tests en grupos.

**EN:** Haskell is a pure functional language with guaranteed immutability and lazy evaluation. Operations do not mutate the received instance; each function returns a new structure with the changes. This eliminates the need for synchronization or locking, but requires rebuilding structures on each operation.

Algebraic types `Maybe Node` with `Just node` and `Nothing` allow representing link absence safely, without `null` or sentinels. Tuples `(Bool, LinkedList)` and `(Int, Stack/Queue)` allow returning the value and the resulting structure in a single operation, preserving immutability.

Recursion is used in `appendNode`, `removeFirst` and `lastNode` to traverse and rebuild node chains. Haskell guarantees tail-call optimization (TCO) in many cases, so these functions are safe for lists of any size.

Haskell's record syntax automatically generates accessor functions for data type fields, so `value` and `next` are functions that can be applied directly to a `Node`. Record update syntax (`node { next = Just link }`) allows creating a copy of a node with a modified field.

Cabal is Haskell's standard package manager; it provides `cabal build`, `cabal test` and dependency management. HUnit is the standard test framework, providing assertions and test organization in groups.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_ (o `Omitido` con razón).
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe.
- [x] Ninguna sección repite lo que ya dice la especificación.

---

*[← Volver a Algorithms](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
