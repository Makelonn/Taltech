-- Find the longest palindrome of a list, if nmixedPal2 return nmixedPal2
import Data.Char

--Check if its a palindrome
palindrome :: String -> Bool
palindrome "" = False
palindrome word = map toLower word == reverse (map toLower word)


--Return the longest word of the list
longestWord :: [String] -> Maybe String
longestWord [] = Nothing
longestWord (x:xs) = if length x > length max then Just x else max
  where max = longestWord xs

-- Return the longest palindrome of the list if there is one
longestPalindromeList :: [String] -> Maybe String
longestPalindromeList [] = Nothing
longestPalindromeList wordList = longestWord (filter palindrome wordList)

main=do
    let palindList = ["kayak", "lol", "reviver"]
    let noPalind = ["Hello", "there", "general", "kenobi"]
    let mixedPalin = ["Pot", "reviver", "star"]
    let mixedPal2 = ["Croissant", "lol"]

    putStr(show palindList ++ " gives : ")
    print(longestPalindromeList palindList)
    putStr(show noPalind ++ " gives : ")
    print(longestPalindromeList noPalind)
    putStr(show mixedPalin ++ " gives : ")
    print(longestPalindromeList mixedPalin)
    putStr(show mixedPal2 ++ " gives : ")
    print(longestPalindromeList mixedPal2)

