
type Node = String
type Edge = (Node, Node)
type Graph = [(Node, [Node])]

-- Funct to insert edge in graph
insertEdge :: Edge -> Graph -> Graph
insertEdge (parent, child) [] = [(parent, [child])]                               --if graph empty then start new graph
insertEdge (parent, child) ((node, children):rem)                                   
    | node == parent = (node, child:children) : rem                               --if current nodee is a parent then it adds the current child to that nodes children
    | otherwise = (node, children) : insertEdge (parent, child) rem               --if not insert edges in remaining graph

-- Funct to build the graph from a list of edges
buildGraph :: [Edge] -> Graph                                                     --this inserts each edge one by one using insert edge ,it starts from empty list
buildGraph = foldr insertEdge []

-- funct Find root of graph
findRoot :: Graph -> [Node]                                                       --finds node that doesn't have incoming edge
findRoot graph = filter (not . (`elem` allChildren)) (map fst graph)              -- removes the element from parent nodes that aper in children
    where allChildren = concatMap snd graph                                       -- takes all children in a single list

--to convert the subgraph starting from the given node to string
graph2str :: Graph -> Node -> String                                               
graph2str graph node = case lookup node graph of                                    
    Just children -> node ++ children2str graph children
    Nothing -> node

--to convert list of children to string
children2str :: Graph -> [Node] -> String
children2str graph [] = ""
children2str graph children = "(" ++ concatMap (\child -> graph2str graph child ++ ",") (init children) ++ lastchild2str graph children ++ ")"

-- funct to convert the last child to string
lastchild2str :: Graph -> [Node] -> String
lastchild2str graph children
  | null children = ""
  | otherwise = graph2str graph (last children)


--removve the last comma
removeCommaAfterLastChild :: String -> String
removeCommaAfterLastChild s = reverse (dropWhile (==',') (reverse s))                   --reverse the string remove comma in beginning and then reverse again

-- Funct to check if the graph is a valid DAG
isValidDAG :: Graph -> Bool
isValidDAG graph = all (\node -> not (dfs node [])) (map fst graph)                      --iterats over each node of graph
  where
    dfs :: Node -> [Node] -> Bool
    dfs node visited                                                                     --takes current node and list of visited nodes
                                                                                                                                                       
      | node `elem` visited = True                                                        --if node is part of visited list -true i.e cycle present
      | otherwise =                                                                        
          case lookup node graph of                                                       
            Just children -> any (\child -> dfs child (node : visited)) children          --it checks its each child by applying dfs function recursively to each child if anyone returns true i.e cycle present
            Nothing -> False                                                              -- no cycle present beacause it will be a node without children

graphToDOT :: Graph -> String
graphToDOT graph =
    "digraph G {\n" ++
    concatMap nodeToDOT graph ++
    "}\n"
  where
    nodeToDOT (parent, children) =
        concatMap (\child -> "    " ++ parent ++ " -> " ++ child ++ ";\n") children

main :: IO ()
main = do
    let edges = [("India", "KA"), ("India", "MH"), ("India", "MP"), ("India", "UP"),
                 ("KA", "Gadag"), ("KA", "Kolar"), ("Kolar", "Malur"),
                 ("MH", "Nashik"), ("MH", "Pune"), ("MH", "Thane"),
                 ("Pune", "Haveli"), ("Pune", "Junnar"), ("Haveli", "Hadapsar"), ("Haveli", "Kesnand"), ("Haveli", "Wagholi"),
                 ("Junnar", "Hirdi"), ("Junnar", "Vadaj"),
                 ("Thane", "Uran"), ("Thane", "Vasai"), ("Vasai", "Dahisar"),
                 ("MP", "Bhopal"), ("Bhopal", "Berasia"), ("Berasia", "Agra"),
                 ("UP", "Jalaun"), ("UP", "Kanpur"), ("Kanpur", "Derapur")]
    
  
    let graph = buildGraph edges
    
    let isValid = isValidDAG graph

    putStrLn "Is the DAG Valid:"
    print isValid

    
    let roots = findRoot graph
    putStrLn "DAG to string:"
    mapM_ (putStrLn . removeCommaAfterLastChild . graph2str graph) roots


    let dotOutput = graphToDOT graph
    writeFile "graph.dot" dotOutput


{--
OUTPUT:
DAG Validation:
True
DAG to string:
India(KA(Gadag,Kolar(Malur)),MH(Nashik,Pune(Haveli(Hadapsar,Kesnand,Wagholi),Junnar(Hirdi,Vadaj)),Thane(Uran,Vasai(Dahisar))),MP(Bhopal(Berasia(Agra))),UP(Jalaun,Kanpur(Derapur))) 
--}
