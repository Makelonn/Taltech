library(geometry)

mydistfun <- function(element1, element2, metricf="Euclidean", p=1) {
  # this function returns the distace between the element1 and element2
  # according to the function metricf
  
  dimensions <- length(element1)
  sqd <- matrix(, dimensions, 1)
  
  # MINKOWSKI
  if (metricf == "Minkowski") {
    p <- 1
    for (i in seq(along = element1)) {
      sqd[i] <- (abs(element1[i] - element2[i]))^p
    }
    dist <- (colSums(sqd))^(1 / p)
  }
  
  # CAMBERRA
  if (metricf == "Camberra") {
    for (i in seq(along = element1)) {
      sqd[i] <- (abs(element1[i] - element2[i])) / (abs(element1[i]) + abs(element2[i]))
    }
    dist <- colSums(sqd)
  }
  
  # MAHALANOBIS
  if (metricf == "Mahalanobis") {
    sub_matrix <- element1 - element2
    cov_matrix <- cov(element1, element2)
    dist <- sqrt(t(sub_matrix) * solve(cov_matrix) * sub_matrix)
    ## Another attempt to code this function
    
  }
  
  # EUCLIDIAN
  if (metricf == "Euclidean") {
    for (i in seq(along = element1)) {
      sqd[i] <- (element1[i] - element2[i])^2
    }
    dist <- sqrt(colSums(sqd))
  }
  
  # MANHATTAN
  if (metricf == "Manhattan") {
    for (i in seq(along = element1)) {
      sqd[i] <- abs(element1[i] - element2[i])
    }
    dist <- colSums(sqd)
  }
  
  return(dist)
}