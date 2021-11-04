# clear
graphics.off()
rm(list=ls())
library(car)

#Loading data
data <- readxl::read_excel('C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\TD7\\test2.xls', col_names = FALSE)


#OPT1 :  manually take correlated attributes (not good idea bc
#lot of attribute is complicated to manage)


diag(cov(data[,1:8])^(1/2))

for(i in seq(along=1:8))
{
  print(paste('SD of col'), i, ":", sqrt(cov(data[,i])))
}

cor(data[,1:8])
#OPT2 : Apply PCA, out some features

colnames(data) <- 1:10
model1 <- lm(data$10-data$1)
#eig <- eigen(data[,1:8])

