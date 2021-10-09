# DBSCAN
rm(list=ls())
graphics.off()
source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1\\ml_distance.R")
source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1\\ml_DBSCAN_tools.R")
# /!\ This file takes a lot of time to execute

#We need non clusterise data
load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1\\ml_data_dbscan.RData")
dimension <- ncol(x)-1
nb_data <- nrow(x)
my_data <- x[,1:dimension]

# Parameters are
set.seed(145)
epsilon <- 1.20 #distance we study
tau <- 8  #nb minimal of point within distance epsilon to form a cluster

distances <- point_to_point_distance_dataset(my_data)

cp_data <- dbscan_matrix(my_data)
my_data <- cbind(my_data, 1)

# 1 is noise point | 0 is core point | 2 is border point
#Determine core point and border point
# -- Core points --
for(i in seq(along=1:nb_data))
{
  if(is_core_point(i,distances, tau, epsilon)) {my_data[i,dimension+1] <- 0}
}

neigh_of_border <- vector()
# -- Border points --
for(i in seq(along=1):nb_data)
{
  if((my_data[i,dimension+1]==1) && is_border_point(i,distances,my_data,epsilon)) {
    my_data[i,dimension+1] <- 2
    neigh_of_border <- c(neigh_of_border, get_border_neigh_core(i, distances, my_data, epsilon))
    }
}


cp_data[,5]<-c(1:nrow(cp_data))
cp_data[,3]<-my_data[,3]
plot(my_data[,1], my_data[,2], col=my_data[,3]+3, pch=20, xlab="X", ylab="Y",main="Repartition of core, border and noise point")

# Treating core points

label <- 1
core_index <- cp_data[cp_data[,3]==0,] #core index take only the core point from cp_data
core_index <- as.integer(core_index[,5])

repeat{
  current_cluster <- cluster_point(cp_data[cp_data[,3]==0,], core_index[1], distances, epsilon, c())
  for(i in seq(along=1:length(current_cluster)))
  {
    cp_data[current_cluster[i],4] <- label
    core_index <- eliminate_occurence(current_cluster[i], core_index)
  }
  label <- label + 1
  if(is.na(core_index) || (length(core_index)==0)){break}
}

plot(my_data[,1], my_data[,2], col=cp_data[,4]+1, pch=20, xlab="X", ylab="Y",main="Clustering of core point")

# Treating border points
border_index <- cp_data[cp_data[,3]==2,]
border_index <- cbind(border_index[,5],neigh_of_border)

for(i in seq(along=1:nrow(border_index)))
{
  cp_data[border_index[i,1],4] <- cp_data[border_index[i,2],4]
}

plot(my_data[,1], my_data[,2], col=cp_data[,4]+1, pch=20, xlab="X", ylab="Y",main="Clustering using DBSCAN")