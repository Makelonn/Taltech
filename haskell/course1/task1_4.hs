-- leap year or not

isLeap year = putStrLn("The year " ++ show year ++ " is leap : " ++ show state) where
    state = (mod year 4 == 0) && ((mod year 100 /= 0)  || ((mod year 100 == 0) && (mod year 400 ==0)))

main = do
    isLeap 2012
    isLeap 2014
    isLeap 2020
    isLeap 2021