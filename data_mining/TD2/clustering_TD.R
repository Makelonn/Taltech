#Implementing cluestering
#Cleaning the workspace
rm(list=ls())
graphics.off()
# Distance fonction
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


# function to find the label
get_label <- function(dataset, centroids){
  for (i in seq(along=1:nrow(dataset))){
    temp_dist <- matrix(,nrow=nrow(centroids))
    for (j in seq(along=1:nrow(centroids))){
      temp_dist[j,] = get_distance(centroids[j,], dataset[i,1:2], "Mahalanobis")
    }
    dataset[i, 3] = which.min(temp_dist)
  }
  return(dataset)
}

# update centroids
update_centroids <- function(dataset){
  last_column = ncol(dataset)
  K = max(dataset[,last_column])
  centroids <- matrix(, nrow=K, ncol=last_column-1)
  for (k in seq(along=1:K)){
    cluster <- dataset[dataset[, last_column] == k, 1:2]
    centroids[k,] = colMeans(cluster)
  }
  cat("___")
  cat(centroids)
  cat("___")
  return(centroids)
}


# load data
load(file="\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\TD2\\kdata.RData")

#split the data in proportion 70/30 for training /validation purposes
sample_size <- floor(0.7 * nrow(x))
data_dimensionality = ncol(x)
set.seed(123) # seed is set so we can reproduce it
train_ind <- sample(seq_len(nrow(x)), size = sample_size)

train_set <- x[train_ind, ]
test <- x[-train_ind, ]
train <- train_set[,1:2] # just to assure that we have two columns

# initialize
# Assume that K = 3
K <- 3 
centroids <- matrix(, nrow=K,ncol=data_dimensionality)


for (k in seq(along=1:K)){
  centroids[k,] = runif(2)
}
cat("Initial centroids are: ", centroids)

# ADD CONVERGENCE CRITERIA !!!

# add one column for labels
aux_column <- matrix(0, nrow(train_set))
train_set = cbind(train_set,aux_column)

for (i in seq(along=1:20)){
  cat("Step: ", i)
  train_set <- get_label(train_set, centroids)
  centroids <- update_centroids(train_set)
  cat(" Centroids have been updated: ", centroids)
  plot(centroids, col="red")
  par(new=TRUE)
}

graphics.off()
plot(train_set[, 1], train_set[, 2], type='p')
par(new=TRUE)
points(centroids[,1], centroids[,2], col="red", type='p')


