module Numbers
  ( sumFirstNRec, factorialRec, fibonacciRec, greatestCommonDivisorRec, leastCommonMultipleRec
  , sumFirstNAcc, factorialAcc, fibonacciAcc, greatestCommonDivisorAcc, leastCommonMultipleAcc
  , sumFirstNIte, factorialIte, fibonacciIte, greatestCommonDivisorIte, leastCommonMultipleIte
  ) where

sumFirstNRec :: Int -> Int
sumFirstNRec n
  | n <= 0    = 0
  | otherwise = n + sumFirstNRec (n - 1)

factorialRec :: Int -> Int
factorialRec n
  | n <= 1    = 1
  | otherwise = n * factorialRec (n - 1)

fibonacciRec :: Int -> Int
fibonacciRec n
  | n <= 0    = 0
  | n == 1    = 1
  | otherwise = fibonacciRec (n - 1) + fibonacciRec (n - 2)

greatestCommonDivisorRec :: Int -> Int -> Int
greatestCommonDivisorRec a 0 = a
greatestCommonDivisorRec a b = greatestCommonDivisorRec b (a `mod` b)

leastCommonMultipleRec :: Int -> Int -> Int
leastCommonMultipleRec a b = (a * b) `div` greatestCommonDivisorRec a b

sumFirstNAcc :: Int -> Int
sumFirstNAcc n = sumFirstHelp n 0
  where
    sumFirstHelp m acc
      | m <= 0    = acc
      | otherwise = sumFirstHelp (m - 1) (acc + m)

factorialAcc :: Int -> Int
factorialAcc n = factorialHelp n 1
  where
    factorialHelp m acc
      | m <= 1    = acc
      | otherwise = factorialHelp (m - 1) (acc * m)

fibonacciAcc :: Int -> Int
fibonacciAcc n = fibonacciHelp n 0 1
  where
    fibonacciHelp i acc2 acc1
      | i <= 0    = acc2
      | otherwise = fibonacciHelp (i - 1) acc1 (acc2 + acc1)

greatestCommonDivisorAcc :: Int -> Int -> Int
greatestCommonDivisorAcc a 0 = a
greatestCommonDivisorAcc a b = greatestCommonDivisorAcc b (a `mod` b)

leastCommonMultipleAcc :: Int -> Int -> Int
leastCommonMultipleAcc a b = (a * b) `div` greatestCommonDivisorAcc a b

sumFirstNIte :: Int -> Int
sumFirstNIte n
  | n <= 0    = 0
  | otherwise = foldl' (+) 0 [1 .. n]

factorialIte :: Int -> Int
factorialIte n
  | n <= 1    = 1
  | otherwise = foldl' (*) 1 [2 .. n]

fibonacciIte :: Int -> Int
fibonacciIte n
  | n <= 1    = n
  | otherwise = snd (foldl' step (0, 1) [2 .. n])
  where
    step (acc2, acc1) _ = (acc1, acc2 + acc1)

greatestCommonDivisorIte :: Int -> Int -> Int
greatestCommonDivisorIte a b = fst (until ((== 0) . snd) (\(x, y) -> (y, x `mod` y)) (a, b))

leastCommonMultipleIte :: Int -> Int -> Int
leastCommonMultipleIte a b = (a * b) `div` greatestCommonDivisorIte a b
