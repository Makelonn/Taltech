-- Fibonnacci sequence up to an index

fibonnacciToIndex :: Int -> [a]
fibonnacciToIndex 0 = []
fibonnacciToIndex index =
    minus1List ++ [minus1 + minus2]
    where
        minus1List = fibonnacciToIndex index-1
        minus1 = last minus1List
        minus2 = minus1List!!(lenght(minus1List)-1)

main=do
    putStrLn("Enter a number : ")
    num <- getLine
    let index_fib = (read num :: Int)
    putStrLn("The Fibonnacci sequence up to the " ++ show index_fib ++ " is " ++ show fibonnacciToIndex index_fib)