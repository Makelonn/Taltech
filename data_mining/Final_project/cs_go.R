rm(list=ls())
graphics.off()

load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\data\\cs_go_data.RData")


### Preprocessing ###

# Labels are : wining a round or not
csgo_no_lab <- as.data.frame(cs_go_data[,-1])

### PCA

#Normalize data
#csgo_normal formula is zVar <- (myVar - mean(myVar)) / sd(myVar) 
cat("Mean for each features : \n", colMeans(csgo_normal))


csgo_no_lab.my_pca <- princomp(csgo_no_lab) #, cor = TRUE)
summary(csgo_no_lab.my_pca)
plot(csgo_no_lab.my_pca, main="PCA - Standard deviation")


### Hopkins statistics

# todo

### Clustering the data ###

# todo  

