rm(list=ls())
graphics.off()

datasize <- 1500
min_x <- -10
min_y <- -10
max_x <- 30
max_y <- 30

random_x <- runif(datasize, min_x, max_x)
random_y <- runif(datasize, min_y, max_y)

random_pts <- cbind(random_x, random_y)

plot(random_pts)

save(random_pts, file="C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\randomly.RData")