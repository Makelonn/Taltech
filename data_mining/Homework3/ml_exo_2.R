rm(list=ls())
graphics.off()

library(docstring)
library(testit)
library(igraph)
library(RColorBrewer)
###---Utils functions---###
ml_get_node_neigh <- function(node_name, graph_edges, type_neigh = "all")
{
  # Type_neigh describe the edge we considere :
  #   all: in and out neigh
  #   in : edges coming in the node_name
  #   out: edges coming out the node_names
  
  neigh <-c()
  #For all edges we test if it corespond to value type_neigh
  for(i in seq(length(graph_edges$from)))
  {
    #Getting the in nodes : if the edge goes to the node_name and do node come from node_name
    #Then we add the node it came from
    if((type_neigh %in% c("in", "all")) &&
       (graph_edges$to[i] == node_name) && (graph_edges$from[i] !=  node_name))
    {
      neigh <- c(neigh, graph_edges$from[i])
    }
    #Same principle with out
    if((type_neigh %in% c("out", "all")) &&
       (graph_edges$from[i] == node_name) && (graph_edges$to[i] !=  node_name))
    {
      neigh <- c(neigh, graph_edges$to[i])
    }
  }
  return(unique(neigh))
}

# node1 and node2 are index
ml_node_distance <- function(graph, node1, node2, type_neigh="in")
{
  #Return the length of path if its exist
  my_nodes <- as_data_frame(graph, what = "vertices")
  my_edges <- as_data_frame(graph, what = "edges")
  #nb_nodes <- length(my_nodes$name)
  n1 <- my_nodes$name[node1]
  n2 <- my_nodes$name[node2]
  my_path <- shortest_paths(graph, V(graph)[n1], to=V(graph)[n2],
                            mode=type_neigh,weights=E(graph)$weights, 
                            output="vpath")
  #If not accessible :
  if(!(V(graph)[n1] %in% my_path$vpath[[1]])
     || !(V(graph)[n2] %in% my_path$vpath[[1]])
     || length(my_path$vpath[[1]])<=1){
    return(-1)}
  else{
  accessible_list <- my_path$vpath[[1]]
  dist <- 0
  for(node in 1:(length(accessible_list)-1))
  {
    to_node <- my_nodes$name[accessible_list[node+1]]
    from_node <- my_nodes$name[accessible_list[node]]
    for(edge in seq(length(my_edges$from)))
    {
      if(((to_node == my_edges$to[edge]) && (from_node == my_edges$from[edge])))
      {
        dist <- dist + my_edges$weight[edge]
        break;
      }
    }

  }}
  return(dist)
}

###---LOCAL CLUSTERING COEF---###
ml_local_clustering_coef <-function(graph)
{
  my_nodes <- as_data_frame(graph, what = "vertices")
  my_edges <- as_data_frame(graph, what = "edges")
  nb_nodes <- length(my_nodes$name) #we take name length but could have be every col
  node_clus_coef <- matrix(0, nrow=nb_nodes) #Matrix to return, for each nodes, gives the coef
  rownames(node_clus_coef) <-my_nodes$name
  
  #Compute the local clustering coef for each
  for(i in seq(nb_nodes))
  {
    current_neigh <- ml_get_node_neigh(my_nodes$name[i], my_edges)
    current_node <- my_nodes$name[i]
    #Now we compute the number of link in the neighbourhood
    counter_link <- 0
    for(j in seq(length(current_neigh)))
    {
      #We test each edges
      for(k in seq(length(my_edges$from)))
      {
        if (my_edges$to[k] == current_neigh[j] &&
            my_edges$from[k] != current_node &&
            my_edges$to[k] != my_edges$from[k] &&
            (my_edges$from[k] %in% current_neigh)) {
          counter_link <- counter_link + 1
        }
        if (my_edges$from[k] == current_neigh[j] &&
            my_edges$to[k] != current_node && 
            my_edges$from[k] != my_edges$to[k] &&
          (my_edges$to[k] %in% current_neigh)) {
            counter_link <- counter_link + 1
          }
        
      }
      
    }
    nb_neigh <- length(current_neigh)
    node_clus_coef[i,1] <- counter_link / (nb_neigh * (nb_neigh-1))
  }
  return(node_clus_coef)
}

