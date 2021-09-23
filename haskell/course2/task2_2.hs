-- Midpoint of a line segment using tuple

midPointLine :: (Double, Double) -> (Double, Double) -> (Double, Double)
midPointLine (x1,y1) (x2,y2) = (x3,y3)
    where
        x3 = (x1+x2)/2
        y3 = (y1+y2)/2

main=do
    putStrLn("Mid point of (2,2) (2,2) is " ++ show (midPointLine (2,2) (2,2)))
    putStrLn("Mid point of (1,1) (1,1) is " ++ show (midPointLine (1,1) (1,1)))
    putStrLn("Mid point of (2,1) (1,4) is " ++ show (midPointLine (2,1) (1,4)))
