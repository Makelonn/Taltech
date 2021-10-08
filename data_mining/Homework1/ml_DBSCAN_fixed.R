# DBSCAN
#rm(list=ls())
graphics.off()
source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1\\ml_distance.R")
source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1\\ml_DBSCAN_tools.R")
# /!\ This file takes a lot of time to execute

#We need non clusterise data
load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1\\ml_2D_data.RData")
dimension <- ncol(x)-1
nb_data <- nrow(x)
my_data <- x[,1:dimension]

# Parameters are
set.seed(145)
epsilon <- 1.15 #distance we study
tau <- 10  #nb minimal of point within distance epsilon to form a cluster

#distances <- point_to_point_distance_dataset(my_data)

my_data <- dbscan_matrix(my_data)

# 0 is noise point | 1 is core point | 2 is border point
#Determine core point and border point
# -- Core points --
for(i in seq(along=1:nb_data))
{
  if(is_core_point(i,distances, tau, epsilon)) { my_data[i,dimension+1] = 1}
}
# -- Border points --
for(i in seq(along=1):nb_data)
{
  if((my_data[i,dimension+1]==0) && is_border_point(i,distances,my_data,epsilon)) {my_data[i,dimension+1] = 2}
}

plot(my_data[,1], my_data[,2], col=my_data[,3]+3, pch=20, xlab="X", ylab="Y",main="Repartition of core, border and noise point")

#Now we make the clusters
#Select a core point
my_data <- cbind(my_data, 0)
label <- 1
core_to_study <- cbind(my_data, 1:nb_data)
core_to_study <- core_to_study[core_to_study[,ncol(core_to_study)-2]==1,]
colnames(core_to_study)<-c("X","Y", "Type_of_point", "Label", "Index")
colnames(my_data)<-c("X","Y", "Type_of_point", "Label")
repeat{
  index <- as.integer(core_to_study[1,ncol(core_to_study)])
  same_cluster <- #aled
  for(point in same_cluster)
  {
    my_data[point, dimension+2] <- label
    core_to_study <- core_to_study[,!(as.integer(core_to_study$Index)==point)] #Delete the point from point to study
  }
  label <- label + 1
  print(label)
  if(length(core_to_study)==0){break}
}


plot(my_data[,1], my_data[,2], col=my_data[,4], pch=20, xlab="X", ylab="Y",main="Clusterisation using DBSCAN")

#add a while there is still core point of label 0