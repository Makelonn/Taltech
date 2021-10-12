######### --- FISHER SCORE 2D --- #########
###########################################
#The larger the fisher score, the better it is (greter discriminatory power)
#mu_j = mean
#teta_j = standart deviation for cluster j (ecart-type)
#p_j : nb of point in the cluster
#mu is the global mean
rm(list=ls())
graphics.off()

mu <- function(dataset, feature_index)
{
  mu <- 0
  for(i in seq(along=1:nrow(dataset)))
  {
    mu <- mu + dataset[i,feature_index]
  }
  mu <- mu / nrow(dataset)
  return(mu)
}

teta_square <- function(dataset,feature_index, mu)
{
  #square_root(1/n * sum_all_pts(x_i - x_mean)^2)
  n <- nrow(dataset)
  teta <- 0
  for(i in seq(along=1:n))
  {
    teta <- teta + (dataset[i, feature_index] - mu)**2
  }
  teta <- (1/n)*teta
  return(teta)
}

fisher_score <- function(dataset)
{
  nb_feature <- ncol(dataset) -1
  print(nb_feature)
  nb_class <- max(dataset[,ncol(dataset)])
  fisher_by_feature <- c()
  for(feature in seq(along=1:nb_feature))
  {
    mu_global <- mu(dataset, feature)
    up_part <- 0
    low_part <- 0
    for(class_j in seq(along=1:nb_class)){
      cluster <- dataset[dataset[,ncol(dataset)]==class_j,]
      cluster<- cluster[, 1:ncol(cluster)-1]
      p_j <- nrow(cluster)
      mu_j <- mu(cluster, feature)
      teta_j <- teta_square(cluster, feature, mu_j)
      up_part <- up_part + p_j*((mu_j - mu_global)**2)
      low_part <- low_part + p_j*teta_j
    }
    fisher <- up_part / low_part
    fisher_by_feature <- c(fisher_by_feature, fisher)
  }
  return(fisher_by_feature)
}


load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework1\\ml_2D_data.RData")

fisher_for_all_feature <- fisher_score(x)