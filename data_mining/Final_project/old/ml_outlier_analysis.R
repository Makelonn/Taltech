# This file compute the LOF for all the point of a dataset
rm(list=ls())
graphics.off()
source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1\\ml_distance.R")
library(ggplot2)
#Dataset to study
load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1\\ml_2D_data.RData")
my_data<-x[,1:2]

#This function return a matrix size nrow(dataset)*nrow(dataset), symmetric,
# [i,j] containing the distance between i-th point of the dataset and j-th point of the dataset
point_to_point_distance_dataset <- function(dataset)
{
  size_dataset = nrow(dataset)
  distance_matrix <- matrix(, nrow=size_dataset, ncol=size_dataset)
  for(i in seq(along=1:size_dataset))
  {
    for(j in seq(along=1:i))
    {
      if(j==i) {distance_matrix[i,j] <- 0}
      else
      {
        dist <- mydistfun(dataset[i,],dataset[j,])
        distance_matrix[i,j] <- dist
        distance_matrix[j,i] <- dist
      }
    }
  }
  return(distance_matrix)
}

# Return the matrix of index | distance |coordinate for the k nearest neighbor of point at the index point_index
k_nearest_neigh <- function(dist_matrix, dataset, point_index, k)
{
  k_neigh <- matrix(, nrow = k, ncol=ncol(dataset) + 2)
  for(count in seq(1:k))
  {
    current_mean_dist <- max(dist_matrix[point_index,])
    index <- -1
    for(i in seq(1:nrow(dataset)))
    {
      if(i != point_index)
      {
        if(dist_matrix[point_index, i] < current_mean_dist)
        {
          if(!(i %in% k_neigh[,1])){
          index <- i
          current_mean_dist <- dist_matrix[point_index, i]}
        }
      }
    }
    k_neigh[count,1] <- index
    k_neigh[count,2] <- dist_matrix[point_index, index]
    for(j in seq(1:ncol(dataset))){k_neigh[count,j+2]<-dataset[index,j]}
  }
  return(k_neigh)
}

YinLk <- function(dataset, k_neigh, index_X, distance_matrix )
{
  Vk_x <- max(k_neigh[,2])
  index_neigh <- vector()
  for(i in seq(along=1:nrow(distance_matrix)))
  {
    if((i != index_X) && (distance_matrix[index_X, i]<=Vk_x)) { index_neigh <- c(index_neigh, i)}
  }
  return(index_neigh) #because it will count the point itself as the distance between x and x = 0
}

R_k <- function(index_X,index_Y,k, distance_matrix, dataset)
{
  k_neigh <- k_nearest_neigh(distance_matrix, dataset, index_Y, k)
  Rk_y <- max(k_neigh[,2])
  Rk_y <- max(Rk_y,distance_matrix[index_X,index_Y])
  return(Rk_y)
}


AR_k <- function(index_X, k, dataset, distance_matrix)
{
  # First we need the k_nearest_neighbors
  k_neigh <- k_nearest_neigh(distance_matrix, dataset, index_X, k)
  # Sum of R_k(X,Y)
  sum_Rk <- 0.0
  for(i in seq(along=2:k)){sum_Rk<- sum_Rk + R_k(index_X, k_neigh[i,1], k ,distance_matrix, dataset)}
  y_in_lk <- YinLk(dataset, k_neigh, index_X, distance_matrix)
  return(sum_Rk / length(y_in_lk))
}

LOF_k <- function(index_X, dataset, distance_matrix, k)
{
  ark <- AR_k(index_X,k, dataset, distance_matrix)
  k_neigh <- k_nearest_neigh(distance_matrix, dataset, index_X, k)
  Y_lk <- YinLk(dataset, k_neigh, index_X, distance_matrix)
  sumAR <- 0
  for(i in Y_lk)
  {
    sumAR <- sumAR + (ark/AR_k(i,k, dataset, distance_matrix))
  }
  return(sumAR / length(Y_lk))
}

K <- 3
distance_matrix <- point_to_point_distance_dataset(my_data)
ncol_data = ncol(my_data)
lof <- matrix(, nrow=nrow(my_data), ncol=ncol_data+1)
for(j in seq(along=1:nrow(my_data))){
  lof[j,1:ncol_data] <- my_data[j,]
  lof[j,ncol_data+1] <- LOF_k(j, my_data, distance_matrix, K)
}

lof <- as.data.frame(lof)
# We print with a scale to match the local outlief factor
plot <-
  ggplot(lof,
         aes(x = lof[, 1],y = lof[, 2],colour = lof[, 3])) +scale_color_gradientn(colours = rainbow(5))+ geom_point() + labs(title = sprintf("Local Outlier Factor for k=%i nearest neighbors",K),y = "Y",x = "X", color="LOF(X)")
print(plot)
