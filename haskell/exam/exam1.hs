--Program in Haskell that takes list of int and modify
-- takes out the negative elem if length != 2
--

replicateNTime :: Int -> [Int]
replicateNTime 0 = []
replicateNTime a = if a < 0 then []
                else replicate a a

multiCopy ::[Int] -> [Int]
multiCopy [] = []
multiCopy myList = if length myList == 2 then myList
                else concat (map replicateNTime myList)

main = do
    let list1 = [2,3,-5,6]
    let list2 = [3,1,0,7,1]
    let list3 = [2,4]
    let list4 = [2,-4]
    let result1 = multiCopy list1
    let result2 = multiCopy list2
    let result3 = multiCopy list3
    let result4 = multiCopy list4
    putStrLn ("List " ++ show list1 ++ " gives " ++ show result1)
    putStrLn ("List " ++ show list2 ++ " gives " ++ show result2)
    putStrLn ("List " ++ show list3 ++ " gives " ++ show result3)
    putStrLn ("List " ++ show list4 ++ " gives " ++ show result4)