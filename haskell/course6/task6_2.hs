-- Write a program in Haskell to solve equation 
-- ax2 + bx + c = 0 for any x
-- using functor

solveEquation :: (Float, Float, Float) -> (Float, Float)
solveEquation (a,b,c) =
    ((-b - sqrt delta) / (2 * a),(- b + sqrt delta) / (2 * a))
    where delta = (b ^2) - 4 * a * c

data MyFunctor a = Coef a
    | Result a deriving Show

instance Functor MyFunctor where
    fmap f(Coef x) = Result (f x)

main = do
    putStrLn "Please enter the coefficient a, b, and c for the solution fo a*x^2 + b*x + c = 0"
    a <- readLn
    b <- readLn
    c <- readLn
    putStrLn ("Computing the results of " ++ show (a::Float) ++"*x^2 + " ++ show (b::Float) ++ "*x + " ++ show (c::Float))
    let myEq = Coef (a, b, c)
    let myResult = fmap solveEquation myEq
    putStrLn "Note that if the equation has no real solution, the result will be (NaN, NaN) ! "
    putStrLn (show myResult)