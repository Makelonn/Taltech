-- Take a list of years as an argument
-- Find the first year in list that is leap --> USING LAMBDA OR HIGHER ORDER FCT°

firstLeap:: [Int] -> Int
firstLeap list =  head$filter (\year -> (mod year 4 == 0) && ((mod year 100 /= 0)  || ((mod year 100 == 0) && (mod year 400 ==0)))) list

main=do
    let list = [2022,2012,2021]
    let list2 = [2020,2012,2021]
    putStrLn("The first leap year in the list " ++ show list ++ " is : ")
    print(firstLeap list)
    putStrLn("The first leap year in the list " ++ show list2 ++ " is : ")
    print(firstLeap list2)
    
