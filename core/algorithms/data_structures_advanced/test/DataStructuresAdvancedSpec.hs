module DataStructuresAdvancedSpec (spec) where

import Data.Maybe (isNothing)
import DataStructuresAdvanced
import Test.Hspec

-- Casos de prueba de la especificación 07_Data_Structures_Advanced.md:
-- 6 de TreeNode (el 6.º, la adaptación inmutable, es el único comportamiento
-- de Haskell), 7 de BinaryTree y 10 de Graph.
--
-- Haskell es inmutable: cada paso encadena el valor devuelto por el anterior y
-- cada caso parte de `newBinaryTree`/`newGraph`. `insert` y `add_vertex` no
-- devuelven indicador en el contrato: su éxito se observa con
-- `contains`/`has_edge` y los contadores. `add_edge` sí devuelve
-- `(éxito, grafo)`. Las aserciones solo usan operaciones del contrato; `Maybe`
-- aparece al observar enlaces y vecinos.

-- ---------------------------------------------------------------------------
-- TreeNode
-- ---------------------------------------------------------------------------

nodeParent :: TreeNode
nodeParent = newTreeNode 10

nodeChildLeft :: TreeNode
nodeChildLeft = newTreeNode 20

nodeChildRight :: TreeNode
nodeChildRight = newTreeNode 30

nodeLinkedBoth :: TreeNode
nodeLinkedBoth =
  treeNodeWithRight
    (treeNodeWithLeft nodeParent (Just nodeChildLeft))
    (Just nodeChildRight)

nodeLeftCleared :: TreeNode
nodeLeftCleared = treeNodeWithLeft nodeLinkedBoth Nothing

nodeBothCleared :: TreeNode
nodeBothCleared = treeNodeWithRight nodeLeftCleared Nothing

nodeWithLeftOnly :: TreeNode
nodeWithLeftOnly = treeNodeWithLeft nodeParent (Just nodeChildLeft)

-- ---------------------------------------------------------------------------
-- BinaryTree
-- ---------------------------------------------------------------------------

treeFrom :: [Int] -> BinaryTree
treeFrom = foldl (flip binaryTreeInsert) newBinaryTree

treeEmpty :: BinaryTree
treeEmpty = newBinaryTree

treeRootOnly :: BinaryTree
treeRootOnly = treeFrom [50]

treeLowerHigher :: BinaryTree
treeLowerHigher = treeFrom [50, 30, 70]

treeMultilevel :: BinaryTree
treeMultilevel = treeFrom [50, 30, 70, 20, 40]

treeDuplicate :: BinaryTree
treeDuplicate = treeFrom [50, 30, 70, 30]

treeOrdered :: BinaryTree
treeOrdered = treeFrom [20, 30, 40, 50, 70]

-- ---------------------------------------------------------------------------
-- Graph
-- ---------------------------------------------------------------------------

graphWithVertices :: [Int] -> Graph
graphWithVertices = foldl (flip graphAddVertex) newGraph

