-- Removes consecutive duplicate from the list
-- init <- remove the last elem
removeDup :: [Int] -> [Int]
removeDup [x] = [x]
removeDup entryList =
    if x == y then
        x : removeDup the_tail
    else [x,y] ++  removeDup the_tail
    where
        x:y:xs = entryList
        the_tail = if null entryList then [] else tail (tail entryList)

main=do
    let aList1 = [1,2,3,3,4,5,6]
    let aList2 = [1,1,2,2,3,3,4,4,5,5,6,6]
    let aList3 = [1,1,2,3,4,5,6]
    let aList4 = [1,2,3,4,5,6,6]

    print(removeDup aList1)
    print(removeDup aList2)
    print(removeDup aList3)
    print(removeDup aList4)