-- Is the integer odd or even

isEven a = mod a 2 == 0

main = do
    putStrLn "Test 1"
    print (isEven 1)
    putStrLn "Test 2"
    print (isEven 2)
    putStrLn "Test 3"
    print (isEven 3)
    putStrLn "Test 10"
    print (isEven 10)
    putStrLn "Test 11"
    print (isEven 11)