module Main where

import qualified Data.ByteString.Lazy        as L
import           Data.ByteString.Lazy.Search (replace)
import           Data.ByteString.UTF8        (fromString)
import           System.Environment          (getArgs)
import           System.Console.ANSI


color :: Color -> String -> String
color c txt = set ++ txt ++ reset
  where
    set = setSGRCode [SetConsoleIntensity BoldIntensity, SetColor Foreground Vivid c]
    reset = setSGRCode [SetConsoleIntensity NormalIntensity, Reset]

higlight :: String -> L.ByteString -> L.ByteString
higlight pat = replace (fromString pat) (fromString $ color Red pat)

main :: IO ()
main = do
    [pat] <- getArgs
    L.interact $ higlight pat
