--Circonference and area using radius
--Circonference : 2*pi*r
--Area : pi*(r**2)

circonference r = putStrLn("Circonference for " ++ show r ++ " is "++ show circ) where
    circ = 2*pi*r

area r = pi*(r**2)

main = do
    putStrLn("Test for 2")
    putStrLn("Circonference")
    print(circonference 2)
    putStrLn("Area")
    print(area 2)
    putStrLn("Test for 8")
    putStrLn("Circonference")
    print(circonference 8)
    putStrLn("Area")
    print(area 8)