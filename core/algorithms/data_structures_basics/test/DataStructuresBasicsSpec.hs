module DataStructuresBasicsSpec (spec) where

import Data.Maybe (isNothing)
import DataStructuresBasics
import Test.Hspec

-- Casos de prueba de la especificación 06_Data_Structures_Basics.md.
--
-- Los pasos de cada estructura son sucesivos sobre la misma instancia: Haskell
-- es inmutable, así que cada paso encadena el valor que devuelve el anterior.
-- Las aserciones solo usan operaciones del contrato, y comparan números o
-- banderas: `Nothing`/`Just` aparecen únicamente al observar el enlace de un
-- `Node`.

-- ---------------------------------------------------------------------------
-- Node — 2 casos de la especificación
-- ---------------------------------------------------------------------------

nodeA :: Node
nodeA = newNode 10

nodeB :: Node
nodeB = newNode 20

nodeALinked :: Node
nodeALinked = nodeWithNext nodeA nodeB

-- ---------------------------------------------------------------------------
-- LinkedList — 5 pasos sobre la misma lista
-- ---------------------------------------------------------------------------

listEmpty :: LinkedList
listEmpty = newLinkedList

listAfter10 :: LinkedList
listAfter10 = linkedListInsertTail 10 listEmpty

listAfter20 :: LinkedList
listAfter20 = linkedListInsertTail 20 listAfter10

listAfter5 :: LinkedList
listAfter5 = linkedListInsertHead 5 listAfter20

listInserted :: LinkedList
listInserted = linkedListInsertTail 10 listAfter5

firstDelete :: (Bool, LinkedList)
firstDelete = linkedListDelete 10 listInserted

absentDelete :: (Bool, LinkedList)
absentDelete = linkedListDelete 99 (snd firstDelete)

headDelete :: (Bool, LinkedList)
headDelete = linkedListDelete 5 (snd absentDelete)

middleDelete :: (Bool, LinkedList)
middleDelete = linkedListDelete 20 (snd headDelete)

lastDelete :: (Bool, LinkedList)
lastDelete = linkedListDelete 10 (snd middleDelete)

-- ---------------------------------------------------------------------------
-- Stack — 4 pasos sobre la misma pila
-- ---------------------------------------------------------------------------

stackEmpty :: Stack
stackEmpty = newStack

emptyPop :: (Int, Stack)
emptyPop = stackPop stackEmpty

stackAfter10 :: Stack
stackAfter10 = stackPush 10 stackEmpty

stackAfter20 :: Stack
stackAfter20 = stackPush 20 stackAfter10

stackAfter30 :: Stack
stackAfter30 = stackPush 30 stackAfter20

firstPop :: (Int, Stack)
firstPop = stackPop stackAfter30

stackReused :: Stack
stackReused = stackPush 40 (snd firstPop)

secondPop :: (Int, Stack)
secondPop = stackPop stackReused

thirdPop :: (Int, Stack)
thirdPop = stackPop (snd secondPop)

fourthPop :: (Int, Stack)
fourthPop = stackPop (snd thirdPop)

finalPop :: (Int, Stack)
finalPop = stackPop (snd fourthPop)

-- ---------------------------------------------------------------------------
-- Queue — 4 pasos sobre la misma cola
-- ---------------------------------------------------------------------------

queueEmpty :: Queue
queueEmpty = newQueue

emptyDequeue :: (Int, Queue)
emptyDequeue = queueDequeue queueEmpty

queueAfter10 :: Queue
queueAfter10 = queueEnqueue 10 queueEmpty

queueAfter20 :: Queue
queueAfter20 = queueEnqueue 20 queueAfter10

queueAfter30 :: Queue
queueAfter30 = queueEnqueue 30 queueAfter20

firstDequeue :: (Int, Queue)
firstDequeue = queueDequeue queueAfter30

queueReused :: Queue
queueReused = queueEnqueue 40 (snd firstDequeue)

secondDequeue :: (Int, Queue)
secondDequeue = queueDequeue queueReused

thirdDequeue :: (Int, Queue)
thirdDequeue = queueDequeue (snd secondDequeue)

fourthDequeue :: (Int, Queue)
fourthDequeue = queueDequeue (snd thirdDequeue)

finalDequeue :: (Int, Queue)
finalDequeue = queueDequeue (snd fourthDequeue)

-- ---------------------------------------------------------------------------
-- Suite
-- ---------------------------------------------------------------------------

