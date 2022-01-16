# Clean up the mess
#rm(list=ls())
#graphics.off()
source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\ml_distance.R")
library(car)

## --- K MEANS --- ##
is_converging <- function(old_centroids, new_centroids, dataset){
  
  #Return true if converge or false if a centroid style move
  last_column = ncol(dataset)
  K = max(dataset[,last_column])
  for(k in seq(along=1:K))
  {
    current_distance <- mydistfun(old_centroids[k,], new_centroids[k,], "Euclidean")
    if((current_distance != 0)){ return(FALSE) }
    #now juste keep the last value a 0 so need to do an array to keep the for all
  }
  return(TRUE)
}

update_centroids <- function(dataset, dimension, K){
  last_column = ncol(dataset)
  #K = max(dataset[,last_column])
  centroids <- matrix(, nrow=K, ncol=last_column-1)
  for (k in seq(along=1:K)){
    cluster <- as.matrix(dataset[dataset[, last_column] == k,])
    #print(cluster)
    cluster <- as.matrix(cluster[,1:ncol(cluster)-1])
    centroids[k,] = colMeans(cluster)
    if(nrow(cluster) == 0 ) {centroids[k,] <- runif(dimension)} # If there is no point around we find another place}
  }
  return(centroids)
}

get_label <- function(dataset, centroids){
  for (i in seq(along=1:nrow(dataset)))
  {
    temp_dist <- matrix(,nrow=nrow(centroids))
    for (j in seq(along=1:nrow(centroids)))
    {
      temp_dist[j,] <- mydistfun(centroids[j,], dataset[i,1:ncol(dataset)-1], "Euclidean")
    }

    dataset[i, ncol(dataset)] <- which.min(temp_dist) #this is the place we stock the label in
  }
  return(dataset)
}

# We prepare the data : we split between the training set and the validation set
ml_k_means <- function(dataset, K=3, print_val=FALSE){
  data_dimensionality = ncol(dataset)

  train_ind <- sample(seq_len(nrow(dataset)), size = nrow(dataset))
  train_set <- dataset[train_ind, ]
  
  # Starting k means, with k=3 to begin with
  centroids <- matrix(, nrow=K,ncol=data_dimensionality)
  for (k in seq(along=1:K)){
    centroids[k,] = runif(data_dimensionality)
    if(print_val) {print(centroids[k,])}
  }
  # cat("Initial centroids are: ", centroids)
  
  # Label column
  train_set <- cbind(train_set, matrix(0, nrow(train_set)))
  i <- 1
  # Iteration : need a convergence criteria
  #for (i in seq(along=1:40)){
  repeat{
    i <- i+1
    #cat("Step: ", i)
    train_set <- get_label(train_set, centroids)
    old_centroids <- centroids
    centroids <- update_centroids(train_set, data_dimensionality, K)
    if(print_val){print(centroids)}
    #cat(" Centroids have been updated: ", centroids)
    if(data_dimensionality == 2){
    plot(train_set[,1], train_set[,2], type="p", col=train_set[,3])
    points(centroids, col="midnightblue", type="p", pch=20)
    par(new=TRUE)}
    #cat("Iteration : ",i, "\n")
    if(is_converging(old_centroids, centroids,train_set)) {break};
    if(i>150) {break};
  }
  
  if(print_val){ cat(" Centroids are updated: ", centroids)}
  if(data_dimensionality == 2)
  {
  graphics.off()
  plot(train_set[, 1], train_set[, 2], type='p', col=train_set[,3])
  par(new=TRUE)
  points(centroids[,1], centroids[,2], col="red", type="p", pch=20)
  }
  
  #plot(train_set[, 1:2],xlim=c(-0.1,3), ylim=c(-0.1,3), type='p', col=train_set[,ncol(train_set)], pch=20, xlab="Dim1", ylab="Dim2", main="Centroid using kmeans")
  #par(new=TRUE)
  #plot(centroids[,1:2],xlim=c(-0.1,3), ylim=c(-0.1,3), type='p', col='blueviolet', pch=15, xlab="", ylab="", main="")
  return(train_set)
  }

## --- TESTING ---#
# Load data
#load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1\\ml_2D_data.RData")
#x <- x[,1:2] #Because we have labels on the file
#ml_k_means(x, K=5)