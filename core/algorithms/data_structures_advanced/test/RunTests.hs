module Main (main) where

import Test.Hspec
import qualified DataStructuresAdvancedSpec

main :: IO ()
main = hspec $ do
  DataStructuresAdvancedSpec.spec
