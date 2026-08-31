module Main (main) where

import Test.Hspec
import qualified RecursiveSpec
import qualified RecursiveWithAccSpec
import qualified IterativeSpec

main :: IO ()
main = hspec $ do
  RecursiveSpec.spec
  RecursiveWithAccSpec.spec
  IterativeSpec.spec
