--Write a program in Haskell to input electricity unit charge and  
--calculate the total electricity bill according to the given condition: 
--For first 50 units 0.50 $/unit 
--For next 100 units 0.75 $/unit 
--For next 100 units 1.20 $/unit 
--For unit above 250 1.50 $/unit 
--An additional surcharge of 20% is added to the bill.

between :: Int -> Int -> Int -> Bool
between a b c --return if a is between b an c
    | a >= b = a <= c --we check if a>=b , if yes the statement is 'is a > c' so we have b<=a<c
    | otherwise = False

electricityBill :: Int -> Float 
electricityBill a
    | between a 0 50 = fromIntegral a*0.50*1.2
    | between a 50 150 = (50*0.5 + (fromIntegral a-50)*0.75)*1.2
    | between a 150 250 = (50*0.5 + 100*0.75 + (fromIntegral a-150)*1.2)*1.2
    | a > 250 = (50 * 0.5 + 100 * 0.75 + 100 * 1.2 + (fromIntegral a-250) * 1.5) * 1.2


main=do
    let units_for_bills = 25
    putStr(show units_for_bills ++ " units gives : ")
    print(electricityBill units_for_bills)
    let units_for_bills2 = 100
    putStr(show units_for_bills2 ++ " units gives : ")
    print(electricityBill units_for_bills2)
    let units_for_bills3 = 175
    putStr(show units_for_bills3 ++ " units gives : ")
    print(electricityBill units_for_bills3)
