# Data Structures Advanced — Haskell

Implementación de la especificación [07_Data_Structures_Advanced](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced/) en **Haskell**, gestionada con **Cabal** y probada con **Hspec**.

Estructuras de datos con múltiples enlaces construidas de forma manual y persistente: **TreeNode** (nodo binario inmutable), **BinaryTree** (árbol binario de búsqueda funcional) y **Graph** (grafo dirigido con registro canónico enlazado de vértices y secuencias de adyacencia ordenadas).

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| `lib/DataStructuresAdvanced.hs` | Implementación de `TreeNode`, `BinaryTree` y `Graph` con tipos algebraicos inmutables y persistentes. / Implementation of `TreeNode`, `BinaryTree`, and `Graph` with immutable and persistent algebraic types. |
| `test/DataStructuresAdvancedSpec.hs` | Suite Hspec: 24 casos de prueba cubriendo los escenarios de la especificación para TreeNode, BinaryTree y Graph. / Hspec test suite: 24 test cases covering the specification scenarios for TreeNode, BinaryTree, and Graph. |
| `test/RunTests.hs` | Punto de entrada del ejecutable del test runner. / Test runner executable entrypoint. |
| `data-structures-advanced.cabal` | Manifiesto del paquete Cabal con advertencias estrictas (`-Wall`) y dependencias. / Cabal package manifest with strict warnings (`-Wall`) and dependencies. |
| `CHANGELOG.md` | Registro de cambios del paquete. / Package changelog. |
| `.gitignore` | Reglas de exclusión de artefactos de compilación (`dist-newstyle`). / Build artifact exclusion rules (`dist-newstyle`). |

**Nota de desviación de ubicación / Location deviation note:**
La especificación propone `src/` como carpeta de código fuente. Siguiendo la convención idiomática generada por `cabal init` en este submódulo (al igual que en `numbers`), las fuentes se ubican en `lib/` en lugar de `src/`.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El paquete fue generado mediante `cabal init` y configurado con `-Wall` para asegurar compilación limpia sin advertencias. La suite de pruebas usa **Hspec** con un runner centralizado en `test/RunTests.hs`. Se adopta un diseño funcional puro: las estructuras son persistentes e inmutables, utilizando `Maybe` para modelar enlaces opcionales y la lista enlazada nativa `[Int]` para la secuencia de adyacencia ordenada.

**EN:** The package was initialized with `cabal init` and configured with `-Wall` to guarantee a clean build with zero warnings. The test suite uses **Hspec** with a centralized runner at `test/RunTests.hs`. A purely functional design is adopted: data structures are persistent and immutable, utilizing `Maybe` to model optional links and the native linked list `[Int]` for the sorted adjacency sequence.

---

## 📄 Configuración clave / Key Configuration

| Archivo / File | Propósito / Purpose |
|---|---|
| `data-structures-advanced.cabal` | Define biblioteca y test-suite con `base ^>=4.20.2.0`, `hspec ^>=2.11.0`, `hs-source-dirs: lib` y `test`, y flag global `-Wall`. |
| `CHANGELOG.md` | Documentación de la versión inicial `0.1.0.0`. |

---

## 🚀 Compilación y ejecución / Build & Run

```bash
cabal build
cabal test
```

**Salida real / Actual output:**

