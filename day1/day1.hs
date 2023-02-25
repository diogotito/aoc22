import           Control.Monad (forM_)
import           Data.List     (sort)

-- Slices a list of lines in groups separated by empty lines
records :: [String] -> [[String]]
records lines = go lines [] []
  where
    go ("":ls) r rs = go ls [] (r : rs)
    go (l:ls) r rs  = go ls (l : r) rs
    go [] r rs      = r : rs

part1 :: String -> Int
part1 input =
  let groups = records . lines $ input
   in maximum $ map (sum . map read) groups

part2 :: String -> Int
part2 input =
  let groups = records . lines $ input
   in sum . take 3 . reverse . sort . map (sum . map read) $ groups

main :: IO ()
main = do
  input <- readFile "input.txt"
  forM_ (zip [1, 2] [part1, part2]) $ \(i, fn) -> do
    putStrLn $ "=== Part " ++ (show i) ++ " ==="
    putStrLn . show . fn $ input
    putStrLn ""
