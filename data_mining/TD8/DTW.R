#### Cleaning workspace, load functions ###
rm(list=ls())
graphics.off()
source(file = "C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\TD8\\ML_distance.R")


### DTW implementation
DTW_matrix <- function(seq1, seq2)
{
  dtw <- matrix(0, nrow=length(seq1), ncol=length(seq2))
  for(i in seq(1:length(seq1)))
  {
    for(j in seq(1:length(seq2)))
    {
      #Cost
      dist <- mydistfun(seq1[i], seq2[i])
      
      #Getting the minimum value
      previous <- c()
      if(i-1 >= 1) {previous <- c(previous, dtw[i-1, j])
      if(j-1 >= 1) {previous <- c(previous, dtw[i-1, j-1])}}
      if(j-1 >= 1) {previous <- c(previous, dtw[i, j-1])}
      if(length(previous) == 0) {previous <- c(0)}
      dtw[i,j] <- dist + min(previous)
    }
  }
  return(dtw)
}

find_path <- function(dtw_matrix)
{
  len_seq1 <- nrow(dtw_matrix)
  len_seq2 <- ncol(dtw_matrix)
  #First col is the index of the element in seq 2, second col is the min distance
  path_matrix <- matrix(,nrow=0, ncol=2)
  colnames(path_matrix) <- c("Seq1_index", "Seq2_index")
  #We need to find for each row the minimum distance
  #We exclude first and last row 
  current_i <- len_seq1
  current_j <- len_seq2
  while(TRUE)
  {
    smaller <- get_smaller_around(dtw_matrix, current_i, current_j)
    if((smaller[1] == -1) ||(smaller[2]==-1) || ((smaller[1]==1)&&(smaller[2]==1))) {
      return(rbind(path_matrix, c(1,1)))}
    path_matrix <- rbind(path_matrix, smaller)
    current_i <- smaller[1]
    current_j <- smaller[2]
    cat(current_i)
    print(current_j)
  }
  #return(path_matrix)
}

get_smaller_around <- function(dtw, i, j)
{
  # Gives the best index tuple for the path STARTING FROM LAST DISTANCES
  # dtw: dtw_matrix with the cost from seq1(rows) to seq2(colums)
  # i: row index
  # j: col index
  max_val <- dtw[nrow(dtw), ncol(dtw)]
  index_tupel <- c(-1,-1)
  if((i-1 > 1) && dtw[i-1, j] <= max_val) {
    index_tupel <- c(i-1, j)
    max_val <- dtw[i-1, j]
    if((j-1 > 1)&& dtw[i-1, j-1] <= max_val){
      index_tupel <- c(i-1, j-1)
      max_val <- dtw[i-1, j-1]
    }
  }
  if((j-1 > 1) && dtw[i, j-1] <= max_val) {
    index_tupel <- c(i, j-1)
    max_val <- dtw[i, j-1]
  }
  return(index_tupel)
}



### Simple model ###
load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\TD8\\data_DTW2.RData")
my_dtw1 <- DTW_matrix(seq1, seq2)
my_path1 <- find_path(my_dtw1)
#Plotting the curves
plot(seq1, col='darkslateblue', type='l', xlim=c(0,9), ylim=c(0,13) ) 
par(new=TRUE)
plot(seq2, col='orange', type='l', xlim=c(0,9), ylim=c(0,13))
for(i in seq(nrow(my_path1)))
{
  segments(my_path1[i,1],seq1[my_path1[i,1]],my_path1[i,2], seq2[my_path1[i,2]])
}

### More complex model ###
par(new=FALSE)
load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\TD8\\data_DTW.RData")
my_dtw1 <- DTW_matrix(seq1, seq2)
my_path1 <- find_path(my_dtw1)
#Plotting the curves
plot(seq1, col='darkslateblue', type='l', ylim=c(-200, 500), xlim=c(25,60) ) 
par(new=TRUE)
plot(seq2, col='orange', type='l', ylim=c(-200, 500), xlim=c(25,60))
for(i in seq(nrow(my_path1)))
{
  segments(my_path1[i,1],seq1[my_path1[i,1]],my_path1[i,2], seq2[my_path1[i,2]])
}