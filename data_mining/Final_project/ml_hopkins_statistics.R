# Entropy function

#Cleaning the workspace and loading distance fucntion
save_results <- FALSE

source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\ml_distance.R")

load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\data\\result_sampling.RData")

#-> Take a representative sample ?
data <- sampled_pers[,1:ncol(sampled_pers)-1] #We don't need to bother ourselves with labels and we work in 2D

datasize <- as.integer(nrow(data)*0.9) # Our sample will be 70% of the original dataset

sample_pts <- data
index_sample <- sample(nrow(data), size=datasize, replace=FALSE)
sample_pts <- sample_pts[index_sample,]

dim <- ncol(data)

# Generating sample data
random_pts <- c()
for(i in seq(dim))
{
  min_i <- min(sample_pts[,i])*0.99
  max_i <- max(sample_pts[,i])*1.01
  
  rdm_i <- runif(datasize, min_i, max_i)
  
  random_pts <- cbind(random_pts, rdm_i)
}
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
  cat(i, "/", datasize, "\n")
}
cat("END\n")
#Distance S - D
distance_SD <- matrix(, nrow=datasize, ncol=size_D) #S is the same size as R
for(i in seq(along=1:datasize))
{
  for(j in seq(along=1:size_D))
  {
    distance_SD[i,j] <- mydistfun(random_pts[i,],data[j,])
  }
  cat(i, "/", datasize, "\n")
}
cat("END\n")
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
  cat(i, "/", datasize, "\n")
}
 hopkins <- hopkins_top / hopkins_bot
cat("Hopkins statistic value is ", hopkins)

if(save_results)
{
  save(hopkins, file="C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\data\\result_hopkins.RData")
}