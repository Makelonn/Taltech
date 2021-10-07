--Remove all even number from a list using filter
import Data.List

withoutEven :: [Int] -> [Int]
withoutEven [] = []
withoutEven nbList = nbList \\ filter even nbList

main=do
    let list1 = [1,2,3,4,5,6,7,8,9,10]
    let list2 = [1,3,5,7]
    let list3 = [2,4,6,8]
    putStr(show list1 ++ " gives : ")
    print(withoutEven list1)
    putStr(show list2 ++ " gives : ")
    print(withoutEven list2)
    putStr(show list3 ++ " gives : ")
    print(withoutEven list3)