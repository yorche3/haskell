module Main (main) where

import Test.Hspec
import qualified DataStructuresBasicsSpec

main :: IO ()
main = hspec $ do
  DataStructuresBasicsSpec.spec
