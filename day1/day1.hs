import Data.List(sort)
import Control.Monad(forM_)

-- Slices a list of lines in groups separated by empty lines
records :: [String] -> [[String]]
records lines = records' lines [] []
  where
    records' ("":ls) r rs = records' ls    [] (r:rs)
    records'  (l:ls) r rs = records' ls (l:r) rs
    records'      [] r rs = r:rs


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
