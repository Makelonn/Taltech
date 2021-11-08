#Cleaning the environment
rm(list=ls())
graphics.off()

library(rgl)
library(kernlab)
#Loading our 2D crescent moon dataset
load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework2\\data\\ML_dataset_half_moon.RData")

moon_3d = data.frame()
#Project moon cresent in 3D


for(i in 1:nrow(x))
{
  val <- c(-70*x[i,1] + x[i,1]**3, 1.4*x[i,2], x[i,1]*x[i,2], x[i,3])
  moon_3d = rbind(moon_3d,val)
}

plot3d(moon_3d[,1],moon_3d[,2],moon_3d[,3], col=moon_3d[,4])


#Now that we have seperated the moons we create the kernel function
kernel_function <- function()
{
  k_dot_product <- function(x, y) #Replace dot product of phi
  {
    phi_x <- c(-70*x[1] + x[1]**3, 1.4*x[2], x[1]*x[2])
    phi_y <- c(-70*y[1] + y[1]**3, 1.4*y[2], y[1]*y[2])
    #calcul of the "dot" product
    sum(phi_x * phi_y)
  }
  class(k_dot_product) <- 'kernel' #To have a kernel function
  return(k_dot_product)
}


x_labels <- x[, 3]
x_train <- x[, 1:2]

#support vector machine
#C-svc -> classification 
my_ksvm <- ksvm(x_train, x_labels, type = "C-svc", kernel = kernel_function(), scaled = c())


#Getting data from results

print(w)

negative_intercept <- b(my_ksvm)[[1]]

sv_coef <- coef(my_ksvm)[[1]]
x_values <- x_train[, 1]

support_vectors <- x_train[SVindex(my_ksvm),] #Get the index with SVindec
plane_equation =  function(x){4 + sv_coef[1] + sv_coef[2] * x + sv_coef[3] * x**2 + sv_coef[4] * x**3}


#Prediction labels using the curve 
length_data <-  nrow(x_train)
predict<- cbind(x_train[,1:2],0)
for(i in seq(length_data))
{
  if(predict[i,2] > plane_equation(x_train[i,1]))
  {
    predict[i,3] <- 1
  }
  else
  {
    predict[i,3] <- 2
  }
}

#Compute accuracy
count <- 0
for(i in 1:length_data)
{
  #If we have the exact label
  if(x[i,3] == predict[i,3]) {count <- count +1}  
}

accuracy = (count/length_data)*100


### PLOTTING EVERYTHING ###
attach(mtcars)
layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE),widths=c(1,1,1), heights=c(1.2,1,1))

#---Results of kernel trick---#
txt <- paste(paste("Accuracy of", round(accuracy,5) ), "%", sep="")
#Plotting all points
plot(x_train, main="Result after using the kernel trick", col="antiquewhite3", pch=1 , xlab = 'X', ylab = 'Y',xlim=c(-15,15),ylim=c(-13,20))

mtext(side = 3, line = 0.25, at = 1, adj = 0.5,  txt)
#Plotting support vector in outstanding way
points(support_vectors[,1], support_vectors[,2], pch=21, col="darkslateblue", bg='darkorange',xlim=c(-15,15),ylim=c(-13,20))
#Plotting the plane using the equation
par(new=TRUE)
curve(plane_equation, from=-15, to=15, lwd=3, xlab='', ylab='', col='darkslateblue',xlim=c(-15,15),ylim=c(-13,20))
#---Original labels ---#
plot(x, col=x[,3]+1, pch=20, main="Original dataset", xlab="X", ylab="Y",xlim=c(-15,15),ylim=c(-13,20))

#---Labels with kernel trick---#
plot(predict[,1:2], xlab = 'X', ylab = 'Y', col = predict[,3] + 1,main="Prediction of SVM", xlim=c(-15,15),ylim=c(-13,20))#, sub="Test")
par(new=TRUE)
curve(plane_equation, from=-15, to=15, lwd=1, xlab='', ylab='', col='darkslateblue',xlim=c(-15,15),ylim=c(-13,20))