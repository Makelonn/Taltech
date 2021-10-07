-- Output of or gate

data EntryGate = EntryGate{a :: Int, b :: Int}deriving(Show)

orGate :: EntryGate -> Int
orGate entry 
    | c > 0 = 1
    | otherwise  = 0
    where c = a entry + b entry

main=do
    let zero = EntryGate  0 0
    let half1 = EntryGate 0 1
    let half2 = EntryGate 1 0
    let one = EntryGate 1 1
    putStr(show zero ++ " gives : ")
    print(orGate zero)
    putStr(show half1 ++ " gives : ")
    print(orGate half1)
    putStr(show half2 ++ " gives : ")
    print(orGate half2)
    putStr(show one ++ " gives : ")
    print(orGate one)