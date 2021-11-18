-- Write a program in Haskell that calculates the following expression 
-- (1+2)/(9*2)+56*3.4
-- using recursive datatype 

data Expr a b= Num Float a
    | Add (Expr a) (Expr b)
    | Mul (Expr a) (Expr b)
    | Div (Expr a) (Expr b)


--applicative functors
instance Functor Expr where
    fmap f(Add x) = Num f x
    fmap f(Mul x) = Num f x
    fmap f(Div x) = Num f x

    
main = do
    --let nb = Add (Div (Add (Num 1) (Num 2)) (Mul (Num 9) (Num 2))) ( Mul (Num 56) (Num 3.4))
    let nb1 = Num 1
    let nb2 = Num 2
    print(fmap () nb1 nb2)
    putStr ( "Result of (1+2)/(9*2)+56*3.4 is " ++  show nb1 ++ " and real result is ~190.56")