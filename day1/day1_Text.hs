{-# LANGUAGE OverloadedStrings #-}

import           Control.Monad  (forM_)
import           Data.List      (sortBy)
import qualified Data.Text      as T
import qualified Data.Text.IO   as TIO
import qualified Data.Text.Read as TR

part1 = maximum . map sum

part2 = sum . take 3 . sortBy (flip compare) . map sum

main = do
  groups <- readGroups <$> TIO.readFile "input.txt"
  putStrLn $ "Part 1: " ++ show (part1 groups)
  putStrLn $ "Part 2: " ++ show (part2 groups)
  where
    readGroups = map (map readInt . T.lines) . T.splitOn "\n\n"
    readInt t =
      let (Right (n, _)) = TR.decimal t
       in n
