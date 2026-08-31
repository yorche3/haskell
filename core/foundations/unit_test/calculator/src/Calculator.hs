module Calculator (addition, subtraction, multiplication, division, modulus) where

addition :: Int -> Int -> Int
addition a b = a + b

subtraction :: Int -> Int -> Int
subtraction a b = a - b

multiplication :: Int -> Int -> Int
multiplication a b = loop 0 b
  where
    loop acc count
      | count <= 0 = acc
      | otherwise = loop (addition acc a) (subtraction count 1)

division :: Int -> Int -> Int
division a b = loop a 0
  where
    loop remaining quotient
      | remaining < b = quotient
      | otherwise = loop (subtraction remaining b) (addition quotient 1)

modulus :: Int -> Int -> Int
modulus a b = subtraction a (multiplication b (division a b))