###---DEGREE CENTRALITY---###
ml_degree_centrality <- function(graph)
{
  my_nodes <- as_data_frame(graph, what = "vertices")
  my_edges <- as_data_frame(graph, what = "edges")
  nb_nodes <- length(my_nodes$name)
  
  centrality_degrees <- matrix(0, nrow=nb_nodes, ncol=1)
  
  for(i in seq(nb_nodes))
  {
    neigh <- ml_get_node_neigh(my_nodes$name[i], my_edges, type_neigh = "all")
    centrality_degrees[i,1] <- length(neigh) / (nb_nodes - 1)
  }
  return(centrality_degrees)
}

###---DEGREE PRESIGE---###
ml_degree_prestige <- function(graph)
{
  my_nodes <- as_data_frame(graph, what = "vertices")
  my_edges <- as_data_frame(graph, what = "edges")
  nb_nodes <- length(my_nodes$name)
  
  degree_prestige <- matrix(0, nrow=nb_nodes, ncol=1)
  
  for(i in seq(nb_nodes))
  {
    in_neigh <- ml_get_node_neigh(my_nodes$name[i], my_edges, type_neigh = "in")
    degree_prestige[i,1] <- length(in_neigh) / (nb_nodes - 1)
  }
  return(degree_prestige)
}

###---GREGARIOUSNESS OF A NODE---###
ml_gregariousness <- function(graph)
{
  my_nodes <- as_data_frame(graph, what = "vertices")
  my_edges <- as_data_frame(graph, what = "edges")
  nb_nodes <- length(my_nodes$name)
  
  gregariousness <- matrix(0, nrow=nb_nodes, ncol=1)
  
  for(i in seq(nb_nodes))
  {
    out_neigh <- ml_get_node_neigh(my_nodes$name[i], my_edges, type_neigh = "out")
    gregariousness[i,1] <- length(out_neigh) / (nb_nodes - 1)
  }
  return(gregariousness)
}

###---CLOSENESS CENTRALITY&PROXIMITY PRESTIGE---###
ml_closeness_centrality <- function(graph)
{
  my_nodes <- as_data_frame(graph, what = "vertices")
  my_edges <- as_data_frame(graph, what = "edges")
  nb_nodes <- length(my_nodes$name)
  
  closeness_centrality <- matrix(0, nrow=nb_nodes, ncol=1)
  
  for(i in seq(nb_nodes))
  {
    node <- my_nodes$name[i]
    total_dist <- 0
    for(j in seq(nb_nodes))
    {
      
      distance<- ml_node_distance(graph, i, j, type_neigh = "all")
      #if -1, no path so no distance
      if(distance != -1) {total_dist <- total_dist + distance}
    }
    closeness_centrality[i,1] <- (nb_nodes-1) / total_dist
  }
  return(closeness_centrality)
}

ml_proximity_prestige <- function(graph)
{
  my_nodes <- as_data_frame(graph, what = "vertices")
  my_edges <- as_data_frame(graph, what = "edges")
  nb_nodes <- length(my_nodes$name)
  
  proximity_prestige <- matrix(0, nrow=nb_nodes, ncol=1)
  
  for(i in seq(nb_nodes))
  {
    nb_accessible_node <- 0
    total_dist <- 0
    for(j in seq(nb_nodes))
    {
      distance<- ml_node_distance(graph, i, j, type_neigh = "in")
      if((distance != -1) && (i!=j))
      {
        total_dist <- total_dist + distance
        nb_accessible_node <- nb_accessible_node + 1
      }
    }
    proximity_prestige[i,1] <- (total_dist / nb_accessible_node)
  }
  return(proximity_prestige)
}

