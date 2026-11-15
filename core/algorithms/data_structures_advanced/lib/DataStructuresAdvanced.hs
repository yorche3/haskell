-- DataStructuresAdvanced.hs — Binary search tree and directed graph
--
-- Specification: 07_Data_Structures_Advanced. Contract step: types and
-- signatures with sentinel bodies.
--
-- Indicators: links and vertex existence are @Maybe@ (@Nothing@, the native
-- absence); flags are Bool; counters are Int; @graphAddEdge@ returns
-- @(success, graph)@ and on failure the indicator with the same graph.
module DataStructuresAdvanced
  ( TreeNode(..)
  , BinaryTree(..)
  , Graph
  , newTreeNode
  , treeNodeWithLeft
  , treeNodeWithRight
  , newBinaryTree
  , binaryTreeInsert
  , binaryTreeContains
  , binaryTreeIsEmpty
  , binaryTreeSize
  , newGraph
  , graphAddVertex
  , graphAddEdge
  , graphHasEdge
  , graphGetNeighbors
  , graphIsEmpty
  , graphVertexCount
  , graphEdgeCount
  ) where

-- Types

-- | Search tree node: value and two optional links.
data TreeNode = TreeNode
  { value :: Int
  , left  :: Maybe TreeNode
  , right :: Maybe TreeNode
  }

-- | Binary search tree: optional root and count of distinct values.
data BinaryTree = BinaryTree
  { btRoot  :: Maybe TreeNode
  , btCount :: Int
  }

-- | Graph vertex: label, sorted adjacency and link to the next vertex of the
-- canonical registry. Internal to @Graph@.
data GraphNode = GraphNode
  { gnLabel      :: Int
  , gnNeighbors  :: [Int]
  , gnNextVertex :: Maybe GraphNode
  }

-- | Directed graph: linked vertex registry and its own counters.
data Graph = Graph
  { grVertices    :: Maybe GraphNode
  , grVertexCount :: Int
  , grEdgeCount   :: Int
  }

-- TreeNode

-- | Node holding @v@ with both links absent (@init@).
newTreeNode :: Int -> TreeNode
newTreeNode _ = TreeNode { value = 0, left = Nothing, right = Nothing }

-- | Copy of @node@ whose left link is @link@ (@set_left@).
treeNodeWithLeft :: TreeNode -> Maybe TreeNode -> TreeNode
treeNodeWithLeft node _ = node

-- | Copy of @node@ whose right link is @link@ (@set_right@).
treeNodeWithRight :: TreeNode -> Maybe TreeNode -> TreeNode
treeNodeWithRight node _ = node

-- BinaryTree

-- | Empty tree: no root, counter at zero (@init@).
newBinaryTree :: BinaryTree
newBinaryTree = BinaryTree { btRoot = Nothing, btCount = 0 }

-- | Inserts @v@; a duplicate is a success and does not grow the tree.
binaryTreeInsert :: Int -> BinaryTree -> BinaryTree
binaryTreeInsert _ t = t

binaryTreeContains :: Int -> BinaryTree -> Bool
binaryTreeContains _ _ = False

binaryTreeIsEmpty :: BinaryTree -> Bool
binaryTreeIsEmpty _ = False

binaryTreeSize :: BinaryTree -> Int
binaryTreeSize _ = 0

-- Graph

-- | Empty graph: no vertices and counters at zero (@init@).
newGraph :: Graph
newGraph = Graph { grVertices = Nothing, grVertexCount = 0, grEdgeCount = 0 }

-- | Registers the vertex; a duplicate keeps the adjacency.
graphAddVertex :: Int -> Graph -> Graph
graphAddVertex _ g = g

-- | Adds edge @u -> v@: @(True, graph)@ if added or already present,
-- @(False, the same graph)@ when either endpoint is missing.
graphAddEdge :: Int -> Int -> Graph -> (Bool, Graph)
graphAddEdge _ _ g = (False, g)

graphHasEdge :: Int -> Int -> Graph -> Bool
graphHasEdge _ _ _ = False

-- | Sorted neighbours: @Nothing@ when the vertex is not registered, @Just []@
-- when it is isolated.
graphGetNeighbors :: Int -> Graph -> Maybe [Int]
graphGetNeighbors _ _ = Nothing

graphIsEmpty :: Graph -> Bool
graphIsEmpty _ = False

graphVertexCount :: Graph -> Int
graphVertexCount _ = 0

graphEdgeCount :: Graph -> Int
graphEdgeCount _ = 0
