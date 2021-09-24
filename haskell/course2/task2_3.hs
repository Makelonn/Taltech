import Control.Monad.Trans.State (put)
-- Fibonnacci sequence up to an index

fibonnacciToIndex :: Int -> [Int]
fibonnacciToIndex 1 = [1,0]
fibonnacciToIndex index =
    mysum : minus1List
    where
        minus1List = fibonnacciToIndex (index-1)
        minus1:minus2:xs = minus1List
        mysum = minus1 + minus2

main=do
    putStrLn "Enter a number : "
    num <- getLine
    let index_fib = (read num :: Int)
    putStr("The Fibonnacci sequence up to the " ++ show index_fib ++ " is ")
    print(fibonnacciToIndex index_fib)