import Data.Char
import Distribution.Compat.CharParsing (digit)
--Write a programm that ask a natural number -> [0...999999]
--Convert it to words (if suitable)


-- Personnal idea :
-- function that count the hundred, tens, units, etc..
-- Use this to return the word ( return "" if 0)
-- Concatenate all of this


--example : 1764
-- fct: digit to str : 1-> one | 2-> two ...
-- fct: pow 10 to str : 10 -> ten | 100 -> hundred ...
-- nb : 20 30 40...
-- 1764 %% 1000 ->

--Will test if can be read as a real number
--(Delete all the digit from the begining, is something is left, it is not a number)

--All the strings we need to  use
digitStr :: [String]
digitStr = ["", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
teenStr :: [String]
teenStr = ["ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
tenStr :: [String]
tenStr = ["", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]


-- |inputIsRealNumber : check if the input is convertible to int > 0
inputIsRealNumber :: String -> Bool
inputIsRealNumber "" = False
inputIsRealNumber xs = all isDigit xs

-- |between if the first parameter is between the 2 second (b <= a < c)
between :: Int -> Int -> Int -> Bool
between a b c
    | a >= b = a < c
    | otherwise = False

-- |getDigitTen return the digit corresponding for a power of ten (215 100 will gives 2)
getDigitTen::Int -> Int -> Int
getDigitTen nb powten = div (nb - mod nb powten) powten --we know the number is divisble by powten


convertNbToStr :: Int -> String
convertNbToStr nb
    | nb < 10 = digitStr!!nb
    | between nb 10 100 = if nb<20 then teenStr!!mod nb 10 else tenStr!!(getDigitTen nb 10 - 1)++ " " ++ convertNbToStr (mod nb 10)
    | between nb 100 1000 = convertNbToStr (getDigitTen nb 100) ++ " hundred " ++ if not (null (convertNbToStr (mod nb 100)) )then "and " ++ convertNbToStr (mod nb 100) else ""
    | between nb 1000 10000 = convertNbToStr (getDigitTen nb 1000) ++ " thousand " ++ if not (null (convertNbToStr (mod nb 1000)) )then "and " ++ convertNbToStr (mod nb 1000) else ""
    | between nb 10000 100000 = convertNbToStr (getDigitTen nb 10000) ++ " hundred thousand " ++ if not (null (convertNbToStr (mod nb 1000)) )then "and " ++ convertNbToStr (mod nb 1000) else ""
    | between nb 100000 1000000 = convertNbToStr (getDigitTen nb 100000) ++ " hundred thousand " ++ if not (null (convertNbToStr (mod nb 10000)) )then "and " ++ convertNbToStr (mod nb 10000) else ""
    | otherwise = "a really big number (which is not implemented because it is over 999999)."

main=do
    putStrLn "Enter a number :"
    inputLine <- getLine
    if inputIsRealNumber inputLine then do
        let nb = read inputLine::Int
        putStrLn "This is a real number ! "
        putStrLn ("The number is " ++ convertNbToStr nb)
    else
        putStrLn "Invalid input !"