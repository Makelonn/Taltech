-- Midpoint of a line segment using tuple

midPointLine :: (Double, Double) -> (Double, Double) -> (Double, Double)
midPointLine (x1,y1) (x2,y2) = putStrLn("The mid point of " ++ show (x1,y1) ++ " and " ++ show (x2,y2) ++ "is" ++ show point) where
    point = ((x1+x2)/2, (y1+y2)/2)

main=do
    midPointLine (2,2) (2,2)
    midPointLine (1,1) (1,1)