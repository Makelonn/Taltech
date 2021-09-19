rm(list=ls())
graphics.off()
## Try to put it in 3D generation

# Generate data
labelsNr<-5 #number of labels
labelsJ<-1:1:labelsNr #labels are numbers 1,2,3
labelsI<-1:1:500 #number of data points for label 500

#When the number of dimensions equals 2 -> bivariate normal distribution 
#that is defined with a two-dimensional vector of means, 
#m=(m1,m2) and covariance matrix sigma  ??=[(??1)^2, ??12, ??21, (??2)^2].
#reference: https://www.itl.nist.gov/div898/handbook/pmc/section5/pmc542.htm

sigma1<-matrix(c(5,2,2,5),ncol=2) #covariance matrix of sigmas, must be symmetric!!
sigma1
sigma2<-matrix(c(2,-2,-2,6),ncol=2)
sigma3<-matrix(c(5,-4,-4,5),ncol=2)
sigma4<-matrix(c(6,4,4,6),ncol=2)
sigma5<-matrix(c(3,-4,-4,3),ncol=2)

# more ellegant way to construct 
#eig_vec_1 <- matrix(c(0.4,0.2,0.2,0.4), nrow=2, ncol=2)
#eig_vec_2 <- matrix(c(0.2,-0.1,-0.1,0.2), nrow=2, ncol=2)

#eig_val_1<- matrix(c(1,0,0,1) ,nrow=2, ncol=2)
#eig_val_2<- matrix(c(1,0,0,1) ,nrow=2, ncol=2)

#covariance matrices
#sigma1 <- eig_vec_1 %*% eig_val_1 %*% solve(eig_vec_1)
#sigma2 <-  eig_vec_2 %*% eig_val_2 %*% solve(eig_vec_2)

mean1=c(2,0) #mean of both 2 variables/dimensions
mean1
mean2=c(4,10)
mean3=c(10,7)
mean4=c(18,15)
mean5=c(-8,-5)

#Sigmas=data.frame(sigma1,sigma2,sigma3)
Sigmas=list(sigma1,sigma2,sigma3,sigma4,sigma5)
Sigmas
Means=list(mean1,mean2,mean3,mean4,mean5)
x<-matrix(,80000,4)  #matrix that will contain all the data

library(mvtnorm) #multivariate normal distribution library (multivariate - more than 1 dimension, variable)

for (j in seq(along=labelsJ)){
  sigma=Sigmas[[j]]
  Mean=Means[[j]]
  xx <- rmvnorm(n=500, Mean, sigma=sigma) #random multivariate normal distribution function
  
  a<-switch(j,"red","green","blue","orange","purple"); #dot color
  plot(xx,col=a,type="p",xlim=c(-10,20),ylim=c(-10,20)) #plot xx
  par(new=TRUE) #to include the previous plot on the previous = combine plots
  for (i in seq(along=labelsI)){ #insert the generated data inside the x matrix and add label
    x[(j-1)*500+i,1:2]=xx[i,]
    x[(j-1)*500+i,3] = runif(1)*10
    x[(j-1)*500+i,4]=j
  }
}



library(rgl)
df <-data.frame(x1= c(x[,1]),x2 = c(x[,2]),x3=c(x[,3]))
View(df)
with(df,plot3d(x1,x2,x3,type = "p"))

x <- x[,1:3] # the data we used was initially prepared for the classification example please remove third column 
plot3d(x[,1], x[,2], x[,3], type="p") 
#save(x,file="/Users/sven/Google Drive/Teaching/Data_Mining_2021/Practice_02/kdata.RData")


