rm(list=ls())
graphics.off()

#To plot the PCA
library(ggbiplot)
library(FactoMineR)
#Generate a dataset
source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework2\\ML_ex_4_generate_dataset_pca.R")

more_than_one_seed <- FALSE

length_data <- 300 
#My data
#load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\part2_perso\\data_PCA.RData")
if(more_than_one_seed){
par(mfrow = c(5 ,4), byrow = TRUE)
for(i in seq(20))
{
set.seed(i)
x <- as.data.frame(generate_pca_dataset(length_data))

x.my_pca <- princomp(x, cor = TRUE)
summary(x.my_pca)

labels <- rep('x', length_data) #Because biplot dos not gives ch parameter
#biplot(x.my_pca, xlabs=labels)
plot(x.my_pca, main=i)
}

par(mfrow = c(5 ,4), byrow = TRUE)
ivalues <- 21:40
for(i in ivalues)
{
  set.seed(i)
  x <- as.data.frame(generate_pca_dataset(length_data))
  
  x.my_pca <- princomp(x, cor = TRUE)
  summary(x.my_pca)
  
  labels <- rep('+', length_data) #Because biplot dos not gives ch parameter
  #biplot(x.my_pca, xlabs=labels)
  plot(x.my_pca, main=i)
}
}else{
par(mfrow = c(1 ,1))
#Best found dataset
set.seed(33)
x <- as.data.frame(generate_pca_dataset(length_data))
x.my_pca <- princomp(x, cor = TRUE)
summary(x.my_pca)
#labels <- rep('+', length_data) #Because biplot dos not gives ch parameter
#biplot(x.my_pca, xlabs=labels)
plot(x.my_pca, main="PCA - Standard deviation")
##Seed 33 !!!!!
}