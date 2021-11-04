# this script illustrates the idea of outlayers
#clear everything
rm(list=ls())

# import data
load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\TD7\\variablesXYZ")
# let us plot the scatter the second column is treated as independent variable and the first as dependent
setD <- matrix( ,ncol=3, nrow = 100)

setD[,1] <- x
setD[,2] <- y
setD[,3] <- z

plot(setD[,2],setD[,1])

# let us see if there is the correlation coefficient
coRCoef<-cor(setD[,2],setD[,1])

#if we are about to build our model we should sample our data
# the goal here is to split available data into two datasets 
kt<-0 # this is counter for the training data set 
kv<-0 # this is counter for the validation data set
validationSetD<-matrix(nrow = 33, ncol = 2) # this set is for validation
trainingSetD<- matrix(nrow = 67, ncol = 2) # this set is for model building (training)

# this is how loops (cycles) are organized in R i is the index or counter 
for (i in seq(along=setD[,2])){
  b<-(i%%3)
  if (b==0){
    kv<-kv+1
    validationSetD[kv,1]<-setD[i,1]
    validationSetD[kv,2]<-setD[i,2]
  } else{
    kt<-kt+1
    trainingSetD[kt,1]<-setD[i,1]
    trainingSetD[kt,2]<-setD[i,2]
  }
}

# let us check correlations again, we do not need to do this, consider it to be a practice 
corCoefT=cor(trainingSetD[,1],trainingSetD[,2])
corCoefV=cor(validationSetD[,1],validationSetD[,2])

# let us try to build liner regression model
model1 <- lm(trainingSetD[,1] ~ trainingSetD[,2])

# let us draw corresponding trend line 
get(getOption("device"))() #open new graphic window
plot(trainingSetD[,2],trainingSetD[,1])
abline(model1) # this draws the trendline for the given model

y_hat<-matrix(nrow = 33, ncol = 1) # this vector is to store estimated (predicted) values
error<-matrix(nrow = 33, ncol = 1) # this vector is to store relative error

# let us check how our model perform on a validation set
C=summary(model1)$coefficients # extract coefficients of the model 1
for (i in seq(along=validationSetD[,2])){
  y_hat[i]=C[2,1]*validationSetD[i,2]+C[1,1] # compute estimate
  error[i]=(validationSetD[i,1]-y_hat[i])/validationSetD[i,1] # compute relative error
}
