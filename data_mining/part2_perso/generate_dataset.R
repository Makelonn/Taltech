rm(list=ls())
graphics.off()

generate_pca_dataset <- function(length_dataset, seed=123, save_data=FALSE)
{
  #set.seed(seed)
  val1  <- c()
  val2  <- c()
  val3  <- c()
  val4  <- c()
  val5  <- c()
  val6  <- c()
  val7  <- c()
  val8  <- c()
  
  #Independants
  val1 <- runif(length_dataset,-200,300)
  val3 <- runif(length_dataset,-200,300)
  val5 <- runif(length_dataset,-200,300)

  for(i in seq(length_dataset))
  {
    #Linear combinaisons
    #val4 <- c(val4, 4*val1[i]*val2[i])
    #val5<- c(val5, -4*val2[i]*val3[i])
    val2 <- c(val2, sin(val5[i]/2)*val3[i]*1/exp(val5))
    val4 <- c(val4, cos(val3[i]-val5[i]) * val5[i]**4)
    val6 <- c(val6, 4*(val5[i]**2)*cos(val5[i]))
    #val7 <- c(val7, exp(val2[i]))
    #val7 <- c(val7, cos(val2[i])*exp(val3[i]))
  }
  
  
  
  my_data <- cbind(val1, val2, val3, val4, val5)#, val6)#, val7) #, val7) #, val7, val8, val9, val10)
  
  
  if(save_data)
  {
    save(my_data,file="C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\part2_perso\\data_PCA.RData")
  }
  return(my_data)
}

