module NaiveSortSpec (spec) where

import NaiveSort
import Test.Hspec

-- Casos de prueba de la especificación 05_Naive_Sort.md
standardInput :: [Int]
standardInput = [5, 2, 9, 1, 5, 6]

standardOutput :: [Int]
standardOutput = [1, 2, 5, 5, 6, 9]

sortedInput :: [Int]
sortedInput = [1, 2, 3, 4, 5]

sortedOutput :: [Int]
sortedOutput = [1, 2, 3, 4, 5]

reverseInput :: [Int]
reverseInput = [5, 4, 3, 2, 1]

reverseOutput :: [Int]
reverseOutput = [1, 2, 3, 4, 5]

identicalInput :: [Int]
identicalInput = [7, 7, 7, 7]

identicalOutput :: [Int]
identicalOutput = [7, 7, 7, 7]

negativeInput :: [Int]
negativeInput = [3, -1, 4, -5, 0]

negativeOutput :: [Int]
negativeOutput = [-5, -1, 0, 3, 4]

singleInput :: [Int]
singleInput = [42]

singleOutput :: [Int]
singleOutput = [42]

emptyInput :: [Int]
emptyInput = []

emptyOutput :: [Int]
emptyOutput = []

-- Caso nulo omitido: `[Int]` no admite `null` ni una lista inválida, así que el
-- indicador de fallo del contrato no es representable (igual que en F# y Gleam).
-- Aislamiento: las listas de Haskell son inmutables, así que cada caso puede
-- usar la constante compartida sin riesgo de contaminar los siguientes.
cases :: [(String, [Int], [Int])]
cases =
  [ ("an unsorted array", standardInput, standardOutput)
  , ("an already sorted array", sortedInput, sortedOutput)
  , ("a reverse ordered array", reverseInput, reverseOutput)
  , ("an array of identical elements", identicalInput, identicalOutput)
  , ("an array with negative numbers", negativeInput, negativeOutput)
  , ("a single element array", singleInput, singleOutput)
  , ("an empty array", emptyInput, emptyOutput)
  ]

-- Helper compartido: recibe la función a probar y el nombre del algoritmo, y
-- ejecuta todos los casos con un mensaje descriptivo cada uno.
assertSortsAllCases :: ([Int] -> [Int]) -> String -> Spec
assertSortsAllCases sort algorithm = mapM_ runCase cases
  where
    runCase (description, input, expected) =
      it (algorithm ++ " should sort " ++ description) $
        sort input `shouldBe` expected

spec :: Spec
spec = do
  describe "selection_sort" $ assertSortsAllCases selectionSort "selection_sort"
  describe "bubble_sort" $ assertSortsAllCases bubbleSort "bubble_sort"
  describe "insertion_sort" $ assertSortsAllCases insertionSort "insertion_sort"
