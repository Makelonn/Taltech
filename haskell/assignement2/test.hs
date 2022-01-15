
type KnightPos = (Int, Int)

moveKnight :: KnightPos -> [KnightPos]
moveKnight (c,r) = filter onBoard
    [(c+2, r-1), (c+2,r+1), (c-2,r-1), (c-2, r+1),
    (c+1, r+2), (c+1, r-2), (c-1, r-2), (c-1, r+2)]
    where onBoard (c,r) = c `elem` [1..8] && r `elem` [1..8]

search:: KnightPos -> [KnightPos] -> KnightPos -> [KnightPos]
search end path start =
    if end `elem` (moveKnight start) then do path++[end]--If we arrive we return
    else do
        startNeighbors <- (moveKnight start)
        possibleNodes <- filter (\x -> x `elem` path) startNeighbors
        if possibleNodes == [] then []
        else if end `elem` possibleNodes then path++[end]
            else map search 

main=do
    let pos1 = (1,1)
    let pos2 = (8,8)
    print ( search pos2 [[]] pos1)