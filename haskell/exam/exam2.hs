import Data.Char (digitToInt)
--Program that hask for a binary number and return the indexes of zeros

--The input is valid if we have only 0 and 1, we compare with char to avoir unnecessary conversion
isValidInput:: Char -> Bool 
isValidInput a = a `elem` ['0','1']

indexOfZero :: [Int] -> [Int]
indexOfZero [] = []
indexOfZero a = filter ((== 0) . (a !!)) [0..(length a - 1)]

main=do
    putStrLn "Enter your number :"
    a <- getLine
    if all isValidInput a then do
        let converted = map digitToInt a
        putStrLn ("Your number is " ++ show converted)
        --Note : we map (+1) so the index start a 1 as in the example, but just show indexOfZero would work, but the index would start at 0 instead of 1 
        putStrLn ("Indexes of 0 in this number are " ++ show (map (+1) (indexOfZero converted)))
    else putStrLn "Invalid input : you must only enter 0 and 1"