module IterativeSpec (spec) where

import Numbers
import Test.Hspec

spec :: Spec
spec = describe "iterative" $ do
  describe "sumFirstNIte" $ do
    it "returns 0 for n = 0" $ sumFirstNIte 0 `shouldBe` 0
    it "sums the first n positive integers" $ sumFirstNIte 3 `shouldBe` 6

  describe "factorialIte" $ do
    it "returns 1 for n = 0" $ factorialIte 0 `shouldBe` 1
    it "computes the factorial of n" $ factorialIte 4 `shouldBe` 24

  describe "fibonacciIte" $ do
    it "returns 0 for n = 0" $ fibonacciIte 0 `shouldBe` 0
    it "returns 1 for n = 1" $ fibonacciIte 1 `shouldBe` 1
    it "computes the nth fibonacci number" $ fibonacciIte 6 `shouldBe` 8

  describe "greatestCommonDivisorIte" $ do
    it "computes the gcd of two numbers" $ greatestCommonDivisorIte 12 8 `shouldBe` 4
    it "returns 1 for coprime numbers" $ greatestCommonDivisorIte 7 5 `shouldBe` 1

  describe "leastCommonMultipleIte" $ do
    it "computes the lcm of two numbers" $ leastCommonMultipleIte 4 6 `shouldBe` 12
    it "computes the lcm of another pair" $ leastCommonMultipleIte 6 8 `shouldBe` 24
