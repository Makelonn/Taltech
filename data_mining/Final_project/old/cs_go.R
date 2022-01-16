rm(list=ls())
graphics.off()

load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\data\\cs_go_data_normal.RData")

### Librairies ###


### Preprocessing ###

# Labels are : wining a round or not
csgo_no_lab <- as.data.frame(csgo_normal[,1:(ncol(csgo_normal)-1)])

### PCA

csgo_no_lab.my_pca <- princomp(csgo_no_lab) #, cor = TRUE)
summary(csgo_no_lab.my_pca)
plot(csgo_no_lab.my_pca, main="PCA - Standard deviation")


### Hopkins statistics

# todo

### Clustering the data ###

# todo  

