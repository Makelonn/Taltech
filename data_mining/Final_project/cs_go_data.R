rm(list=ls())
graphics.off()

# cs_go_data from https://www.kaggle.com/christianlillelund/csgo-round-winner-classification


cs_go_data <- read.csv("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\data\\csgo_round_snapshots.csv")

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

######### Saving to RData file #########
save(cs_go_data, file="C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Final_project\\data\\cs_go_data.RData")