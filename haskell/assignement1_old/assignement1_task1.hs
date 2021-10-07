-- Write a program in haskell that determines a String is palindrome or not. 
-- Examples of some palindroms: Anna, Civic, Kayak, Level, Madam etc.
import Data.Char

palindrome :: String -> Bool
palindrome word = map toLower word == reverse (map toLower word)

main=do
    let aList1 = "anna"
    let aList2 = "Civic"
    let aList3 = "KayaK"
    let aList4 = "Palindrome"
    let aList5 = [1,2,1,3,4,5,6,6]

    putStr(show aList1 ++ " gives : ")
    print(palindrome aList1)
    putStr(show aList2 ++ " gives : ")
    print(palindrome aList2)
    putStr(show aList3 ++ " gives : ")
    print(palindrome aList3)
    putStr(show aList4 ++ " gives : ")
    print(palindrome aList4)

--Do we need to manage sentences ?