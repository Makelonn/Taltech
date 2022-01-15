import Control.Monad
import Data.List
--pathdinging for knight
--return the closest point you can reach from the position


type KnightPos = (Int, Int) --row, cols

--List of reachable places
moveKnight :: KnightPos -> [KnightPos]
moveKnight (c,r) = filter onBoard
    [(c+2, r-1), (c+2,r+1), (c-2,r-1), (c-2, r+1),
    (c+1, r+2), (c+1, r-2), (c-1, r-2), (c-1, r+2)]
    where onBoard (c,r) = c `elem` [1..8] && r `elem` [1..8]

howMuchMove :: Int -> KnightPos -> KnightPos -> Int 
howMuchMove n start end = if canReachinN n start end then n
                        else howMuchMove (n-1) start end

canReachinN :: Int -> KnightPos -> KnightPos -> Bool
canReachinN n start end
    | (n==1 && end `elem` moveKnight start) = 1
    | (n==2 && (end `elem` (start >>= moveKnight >>= moveKnight)) ) = 2
    | (n==3 && end `elem` start >>= moveKnight >>= moveKnight >>= moveKnight ) = 3
    | (n==4 && end `elem` start >>= moveKnight >>= moveKnight >>= moveKnight >>= moveKnight) = 4
    | (n==5 && end `elem` start >>= moveKnight >>= moveKnight >>= moveKnight >>= moveKnight >>= moveKnight ) = 5
    | (n==6 && end `elem` start >>= moveKnight >>= moveKnight >>= moveKnight >>= moveKnight >>= moveKnight >>= moveKnight ) = 6
    | otherwise = error ("More than 6 move : error all cases are reachable in 6 moves")

main=do
    let listallpos = concat (map (\x -> (map (\y -> (x,y) ) [1..8])) [1..8])
    print listallpos
