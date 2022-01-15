import Data.List
import Data.Array
import Control.Monad
-- Programm that find nodes between nodes
-- Graph is stored with list (Node number, node label) and list of edges (node start, node end)


-- Graph definition - TODO
type Node = Int
data Graph = Graph{v::[(Node, Char)], e::[(Node, Node)]} deriving (Show)

instance Semigroup Graph where
    Graph av ae <> Graph bv be = Graph (av <> bv) (ae <> be)

nodeList :: Graph -> [(Int, Char)]
nodeList (Graph v _) = v

edgeList :: Graph -> [(Int, Int)]
edgeList (Graph _ e) = e

--Ordering list of edges and nodes
orderGraph :: Graph -> Graph
orderGraph gr = Graph (sort (nodeList gr)) (sort (edgeList gr))

--Removing duplicate label edges functions - TODO

removeDupLabel::[(Node, Char)] -> [(Node, Char)]
removeDupLabel [] = []
removeDupLabel [a] = [a]
removeDupLabel list = if elem (fst x) (map fst xs) then removeDupLabel xs
                    else (removeDupLabel xs) ++ [x]
                    where
                        x = last list
                        xs = init list

removeDupEdge :: [(Node, Node)] -> [(Node, Node)]
removeDupEdge [] = []
removeDupEdge [a] = [a]
removeDupEdge list = if (elem x xs) || (elem (snd x, fst x) xs) then removeDupEdge xs
                    else (removeDupEdge xs) ++ [x]
                    where
                        x = last list
                        xs = init list

--Helper function
helper :: Graph -> Graph
helper gr = Graph (removeDupLabel (nodeList ordgr)) (removeDupEdge (edgeList ordgr)) where ordgr = orderGraph gr

-- List of index -> list of value -> list of value which were at said indexes
takeIndexes :: [Int] -> [a] -> [a]
takeIndexes [] _ = []
takeIndexes _ [] = []
takeIndexes i xs = (xs!!head i):takeIndexes (tail i) xs

--Get all neighbors of a node
accessibleList:: Graph -> Node -> [Node]
accessibleList gr node = if (elem node (map fst (edgeList gr))) then a --If there is edge from the node
                        else [] --if no edge from the node : nothing
                        where a =  (takeIndexes (elemIndices node (map fst (edgeList gr))) (map snd (edgeList gr)))
                        --won't be [] because of first test | takeIndexes (list of node which 'receive' a edge) (list of index where the edge came from our node)

--Getting the path
--search:: Monad m => Graph -> Int -> Int -> Maybe [[Int]]
--Start node -> Already visited -> List of path
search:: Graph -> Node -> [Node] -> Node -> [Node]
search gr end path start = do
    let startNeigh = accessibleList gr start
    let possibleNode = filter (\x ->not (x `elem` path)) startNeigh
    if null possibleNode then []
    else if end `elem` possibleNode then path++[start, end]
    else do
        let listPath = map (\x -> search gr end path x) possibleNode
        if listPath == [] then []
        else start:listPath!!1

main=do
    let gr1 = Graph [(1, 'b'), (0, 'a'), (2, 'c'), (3, 'd')] [(0,1), (0,2), (2,3), (1,3)]
    let gr1bis = helper gr1
    putStrLn "------Graph example for subject------"
    putStrLn ("From a->d : " ++ show (search gr1bis 3 [] 0) )
    putStrLn ("From a->b : " ++ show (search gr1bis 1 [] 0) )
    putStrLn ("From a->c : " ++ show (search gr1bis 2 [] 0) )
    putStrLn ("From b->d : " ++ show (search gr1bis 3 [] 1) )
    putStrLn ("From c->d : " ++ show (search gr1bis 3 [] 2) )

