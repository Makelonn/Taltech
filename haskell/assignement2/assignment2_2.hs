import Data.List
-- Programm that find nodes between nodes
-- Graph is stored with list (Node number, node label) and list of edges (node start, node end)


-- Graph definition - TODO
data Graph = Graph{v::[(Int, Char)], e::[(Int, Int)]} deriving (Show)

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

removeDupLabel::[(Int, Char)] -> [(Int, Char)]
removeDupLabel [] = []
removeDupLabel [a] = [a]
removeDupLabel list = if elem (fst x) (map fst xs) then removeDupLabel xs
                    else (removeDupLabel xs) ++ [x]
                    where
                        x = last list
                        xs = init list

removeDupEdge :: [(Int, Int)] -> [(Int, Int)]
removeDupEdge e = e


--Getting the path


main=do
    let gr = Graph [(1, 'b'), (0, 'a'), (2, 'c'), (3, 'd')] [(0,1), (0,2), (2,3), (1,3)]
    let gr1 = Graph [(0, 'a'),(1, 'b'), (2,'c'), (1,'g')] [(0,1), (1,3), (1,0), (1,3), (2,4)]
    putStrLn "Before :"
    print (nodeList gr1)
    print (removeDupLabel (nodeList gr1))

