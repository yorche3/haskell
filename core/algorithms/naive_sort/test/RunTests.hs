module Main (main) where

import Test.Hspec
import qualified NaiveSortSpec

main :: IO ()
main = hspec $ do
  NaiveSortSpec.spec