```text
Build profile: -w ghc-9.10.3 -O1
In order, the following will be built (use -v for more details):
 - data-structures-advanced-0.1.0.0 (lib) (first run)
Configuring library for data-structures-advanced-0.1.0.0...
Preprocessing library for data-structures-advanced-0.1.0.0...
Building library for data-structures-advanced-0.1.0.0...
[1 of 1] Compiling DataStructuresAdvanced ( lib/DataStructuresAdvanced.hs, dist-newstyle/build/x86_64-linux/ghc-9.10.3/data-structures-advanced-0.1.0.0/build/DataStructuresAdvanced.o, dist-newstyle/build/x86_64-linux/ghc-9.10.3/data-structures-advanced-0.1.0.0/build/DataStructuresAdvanced.dyn_o )
Build profile: -w ghc-9.10.3 -O1
In order, the following will be built (use -v for more details):
 - data-structures-advanced-0.1.0.0 (test:data-structures-advanced-test) (first run)
Configuring test suite 'data-structures-advanced-test' for data-structures-advanced-0.1.0.0...
Preprocessing test suite 'data-structures-advanced-test' for data-structures-advanced-0.1.0.0...
Building test suite 'data-structures-advanced-test' for data-structures-advanced-0.1.0.0...
[1 of 2] Compiling DataStructuresAdvancedSpec ( test/DataStructuresAdvancedSpec.hs, dist-newstyle/build/x86_64-linux/ghc-9.10.3/data-structures-advanced-0.1.0.0/t/data-structures-advanced-test/build/data-structures-advanced-test/data-structures-advanced-test-tmp/DataStructuresAdvancedSpec.o )
[2 of 2] Compiling Main             ( test/RunTests.hs, dist-newstyle/build/x86_64-linux/ghc-9.10.3/data-structures-advanced-0.1.0.0/t/data-structures-advanced-test/build/data-structures-advanced-test/data-structures-advanced-test-tmp/Main.o )
[3 of 3] Linking dist-newstyle/build/x86_64-linux/ghc-9.10.3/data-structures-advanced-0.1.0.0/t/data-structures-advanced-test/build/data-structures-advanced-test/data-structures-advanced-test
Running 1 test suites...
Test suite data-structures-advanced-test: RUNNING...

TreeNode
  create a tree node
    get_value should return 10 [✔]
  absent initial links
    get_left should be absent [✔]
    get_right should be absent [✔]
  link two children
    get_value(get_left) should return 20 [✔]
    get_value(get_right) should return 30 [✔]
  traverse each link
    the left child should lead to 20 [✔]
    the right child should lead to 30 [✔]
    the left child's links should be absent [✔]
    the right child's links should be absent [✔]
  unlink children
    clearing left should keep value 10 [✔]
    clearing left should keep the right child 30 [✔]
    clearing left should leave the left link absent [✔]
    clearing right should leave both links absent [✔]
    clearing right should keep value 10 [✔]
  immutable adaptation
    set_left should return a node with the new link [✔]
    the original node should be unchanged [✔]
BinaryTree
  create empty
    is_empty should return True [✔]
    size should return 0 [✔]
    contains(50) should fail [✔]
  insert the root
    contains(50) should succeed [✔]
    size should return 1 [✔]
    is_empty should return False [✔]
  insert lower and higher
    size should return 3 [✔]
    all three values should be present [✔]
  multilevel branches
    every inserted value should be present [✔]
    size should return 5 [✔]
  missing value in nonempty tree
    contains(99) should fail [✔]
    size should stay 1 [✔]
    contains(50) should still succeed [✔]
  idempotent duplicate
    size should return 3 [✔]
    all three values should be preserved [✔]
  ordered insertions
    size should return 5 [✔]
    every inserted value should be present [✔]
    contains(99) should fail [✔]
Graph
  create empty
    is_empty should return True [✔]
    vertex_count should return 0 [✔]
    edge_count should return 0 [✔]
    has_edge(10,30) should fail [✔]
    get_neighbors(10) should fail [✔]
  isolated vertex
    is_empty should return False [✔]
    vertex_count should return 1 [✔]
    edge_count should return 0 [✔]
    neighbours of 10 should be empty [✔]
  nonconsecutive labels and directed edge
    add_edge(10,70) should succeed [✔]
    has_edge(10,70) should succeed [✔]
    has_edge(70,10) should fail [✔]
    vertex_count should return 2 [✔]
    edge_count should return 1 [✔]
  duplicate vertex preserves adjacency
    add_edge(10,30) should succeed [✔]
    vertex_count should return 2 [✔]
    edge_count should return 1 [✔]
    neighbours of 10 should be [30] [✔]
  duplicate edge
    both add_edge calls should succeed [✔]
    vertex_count should return 2 [✔]
    edge_count should return 1 [✔]
    neighbours of 10 should be [30] [✔]
  missing endpoint without mutation
    the four invalid add_edge calls should fail [✔]
    vertex_count should stay 2 [✔]
    edge_count should stay 1 [✔]
    neighbours of 10 should stay [30] [✔]
    neighbours of 30 should be empty [✔]
    the attempted edges should be absent [✔]
    get_neighbors(98) should fail [✔]
    get_neighbors(99) should fail [✔]
  sorted neighbours and counts
    all four add_edge calls should succeed [✔]
    neighbours of 10 should be [30,50,70] [✔]
    neighbours of 30 should be [50] [✔]
    neighbours of 50 should be empty [✔]
    neighbours of 70 should be empty [✔]
    vertex_count should return 4 [✔]
    edge_count should return 4 [✔]
  missing-edge query
    has_edge(10,30) should fail [✔]
    vertex_count should return 2 [✔]
    edge_count should return 0 [✔]
    is_empty should return False [✔]
  neighbours of missing vertex
    get_neighbors(99) should fail [✔]
    the failure should differ from the empty neighbours of 10 [✔]
    vertex_count should stay 1 [✔]
    edge_count should stay 0 [✔]
  self-loop and duplicate
    both add_edge calls should succeed [✔]
    has_edge(10,10) should succeed [✔]
    neighbours of 10 should be [10] [✔]
    vertex_count should return 1 [✔]
    edge_count should return 1 [✔]
  neighbour-result isolation
    add_edge(10,50) should succeed [✔]
    the saved result should remain [30] [✔]
    fresh neighbours of 10 should be [30,50] [✔]
    vertex_count should return 3 [✔]
    edge_count should return 2 [✔]

Finished in 0.0032 seconds
89 examples, 0 failures
Test suite data-structures-advanced-test: PASS
Test suite logged to:
~/programming_languages/haskell/core/algorithms/data_structures_advanced/dist-newstyle/build/x86_64-linux/ghc-9.10.3/data-structures-advanced-0.1.0.0/t/data-structures-advanced-test/test/data-structures-advanced-0.1.0.0-data-structures-advanced-test.log
1 of 1 test suites (1 of 1 test cases) passed.
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `newTreeNode` | `Int -> TreeNode` | `O(1)` | Constructor con enlaces iniciales `Nothing`. / Constructor with initial links `Nothing`. |
| `treeNodeWithLeft` | `TreeNode -> Maybe TreeNode -> TreeNode` | `O(1)` | Reconstrucción funcional del nodo con nuevo enlace izquierdo. / Functional reconstruction of node with new left link. |
| `treeNodeWithRight` | `TreeNode -> Maybe TreeNode -> TreeNode` | `O(1)` | Reconstrucción funcional del nodo con nuevo enlace derecho. / Functional reconstruction of node with new right link. |
| `newBinaryTree` | `BinaryTree` | `O(1)` | Árbol vacío con raíz `Nothing` y contador 0. / Empty tree with root `Nothing` and count 0. |
| `binaryTreeInsert` | `Int -> BinaryTree -> BinaryTree` | `O(h)` | Inserción funcional en ABB (`h` = altura). Duplicados no incrementan el tamaño. / Functional BST insertion (`h` = height). Duplicates do not grow size. |
| `binaryTreeContains` | `Int -> BinaryTree -> Bool` | `O(h)` | Búsqueda guiada por la invariante de orden del ABB. / Search guided by the BST ordering invariant. |
| `binaryTreeIsEmpty` | `BinaryTree -> Bool` | `O(1)` | Consulta directa sobre el contador `btCount`. / Direct query on counter `btCount`. |
| `binaryTreeSize` | `BinaryTree -> Int` | `O(1)` | Retorna el número de elementos únicos `btCount`. / Returns distinct element count `btCount`. |
| `newGraph` | `Graph` | `O(1)` | Grafo vacío sin vértices ni aristas. / Empty graph with no vertices and no edges. |
| `graphAddVertex` | `Int -> Graph -> Graph` | `O(V)` | Búsqueda lineal en registro de vértices; prepend si es nuevo. Duplicados conservan adyacencias. / Linear search in vertex registry; prepend if new. Duplicates preserve adjacency. |
| `graphAddEdge` | `Int -> Int -> Graph -> (Bool, Graph)` | `O(V + d(u))` | Verifica existencia de extremos y realiza inserción ordenada en adyacencia. Retorna `(False, g)` si falta extremo. / Checks endpoints and performs sorted insertion in adjacency. Returns `(False, g)` on missing endpoint. |
| `graphHasEdge` | `Int -> Int -> Graph -> Bool` | `O(V + d(u))` | Búsqueda de vértice origen y pertenencia en lista de adyacencia. / Lookup of source vertex and membership in adjacency list. |
| `graphGetNeighbors` | `Int -> Graph -> Maybe [Int]` | `O(V)` | Retorna `Nothing` si no existe el vértice, o `Just [Int]` (ordenado) si existe. / Returns `Nothing` if vertex absent, or `Just [Int]` (sorted) if present. |
| `graphIsEmpty` | `Graph -> Bool` | `O(1)` | Consulta sobre `grVertexCount == 0`. / Query on `grVertexCount == 0`. |
| `graphVertexCount` | `Graph -> Int` | `O(1)` | Retorna `grVertexCount`. / Returns `grVertexCount`. |
| `graphEdgeCount` | `Graph -> Int` | `O(1)` | Retorna `grEdgeCount`. / Returns `grEdgeCount`. |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Reutilización de valor mediante valor embebido (`value :: Int`, `gnLabel :: Int`) | Jerarquía de clases de tipos (`class HasValue a`) | Haskell no tiene herencia de tipos de registro (OOP). Un campo directo en `TreeNode` y `GraphNode` preserva el aislamiento estricto sin sobrecarga de typeclasses ni acoplamiento innecesario. / Haskell has no OOP record inheritance. Direct record fields in `TreeNode` and `GraphNode` preserve strict isolation without typeclass overhead or unnecessary coupling. |
| Retorno de par `(Bool, Graph)` en `graphAddEdge` | Retornar solo `Graph` o `Maybe Graph` | El contrato exige saber si la inserción fue exitosa o falló (por falta de extremos) preservando el grafo inmutable intacto. / The contract requires reporting success or failure (missing endpoints) while preserving the intact immutable graph. |
| Adyacencia con lista estándar `[Int]` e inserción manual ordenada | `Data.Set` o `Data.Sequence` | La especificación prohíbe el uso de estructuras de biblioteca de alto nivel (árboles balanceados, conjuntos) para el grafo y su adyacencia, pero permite listas enlazadas nativas con inserción manual. / The spec forbids high-level standard collections (balanced trees, sets) for the graph and adjacency, but allows native linked lists with manual insertion. |
| Registro canónico enlazado manual (`GraphNode` con `gnNextVertex :: Maybe GraphNode`) | `Data.Map Int [Int]` o array indexado | Cumple estrictamente el requisito pedagógico de registro canónico enlazado y recorrido manual con coste `O(V)`, sin delegar en tablas hash o árboles. / Strictly satisfies the pedagogical requirement of a manual linked registry with `O(V)` traversal, without delegating to hash tables or trees. |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| Tipo base `Node(value)` con herencia OOP | Valor embebido en `TreeNode` y `GraphNode` | Haskell no soporta herencia de registros OOP. Ambos tipos declaran su propio campo de valor entero sin validaciones previas. / Haskell does not support OOP record inheritance. Both types declare their own integer value field without prior validations. |
| Mutación in-place de enlaces (`node.left = child`) | Reconstrucción funcional pura (`treeNodeWithLeft`, `node { left = link }`) | Haskell es un lenguaje puro e inmutable; cualquier "modificación" produce un nuevo nodo compartiendo subestructuras inmutables. / Haskell is pure and immutable; any "update" produces a new node sharing immutable subtrees. |
| Modificación externa de lista de vecinos en `Graph.get_neighbors` | Retorno de lista inmutable `[Int]` compartida | En Haskell las listas son inmutables por definición. No es necesario realizar una copia defensiva profunda; la inmutabilidad garantiza que modificaciones externas son imposibles y el aislamiento está garantizado. / In Haskell lists are immutable by definition. Deep defensive copying is unnecessary; immutability guarantees external mutation is impossible and isolation is preserved. |
| Ubicación en `src/` | Ubicación en `lib/` | Convención estándar generada por Cabal para bibliotecas Haskell en este proyecto. / Standard Cabal convention for Haskell libraries in this project. |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `TreeNode.get_left`, `get_right` | Enlace hijo ausente / Absent child link | `Nothing` | `left (newTreeNode 10) == Nothing` |
| `BinaryTree.contains` | Valor ausente en el árbol / Value absent from tree | `False` | `binaryTreeContains 99 tree == False` |
| `Graph.add_edge` | Extremo origen o destino ausente / Missing source or target vertex | `(False, g)` | `graphAddEdge 10 99 g == (False, g)` |
| `Graph.has_edge` | Arista ausente o extremos inexistentes / Missing edge or nonexistent endpoints | `False` | `graphHasEdge 10 30 g == False` |
| `Graph.get_neighbors` | Vértice no registrado / Vertex not registered in graph | `Nothing` | `graphGetNeighbors 99 g == Nothing` (distinto de `Just []` para vértice aislado) |
| Entrada nula / Null input | Paso de puntero nulo / Passing null pointer | No representable | Haskell no tiene `null`/punteros anulables a nivel de lenguaje; los tipos son estrictamente seguros. / Haskell lacks `null`/nullable pointers at language level; types are strictly safe. |

---

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| **TreeNode: Crear un nodo de árbol** | Sí | `test/DataStructuresAdvancedSpec.hs:137` | `TreeNode -> create a tree node -> get_value should return 10` |
| **TreeNode: Enlaces iniciales ausentes** | Sí | `test/DataStructuresAdvancedSpec.hs:140` | `TreeNode -> absent initial links -> get_left / get_right should be absent` |
| **TreeNode: Enlazar dos hijos** | Sí | `test/DataStructuresAdvancedSpec.hs:145` | `TreeNode -> link two children -> get_value(get_left/right) should return 20/30` |
| **TreeNode: Recorrer cada enlace** | Sí | `test/DataStructuresAdvancedSpec.hs:150` | `TreeNode -> traverse each link -> children lead to 20/30, links absent` |
| **TreeNode: Desenlazar hijos** | Sí | `test/DataStructuresAdvancedSpec.hs:161` | `TreeNode -> unlink children -> clearing left/right preserves values` |
| **TreeNode: Adaptación inmutable** | Sí | `test/DataStructuresAdvancedSpec.hs:173` | `TreeNode -> immutable adaptation -> set_left returns new node, original unchanged` |
| **BinaryTree: Crear vacío** | Sí | `test/DataStructuresAdvancedSpec.hs:180` | `BinaryTree -> create empty -> is_empty True, size 0, contains False` |
| **BinaryTree: Insertar la raíz** | Sí | `test/DataStructuresAdvancedSpec.hs:187` | `BinaryTree -> insert the root -> contains True, size 1, is_empty False` |
| **BinaryTree: Insertar menor y mayor** | Sí | `test/DataStructuresAdvancedSpec.hs:194` | `BinaryTree -> insert lower and higher -> size 3, all present` |
| **BinaryTree: Ramas de varios niveles** | Sí | `test/DataStructuresAdvancedSpec.hs:200` | `BinaryTree -> multilevel branches -> all 5 present, size 5` |
| **BinaryTree: Valor ausente en árbol no vacío** | Sí | `test/DataStructuresAdvancedSpec.hs:206` | `BinaryTree -> missing value in nonempty tree -> contains 99 fails, size 1` |
| **BinaryTree: Duplicado idempotente** | Sí | `test/DataStructuresAdvancedSpec.hs:213` | `BinaryTree -> idempotent duplicate -> size 3, values preserved` |
| **BinaryTree: Inserciones ordenadas** | Sí | `test/DataStructuresAdvancedSpec.hs:219` | `BinaryTree -> ordered insertions -> size 5, all present, 99 absent` |
| **Graph: Crear vacío** | Sí | `test/DataStructuresAdvancedSpec.hs:229` | `Graph -> create empty -> is_empty True, counts 0, has_edge/get_neighbors fail` |
| **Graph: Vértice aislado** | Sí | `test/DataStructuresAdvancedSpec.hs:240` | `Graph -> isolated vertex -> not empty, 1 vertex, 0 edges, neighbours Just []` |
| **Graph: Etiquetas no consecutivas y arista dirigida** | Sí | `test/DataStructuresAdvancedSpec.hs:249` | `Graph -> nonconsecutive labels and directed edge -> forward True, reverse False, counts 2/1` |
| **Graph: Vértice duplicado conserva adyacencia** | Sí | `test/DataStructuresAdvancedSpec.hs:261` | `Graph -> duplicate vertex preserves adjacency -> counts 2/1, neighbours [30]` |
| **Graph: Arista duplicada** | Sí | `test/DataStructuresAdvancedSpec.hs:271` | `Graph -> duplicate edge -> both succeed, counts 2/1, neighbours [30]` |
| **Graph: Extremo inexistente sin mutación** | Sí | `test/DataStructuresAdvancedSpec.hs:281` | `Graph -> missing endpoint without mutation -> 4 calls fail, state preserved` |
| **Graph: Vecinos ordenados y contadores** | Sí | `test/DataStructuresAdvancedSpec.hs:300` | `Graph -> sorted neighbours and counts -> all succeed, counts 4/4, ordered lists` |
| **Graph: Consulta de arista ausente** | Sí | `test/DataStructuresAdvancedSpec.hs:316` | `Graph -> missing-edge query -> has_edge False, counts 2/0, not empty` |
| **Graph: Vecinos de vértice inexistente** | Sí | `test/DataStructuresAdvancedSpec.hs:325` | `Graph -> neighbours of missing vertex -> returns Nothing, distinct from Just []` |
| **Graph: Bucle y duplicado** | Sí | `test/DataStructuresAdvancedSpec.hs:334` | `Graph -> self-loop and duplicate -> loop present, neighbours [10], counts 1/1` |
| **Graph: Aislamiento del resultado de vecinos** | Sí | `test/DataStructuresAdvancedSpec.hs:346` | `Graph -> neighbour-result isolation -> saved result unchanged, fresh query [30,50]` |

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Inserciones lineales en ABB desbalanceado | Árboles con inserciones estrictamente ordenadas degeneran en lista enlazada con altura `O(n)`. | Comportamiento esperado para este módulo pedagógico; el balanceo (AVL o Red-Black) se aborda en módulos posteriores. / Expected behavior for this pedagogical module; balancing (AVL/Red-Black) is addressed in subsequent modules. |
| Inmutabilidad y mutaciones locales | Modificar una adyacencia requiere reconstruir el registro enlazado hasta el vértice en `O(V)`. | Propiedad intrínseca de estructuras de datos funcionales persistentes; preserva la pureza y evita efectos secundarios. / Intrinsic property of persistent functional data structures; preserves purity and prevents side-effects. |

---

## 📝 Notas de implementación / Implementation Notes

- **Inmutabilidad y pureza:** Todas las estructuras de datos (`TreeNode`, `BinaryTree`, `Graph`, `GraphNode`) son tipos algebraicos inmutables. Las modificaciones estructurales reconstruyen de forma persistente los nodos necesarios compartiendo la memoria no afectada.
- **Ausencia y seguridad:** La ausencia de enlaces o fallos de búsqueda se modela mediante el tipo `Maybe`, eliminando cualquier riesgo de excepciones por desreferenciación nula.
- **Registro enlazado manual:** El registro de vértices de `Graph` implementa la estructura canónica enlazada descrita en la especificación (`GraphNode` referenciando `gnNextVertex :: Maybe GraphNode`), implementando la búsqueda manual `findVertex` en `O(V)` sin delegar en mapas ni conjuntos de biblioteca.
- **Inserción ordenada de vecinos:** La lista de adyacencia mantiene los vecinos en orden estrictamente creciente mediante la función recursiva manual `insertNeighbor`, descartando duplicados sin alterar la complejidad `O(d(u))`.

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

## 📚 Referencias / References

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [07_Data_Structures_Advanced.md](../../../../docs/core/algorithms/07_Data_Structures_Advanced.md) |
| Primera base del lenguaje / First language reference | `data_structures_basics` — [data_structures_basics/README.md](../data_structures_basics/README.md) |
| Segunda base del lenguaje / Second language reference | `numbers` — [numbers/README.md](../../foundations/numbers/README.md) |
| Guía de inicialización / Initialisation guide | [core/00_Project_Initialization_Guide.md](../../../../docs/core/00_Project_Initialization_Guide.md) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [AGENT_Template.md](../../../../docs/AGENT_Template.md) |
| Validación de la documentación / Documentation validation | [WORKFLOW.md](../../../../docs/WORKFLOW.md) |
| Documentación oficial del lenguaje / Language official docs | [Haskell Language Documentation](https://www.haskell.org/documentation/) |
