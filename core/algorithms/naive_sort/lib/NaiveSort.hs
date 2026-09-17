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
