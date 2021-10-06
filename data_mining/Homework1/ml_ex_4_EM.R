# Implementation of EM algorithm

# clear everything and load required libraries/codes
rm(list=ls())
graphics.off()
library(mvtnorm)
library(car)
library(Matrix)
library(rgl)
library(scales)
#source("C:/Users/Sven/Google Drive/Teaching/Data_Mining_2020/Lab3/mySum.R")
source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1\\ml_mySum.R")


#set.seed(2)
#loading and plotting data
#setwd("C:/Users/Sven/Google Drive/Teaching/Data_Mining_2020/Lab3/Data")
setwd("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1")

#load("2dData-strange.RData")
#load("C:/Users/Sven/Google Drive/Teaching/Data_Mining_2020/Lab3/Data/2gaussiandata.RData")
load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1\\ml_3D_data.RData")

# We use a seed so we don't have weir shaped sigma

##plot(x[,1],x[,1], col=scales::alpha(x[,3],0.3), pch=20, xlim=c(-12,10),ylim=c(-12,12)) #*****plotting data
plot(x[,1],x[,2], pch=20, xlim=c(-5,15),ylim=c(-5,20)) #*****plotting data
#plot3d(x[,1], x[,2], x[,3], type="p", xlim=c(-5,15),ylim=c(-5,20))
# data manipulation
#classes <- x[,3] #labels vector
#x <-x[,1:2] #removing labels from data
#hist(x, col="blue")
#plot(density(x))

set.seed(9)
#Step 1: initialization
pi1<-1.5  # 0.5
pi2<-0.5

#initial values for means & sigma
# First ellipsoid
mu1<-matrix(c(sample(-10:0, 1),sample(-10:0, 1),sample(-10:0, 1)),nrow=3) #random uniformly selected starting values

sym1 = sample(-3:3, 1)

sigma1<-matrix(c(sample(1:5, 1),sym1,sym1,
                 sym1,sample(1:5, 1),sym1,
                 sym1,sym1,sample(1:5, 1)),nrow=3)

# Second ellipsdoi
mu2<-matrix(c(sample(0:10, 1),sample(0:10, 1),sample(0:10, 1)),nrow=3) #random uniformly selected starting values
sym2 =sample(-3:3, 1)


#sigma2<-sigma1
sigma2<-matrix(c(sample(1:5, 1),sym2,sym2,
                 sym2,sample(1:5, 1),sym2,
                 sym2,sym2,sample(1:5, 1)),nrow=3)


#initial conditions for stopping the algo
loglik<- rep(NA, 1000) #log likelihoods storage (dim * datasize)
loglik[1]<-0 #initial log likelihood value
loglik[2]<-          mySum(pi1*(log(pi1)+log(matrix(dmvnorm(x,mu1,sigma1),nrow=3,ncol=1000))))
loglik[2]<-loglik[2]+mySum(pi2*(log(pi2)+log(matrix(dmvnorm(x,mu2,sigma2),nrow=3,ncol=1000))))

#Plot 3D
plot3d(x, col="purple",xlim=c(-5,15),ylim=c(-5,20),zlim=c(-5,15))
plot3d(ellipse3d(sigma1, scale=c(1,1,1), centre=as.vector(mu1), level=0.95, subdivide = 3),col="steelblue", alpha = 0.5, add=TRUE)
plot3d(ellipse3d(sigma2, scale=c(1,1,1), centre=as.vector(mu2), level=0.95, subdivide = 3),col="yellowgreen", alpha = 0.5, add=TRUE)
points3d(mu1[1], mu1[2], mu1[3], pch=100, cex=1, col="steelblue")
points3d(mu2[1], mu2[2], mu2[3], pch=100, cex=1, col="yellowgreen")

k<-2

