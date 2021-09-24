
rm(list=ls())
graphics.off()

load(file="\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\TD3\\data_training\\kmeans\\dataforEM.RData")

plot(train_set[, 1], train_set[, 2], type='p', col=train_set[,3])
par(new=TRUE)
points(centroids[,1], centroids[,2], col="red", type="p")