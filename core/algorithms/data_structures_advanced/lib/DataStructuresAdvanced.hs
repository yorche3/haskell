-- DataStructuresAdvanced.hs — Binary search tree and directed graph
--
-- Specification: 07_Data_Structures_Advanced. Absence is @Nothing@; flags are
-- Bool; counters are Int.
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

-- | Search tree node: value and two optional links.
data TreeNode = TreeNode
  { value :: Int
  , left  :: Maybe TreeNode
  , right :: Maybe TreeNode
  }

-- | Tree: optional root and count of distinct values.
data BinaryTree = BinaryTree
  { btRoot  :: Maybe TreeNode
  , btCount :: Int
  }

-- | Registry vertex: label, sorted adjacency, link to the next vertex.
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

newTreeNode :: Int -> TreeNode
newTreeNode v = TreeNode { value = v, left = Nothing, right = Nothing }

treeNodeWithLeft :: TreeNode -> Maybe TreeNode -> TreeNode
treeNodeWithLeft node link = node { left = link }

treeNodeWithRight :: TreeNode -> Maybe TreeNode -> TreeNode
treeNodeWithRight node link = node { right = link }

newBinaryTree :: BinaryTree
newBinaryTree = BinaryTree { btRoot = Nothing, btCount = 0 }

-- Duplicate is a success and does not grow the counter.
binaryTreeInsert :: Int -> BinaryTree -> BinaryTree
binaryTreeInsert v t =
  let (root, added) = insertNode v (btRoot t)
   in BinaryTree
        { btRoot = Just root
        , btCount = btCount t + (if added then 1 else 0)
        }

insertNode :: Int -> Maybe TreeNode -> (TreeNode, Bool)
insertNode v Nothing = (newTreeNode v, True)
insertNode v (Just node)
  | v == value node = (node, False)
  | v < value node =
      let (newLeft, added) = insertNode v (left node)
       in (treeNodeWithLeft node (Just newLeft), added)
  | otherwise =
      let (newRight, added) = insertNode v (right node)
       in (treeNodeWithRight node (Just newRight), added)

binaryTreeContains :: Int -> BinaryTree -> Bool
binaryTreeContains v t = containsNode v (btRoot t)

containsNode :: Int -> Maybe TreeNode -> Bool
containsNode _ Nothing = False
containsNode v (Just node)
  | v == value node = True
  | v < value node = containsNode v (left node)
  | otherwise = containsNode v (right node)

binaryTreeIsEmpty :: BinaryTree -> Bool
binaryTreeIsEmpty t = btCount t == 0

binaryTreeSize :: BinaryTree -> Int
binaryTreeSize t = btCount t

newGraph :: Graph
newGraph = Graph { grVertices = Nothing, grVertexCount = 0, grEdgeCount = 0 }

findVertex :: Int -> Maybe GraphNode -> Maybe GraphNode
findVertex _ Nothing = Nothing
findVertex v (Just node)
  | gnLabel node == v = Just node
  | otherwise = findVertex v (gnNextVertex node)

insertNeighbor :: Int -> [Int] -> [Int]
insertNeighbor v [] = [v]
insertNeighbor v ns@(x : xs)
  | v == x = ns
  | v < x = v : ns
  | otherwise = x : insertNeighbor v xs

addNeighbor :: Int -> Int -> Maybe GraphNode -> Maybe GraphNode
addNeighbor _ _ Nothing = Nothing
addNeighbor u v (Just node)
  | gnLabel node == u =
      Just (node { gnNeighbors = insertNeighbor v (gnNeighbors node) })
  | otherwise =
      Just (node { gnNextVertex = addNeighbor u v (gnNextVertex node) })

graphAddVertex :: Int -> Graph -> Graph
graphAddVertex v g = case findVertex v (grVertices g) of
  Just _ -> g
  Nothing ->
    g
      { grVertices = Just (GraphNode v [] (grVertices g))
      , grVertexCount = grVertexCount g + 1
      }

-- Directed @u -> v@: @(True, graph)@ if added or already present.
graphAddEdge :: Int -> Int -> Graph -> (Bool, Graph)
graphAddEdge u v g = case (findVertex u vertices, findVertex v vertices) of
  (Just from, Just _)
    | v `elem` gnNeighbors from -> (True, g)
    | otherwise ->
        ( True
        , g
            { grVertices = addNeighbor u v vertices
            , grEdgeCount = grEdgeCount g + 1
            }
        )
  _ -> (False, g)
 where
  vertices = grVertices g

graphHasEdge :: Int -> Int -> Graph -> Bool
graphHasEdge u v g = case findVertex u (grVertices g) of
  Nothing -> False
  Just from -> v `elem` gnNeighbors from

-- @Nothing@ when the vertex is not registered, @Just []@ when it is isolated.
graphGetNeighbors :: Int -> Graph -> Maybe [Int]
graphGetNeighbors v g = gnNeighbors <$> findVertex v (grVertices g)

graphIsEmpty :: Graph -> Bool
graphIsEmpty g = grVertexCount g == 0

graphVertexCount :: Graph -> Int
graphVertexCount = grVertexCount

graphEdgeCount :: Graph -> Int
graphEdgeCount = grEdgeCount
