-- Grade depending on scale

gradingScale :: Int -> String
gradingScale gradeNb 
    |80 < gradeNb < 90 = "A+"
    |70 < gradeNb < 79 = "A"
    |60 < gradeNb < 69 = "B"
    |50 < gradeNb < 59 = "C"
    | gradeNb < 50 ="Fail :("
    |otherwise="This is not a grade !"

main=doq
    putStrLn("Enter a grade : ")
    num <- getLine
    let grade = (read num :: Int)
    putStrLn(gradingScale grade)