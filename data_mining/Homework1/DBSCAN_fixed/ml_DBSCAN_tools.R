#DBscan ressources


point_to_point_distance_dataset <- function(dataset)
{
  size_dataset = nrow(dataset)
  distance_matrix <- matrix(, nrow=size_dataset, ncol=size_dataset)
  for(i in seq(along=1:size_dataset))
  {
    for(j in seq(along=1:i))
    {
      if(j==i) {distance_matrix[i,j] <- 0}
      else
      {
        dist <- mydistfun(dataset[i,],dataset[j,])
        distance_matrix[i,j] <- dist
        distance_matrix[j,i] <- dist
      }
    }
  }
  return(distance_matrix)
}

is_core_point <- function(index, m_distance, tau, epsilon)
{
  dist_line <- m_distance[index,]
  cpt<-0
  for(i in seq(along=1:length(dist_line)))
  {
    if(dist_line[i] <= epsilon){
      cpt <- cpt + 1 
    }
  }
  cpt<-cpt-1 #We remove one because there is a distance of 0 with itself
  return(cpt>=tau)
}

is_border_point <- function(index, m_distance, dataset, epsilon)
{
  dist_line <- m_distance[index,]
  for(i in seq(along=1:length(dist_line)))
  {
    if((dist_line[i] <= epsilon) &&(i != index) &&(dataset[i,ncol(dataset)]==0)){
      #if distance under epsilon and the point is a core point
      return(TRUE)
    }
  }
  return(FALSE)
}

get_border_neigh_core <- function(index, m_dist, dataset, epsilon)
{
    dist_line <- m_dist[index,]
    for(i in seq(along=1:length(dist_line)))
    {
      if((dist_line[i] <= epsilon) &&(i != index) &&(dataset[i,ncol(dataset)]==0)){
        #if distance under epsilon and the point is a core point
        return(i)
      }
    }
    return(-1)
}

dbscan_matrix <- function(dataset)
{
  my_matrix <- cbind(dataset, 0, 0,0)
  colnames(my_matrix)<-c("X","Y", "Type_of_point", "Label", "Index")
  return(my_matrix)
}


find_neigh_core_point <- function(index, distances, epsilon, cores_index)
{
  neigh <- c()
  for(i in seq(along=1:length(cores_index)))
  {
    dist <- distances[index, as.integer(cores_index[i])]
    if(((dist <= epsilon) && (i != index))) {neigh <- c(neigh, as.integer(cores_index[i]))}
  }
  return(neigh)
}

cluster_point <- function(dataset, index, distances, epsilon, other_pts_cluster)
{
  #cp_data <- dataset(X,Y, Typeofpoint=1, Label, Index) | Index (int) | distances | epsilon | vecteur vide
  neigh_descendants <- c(other_pts_cluster)
  neigh <- find_neigh_core_point(index, distances, epsilon, dataset[,5])
  #print(neigh_descendants)
  for(i in seq(along=1:length(neigh)))
  {
    if(!(neigh[i] %in% neigh_descendants) || (length(neigh_descendants) == 0))
    {
      neigh_descendants <- c(neigh_descendants, neigh[i])
      neigh_descendants <- c(neigh_descendants, cluster_point(dataset, neigh[i], distances, epsilon, neigh_descendants))
    }
  }
  return(unique(neigh_descendants))
}

eliminate_occurence <- function(value, list)
{
  if(length(list)==0){return(list)}
  for(i in seq(along=1:length(list)))
  {
    if(list[i]==value){
      list <- list[-i]
      return(list)
    }
  }
}