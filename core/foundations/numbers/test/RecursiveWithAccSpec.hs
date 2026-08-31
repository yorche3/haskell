module RecursiveWithAccSpec (spec) where

import Numbers
import Test.Hspec

spec :: Spec
spec = describe "recursive_with_accumulator" $ do
  describe "sumFirstNAcc" $ do
    it "returns 0 for n = 0" $ sumFirstNAcc 0 `shouldBe` 0
    it "sums the first n positive integers" $ sumFirstNAcc 3 `shouldBe` 6

  describe "factorialAcc" $ do
    it "returns 1 for n = 0" $ factorialAcc 0 `shouldBe` 1
    it "computes the factorial of n" $ factorialAcc 4 `shouldBe` 24

  describe "fibonacciAcc" $ do
    it "returns 0 for n = 0" $ fibonacciAcc 0 `shouldBe` 0
    it "returns 1 for n = 1" $ fibonacciAcc 1 `shouldBe` 1
    it "computes the nth fibonacci number" $ fibonacciAcc 6 `shouldBe` 8

  describe "greatestCommonDivisorAcc" $ do
    it "computes the gcd of two numbers" $ greatestCommonDivisorAcc 12 8 `shouldBe` 4
    it "returns 1 for coprime numbers" $ greatestCommonDivisorAcc 7 5 `shouldBe` 1

  describe "leastCommonMultipleAcc" $ do
    it "computes the lcm of two numbers" $ leastCommonMultipleAcc 4 6 `shouldBe` 12
    it "computes the lcm of another pair" $ leastCommonMultipleAcc 6 8 `shouldBe` 24
