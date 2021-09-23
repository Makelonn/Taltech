-- Fibonnacci sequence up to an index

fibonnacciToIndex :: Int -> [Int]
fibonnacciToIndex 1 = [0,1]
fibonnacciToIndex index =
    [sum, minus1, minus2] ++ minus1List
    where
        minus1List = fibonnacciToIndex (index-1)
        minus1:minus2:xs = minus1List
        sum = minus1 + minus2

main=do
    putStrLn "Enter a number : "
    num <- getLine
    let index_fib = (read num :: Int)
    putStrLn("The Fibonnacci sequence up to the " ++ show index_fib ++ " is ")
    let fibo_list = fibonnacciToIndex index_fib