######### Cleaning workspace ######### 
rm(list=ls())
graphics.off()


######### Parameters #########
sample_size <- 2500
save_results <- TRUE

######### Loading data ######### 
# from https://www.kaggle.com/ramontanoeiro/big-five-personality-test-removed-nan-and-0?select=data-final-clean.csv
personnality <- read.csv("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\data\\data.csv")
nb_question <- ncol(personnality)-1
personnality <- as.matrix(personnality[,1:nb_question]) #removing the country : it's string and we care about question only

######### Sampling the data #########
samp_coord <- sample(1:nrow(personnality), sample_size)
sampled_pers <- personnality[samp_coord,]

if(save_results)
{
  save(sampled_pers, file="C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\data\\result_sampling.RData")
}

######### Tools #########
source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\ml_kmeans.R")

######### Hopkins #########
#source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\ml_hopkins_statistics.R")

######### K-means algorithm #########
classified <- ml_k_means(sampled_pers, 3)
if(save_results){save(classified, file="C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\data\\result_kmeans.RData")
}

cat("Checking the value of labels : ", unique(classified[,nb_question+1]))

######### Silhouette #########

source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\ml_silhouette.R")


cat("Done\n")