spec :: Spec
spec = do
  describe "Node" $ do
    describe "initialize and observe value/link" $ do
      it "get_value should return 10" $
        value nodeA `shouldBe` 10
      it "get_next should be absent" $
        isNothing (next nodeA) `shouldBe` True
    describe "initialize another node, link and traverse" $ do
      it "get_value(get_next(a)) should return 20" $
        (value <$> next nodeALinked) `shouldBe` Just 20
      it "the next of b should be absent" $
        isNothing (next nodeB) `shouldBe` True

  describe "linked_list" $ do
    describe "empty state" $ do
      it "is_empty should return True" $
        linkedListIsEmpty listEmpty `shouldBe` True
      it "size should return 0" $
        linkedListSize listEmpty `shouldBe` 0
      it "get_head should return -1" $
        linkedListHead listEmpty `shouldBe` (-1)
    describe "insert at both ends" $ do
      it "size should return 4" $
        linkedListSize listInserted `shouldBe` 4
      it "get_head should return 5" $
        linkedListHead listInserted `shouldBe` 5
    describe "delete first occurrence" $ do
      it "delete(10) should report success" $
        fst firstDelete `shouldBe` True
      it "get_head should still return 5" $
        linkedListHead (snd firstDelete) `shouldBe` 5
      it "size should return 3" $
        linkedListSize (snd firstDelete) `shouldBe` 3
    describe "absent value" $ do
      it "delete(99) should report failure" $
        fst absentDelete `shouldBe` False
      it "get_head should not change (5)" $
        linkedListHead (snd absentDelete) `shouldBe` 5
      it "size should not change (3)" $
        linkedListSize (snd absentDelete) `shouldBe` 3
    describe "empty the list" $ do
      it "delete(5) should report success" $
        fst headDelete `shouldBe` True
      it "delete(20) should report success" $
        fst middleDelete `shouldBe` True
      it "delete(10) should report success" $
        fst lastDelete `shouldBe` True
      it "is_empty should return True" $
        linkedListIsEmpty (snd lastDelete) `shouldBe` True
      it "size should return 0" $
        linkedListSize (snd lastDelete) `shouldBe` 0
      it "get_head should return -1" $
        linkedListHead (snd lastDelete) `shouldBe` (-1)

  describe "stack" $ do
    describe "empty state and failed removal" $ do
      it "is_empty should return True" $
        stackIsEmpty stackEmpty `shouldBe` True
      it "size should return 0" $
        stackSize stackEmpty `shouldBe` 0
      it "peek should return -1" $
        stackPeek stackEmpty `shouldBe` (-1)
      it "pop should return -1" $
        fst emptyPop `shouldBe` (-1)
      it "the stack should stay empty after the failed pop" $
        stackIsEmpty (snd emptyPop) `shouldBe` True
    describe "LIFO and non-mutating peek" $ do
      it "peek should return 30" $
        stackPeek stackAfter30 `shouldBe` 30
      it "size should return 3" $
        stackSize stackAfter30 `shouldBe` 3
    describe "removal and reuse" $ do
      it "the first pop should return 30" $
        fst firstPop `shouldBe` 30
      it "the second pop should return 40" $
        fst secondPop `shouldBe` 40
      it "the third pop should return 20" $
        fst thirdPop `shouldBe` 20
      it "the fourth pop should return 10" $
        fst fourthPop `shouldBe` 10
      it "is_empty should return True" $
        stackIsEmpty (snd fourthPop) `shouldBe` True
      it "size should return 0" $
        stackSize (snd fourthPop) `shouldBe` 0
    describe "empty after removal" $ do
      it "pop should return -1" $
        fst finalPop `shouldBe` (-1)
      it "is_empty should stay True" $
        stackIsEmpty (snd finalPop) `shouldBe` True

  describe "queue" $ do
    describe "empty state and failed removal" $ do
      it "is_empty should return True" $
        queueIsEmpty queueEmpty `shouldBe` True
      it "size should return 0" $
        queueSize queueEmpty `shouldBe` 0
      it "peek should return -1" $
        queuePeek queueEmpty `shouldBe` (-1)
      it "dequeue should return -1" $
        fst emptyDequeue `shouldBe` (-1)
      it "the queue should stay empty after the failed dequeue" $
        queueIsEmpty (snd emptyDequeue) `shouldBe` True
    describe "FIFO and non-mutating peek" $ do
      it "peek should return 10" $
        queuePeek queueAfter30 `shouldBe` 10
      it "size should return 3" $
        queueSize queueAfter30 `shouldBe` 3
    describe "removal and reuse" $ do
      it "the first dequeue should return 10" $
        fst firstDequeue `shouldBe` 10
      it "the second dequeue should return 20" $
        fst secondDequeue `shouldBe` 20
      it "the third dequeue should return 30" $
        fst thirdDequeue `shouldBe` 30
      it "the fourth dequeue should return 40" $
        fst fourthDequeue `shouldBe` 40
      it "is_empty should return True" $
        queueIsEmpty (snd fourthDequeue) `shouldBe` True
      it "size should return 0" $
        queueSize (snd fourthDequeue) `shouldBe` 0
    describe "empty after removal" $ do
      it "dequeue should return -1" $
        fst finalDequeue `shouldBe` (-1)
      it "is_empty should stay True" $
        queueIsEmpty (snd finalDequeue) `shouldBe` True
