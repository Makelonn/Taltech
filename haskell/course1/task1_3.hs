--Euclidian distance

euclidian (x1,y1,x2,y2) = putStrLn("The distance between (" ++ show x1 ++","++show y1++") and (" ++ show x2 ++ ","++show y2++") is " ++ show dist) where
    dist = sqrt( (x2-x1)**2 + (y2-y1)**2)

main = do
    euclidian(-3,-4,17,6.5)