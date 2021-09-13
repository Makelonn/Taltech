-- Is the integer odd or even

isEven a = mod a 2 == 0

main = do
    putStrLn("Enter a number : ")
    num <- getLine
    let x = (read num :: Int)
    putStr("The number " ++ show x ++ " is ")
    if isEven x then
        putStrLn("even.")
    else
        putStrLn("odd.")