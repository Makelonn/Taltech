#Silhouette

rm(list=ls())
graphics.off()


source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\ml_distance.R")
# Compute the silhouette
# Dataset should have the label as the last col and all the other cols are the coordinate

load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\data\\result_kmeans.RData")
#label is the cluster to which we want to do the distance
# dataset should contain the label
# point should NOT contain its label, only the coordinate
#plot(x)
average_dist_other_cluster <- function(dataset, point, label)
{
  
  clusterpoint <- dataset[dataset[,ncol(dataset)]==label,]
  clusterpoint <- clusterpoint[,1:(ncol(dataset)-1)]
  avg_dist <- 0.0
  for(i in seq(along=1:nrow(clusterpoint)))
  {
    avg_dist <- avg_dist + mydistfun(point, clusterpoint[i,])
  }
  avg_dist <- avg_dist/nrow(clusterpoint)
  return(avg_dist)
}

# Cluster shouldn't contain the label col, and the point neither
# Cluster shouldn't contain the point
average_dist_same_cluster <- function(cluster, point)
{
  avg_dist <- 0.0
  for(i in seq(along=1:nrow(cluster)))
  {
    avg_dist <- avg_dist + mydistfun(point, cluster[i,])
  }
  avg_dist <- avg_dist/nrow(cluster)
  return(avg_dist)
}

silhouette <- function(dataset)
{
  #We will add values as we compute them
  sil <- vector()
  k <- max(dataset[,ncol(dataset)])
  for(p in seq(along=1:nrow(dataset)))
  {
    point_to_study <- dataset[p, 1:(ncol(dataset)-1)]
    label_point <- dataset[p, ncol(dataset)]
    dist_other_cluster <- vector()
    for(cl in seq(along=1:k))
    {
      if(cl != label_point){
        dist_other_cluster <- c(dist_other_cluster, average_dist_other_cluster(dataset, point_to_study, cl))
      }
    }
    cluster_in <- dataset[-p,] # Remove the point we are studying
    cluster_in <- cluster_in[cluster_in[,ncol(cluster_in)]==label_point,] #Only keep point from the same label
    Din_avg <- average_dist_same_cluster(cluster_in, point_to_study)
    Dou_min <- min(dist_other_cluster)
    #We add our silhouette value to our cluster
    sil_p <- (Dou_min-Din_avg) / (max(Dou_min, Din_avg))
    sil <- c(sil, sil_p)
    cat(p, "/", nrow(dataset), "\n")
  }
  return(sil)
}

my_sil <- silhouette(classified)
cluster_with_sil <- data.frame(classified[,ncol(classified)], my_sil)
colnames(cluster_with_sil)<-c("Cluster","Silhouette_value")
#We order by cluster and then by silhouette value
cluster_with_sil <- cluster_with_sil[order(cluster_with_sil$Cluster,cluster_with_sil$Silhouette_value),]
K <- max(classified[,ncol(classified)])
plot(1:nrow(cluster_with_sil),
     cluster_with_sil$Silhouette_value, type="h", xaxt = "n", xlab = "Cluster label",
     ylab = "Silhouette", col=cluster_with_sil$Cluster)

save(my_sil, file="C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\data\\result_sil_unordered.RData")
save(cluster_with_sil, file="C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\data\\result_sil_ordered.RData")
