# Create the dataset from the course with play outside
rm(list=ls())
graphics.off()

# Outlook
is_sunny <- c(TRUE,TRUE,FALSE,FALSE,FALSE,TRUE,TRUE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE)

# Temperature
is_warm <-  c(TRUE,TRUE,TRUE,FALSE,FALSE,FALSE,TRUE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE)

#Humidity
is_higly_humid <- c(TRUE,TRUE,TRUE,FALSE,FALSE,FALSE,TRUE,FALSE,FALSE,FALSE,TRUE,FALSE,TRUE)

#Wind
is_windy <- c(FALSE,TRUE,FALSE,FALSE,TRUE,TRUE,FALSE,FALSE,FALSE,TRUE,TRUE,FALSE,TRUE)

#Play outside ?
is_playable <- c(FALSE,FALSE,TRUE,TRUE,FALSE,TRUE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE)


tennis <- data.frame(is_sunny, is_warm, is_higly_humid,is_windy, is_playable)

save(tennis,file="C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\tennis_data.RData")