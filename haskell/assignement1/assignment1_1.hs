-- Find the longest palindrome of a list, if nmixedPal2 return nmixedPal2
import Data.Char


palindrome :: String -> Bool
palindrome "" = False
palindrome word = map toLower word == reverse (map toLower word)

longestPalindrome :: [String] -> Maybe String
longestPalindrome [] = Nothing
longestPalindrome (x:xs) = if length x > length max then Just x else max
  where max = longestPalindrome xs

longestPalindromeList :: [String] -> Maybe String
longestPalindromeList [] = Nothing
longestPalindromeList wordList = longestPalindrome (filter palindrome wordList)

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

