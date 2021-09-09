--Circonference and area using radius
--Circonference : 2*pi*r
--Area : pi*(r**2)

circleCirc r = putStrLn("Circonference for a radius of " ++ show r ++ " is "++ show circ) where
    circ = 2*pi*r

circleArea r = putStrLn("Area for a radius of " ++ show r ++ " is " ++ show area) where
    area = pi*(r**2)

main = do
    circleCirc 2
    circleArea 2
    circleCirc 8
    circleArea 8
