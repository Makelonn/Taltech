-- take in entry a list of triangle ( base + height )
-- find the area of all, return the max area triangle --> USING LAMBDA OR HIGHER ORDER FCT°

data Triangle = Triangle{base :: Double, height :: Double}deriving(Show)

area:: Triangle -> Double
area triangle = ( base triangle * height triangle ) / 2


maxAreaTriangle :: [Triangle] -> Triangle
maxAreaTriangle list = head (filter (\x -> area x == maximum(map area list)) list)

main=do
    let triangle1 = Triangle 2 2
    let triangle2 = Triangle 4 8
    let triangle3 = Triangle 1 2
    let triangle4 = Triangle 4 8
    let triangle5  = Triangle 14 5
    let t_list = [triangle1,triangle2,triangle3,triangle4,triangle5]
    putStrLn("The maximum triangle form the list : " ++ show t_list ++ " is : ")
    print(maxAreaTriangle t_list)