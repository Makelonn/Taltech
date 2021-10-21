-- take a list of nb as an argument
-- find all squares of this number
-- find the sum of the square < 100 --> USING FOLD

sumOfCase:: [Int] -> Int
sumOfCase [] = 0
sumOfCase mylist = foldr (+) 0  a
    where a = filter (<100) (map (^2) mylist)

main=do
    let list = [1,2,3,100,200]
    let list2 = [1,2,3]
    let list3 = [100,400]
    putStr ("The sum of the square < 100 of the number of the list :" ++ show list ++ " is : ")
    print(sumOfCase list)
    putStr ("The sum of the square < 100 of the number of the list :" ++ show list2 ++ " is : ")
    print(sumOfCase list2)
    putStr ("The sum of the square < 100 of the number of the list :" ++ show list3 ++ " is : ")
    print(sumOfCase list3)