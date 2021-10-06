# Entropy function

#Cleaning the workspace and loading distance fucntion
rm(list=ls())
graphics.off()
source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1\\ml_distance.R")

load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1\\ml_2D_data.RData")


my_data <- x[,1:2] #We don't need to bother ourselves with labels and we work in 2D

datasize <- nrow(my_data)
k_dimension <- ncol(my_data)
# Parameters

phi <- 10

# Discretization of the data
grid_val<-matrix(, nrow=k_dimension, ncol=phi+1)
for(i in seq(along=1:k_dimension))
{
  #For each dimension of our dataset
  min_val <- min(my_data[,i])*0.99 # *0.99 to have 1% of marging around the data
  max_val <- max(my_data[,i])*1.01 #1.01 to a +1% of marging
  grid_val[i,]<-seq(min_val, max_val,length.out=(phi+1)) #phi+1 because we want phi region
}

m <- phi**k_dimension

p_i <- vector()
# Number of point by grid region
for(i in seq(along=1:phi))
{
  x_min <- grid_val[1,i]
  x_max <- grid_val[1,i+1]
  in_region <- matrix(,nrow=0,ncol=ncol(my_data))
  for(i in seq(along=1:nrow(my_data)))
  {
    if(((my_data[i, 1]<x_max)&&(my_data[i,1]>=x_min))){in_region <- rbind(in_region,my_data[i, 1])}
  }
  #p_i<- c(p_i, nrow(in_region))
  for(j in seq(along=1:phi))
  {
    y_min <- grid_val[2,j]
    y_max <- grid_val[2,j+1]
    in_region2 <- matrix(,nrow=0, ncol=ncol(my_data))
    for(i in seq(along=1:nrow(in_region)))
    {
      if(((in_region[i, 2]<y_max)&&(in_region[i,2]>=y_min))){in_region2 <- rbind(in_region2,in_region[i, 1])}
    }
    p_i<- c(p_i, nrow(in_region2))
  }
}


#We just need those values for iteration: we put all of them into vector
entropy <- 0
for(i in seq(along=1:m))
{
  p <- p_i[i] / datasize
  if(p != 0) #If p=0 we have 0*log(0) + 1*log(1) = 0 but because of log(0) r would return NaN
  {
    entropy <- entropy + ((p*log2(p)) + ((1-p)*log2(1-p)))
  }
}
entropy <- -entropy
cat("Entropy value is : ", entropy)