module RecursiveSpec (spec) where

import Numbers
import Test.Hspec

spec :: Spec
spec = describe "recursive" $ do
  describe "sumFirstNRec" $ do
    it "returns 0 for n = 0" $ sumFirstNRec 0 `shouldBe` 0
    it "sums the first n positive integers" $ sumFirstNRec 3 `shouldBe` 6

  describe "factorialRec" $ do
    it "returns 1 for n = 0" $ factorialRec 0 `shouldBe` 1
    it "computes the factorial of n" $ factorialRec 4 `shouldBe` 24

  describe "fibonacciRec" $ do
    it "returns 0 for n = 0" $ fibonacciRec 0 `shouldBe` 0
    it "returns 1 for n = 1" $ fibonacciRec 1 `shouldBe` 1
    it "computes the nth fibonacci number" $ fibonacciRec 6 `shouldBe` 8

  describe "greatestCommonDivisorRec" $ do
    it "computes the gcd of two numbers" $ greatestCommonDivisorRec 12 8 `shouldBe` 4
    it "returns 1 for coprime numbers" $ greatestCommonDivisorRec 7 5 `shouldBe` 1

  describe "leastCommonMultipleRec" $ do
    it "computes the lcm of two numbers" $ leastCommonMultipleRec 4 6 `shouldBe` 12
    it "computes the lcm of another pair" $ leastCommonMultipleRec 6 8 `shouldBe` 24