###---BETWEENESS CENTRALITY---###
ml_betweeness_centrality <- function(graph)
{
  my_nodes <- as_data_frame(graph, what = "vertices")
  my_edges <- as_data_frame(graph, what = "edges")
  nb_nodes <- length(my_nodes$name)
  
  btw_centrality <- matrix(0, nrow=nb_nodes, ncol=1)
  for(index in seq(nb_nodes))
  {
    for(node1 in my_nodes$name)
    {
      for(node2 in my_nodes$name)
      {
        #We study only if not the same node 
        if(node1 != node2)
        {
          btw_path <- shortest_paths(graph, V(graph)[node1], to=V(graph)[node2], weights = E(graph)$weigths, mode="in", output="vpath")
          if(index %in% as.integer(btw_path$vpath[[1]]))
          {
            btw_centrality[index,1] <- btw_centrality[index,1] + 1
          }
        }
      }
    }
  }
  return(btw_centrality)
}

###---COMMON NEIGHBOR BASED MESURE---###
ml_common_neigh_based_mesure <- function(graph, node1, node2)
{
  my_nodes <- as_data_frame(graph, what = "vertices")
  my_edges <- as_data_frame(graph, what = "edges")
  node1_name <- my_nodes$name[node1]
  node2_name <- my_nodes$name[node2]
  common_neigh <- intersect(ml_get_node_neigh(node1_name, my_edges), ml_get_node_neigh(node2_name, my_edges))
  return(length(common_neigh))
}

###---JACCARD MESURE---###
ml_jaccard_mesure <- function(graph, node1, node2)
{
  my_nodes <- as_data_frame(graph, what = "vertices")
  my_edges <- as_data_frame(graph, what = "edges")
  
  nb_all_neigh <- length(ml_get_node_neigh(my_nodes$name[node1], my_edges)) + length(ml_get_node_neigh(my_nodes$name[node2],my_edges))
  print(nb_all_neigh)
  return(ml_common_neigh_based_mesure(graph, node1, node2) / nb_all_neigh)
}

###---Testing---###
my_edges <- read.csv("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework3\\data\\graph\\Dataset1-Media-Example-EDGES.csv")
my_nodes <- read.csv("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework3\\data\\graph\\Dataset1-Media-Example-NODES.csv")

my_graph <- graph_from_data_frame(d=my_edges, directed=T, vertices=my_nodes)



#Qty of edge between neigh
cat("Local clustering coefficient\n")
local_clustering <- ml_local_clustering_coef(my_graph)
#Bascially how much node connected / total of node
cat("Degree centrality\n")
degree_centrality <- ml_degree_centrality(my_graph)
#How much node coming in / total = popularity
cat("Degree prestige\n")
degree_prestique <- ml_degree_prestige(my_graph)
#propensity of the node to follow other
cat("Gregariousness of nodes\n")
gregariousness <- ml_gregariousness(my_graph)
#average shortest path dist from other nodes
cat("Closeness centrality\n")
closeness <- ml_closeness_centrality(my_graph)
#With "in" -> path may not exist
cat("Proximity prestige\n")
proxim_prestige <- ml_proximity_prestige(my_graph)
#Nb of path going trough = how critic
cat("Betweeness centrality")
btw_centrality <- ml_betweeness_centrality(my_graph)
cat("We will use node 1 and 2 and node 4 and 5 to compute next values :\n")
common_neigh_msr1 <- ml_common_neigh_based_mesure(my_graph, 1,2)
common_neigh_msr2 <- ml_common_neigh_based_mesure(my_graph, 4,5)
cat("Common neighbors mesure\n\tNode 1&2:", common_neigh_msr1, "\n\tNode 4&5:", common_neigh_msr2, "\n" )

jaccard1 <- ml_jaccard_mesure(my_graph, 1,2)
jaccard2 <- ml_jaccard_mesure(my_graph, 4,5)
cat("Jaccard mesure\n\tNode 1&2:", jaccard1, "\n\tNode 4&5:", jaccard2, "\n" )

plot(my_graph)

cat("Done.")