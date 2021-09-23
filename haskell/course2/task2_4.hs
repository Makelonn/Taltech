-- Removes consecutive duplicate from the list
-- init <- remove the last elem
removeDup :: [a] -> [a]
removeDup [x] = [x]
removeDup entryList = 
    if (x == y) then 
        outList <- removeDup x ++ [tail entryList]
    else outList <- [x,y] ++  removeDup tail entryList
    where
        x:y:xs = entryList

main=do
    aList1 = [1,2,3,3,4,5,6]
    aList2 = [1,1,2,2,3,3,4,4,5,5,6,6]
    aList3 = [1,1,2,3,4,5,6]
    aList4 = [1,2,3,4,5,6,6]

    putStrLn(removeDup aList1)
    putStrLn(removeDup aList2)
    putStrLn(removeDup aList3)
    putStrLn(removeDup aList4)