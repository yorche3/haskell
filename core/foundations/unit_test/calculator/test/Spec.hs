module Main (main) where

import Calculator
import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "Calculator" $ do
    it "addition" $ addition 2 3 `shouldBe` 5
    it "subtraction" $ subtraction 5 3 `shouldBe` 2
    it "multiplication" $ multiplication 4 3 `shouldBe` 12
    it "division" $ division 10 3 `shouldBe` 3
    it "modulus" $ modulus 10 3 `shouldBe` 1
