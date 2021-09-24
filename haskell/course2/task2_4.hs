-- Removes consecutive duplicate from the list
-- init <- remove the last elem
removeDup :: [Int] -> [Int]
removeDup [] = []
removeDup [x] = [x]
removeDup entryList =
    if x == y then
        x : removeDup the_tail
    else x: removeDup (y:the_tail)
    where
        x = head entryList
        y =entryList!!1 
        the_tail = tail (tail entryList)

main=do
    let aList1 = [1,2,3,3,4,5,6]
    let aList2 = [1,2,3,4,5,6,6]
    let aList3 = [1,1,2,3,4,5,6]
    let aList4 = [1,1,2,2,3,3,4,4,5,5,6,6]
    --let aList5 = [1,2,1,3,4,5,6,6]

    putStr(show aList1 ++ " gives : ")
    print(removeDup aList1)
    putStr(show aList2 ++ " gives : ")
    print(removeDup aList2)
    putStr(show aList3 ++ " gives : ")
    print(removeDup aList3)
    putStr(show aList4 ++ " gives : ")
    print(removeDup aList4)
    --putStr(show aList5 ++ "gives : ")
    --print(removeDup aList5)