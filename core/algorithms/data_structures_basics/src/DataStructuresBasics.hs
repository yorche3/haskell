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
-- LinkedList
-- ---------------------------------------------------------------------------

-- | Empty list: no head, no tail and counter at zero (@init@).
newLinkedList :: LinkedList
newLinkedList = LinkedList { llHead = Nothing, llTail = Nothing, llCount = 0 }

-- | Head value, or -1 when the list is empty (@get_head@).
linkedListHead :: LinkedList -> Int
linkedListHead _ = -1

-- | Inserts @v@ at the front of the list (@insert_head@).
linkedListInsertHead :: Int -> LinkedList -> LinkedList
linkedListInsertHead _ l = l

-- | Inserts @v@ at the end of the list (@insert_tail@).
linkedListInsertTail :: Int -> LinkedList -> LinkedList
linkedListInsertTail _ l = l

-- | Removes the first occurrence of @v@ (@delete@): @(True, the resulting
-- list)@ when it was there and @(False, the same list)@ when it was not.
linkedListDelete :: Int -> LinkedList -> (Bool, LinkedList)
linkedListDelete _ l = (False, l)

-- | True when the list stores no nodes (@is_empty@).
linkedListIsEmpty :: LinkedList -> Bool
linkedListIsEmpty _ = False

-- | Number of nodes stored (@size@).
linkedListSize :: LinkedList -> Int
linkedListSize _ = 0

-- ---------------------------------------------------------------------------
-- Stack
-- ---------------------------------------------------------------------------

-- | Empty stack: no top and counter at zero (@init@).
newStack :: Stack
newStack = Stack { stTop = Nothing, stCount = 0 }

-- | Pushes @v@ on top of the stack (@push@).
stackPush :: Int -> Stack -> Stack
stackPush _ s = s

-- | Removes and returns the top value (@pop@); @(-1, the same stack)@ when the
-- stack is empty.
stackPop :: Stack -> (Int, Stack)
stackPop s = (-1, s)

-- | Returns the top value without removing it, or -1 when empty (@peek@).
stackPeek :: Stack -> Int
stackPeek _ = -1

-- | True when the stack stores no nodes (@is_empty@).
stackIsEmpty :: Stack -> Bool
stackIsEmpty _ = False

-- | Number of nodes stored (@size@).
stackSize :: Stack -> Int
stackSize _ = 0

-- ---------------------------------------------------------------------------
-- Queue
-- ---------------------------------------------------------------------------

-- | Empty queue: no front, no rear and counter at zero (@init@).
newQueue :: Queue
newQueue = Queue { qFront = Nothing, qRear = Nothing, qCount = 0 }

-- | Adds @v@ at the rear of the queue (@enqueue@).
queueEnqueue :: Int -> Queue -> Queue
queueEnqueue _ q = q

-- | Removes and returns the front value (@dequeue@); @(-1, the same queue)@
-- when the queue is empty.
queueDequeue :: Queue -> (Int, Queue)
queueDequeue q = (-1, q)

-- | Returns the front value without removing it, or -1 when empty (@peek@).
queuePeek :: Queue -> Int
queuePeek _ = -1

-- | True when the queue stores no nodes (@is_empty@).
queueIsEmpty :: Queue -> Bool
queueIsEmpty _ = False

-- | Number of nodes stored (@size@).
queueSize :: Queue -> Int
queueSize _ = 0