#main loop with step 2, 3 - EM
while(((abs(loglik[k]-loglik[k-1])) >= 0.00001)) {  #if no significant improvement, finish

  # Step 2 -> E-step: Expectation - Calculating the "Soft Labels" of Each Data Point
  tau1<-pi1*matrix(dmvnorm(x,mu1,sigma1))
  tau2<-pi2*matrix(dmvnorm(x,mu2,sigma2))

  normalizer<-tau1 + tau2


  tau1<-tau1/normalizer
  tau2<-tau2/normalizer

  # Step 3 -> M step: Maximization - Re-estimate the Component Parameters
  n<-nrow(x) #number of datapoints

  pi1<-mySum(tau1)/n #recomputing responsabilities
  pi2<-mySum(tau2)/n

  mu1[1]<-(t(tau1)%*%x[,1])/mySum(tau1) #recalculating mean values
  mu1[2]<-(t(tau1)%*%x[,2])/mySum(tau1)  #t(tau) to perform matrix multiplication, row by vector == scalar
  mu1[3]<-(t(tau1)%*%x[,3])/mySum(tau1)

  mu2[1]<-(t(tau2)%*%x[,1])/mySum(tau2)
  mu2[2]<-(t(tau2)%*%x[,2])/mySum(tau2)
  mu2[3]<-(t(tau2)%*%x[,3])/mySum(tau2)

  #Sigma 1 - Diagonal
  sigma1[1,1]<-t(tau1)%*%((x[,1]-mu1[1])*(x[,1]-mu1[1]))/(mySum(tau1)) #recalculating covariance matrix
  sigma1[2,2]<-t(tau1)%*%((x[,2]-mu1[2])*(x[,2]-mu1[2]))/(mySum(tau1))
  sigma1[3,3]<-t(tau1)%*%((x[,3]-mu1[3])*(x[,3]-mu1[3]))/(mySum(tau1))
          # Symetric part
  sigma1[1,2]<-t(tau1)%*%((x[,1]-mu1[1])*(x[,2]-mu1[2]))/(mySum(tau1))
  sigma1[2,1]<-sigma1[1,2]
  sigma1[1,3]<-t(tau1)%*%((x[,1]-mu1[1])*(x[,3]-mu1[3]))/(mySum(tau1))
  sigma1[3,1]<-sigma1[1,3]
  sigma1[2,3]<-t(tau1)%*%((x[,2]-mu1[2])*(x[,3]-mu1[3]))/(mySum(tau1))
  sigma1[3,2]<-sigma1[2,3]
  
  #Sigma 2 - Diagonal
  sigma2[1,1]<-t(tau2)%*%((x[,1]-mu2[1])*(x[,1]-mu2[1]))/(mySum(tau2)) #recalculating covariance matrix
  sigma2[2,2]<-t(tau2)%*%((x[,2]-mu2[2])*(x[,2]-mu2[2]))/(mySum(tau2))
  sigma2[3,3]<-t(tau2)%*%((x[,3]-mu2[3])*(x[,3]-mu2[3]))/(mySum(tau2))
          # Symetric part
  sigma2[1,2]<-t(tau2)%*%((x[,1]-mu2[1])*(x[,2]-mu2[2]))/(mySum(tau2))
  sigma2[2,1]<-sigma2[1,2]
  sigma2[1,3]<-t(tau2)%*%((x[,1]-mu2[1])*(x[,3]-mu2[3]))/(mySum(tau2))
  sigma2[3,1]<-sigma2[1,3]
  sigma2[2,3]<-t(tau2)%*%((x[,2]-mu2[2])*(x[,3]-mu2[3]))/(mySum(tau2))
  sigma2[3,2]<-sigma2[2,3]

  # graphics.off()
  # plot3d(x, col="purple",xlim=c(-5,15),ylim=c(-5,20),zlim=c(-5,15))
  # plot3d(ellipse3d(sigma1, scale=c(1,1,1), centre=as.vector(mu1), level=0.95, subdivide = 3),col="steelblue", alpha = 0.5, add=TRUE)
  # plot3d(ellipse3d(sigma2, scale=c(1,1,1), centre=as.vector(mu2), level=0.95, subdivide = 3),col="yellowgreen", alpha = 0.5, add=TRUE)
  # points3d(mu1[1], mu1[2], mu1[3], pch=100, cex=1, col="steelblue")
  # points3d(mu2[1], mu2[2], mu2[3], pch=100, cex=1, col="yellowgreen")
  #new loglik calculation
  loglik[k+1] <- mySum(pi1*(log(pi1)+log(matrix(dmvnorm(x,mu1,sigma1), nrow=2,ncol=1000))))
  k<-k+1
}

graphics.off()
plot3d(x, col="black",xlim=c(-5,15),ylim=c(-5,20),zlim=c(-5,15))
plot3d(ellipse3d(sigma1, scale=c(1,1,1), centre=as.vector(mu1), level=0.95, subdivide = 3),col="steelblue", alpha = 0.5, add=TRUE)
plot3d(ellipse3d(sigma2, scale=c(1,1,1), centre=as.vector(mu2), level=0.95, subdivide = 3),col="yellowgreen", alpha = 0.5, add=TRUE)
points3d(mu1[1], mu1[2], mu1[3], pch=100, cex=1, col="steelblue")
points3d(mu2[1], mu2[2], mu2[3], pch=100, cex=1, col="yellowgreen")
# Comparison with library implementation of EM
# library(mixtools)
# gm<-mvnormalmixEM(x,k=2,epsilon=1e-04)  #multivariate normal distribution EM
#                                         #normalmixEM is only for univariate normal
# gm$lambda
# gm$mu
# gm$sigma
# gm$loglik
# plot(gm, which=2)
# 
# (head(gm$posterior))
# pred<-apply(gm$posterior, 1, function(row) which.max(row))
# (confusionMatrix[1,1]+confusionMatrix[2,2])/1000 # accuracy
# (confusionMatrix[1,2]+confusionMatrix[2,1])/1000 # error rate
