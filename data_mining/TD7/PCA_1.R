# clear
graphics.off()
rm(list=ls())
# load the data first, this time we use native R format
load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\TD7\\variablesXYZ")

# activate libs for plotting in 3D 
library("scatterplot3d")
library("car")
library("rgl")

# let us find what is the lengths of the data 
data_length=length(x)

# this part was not done in class, if you wish you may uncomment it to see histograms
# draw histograms
#get( getOption( "device" ) )()
#layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
#hist(x)
#hist(y)
#hist(z)

# here we compute the correlations you already know it from the previous example

cxy<-cor(x,y)
cyz<-cor(y,z)
czx<-cor(x,z)

# here we compute standard deviations this is new function for you
sx<-sd(x)
sy<-sd(y)
sz<-sd(z)


# find mean one more new function
mean_x<-mean(x)
mean_y<-mean(y)
mean_z<-mean(z)

# remove mean (center the data)
for (i in seq(along=x)){
  x[i]=x[i]-mean_x
  y[i]=y[i]-mean_y
  z[i]=z[i]-mean_z
}

# combine all columns into the single matrix 
D<-cbind(x,y,z)

# perform PCA
# find covariance matrix
cov_D<-cov(D)

#find it eigenvalues and eigenvectors
eig_cov_D<-eigen(cov_D)

# compute D prime (D rotated into the new coordinates)
rotated_D<-D%*%eig_cov_D$vectors

# check correlations between the columns of rotated D 
crxy<-cor(rotated_D[,1],rotated_D[,2])
cryz<-cor(rotated_D[,2],rotated_D[,3])
crzx<-cor(rotated_D[,3],rotated_D[,1])

# why not to see standard deviations just to be sure
srx<-sd(rotated_D[,1])
sry<-sd(rotated_D[,2])
srz<-sd(rotated_D[,3])


open3d() # open new window for 3D plot
options(rgl.useNULL = FALSE, rgl.printRglwidget = TRUE)
scatter3d(x,y,z, point.col = "red", surface=TRUE,grid=TRUE)

#open3d()
scatter3d(rotated_D[,1],rotated_D[,2],rotated_D[,3], point.col = "green", surface=TRUE,grid=TRUE)

