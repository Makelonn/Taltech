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
  
  #Independants
  val1 <- runif(length_dataset,-200,300)
  val3 <- runif(length_dataset,-200,300)
  val5 <- runif(length_dataset,-200,300)

  for(i in seq(length_dataset))
  {
    #Linear combinaisons
    val2 <- c(val2, sin(val5[i]/2)*val3[i]*1/exp(val5))
    val4 <- c(val4, cos(val3[i]-val5[i]) * val5[i]**4)
  }
  
  
  
  my_data <- cbind(val1, val2, val3, val4, val5)
  
  
  if(save_data)
  {
    save(my_data,file="C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework2\\data\\ML_ex_4_dataset_pca.RData")
  }
  return(my_data)
}

