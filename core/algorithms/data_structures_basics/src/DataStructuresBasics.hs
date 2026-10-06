-- DataStructuresBasics.hs — Shared cell, linked list, stack and queue
--
-- Specification: 06_Data_Structures_Basics
--
-- Contract stub (step 4b): declares the new types and the signatures, and leaves
-- every body at its failure indicator. The algorithm is written in step 5 and the
-- suite in step 4c.
--
-- Indicators:
--   * only the Node links may be absent (Nothing): Node.next, llHead, llTail,
--     stTop, qFront and qRear are @Maybe Node@; no public operation returns
--     @Maybe@;
--   * operations that extract a number return Int and fail with -1;
--   * flags return Bool and fail with False;
--   * counters return Int and start at 0;
--   * linkedListDelete, stackPop and queueDequeue return a tuple
--     @(value or success, structure)@: on failure, the indicator and the same
--     structure, never an exception.
--
-- Haskell is immutable: every operation returns a new value.
module DataStructuresBasics
  ( Node(..)
  , LinkedList(..)
  , Stack(..)
  , Queue(..)
  , newNode
  , nodeWithNext
  , newLinkedList
  , linkedListHead
  , linkedListInsertHead
  , linkedListInsertTail
  , linkedListDelete
  , linkedListIsEmpty
  , linkedListSize
  , newStack
  , stackPush
  , stackPop
  , stackPeek
  , stackIsEmpty
  , stackSize
  , newQueue
  , queueEnqueue
  , queueDequeue
  , queuePeek
  , queueIsEmpty
  , queueSize
  ) where

-- ---------------------------------------------------------------------------
-- Types
-- ---------------------------------------------------------------------------

