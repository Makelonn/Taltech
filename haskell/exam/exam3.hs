--Takes a list a return list of list that can be done with removing 2 elements of the list

removeX:: [a] -> Int -> [a]
removeX [] _ = []
removeX (x:xs) a 
    | a == 0 = xs
    | otherwise = x:removeX xs (a-1)


-- Get all the possible sub list
subList :: [a] -> [[a]]
subList [] =  []
subList (x:xs) = [x] : foldr fct [] (subList xs)
  where fct ys r = ys : (x : ys) : r

--Keep only the sublist that have the size - 2
drops :: [a] -> [[a]]
drops [] = []
drops a = if length a <= 2 then []
        else filter (\x -> length x == size) (subList a)
        where size = length a - 2


main=do
    let list1 = ['s']
    let list2 = [1,7]
    let list3 = [1,2,3]
    let list4 = ['a', 'f', 'r', 's']

    let result1 = drops list1
    let result2 = drops list2
    let result3 = drops list3
    let result4 = drops list4

    putStrLn ("List " ++ show list1 ++ " gives " ++ show result1)
    putStrLn ("List " ++ show list2 ++ " gives " ++ show result2)
    putStrLn ("List " ++ show list3 ++ " gives " ++ show result3)
    putStrLn ("List " ++ show list4 ++ " gives " ++ show result4)
