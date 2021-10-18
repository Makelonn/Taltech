# clear everything and load required libraries/codes
rm(list=ls())
graphics.off()

source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1\\ml_distance.R")

load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\TD5\\Clusters_labels-W5Practice.RData")

nb_data <- nrow(x)
for(i in seq(along=1:nb_data))
{
  if(x[i,3]==6){x[i,3] <- 5}
}

# counters for two sets
k_train<-0
k_valid<-0
# create the arrays to store training and validation data
nb_train <- nb_data * 0.77
x_train<-matrix(,0,3)
x_valid<-x

for(i in seq(along=1:nb_train))
{
  index <- sample(1:nrow(x_valid), 1) #as.integer(runif(1,min=1,max=nrow(x_train)))
  x_train <- rbind(x_train, x_valid[index,])
  x_valid <- x_valid[-index,]
}



# perform classification
library(class)
knn_res<-knn(x_train[,1:2], x_valid[,1:2], cl=x_train[,3], k=7) #, k = 7,l=4, prob = TRUE))
predicted_classes<-as.numeric(knn_res)

# now we may try to plot the results
# for(i in seq(along=x_valid[,1])){
#   a<-switch(x_valid[i,3], "red","green","blue")
#   b<-switch(predicted_classes[i], 'orange','purple','cyan')
#   plot(x_valid[i,1],x_valid[i,2],col=a,pch=20,cex=2,xlim=c(-15,20),ylim=c(-15,20))
#   par(new=TRUE)
#   plot(x_valid[i,1],x_valid[i,2],col=b,pch=20,xlim=c(-15,20),ylim=c(-15,20))
#   par(new=TRUE)
# }

par(mfrow=c(1,2))
plot(x[,1],x[,2], col=x[,3], pch=20,xlim=c(-20,20),ylim=c(-20,20), main="Original clustering")
plot(x_train[,1], x_train[,2], pch=20, col=x_train[,3],xlim=c(-20,20),ylim=c(-20,20), main="Using KNN", xlab="x[,1]", ylab="x[,2]")
par(new=TRUE)
plot(x_valid[,1], x_valid[,2], pch=20, col=x_valid[,3],xlim=c(-20,20),ylim=c(-20,20), xlab="", ylab="")


#confusion_matrix <- confusionMatrix(factor(predicted_classes), factor(x_valid[,3]))
