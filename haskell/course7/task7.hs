import Control.Monad (replicateM)
--Using the function movknight and in3 from lecture
--write a programm that tells you if you can reach a pos from another in 5 moves

type KnightPos = (Int, Int) --row, cols

moveKnight :: KnightPos -> [KnightPos]
moveKnight (c,r) = filter onBoard
    [(c+2, r-1), (c+2,r+1), (c-2,r-1), (c-2, r+1),
    (c+1, r+2), (c+1, r-2), (c-1, r-2), (c-1, r+2)]
    where onBoard (c,r) = c `elem` [1..8] && r `elem` [1..8]

in3 :: KnightPos -> [KnightPos]
in3 start = do
    first <- moveKnight start
    second <- moveKnight first
    moveKnight second
--in3 start = return start >>= moveKnight >>= moveKnight >>= moveKnight is the same !

in5 :: KnightPos -> [KnightPos]
in5 start = return start >>= moveKnight >>= moveKnight >>= moveKnight >>= moveKnight >>= moveKnight

canReachIn3 :: KnightPos -> KnightPos -> Bool 
canReachIn3 start end = end `elem` in3 start

canReachIn5 :: KnightPos -> KnightPos -> Bool 
canReachIn5 start end = end `elem` in5 start

main=do
    let myK1 = (1,1)
    let myK2 = (1,2) --(1,2) is false | (6,3) is reachable in 3 and 5moves | (7,8) is reachable in 5moves
    let myK3 = (6,3)
    let myK4 = (7,8)
    putStrLn ("Start position :" ++ show myK1)
    putStrLn ("We are gonna study 3 other positions : " ++ show myK2 ++ " and " ++ show myK3 ++ " and " ++ show myK4)

    putStrLn ("Position " ++ show myK2 ++ "(from " ++ show myK1 ++ ") is reachable in 3 moves : " ++ show (canReachIn3 myK1 myK2) ++ "\n\t\t\t\t    and in 5 moves : " ++ show (canReachIn5 myK1 myK2))
    putStrLn ("Position " ++ show myK3 ++ "(from " ++ show myK1 ++ ") is reachable in 3 moves : " ++ show (canReachIn3 myK1 myK3) ++ "\n\t\t\t\t    and in 5 moves : " ++ show (canReachIn5 myK1 myK3))
    putStrLn ("Position " ++ show myK4 ++ "(from " ++ show myK1 ++ ") is reachable in 3 moves : " ++ show (canReachIn3 myK1 myK4) ++ "\n\t\t\t\t    and in 5 moves : " ++ show (canReachIn5 myK1 myK4))


