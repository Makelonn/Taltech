 -- We have 3 set of fruits
 -- write a programm to concatenate the sets
 -- using monoids and data type fruit

--tip for myself tomorrow :  family exemple lecture 6

data Fruits = FruitsList {fruit::[String]}
    deriving Show


instance Semigroup Fruits where
    FruitsList a <> FruitsList b = FruitsList (a<>b)

fruitSet1::Fruits
fruitSet1 = FruitsList ["mango","melon","apple"]

fruitSet2::Fruits
fruitSet2 = FruitsList ["berry","banana","kiwi", "pineapple"]

fruitSet3::Fruits
fruitSet3 = FruitsList ["grapes","orange"]

main=do
    putStrLn ("The fruits list are :" ++ show fruitSet1 ++ " and " ++ show fruitSet2 ++ " and " ++ show fruitSet3)
    let newFruitSet = fruitSet1 <> fruitSet2 <> fruitSet3
    putStrLn ("The obtained fruit set is the following: " ++ show newFruitSet)