-- Aplica las aristas en orden y devuelve los indicadores y el grafo final.
addEdges :: [(Int, Int)] -> Graph -> ([Bool], Graph)
addEdges edges g0 = foldl step ([], g0) edges
  where
    step (flags, g) (u, v) =
      let (ok, g') = graphAddEdge u v g
       in (flags ++ [ok], g')

graphEmpty :: Graph
graphEmpty = newGraph

graphIsolated :: Graph
graphIsolated = graphAddVertex 10 newGraph

graphDirectedResult :: ([Bool], Graph)
graphDirectedResult = addEdges [(10, 70)] (graphWithVertices [10, 70])

graphDuplicateVertexResult :: ([Bool], Graph)
graphDuplicateVertexResult =
  let (flags, g) = addEdges [(10, 30)] (graphWithVertices [10, 30])
   in (flags, graphAddVertex 10 g)

graphDuplicateEdgeResult :: ([Bool], Graph)
graphDuplicateEdgeResult =
  addEdges [(10, 30), (10, 30)] (graphWithVertices [10, 30])

graphMissingEndpointResult :: ([Bool], Graph)
graphMissingEndpointResult =
  let (_, g) = addEdges [(10, 30)] (graphWithVertices [10, 30])
   in addEdges [(10, 99), (99, 10), (98, 99), (99, 99)] g

graphSortedResult :: ([Bool], Graph)
graphSortedResult =
  addEdges
    [(10, 70), (10, 30), (10, 50), (30, 50)]
    (graphWithVertices [10, 30, 50, 70])

graphNoEdge :: Graph
graphNoEdge = graphWithVertices [10, 30]

graphSelfLoopResult :: ([Bool], Graph)
graphSelfLoopResult = addEdges [(10, 10), (10, 10)] graphIsolated

-- ---------------------------------------------------------------------------
-- Suite
-- ---------------------------------------------------------------------------

spec :: Spec
spec = do
  describe "TreeNode" $ do
    describe "create a tree node" $
      it "get_value should return 10" $
        value nodeParent `shouldBe` 10
    describe "absent initial links" $ do
      it "get_left should be absent" $
        isNothing (left nodeParent) `shouldBe` True
      it "get_right should be absent" $
        isNothing (right nodeParent) `shouldBe` True
    describe "link two children" $ do
      it "get_value(get_left) should return 20" $
        (value <$> left nodeLinkedBoth) `shouldBe` Just 20
      it "get_value(get_right) should return 30" $
        (value <$> right nodeLinkedBoth) `shouldBe` Just 30
    describe "traverse each link" $ do
      it "the left child should lead to 20" $
        (value <$> left nodeLinkedBoth) `shouldBe` Just 20
      it "the right child should lead to 30" $
        (value <$> right nodeLinkedBoth) `shouldBe` Just 30
      it "the left child's links should be absent" $
        (isNothing (left nodeChildLeft), isNothing (right nodeChildLeft))
          `shouldBe` (True, True)
      it "the right child's links should be absent" $
        (isNothing (left nodeChildRight), isNothing (right nodeChildRight))
          `shouldBe` (True, True)
    describe "unlink children" $ do
      it "clearing left should keep value 10" $
        value nodeLeftCleared `shouldBe` 10
      it "clearing left should keep the right child 30" $
        (value <$> right nodeLeftCleared) `shouldBe` Just 30
      it "clearing left should leave the left link absent" $
        isNothing (left nodeLeftCleared) `shouldBe` True
      it "clearing right should leave both links absent" $
        (isNothing (left nodeBothCleared), isNothing (right nodeBothCleared))
          `shouldBe` (True, True)
      it "clearing right should keep value 10" $
        value nodeBothCleared `shouldBe` 10
    describe "immutable adaptation" $ do
      it "set_left should return a node with the new link" $
        (value <$> left nodeWithLeftOnly) `shouldBe` Just 20
      it "the original node should be unchanged" $
        isNothing (left nodeParent) `shouldBe` True

  describe "BinaryTree" $ do
    describe "create empty" $ do
      it "is_empty should return True" $
        binaryTreeIsEmpty treeEmpty `shouldBe` True
      it "size should return 0" $
        binaryTreeSize treeEmpty `shouldBe` 0
      it "contains(50) should fail" $
        binaryTreeContains 50 treeEmpty `shouldBe` False
    describe "insert the root" $ do
      it "contains(50) should succeed" $
        binaryTreeContains 50 treeRootOnly `shouldBe` True
      it "size should return 1" $
        binaryTreeSize treeRootOnly `shouldBe` 1
      it "is_empty should return False" $
        binaryTreeIsEmpty treeRootOnly `shouldBe` False
    describe "insert lower and higher" $ do
      it "size should return 3" $
        binaryTreeSize treeLowerHigher `shouldBe` 3
      it "all three values should be present" $
        map (`binaryTreeContains` treeLowerHigher) [50, 30, 70]
          `shouldBe` [True, True, True]
    describe "multilevel branches" $ do
      it "every inserted value should be present" $
        map (`binaryTreeContains` treeMultilevel) [50, 30, 70, 20, 40]
          `shouldBe` replicate 5 True
      it "size should return 5" $
        binaryTreeSize treeMultilevel `shouldBe` 5
    describe "missing value in nonempty tree" $ do
      it "contains(99) should fail" $
        binaryTreeContains 99 treeRootOnly `shouldBe` False
      it "size should stay 1" $
        binaryTreeSize treeRootOnly `shouldBe` 1
      it "contains(50) should still succeed" $
        binaryTreeContains 50 treeRootOnly `shouldBe` True
    describe "idempotent duplicate" $ do
      it "size should return 3" $
        binaryTreeSize treeDuplicate `shouldBe` 3
      it "all three values should be preserved" $
        map (`binaryTreeContains` treeDuplicate) [50, 30, 70]
          `shouldBe` [True, True, True]
    describe "ordered insertions" $ do
      it "size should return 5" $
        binaryTreeSize treeOrdered `shouldBe` 5
      it "every inserted value should be present" $
        map (`binaryTreeContains` treeOrdered) [20, 30, 40, 50, 70]
          `shouldBe` replicate 5 True
      it "contains(99) should fail" $
        binaryTreeContains 99 treeOrdered `shouldBe` False

  describe "Graph" $ do
    describe "create empty" $ do
      it "is_empty should return True" $
        graphIsEmpty graphEmpty `shouldBe` True
      it "vertex_count should return 0" $
        graphVertexCount graphEmpty `shouldBe` 0
      it "edge_count should return 0" $
        graphEdgeCount graphEmpty `shouldBe` 0
      it "has_edge(10,30) should fail" $
        graphHasEdge 10 30 graphEmpty `shouldBe` False
      it "get_neighbors(10) should fail" $
        graphGetNeighbors 10 graphEmpty `shouldBe` Nothing
    describe "isolated vertex" $ do
      it "is_empty should return False" $
        graphIsEmpty graphIsolated `shouldBe` False
      it "vertex_count should return 1" $
        graphVertexCount graphIsolated `shouldBe` 1
      it "edge_count should return 0" $
        graphEdgeCount graphIsolated `shouldBe` 0
      it "neighbours of 10 should be empty" $
        graphGetNeighbors 10 graphIsolated `shouldBe` Just []
    describe "nonconsecutive labels and directed edge" $ do
      let (flags, g) = graphDirectedResult
      it "add_edge(10,70) should succeed" $
        flags `shouldBe` [True]
      it "has_edge(10,70) should succeed" $
        graphHasEdge 10 70 g `shouldBe` True
      it "has_edge(70,10) should fail" $
        graphHasEdge 70 10 g `shouldBe` False
      it "vertex_count should return 2" $
        graphVertexCount g `shouldBe` 2
      it "edge_count should return 1" $
        graphEdgeCount g `shouldBe` 1
    describe "duplicate vertex preserves adjacency" $ do
      let (flags, g) = graphDuplicateVertexResult
      it "add_edge(10,30) should succeed" $
        flags `shouldBe` [True]
      it "vertex_count should return 2" $
        graphVertexCount g `shouldBe` 2
      it "edge_count should return 1" $
        graphEdgeCount g `shouldBe` 1
      it "neighbours of 10 should be [30]" $
        graphGetNeighbors 10 g `shouldBe` Just [30]
    describe "duplicate edge" $ do
      let (flags, g) = graphDuplicateEdgeResult
      it "both add_edge calls should succeed" $
        flags `shouldBe` [True, True]
      it "vertex_count should return 2" $
        graphVertexCount g `shouldBe` 2
      it "edge_count should return 1" $
        graphEdgeCount g `shouldBe` 1
      it "neighbours of 10 should be [30]" $
        graphGetNeighbors 10 g `shouldBe` Just [30]
    describe "missing endpoint without mutation" $ do
      let (flags, g) = graphMissingEndpointResult
      it "the four invalid add_edge calls should fail" $
        flags `shouldBe` replicate 4 False
      it "vertex_count should stay 2" $
        graphVertexCount g `shouldBe` 2
      it "edge_count should stay 1" $
        graphEdgeCount g `shouldBe` 1
      it "neighbours of 10 should stay [30]" $
        graphGetNeighbors 10 g `shouldBe` Just [30]
      it "neighbours of 30 should be empty" $
        graphGetNeighbors 30 g `shouldBe` Just []
      it "the attempted edges should be absent" $
        [graphHasEdge 10 99 g, graphHasEdge 99 10 g, graphHasEdge 98 99 g, graphHasEdge 99 99 g]
          `shouldBe` replicate 4 False
      it "get_neighbors(98) should fail" $
        graphGetNeighbors 98 g `shouldBe` Nothing
      it "get_neighbors(99) should fail" $
        graphGetNeighbors 99 g `shouldBe` Nothing
    describe "sorted neighbours and counts" $ do
      let (flags, g) = graphSortedResult
      it "all four add_edge calls should succeed" $
        flags `shouldBe` replicate 4 True
      it "neighbours of 10 should be [30,50,70]" $
        graphGetNeighbors 10 g `shouldBe` Just [30, 50, 70]
      it "neighbours of 30 should be [50]" $
        graphGetNeighbors 30 g `shouldBe` Just [50]
      it "neighbours of 50 should be empty" $
        graphGetNeighbors 50 g `shouldBe` Just []
      it "neighbours of 70 should be empty" $
        graphGetNeighbors 70 g `shouldBe` Just []
      it "vertex_count should return 4" $
        graphVertexCount g `shouldBe` 4
      it "edge_count should return 4" $
        graphEdgeCount g `shouldBe` 4
    describe "missing-edge query" $ do
      it "has_edge(10,30) should fail" $
        graphHasEdge 10 30 graphNoEdge `shouldBe` False
      it "vertex_count should return 2" $
        graphVertexCount graphNoEdge `shouldBe` 2
      it "edge_count should return 0" $
        graphEdgeCount graphNoEdge `shouldBe` 0
      it "is_empty should return False" $
        graphIsEmpty graphNoEdge `shouldBe` False
    describe "neighbours of missing vertex" $ do
      it "get_neighbors(99) should fail" $
        graphGetNeighbors 99 graphIsolated `shouldBe` Nothing
      it "the failure should differ from the empty neighbours of 10" $
        graphGetNeighbors 99 graphIsolated `shouldNotBe` graphGetNeighbors 10 graphIsolated
      it "vertex_count should stay 1" $
        graphVertexCount graphIsolated `shouldBe` 1
      it "edge_count should stay 0" $
        graphEdgeCount graphIsolated `shouldBe` 0
    describe "self-loop and duplicate" $ do
      let (flags, g) = graphSelfLoopResult
      it "both add_edge calls should succeed" $
        flags `shouldBe` [True, True]
      it "has_edge(10,10) should succeed" $
        graphHasEdge 10 10 g `shouldBe` True
      it "neighbours of 10 should be [10]" $
        graphGetNeighbors 10 g `shouldBe` Just [10]
      it "vertex_count should return 1" $
        graphVertexCount g `shouldBe` 1
      it "edge_count should return 1" $
        graphEdgeCount g `shouldBe` 1
