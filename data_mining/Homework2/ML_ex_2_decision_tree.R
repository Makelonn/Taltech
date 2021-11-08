#Cleaning env
rm(list=ls())
graphics.off()
library(data.tree)
load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework2\\data\\ML_ex_2_dataset_decision_tree.RData")
data <- tennis


#Calculate the information of the feature (discrete values)
entropy_discrete <- function(dataset, index_feature)
{
  n_rows <- nrow(dataset)
  values <- unique(dataset[, index_feature])
  results <-  unique(dataset[, ncol(dataset)])
  #Now, for each values, we calculate the probability to play or not
  entropies_branchs <- 0 
  for( val in values)
  {
    
    nb_val <- length(which(dataset[, index_feature] == val))
    entropy_val <- 0 #Entropy for the value 
    for(res in results)
    {
      nb_res <- length(which((dataset[, index_feature] == val) & (dataset[, ncol(dataset)] == res)))
      #add to entropy
      if(nb_res != 0)
      {
      entropy_val <- entropy_val - ((nb_res/nb_val)*log2(nb_res/nb_val))
      }
    }
    entropies_branchs <- entropies_branchs +((nb_val/n_rows)*entropy_val)
  }
  return(entropies_branchs)
}  


#Define which feature gives the most information
most_usefull_feature <- function(dataset, current_entropy)
{
  info_gain <- -1
  best_index <- -1
  for(i in seq(ncol(dataset)-1))
  {
    gain <- current_entropy - entropy_discrete(dataset, i)
    if(gain > info_gain)
    {
      info_gain <- gain
      best_index <- i
    }
  }
  return(best_index)
}

entropy_source <- function(dataset)
{
  results <-  unique(dataset[, ncol(dataset)])
  nb_values <- nrow(dataset)
  entropy <- 0
  for(res in results)
  {
    res_count <- length(which(dataset[, ncol(dataset)] == res))
    entropy <- entropy - ((res_count/nb_values)*log2(res_count/nb_values))
  }
  return(entropy)
}

decision_tree <- function(dataset, root_node)
{
  source_entropy <- entropy_source(dataset)
  feat_index <- most_usefull_feature(dataset, source_entropy)
  feat_name <- colnames(dataset)[feat_index]
  #print(feat_name)
  current_node <- Node$new(feat_name)
  #Now that we have the choosen feature we split the dataset in 2 :
  descendants <- unique(dataset[, feat_index]) #All values for feature will be a node
  for(i in descendants)
  {
    sub_dataset <- dataset[dataset[, feat_index] == i,]
    if(ncol(sub_dataset)>2)
    {
    sub_dataset <- sub_dataset[, -feat_index]
    current_node$AddChildNode(decision_tree(sub_dataset, Node$new(i)))
    }
    else
    {
      current_node$AddChildNode(Node$new(i)) 
    }
  }
  root_node$AddChildNode(current_node)
  return(root_node)
}

my_tree <- decision_tree(data, Node$new("Decision tree"))

plot(my_tree)
#print(my_tree)
