# clear everything and load required libraries/codes
rm(list=ls())
graphics.off()

source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1\\ml_distance.R")

load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\TD5\\Clusters_labels-W5Practice.RData")



nb_data <- nrow(x)

#The data does not have a label "5" but have a "6" so we replace it with 5
for(i in seq(along=1:nb_data))
{
  if(x[i,3]==6){x[i,3] <- 5}
}

point_to_point_distance_dataset <- function(dataset_1, dataset_2)
{ 
  #Both dataset should only contain features ! no labels
  #We will return a matrix with rows corresponding to dataset_1 and cols to dataset_2
  size_dataset1 = nrow(dataset_1)
  size_dataset2 = nrow(dataset_2)
  distance_matrix <- matrix(, nrow=size_dataset1, ncol=size_dataset2)
  for(point1 in seq(along=1:size_dataset1))
  {
    for(point2 in seq(along=1:size_dataset2))
    {
        dist <- mydistfun(dataset_1[point1,],dataset_2[point2,])
        distance_matrix[point1,point2] <- dist
    }
  }
  return(distance_matrix)
}

k_nearest_neigh_label <- function(dist_matrix, dataset, point_index, k)
{
  #k neigh contain index | label
  k_neigh <- matrix(, nrow = k, ncol= 2)
  for(count in seq(1:k)) #We find the closet point k times
  {
    current_min_dist <- max(dist_matrix[point_index,])
    index <- -1
    for(i in seq(1:nrow(dataset))) #Searching for minimal distance not studied
    {
      if(i != point_index)
      {
        if(dist_matrix[point_index, i] < current_min_dist)
        {
          if(!(i %in% k_neigh[,1])){
            index <- i
            current_min_dist <- dist_matrix[point_index, i]}
        }
      }
    }
    k_neigh[count,1] <- index
    k_neigh[count,2] <- dataset[index, ncol(dataset)]
  }
  
  #Here k_neigh will contain the k nearest neighbors label
  # We then find the label the most commun
  labels_vect <- as.vector(matrix(0,nrow=max(dataset[,ncol(dataset)]))) # Vector which size = nb label
  for(i in seq(along=1:k))
  {
    #For all the k nearest neighbors, we count the label sums
    labels_vect[k_neigh[i,2]] <- 1 + labels_vect[k_neigh[i,2]]
  }
  label <- which.max(labels_vect)
  return(label)
}

### ----- Prepararing data ----- ### 
#Repartition of data in 2 sets : 2/3 of data to train and 1/3 to validate
nb_train <- nb_data * 0.77
x_train<-matrix(,0,3)
x_validation<-x 
for(i in seq(along=1:nb_train))
{
  index <- sample(1:nrow(x_validation), 1)
  x_train <- rbind(x_train, x_validation[index,])
  x_validation <- x_validation[-index,]
}
### ----- Applying KNN ----- ###
k <- 7
#Distance matrix
distmatrix <- point_to_point_distance_dataset(x_validation, x_train)
#Label matrix
predicted <- matrix(, nrow=nrow(x_validation), ncol=1)
#Goodness
nb_labels <- max(x[,ncol(x)])
confusion_matrix <- matrix(0, nrow=nb_labels, ncol=nb_labels)
for(i in seq(along=1:nrow(x_validation)))
{
  predicted_label <- k_nearest_neigh_label(distmatrix, x_train, i, k)
  true_label <- x_validation[i,3]
  # Adding in our label matrix
  predicted[i,1] <- predicted_label
  #Confusion matrix
  confusion_matrix[predicted_label, true_label] <- 1 + confusion_matrix[predicted_label, true_label]
}
predicted <- cbind(x_validation[,1:(ncol(x_validation)-1)], predicted)

### ----- Plotting ----- ###
par(mfrow=c(1,2))
# Data we were given
plot(x[,1],x[,2], col=x[,3]+1, pch=20,xlim=c(-20,20),ylim=c(-20,20), main="Original clustering")
#Training data
plot(x_train[,1], x_train[,2], pch=20, col=x_train[,3]+1,xlim=c(-20,20),ylim=c(-20,20), main="Using KNN", sub="The point circled in black are the validation set",xlab="x[,1]", ylab="x[,2]")
par(new=TRUE)
#Validation data
plot(predicted[,1], predicted[,2], pch=21, col="black", bg=predicted[,3]+1,xlim=c(-20,20),ylim=c(-20,20), xlab="", ylab="")