-- | Shared linked cell used by LinkedList, Stack and Queue.
--
-- The value is fixed at creation and the link is the module's only absent
-- value: a cell is built with 'newNode' (the contract's @init@) and its link is
-- updated with 'nodeWithNext' (@set_next@).
data Node = Node
  { value :: Int
  , next  :: Maybe Node
  }

-- | Singly linked list built from scratch over Node.
--
-- 'newLinkedList' (@init@) is the empty list: no head, no tail, counter at
-- zero.
data LinkedList = LinkedList
  { llHead  :: Maybe Node
  , llTail  :: Maybe Node
  , llCount :: Int
  }

-- | LIFO stack built from scratch over Node.
data Stack = Stack
  { stTop   :: Maybe Node
  , stCount :: Int
  }

-- | FIFO queue built from scratch over Node.
data Queue = Queue
  { qFront :: Maybe Node
  , qRear  :: Maybe Node
  , qCount :: Int
  }

-- ---------------------------------------------------------------------------
-- Node
-- ---------------------------------------------------------------------------

-- | Builds a cell holding @v@ with no link (@init@).
newNode :: Int -> Node
newNode v = Node { value = v, next = Nothing }

-- | Returns a copy of @node@ whose link points at @link@ (@set_next@).
nodeWithNext :: Node -> Node -> Node
nodeWithNext node link = node { next = Just link }

-- ---------------------------------------------------------------------------
-- Auxiliaries: the chain is rebuilt on the way back, so no chain is walked
-- twice and no list of values is materialised
-- ---------------------------------------------------------------------------

-- | Chain with @newNode@ linked after its last node.
appendNode :: Maybe Node -> Node -> Maybe Node
appendNode Nothing newNode = Just newNode
appendNode (Just node) newNode = case next node of
  Nothing   -> Just (nodeWithNext node newNode)
  Just rest -> Just node { next = appendNode (Just rest) newNode }

-- | Removes the first occurrence of @v@: whether it was there and the resulting
-- chain (the same one when it was not).
removeFirst :: Maybe Node -> Int -> (Bool, Maybe Node)
removeFirst Nothing _ = (False, Nothing)
removeFirst (Just node) v
  | value node == v = (True, next node)
  | otherwise       = case removeFirst (next node) v of
      (True, rest) -> (True, Just node { next = rest })
      (False, _)   -> (False, Just node)

-- | Last cell of a chain.
lastNode :: Node -> Node
lastNode node = case next node of
  Nothing   -> node
  Just rest -> lastNode rest

-- ---------------------------------------------------------------------------
-- LinkedList
-- ---------------------------------------------------------------------------

-- | Empty list: no head, no tail and counter at zero (@init@).
newLinkedList :: LinkedList
newLinkedList = LinkedList { llHead = Nothing, llTail = Nothing, llCount = 0 }

-- | Head value, or -1 when the list is empty (@get_head@).
linkedListHead :: LinkedList -> Int
linkedListHead ll = case llHead ll of
  Just node -> value node
  Nothing   -> -1

-- | Inserts @v@ at the front of the list (@insert_head@).
linkedListInsertHead :: Int -> LinkedList -> LinkedList
linkedListInsertHead v l =
  let newHead = (newNode v) { next = llHead l }
      newTail = case llTail l of
        Nothing -> Just newHead
        Just _  -> llTail l
  in LinkedList { llHead = Just newHead, llTail = newTail, llCount = llCount l + 1 }

-- | Inserts @v@ at the end of the list (@insert_tail@).
--
-- The tail cell cannot be linked in place (the chain is immutable), so the path
-- down to it is rebuilt: O(n) instead of the O(1) the specification promises.
linkedListInsertTail :: Int -> LinkedList -> LinkedList
linkedListInsertTail v l = case llHead l of
  Nothing -> LinkedList { llHead = Just newTail, llTail = Just newTail, llCount = 1 }
  Just _  -> LinkedList
    { llHead  = appendNode (llHead l) newTail
    , llTail  = Just newTail
    , llCount = llCount l + 1
    }
  where
    newTail = newNode v

-- | Removes the first occurrence of @v@ (@delete@): @(True, the resulting
-- list)@ when it was there and @(False, the same list)@ when it was not.
linkedListDelete :: Int -> LinkedList -> (Bool, LinkedList)
linkedListDelete v l = case llHead l of
  Nothing -> (False, l)
  Just _  ->
    let (found, newHead) = removeFirst (llHead l) v
    in if found
         then
           let newTail = case newHead of
                 Nothing   -> Nothing
                 Just node -> Just (lastNode node)
           in (True, LinkedList { llHead = newHead, llTail = newTail, llCount = llCount l - 1 })
         else (False, l)

-- | True when the list stores no nodes (@is_empty@).
linkedListIsEmpty :: LinkedList -> Bool
linkedListIsEmpty ll = llCount ll == 0

-- | Number of nodes stored (@size@).
linkedListSize :: LinkedList -> Int
linkedListSize ll = llCount ll

-- ---------------------------------------------------------------------------
-- Stack
-- ---------------------------------------------------------------------------

-- | Empty stack: no top and counter at zero (@init@).
newStack :: Stack
newStack = Stack { stTop = Nothing, stCount = 0 }

-- | Pushes @v@ on top of the stack (@push@).
stackPush :: Int -> Stack -> Stack
stackPush v s = Stack { stTop = Just newNode, stCount = stCount s + 1 }
  where newNode = Node { value = v, next = stTop s }

-- | Removes and returns the top value (@pop@); @(-1, the same stack)@ when the
-- stack is empty.
stackPop :: Stack -> (Int, Stack)
stackPop s = case stTop s of
  Nothing   -> (-1, s)
  Just node -> (value node, Stack { stTop = next node, stCount = stCount s - 1 })

-- | Returns the top value without removing it, or -1 when empty (@peek@).
stackPeek :: Stack -> Int
stackPeek s = case stTop s of
  Nothing   -> -1
  Just node -> value node

-- | True when the stack stores no nodes (@is_empty@).
stackIsEmpty :: Stack -> Bool
stackIsEmpty s = stCount s == 0

-- | Number of nodes stored (@size@).
stackSize :: Stack -> Int
stackSize s = stCount s

-- ---------------------------------------------------------------------------
-- Queue
-- ---------------------------------------------------------------------------

-- | Empty queue: no front, no rear and counter at zero (@init@).
newQueue :: Queue
newQueue = Queue { qFront = Nothing, qRear = Nothing, qCount = 0 }

-- | Adds @v@ at the rear of the queue (@enqueue@).
--
-- The path down to the rear is rebuilt, like in 'linkedListInsertTail': O(n)
-- instead of the O(1) the specification promises.
queueEnqueue :: Int -> Queue -> Queue
queueEnqueue v q = case qFront q of
  Nothing -> Queue { qFront = Just newRear, qRear = Just newRear, qCount = 1 }
  Just _  -> Queue
    { qFront = appendNode (qFront q) newRear
    , qRear  = Just newRear
    , qCount = qCount q + 1
    }
  where
    newRear = newNode v

-- | Removes and returns the front value (@dequeue@); @(-1, the same queue)@
-- when the queue is empty.
queueDequeue :: Queue -> (Int, Queue)
queueDequeue q = case qFront q of
  Nothing   -> (-1, q)
  Just node ->
    let newFront = next node
        newRear = case newFront of
          Nothing -> Nothing
          Just _  -> qRear q
    in (value node, Queue { qFront = newFront, qRear = newRear, qCount = qCount q - 1 })

-- | Returns the front value without removing it, or -1 when empty (@peek@).
queuePeek :: Queue -> Int
queuePeek q = case qFront q of
  Nothing   -> -1
  Just node -> value node

-- | True when the queue stores no nodes (@is_empty@).
queueIsEmpty :: Queue -> Bool
queueIsEmpty q = qCount q == 0

-- | Number of nodes stored (@size@).
queueSize :: Queue -> Int
queueSize q = qCount q
