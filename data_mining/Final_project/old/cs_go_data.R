rm(list=ls())
graphics.off()

######### Loading data ######### 
# from https://www.kaggle.com/christianlillelund/csgo-round-winner-classification
cs_go_data <- read.csv("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\data\\csgo_round_snapshots.csv")


######### Librairy ######### 

library(matrixStats)
require('fBasics')
# First, we want only numerical data so we can use the function created before in the semester
# There are 3 non numerical columns: map, round winner & bomb_planted

######### Map to numerical ######### 

print(unique(cs_go_data$map)) #What values are possible

cs_go_data$map[cs_go_data$map=="de_dust2"] <- 1
cs_go_data$map[cs_go_data$map=="de_mirage"] <- 2
cs_go_data$map[cs_go_data$map=="de_nuke"] <- 3
cs_go_data$map[cs_go_data$map=="de_inferno"] <- 4
cs_go_data$map[cs_go_data$map=="de_overpass"] <- 5
cs_go_data$map[cs_go_data$map=="de_vertigo"] <- 6
cs_go_data$map[cs_go_data$map=="de_train"] <- 7
cs_go_data$map[cs_go_data$map=="de_cache"] <- 8

cs_go_data$map <- as.numeric(cs_go_data$map)

print(unique(cs_go_data$map)) #Check if all values are numerical

######### Round winner to numerical #########

print(unique(cs_go_data$round_winner)) #What values are possible

cs_go_data$round_winner[cs_go_data$round_winner=="T"] <- 1
cs_go_data$round_winner[cs_go_data$round_winner=="CT"] <- 2

cs_go_data$round_winner <- as.numeric(cs_go_data$round_winner)

print(unique(cs_go_data$round_winner)) #Check if all values are numerical

######### bomb_planted to numerical #########

print(unique(cs_go_data$bomb_planted)) #What values are possible

cs_go_data$bomb_planted[cs_go_data$bomb_planted=="True"] <- 1
cs_go_data$bomb_planted[cs_go_data$bomb_planted=="False"] <- 0

cs_go_data$bomb_planted <- as.numeric(cs_go_data$bomb_planted)

print(unique(cs_go_data$bomb_planted)) #Check if all values are numerical

######### Normalise data #########

csgo_no_lab <- as.matrix(cs_go_data[,-1]) # Labels are : wining a round or not

#csgo_no_lab <- csgo_no_lab[1:300,]
#csgo_normal formula is zVar <- (myVar - mean(myVar)) / sd(myVar) 

csgo_normal <- matrix(, nrow=nrow(csgo_no_lab), ncol=ncol(csgo_no_lab))

for(i in seq(ncol(csgo_no_lab)))
{
  current_mean <- mean(csgo_no_lab[i,], na.rm = TRUE)
  current_sd <- sd(csgo_no_lab[i,])
  cat(i,"/",ncol(csgo_no_lab),"\tmean ", current_mean, "\tsd ", current_sd, "\n")
  for(j in seq(nrow(csgo_no_lab)))
  {
    csgo_normal[j,i] <- (csgo_no_lab[j,i] - current_mean) / current_sd
  }
  
}

#cat("Means : ", colMeans(csgo_normal), "\nStandard dev :", colSds(csgo_normal), "\n") #Check the value
csgo_normal <- c(csgo_normal, as.vector(cs_go_data[,ncol(cs_go_data)])) #Labels
######### Saving to RData file #########
save(cs_go_data, file="C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\data\\cs_go_data.RData")
save(csgo_normal, file="C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\data\\cs_go_data_normal.RData")
