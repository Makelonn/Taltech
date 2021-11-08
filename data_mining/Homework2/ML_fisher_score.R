######### --- FISHER SCORE 2D --- #########
###########################################
#The larger the fisher score, the better it is (greter discriminatory power)
#mu_j = mean
#teta_j = standart deviation for cluster j (ecart-type)
#p_j : nb of point in the cluster
#mu is the global mean
rm(list=ls())
graphics.off()


load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework2\\data\\ML_dataset_3D_labels.RData")

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

fisher_score <- function(dataset, display=FALSE)
{
  nb_feature <- ncol(dataset)-1
  nb_class <- max(dataset[,ncol(dataset)])
  fisher_by_feature <- c()
  for(feature in seq(along=1:nb_feature))
  {
    if(display){
      display_matrix <- matrix(, nrow = nb_class, ncol=3)
      colnames(display_matrix) <- c("P_j", "Mu_j", "Teta_j")
    }
    mu_global <- mu(dataset, feature)
    up_part <- 0
    low_part <- 0
    for(class_j in seq(along=1:nb_class))
    {
      cluster <- dataset[dataset[,ncol(dataset)]==class_j,]
      cluster<- cluster[, 1:ncol(cluster)-1]
      p_j <- nrow(cluster)
      mu_j <- mu(cluster, feature)
      teta_j <- teta_square(cluster, feature, mu_j)
      if(display){
        display_matrix[class_j,1] <- p_j
        display_matrix[class_j,2] <- mu_j
        display_matrix[class_j,3] <- teta_j
      }
      up_part <- up_part + p_j*((mu_j - mu_global)**2)
      low_part <- low_part + p_j*teta_j
    }
    if(display){
      cat("\nCoefficient calculated :\n")
      print(display_matrix)}
    fisher <- up_part / low_part
    fisher_by_feature <- c(fisher_by_feature, fisher)
  }
  if(display)
  {
    fish_display <- matrix(fisher_by_feature, nrow=1)
    rownames(fish_display) <- c("Fisher score")
    cat("\nFisher score for all features :\n")
    print(fish_display)
    max_index <- which.max(fisher_by_feature)
    cat("\nThe feature with the maximum fisher score is the feature number : ")
    cat(max_index)
    cat("\n")
  }
  return(fisher_by_feature)
}
# /!\ Need to have features
fisher_score(x, display=TRUE)