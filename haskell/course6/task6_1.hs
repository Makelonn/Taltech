-- Write a program in Haskell that calculates the following expression 
-- (1+2)/(9*2)+56*3.4
-- using recursive datatype 

data Expr = Num Float 
    | Add Expr Expr
    | Mul Expr Expr
    | Div Expr Expr
    deriving Show


calculate :: Expr -> Float
calculate (Num a) = a
calculate (Add a b) = calculate a + calculate b
calculate (Mul a b) = calculate a * calculate b
calculate (Div a b) = calculate a / calculate b
    
main = do
    let nb = Add (Div (Add (Num 1) (Num 2)) (Mul (Num 9) (Num 2))) ( Mul (Num 56) (Num 3.4))
    putStrLn("In recursive datatype, (1+2)/(9*2)+56*3.4 is "++ show nb)
    let result = calculate nb
    putStr ( "Result of (1+2)/(9*2)+56*3.4 is " ++  show result ++ " (calculated by hand is ~190.56)")