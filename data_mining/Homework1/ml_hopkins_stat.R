# Hopkin# Entropy function

#Cleaning the workspace and loading distance fucntion
rm(list=ls())
graphics.off()
source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1\\ml_distance.R")

load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1\\ml_2D_data.RData")

plot(x, col=x[,3])

#-> Take a representative sample ?
data <- x[,1:2] #We don't need to bother ourselves with labels and we work in 2D

datasize <- as.integer(nrow(data)*0.7) # Our sample will be 70% of the original dataset

sample_pts <- data
index_sample <- sample(nrow(data), size=datasize, replace=FALSE)
sample_pts <- sample_pts[index_sample,]

plot(sample_pts)

# Generating sample data
min_x <- min(sample_pts[,1])*0.99
max_x <- max(sample_pts[,1])*1.01

min_y <- min(sample_pts[,2])*0.99
max_y <- max(sample_pts[,2])*1.01

random_x <- runif(datasize, min_x, max_x)
random_y <- runif(datasize, min_y, max_y)

random_pts <- cbind(random_x, random_y)
plot(data,  ylim=c(-10,35), xlim=c(-10,30))
par(new= TRUE)
plot(sample_pts, col="green", ylim=c(-10,35), xlim=c(-10,30))
par(new=TRUE)
#plot(random_pts, col='red', ylim=c(-10,35), xlim=c(-10,30))

#We will compute all the distance by once so we dont have to iterate several times
#Distance R - D

size_D <- nrow(data) #size R = datasize
distance_RD <- matrix(, nrow=datasize, ncol=size_D) #row = R and col = D
for(i in seq(along=1:datasize))
{
  for(j in seq(along=1:size_D))
  {
    distance_RD[i,j] <- mydistfun(sample_pts[i,],data[j,])
  }
}
#Distance S - D
distance_SD <- matrix(, nrow=datasize, ncol=size_D) #S is the same size as R
for(i in seq(along=1:datasize))
{
  for(j in seq(along=1:size_D))
  {
    distance_SD[i,j] <- mydistfun(random_pts[i,],data[j,])
  }
}

# Calculate Hopkins Statistics

# H = sum(distance DS) / sum(distance RD + DS)

hopkins_top <- 0
hopkins_bot <- 0
for(i in seq(along=1:datasize))
{
  i_sd <- which.min(distance_RD[i,]) # == min(distance_RD[i,]), arr.ind = TRUE)
  dis_RD <- distance_RD[,-i_sd] #We don't want to compare with itself
  hopkins_top <- hopkins_top +  min(distance_SD[i,])
  hopkins_bot <- hopkins_bot + (  min(dis_RD[i,]) +  min(distance_SD[i,]))
}
hopkins <- hopkins_top / hopkins_bot
cat("Hopkins statistic value is ", hopkins)