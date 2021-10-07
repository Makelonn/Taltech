-- Using Map Module a program that output [(1,[4]) ,(2,[8]), (3,[12]), (4,[16])]

import qualified Data.Map as Map

makeMap :: Int -> Map.Map Int [Int]
makeMap a = Map.fromList (map values [1..a]) where values b = (b, [b*4])

main=do
    let aMap = makeMap 4
    print aMap
