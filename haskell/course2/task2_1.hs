-- Grade depending on scale
between :: Int -> Int -> Int -> Bool
between a b c --return if a is between b an c
    | a >= b = a <= c --we check if a>=b , if yes the statement is 'is a > c' so we have b<=a<c
    | otherwise = False

gradingScale :: Int -> String
gradingScale gradeNb 
    |between gradeNb 80 90 = "A+"
    |between gradeNb 70 79 = "A"
    |between gradeNb 60 69= "B"
    |between gradeNb 50 59= "C"
    |between gradeNb 0 50 ="Fail :("
    |otherwise="This is not a grade !"

main=do
    putStrLn("Enter a grade : ")
    num <- getLine
    let grade = (read num :: Int)
    putStrLn(gradingScale grade)