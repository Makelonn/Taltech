# Clean up the mess
rm(list=ls())
graphics.off()
source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1\\ml_distance.R")
library(car)
# Load data
load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1\\ml_2D_data.RData")
x <- x[,1:2] #Because we have labels on the file
## --- DISTANCE --- ##
get_distance <-function(element1,element2,metricf){
  # return distance btw ele1 and ele2 according to metricf
  dimensions=length(element1)
  sqd<-matrix(, dimensions,1)
  
  # EUCLIDIAN
  if (metricf == "Euclidean") {
    for (i in seq(along = element1)) {
      sqd[i] <- (element1[i] - element2[i])^2
    }
    dist <- sqrt(colSums(sqd))
  }
  
  # MANHATTAN
  if (metricf == "Manhattan") {
    for (i in seq(along = element1)) {
      sqd[i] <- abs(element1[i] - element2[i])
    }
    dist <- colSums(sqd)
  }
  
  
  # MINKOWSKI
  if (metricf == "Minkowski") {
    p <- 1
    for (i in seq(along = element1)) {
      sqd[i] <- (abs(element1[i] - element2[i]))^p
    }
    dist <- (colSums(sqd))^(1 / p)
  }
  
  # MAHALANOBIS
  if (metricf == "Mahalanobis") {
    sub_matrix <- element1 - element2
    cov_matrix <- cov(element1, element2)
    dist <- sqrt(t(sub_matrix) * solve(cov_matrix) * sub_matrix)
    
  }
  
  # COSINE
  if (metricf == "Cosine") {
    norm1 <- sqrt(sum(element1))
    norm2 <- sqrt(sum(element2))
    dist <- (dot(element1, element2)) / (norm1 * norm2)
  }
  
  # CAMBERRA
  if (metricf == "Camberra") {
    for (i in seq(along = element1)) {
      sqd[i] <- (abs(element1[i] - element2[i])) / (abs(element1[i]) + abs(element2[i]))
    }
    dist <- colSums(sqd)
  }
  return(dist)
}
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

update_centroids <- function(dataset, dimension){
  last_column = ncol(dataset)
  K = max(dataset[,last_column])
  centroids <- matrix(, nrow=K, ncol=last_column-1)
  for (k in seq(along=1:K)){
    cluster <- dataset[dataset[, last_column] == k,]
    cluster <- cluster[,1:2]
    centroids[k,] = colMeans(cluster)
    if(nrow(cluster) == 0 ) {centroids[k,] <- runif(2)} # If there is no point around we find another place}
  }
  print(centroids)
  return(centroids)
}

get_label <- function(dataset, centroids){
  for (i in seq(along=1:nrow(dataset))){
    temp_dist <- matrix(,nrow=nrow(centroids))
    for (j in seq(along=1:nrow(centroids))){
      temp_dist[j,] = mydistfun(centroids[j,], dataset[i,1:2], "Euclidean")
    }
    dataset[i, 3] = which.min(temp_dist) #this is the place we stock the label in
  }
  return(dataset)
}

# We prepare the data : we split between the training set and the validation set
sample_size <- floor(0.7 * nrow(x))
data_dimensionality = ncol(x)
set.seed(12) # seed is set so we can reproduce it
train_ind <- sample(seq_len(nrow(x)), size = sample_size)
train_set <- x[train_ind, ]
test <- x[-train_ind, ]
train <- train_set[,1:2] # just to assure that we have two columns
# Starting k means, with k=3 to begin with
K <- 5
centroids <- matrix(, nrow=K,ncol=data_dimensionality)
for (k in seq(along=1:K)){
  centroids[k,] = runif(2)
  print(centroids[k,])
}
# cat("Initial centroids are: ", centroids)

# Label column
aux_column <- matrix(0, nrow(train_set))
train_set = cbind(train_set,aux_column)
i <- 1
# Iteration : need a convergence criteria
#for (i in seq(along=1:40)){
repeat{
  i <- i+1
  #cat("Step: ", i)
  train_set <- get_label(train_set, centroids)
  old_centroids <- centroids
  centroids <- update_centroids(train_set, 2)
  #cat(" Centroids have been updated: ", centroids)
  plot(train_set[,1], train_set[,2], type="p", col=train_set[,3])
  points(centroids, col="midnightblue", type="p", pch=20)
  par(new=TRUE)
  #cat("Iteration : ",i, "\n")
  if(is_converging(old_centroids, centroids,train_set)) {break};
}

# cat(" Centroids are updated: ", centroids)
graphics.off()
plot(train_set[, 1], train_set[, 2], type='p', col=train_set[,3])
par(new=TRUE)
points(centroids[,1], centroids[,2], col="red", type="p", pch=20)