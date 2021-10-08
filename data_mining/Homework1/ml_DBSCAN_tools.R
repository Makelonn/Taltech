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
    if(dist_line[i] < epsilon){
      cpt <- cpt + 1 
    }
  }
  cpt<-cpt-1 #We remove one because there is a distance of 0 with itself
  return(cpt<=tau)
}

is_border_point <- function(index, m_distance, dataset, epsilon)
{
  dist_line <- m_distance[index,]
  for(i in seq(along=1:length(dist_line)))
  {
    if((dist_line[i] < epsilon) &&(i != index) &&(dataset[i,ncol(dataset)]==1)){
      #if distance under epsilon and the point is a core point
      return(TRUE)
    }
  }
  return(FALSE)
}

dbscan_matrix <- function(dataset)
{
  my_matrix <- cbind(dataset, 0)
  return(my_matrix)
}


is_in_list <-function(value, list)
{
  if(is.na(list) || length(list)==0) {return(FALSE)}
  for(i in seq(along=1:length(value))){if((list[i]==value)){return(TRUE)}}
  return(FALSE)
}

find_neigh_core_point <- function(index, distances, epsilon, cores_index)
{
  neigh <- c()
  for(i in seq(along=1:length(cores_index)))
  {
    if(distances[index, cores_index[i]] <= epsilon) {neigh <- c(neigh, cores_index[i])}
  }
  return(neigh)
}

find_cluster_core <- function(index, distances, epsilon, cores_index)
{
  #Need to do a recursion 
}