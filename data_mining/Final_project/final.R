######### Cleaning workspace ######### 
rm(list=ls())
graphics.off()

######### Loading data ######### 
# from https://www.kaggle.com/ramontanoeiro/big-five-personality-test-removed-nan-and-0?select=data-final-clean.csv
personnality <- read.csv("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\data\\data.csv")
nb_question <- ncol(personnality)-1
personnality <- as.matrix(personnality[,1:nb_question]) #removing the country : it's string and we care about question only

######### Parameters #########
sample_size <- 2500
save_results <- FALSE
######### Sampling the data #########
samp_coord <- sample(1:nrow(personnality), sample_size)
sampled_pers <- personnality[samp_coord,]

######### Tools #########
source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\ml_kmeans.R")
#source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\ml_silhouette.R")
source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\ml_decision_tree.R")

######### K-means algorithm #########
classified <- ml_k_means(sampled_pers, 5)
if(save_results){save(classified, file="C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\data\\result_kmeans.RData")
}

cat("Checking the value of labels : ", unique(classified[,nb_question+1]))

######### Silhouette #########
sil <- silhouette(classified)
cluster_with_sil <- data.frame(classified[,ncol(classified)], sil)
colnames(cluster_with_sil)<-c("Cluster","Silhouette_value")
#We order by cluster and then by silhouette value
cluster_with_sil <- cluster_with_sil[order(cluster_with_sil$Cluster,cluster_with_sil$Silhouette_value),]
K <- max(x[,ncol(x)])
plot(1:nrow(cluster_with_sil),
     cluster_with_sil$Silhouette_value, type="h", xaxt = "n", xlab = "Cluster label",
     ylab = "Silhouette", col=cluster_with_sil$Cluster)

if(save_results){
  save(sil, file="C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\data\\result_sil_unordered.RData")
  save(cluster_with_sil, file="C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\data\\result_sil_ordered.RData")
}
######### Decision tree #########
my_tree <- decision_tree(classified, Node$new("Decision tree"))
plot(my_tree)
print(my_tree)

if(save_results){save(my_tree, file="C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\data\\result_tree.RData")
}

cat("Done\n")

