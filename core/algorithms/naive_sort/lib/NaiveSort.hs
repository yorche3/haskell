-- |
-- naive_sort.hs — Módulo Naive Sort con ordenamientos elementales
--
-- Especificación: 05_Naive_Sort
--
-- Funciones del contrato ([Int] -> [Int]), de menor a mayor:
--   selectionSort  — encuentra el mínimo del tramo no ordenado y lo ubica al inicio
--   bubbleSort     — compara e intercambia adyacentes, con bandera `swapped`
--   insertionSort  — inserta cada elemento en su sub-lista ordenada
--
-- Caso nulo: `[Int]` no admite `null` ni una lista inválida, así que el
-- indicador de fallo del lenguaje no es representable (igual que en F# y Gleam).
module NaiveSort
  ( selectionSort, bubbleSort, insertionSort
  ) where

selectionSort :: [Int] -> [Int]
selectionSort [] = []
selectionSort [x] = [x]
selectionSort xs =
    let (minVal, rest) = pickMin xs
    in minVal : selectionSort rest

pickMin :: [Int] -> (Int, [Int])
pickMin [] = error "Cannot pick minimum from an empty list"
pickMin (x:xs) = go x [] xs
  where
    go minVal acc [] = (minVal, reverse acc)
    go minVal acc (y:ys)
      | y < minVal = go y (minVal:acc) ys
      | otherwise  = go minVal (y:acc) ys

bubbleSort :: [Int] -> [Int]
bubbleSort [] = []
bubbleSort [x] = [x]
bubbleSort xs =
    let (swapped, result) = bubblePass xs
    in if swapped then bubbleSort result else result

bubblePass :: [Int] -> (Bool, [Int])
bubblePass [] = (False, [])
bubblePass [x] = (False, [x])
bubblePass (x:y:xs)
    | x > y     = let (swapped, rest) = bubblePass (x:xs)
                  in (True, y:rest)
    | otherwise = let (swapped, rest) = bubblePass (y:xs)
                  in (swapped, x:rest)

insertionSort :: [Int] -> [Int]
insertionSort [] = []
insertionSort (x:xs) = insert x (insertionSort xs)

insert :: Int -> [Int] -> [Int]
insert x [] = [x]
insert x (y:ys)
    | x <= y    = x : y : ys
    | otherwise = y : insert x ys