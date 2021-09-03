data <- read.csv(file = "data/inflammation-01.csv", header = FALSE)
head(data) #Display the first rows/cols of a large dataset
avg_day_inflation <- apply(data, 2, mean)
plot(avg_day_inflation)

