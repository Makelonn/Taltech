rm(list=ls())
graphics.off()


nb_points <- 400
dimension <- 2
sigma <- 0.5

#Generating the angles
x1 <- runif(nb_points, 0, pi) #First moon angles
x2 <- runif(nb_points, pi, 2 * pi) #Second moon angles
  
  
#Generating our points
c1 <- cbind(8 * cos(x1) + (rnorm(nb_points) * sigma) - 4, 12 * sin(x1) + rnorm(nb_points) * sigma + 4) #+4 because -4 + 8(shift)
c2 <- cbind(8 * cos(x2) + (rnorm(nb_points) * sigma) + 4, 12 * sin(x2) + rnorm(nb_points) * sigma + 4 )
  
#Labelling crescents
c1 <- cbind(c1, 1)
c2 <- cbind(c2, 2)
  
#Adding cressents in the dataset
x <- rbind(c1,c2)
  
#save(x, file= "C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework2\\moon.RData")
plot(x, col=x[,3]+1)