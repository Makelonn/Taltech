import Data.Char
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
test_input :: String -> Bool
test_input "" = False 
test_input xs = all isDigit xs


main=do
    putStrLn "Enter a number"
    inputLine <- getLine
    if test_input inputLine then 
        putStrLn "This is a real number !"
    else putStrLn "Oh no ! Our real number :( it's broken"