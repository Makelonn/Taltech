# More classification algorithms demo
# Decision Trees, Logistic Regression and SVM algorithms

# clear everything and load required libraries/codes
rm(list=ls())

#loading and plotting data
load("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\ml_data.RData")

#data plotting - visualization
plot(x[,1],x[,2], col=scales::alpha(x[,3],0.3), pch=20)

# data preparation
set.seed(42) # seed is necessary to make it reproducible
#split the data in proportion 70/30 for training and test purposes.
training_percentage = 70
sample_size <- floor((training_percentage/100) * nrow(x))
train_ind <- sample(seq_len(nrow(x)), size = sample_size)
train_ind
train_set <- x[train_ind, ]
test <- x[-train_ind, ]
train <- train_set[,1:2] 
train_classes <- train_set[,3]

trainDF <- as.data.frame(train_set)
testDF <- as.data.frame(test)

library(e1071)
nbmodel = naiveBayes(train, train_classes, laplace = 0)
classes_hat = predict(nbmodel, test,
        type = c("class", "raw"), threshold = 0.001, eps = 0)
cat(classes_hat)


dev.off() #turning off previous plot

#DECISION TREES

#using library tree
library(tree)
# y ~ . forecast y, using all the predictors
treeTrain <- tree(as.factor(trainDF$V3) ~., trainDF) #formula to plot and where data comes from
summary(treeTrain) #some statistics
plot(treeTrain) #plotting of tee structure
text(treeTrain, pretty = 1) #adding text

preds <- predict(treeTrain, testDF, type="class") #to make it return class values
confusionMatrix <- table(testDF$V3, preds) #create confusion matrix
confusionMatrix
accTest <- sum(diag(confusionMatrix)) / sum(confusionMatrix) #get accuracy (ratio of correctly classified instances)
print(paste('Accuracy on Test data', accTest)) 

# Loading package
library(e1071)
library(caTools)
library(caret)

classifier_cl <- naiveBayes(noname ~ ., data = train_set)
classifier_cl

#using library party -  similar as before
library(party)

treeTrain2 <- ctree(as.factor(trainDF$V3) ~., trainDF)
plot(treeTrain2)

predictModel2 <- predict(treeTrain2, testDF)  
confusionMatrix2 <- table(testDF$V3, predictModel2)
confusionMatrix2
accTest <- sum(diag(confusionMatrix2)) / sum(confusionMatrix2) 
print(paste('Accuracy on Test data', accTest)) 



#LOGISTIC REGRESSION

#from generalized linear models library
logreg <- glm(formula=as.factor(trainDF$V3) ~., family = "binomial", data=trainDF, maxit=100) #binomial to have logreg binary classification, maxit = maximum iterations for convergence
summary(logreg)

probslr <- predict(logreg,newdata=testDF, type = "response") #get probabilities of the predictions
probslr[1:10] #see first 10 prob predictions
predClass <- ifelse(probslr > 0.5, 2, 1) #converting soft predictions (probs) to hard ones (labels), if greater than 0.5 then cat 1, otherwise 2
head(predClass)
confusionMatrix3 <- table(testDF$V3, predClass) #create confusion matrix
confusionMatrix3
accTest <- sum(diag(confusionMatrix3)) / sum(confusionMatrix3) #get accuracy
print(paste('Accuracy on Test data', accTest))



#SUPPORT VECTOR MACHINES or SVM
library(e1071)

# read more about the kernel trick - https://towardsdatascience.com/the-kernel-trick-c98cdbcaeb3f#:~:text=The%20%E2%80%9Ctrick%E2%80%9D%20is%20that%20kernel,the%20data%20by%20these%20transformed

svmT1 = svm(as.factor(trainDF$V3) ~ ., data = trainDF, kernel = "linear", scale = FALSE) #SVM using linear kernel - supposing data is linearly separable
print(svmT1)
plot(svmT1, trainDF)

svmT2 = svm(as.factor(trainDF$V3) ~ ., data = trainDF, kernel = "radial", scale = FALSE) #SVM using radial / circular kernel - when data is not linearly separable
print(svmT2)
plot(svmT2, trainDF)

svmT3 = svm(as.factor(trainDF$V3) ~ ., data = trainDF, kernel = "polynomial", scale = FALSE) #SVM using polynomial kernel - when data is not linearly separable
print(svmT3)
plot(svmT3, trainDF)

svmT4 = svm(as.factor(trainDF$V3) ~ ., data = trainDF, kernel = "sigmoid", scale = FALSE) #SVM using sigmoid kernel - when data is not linearly separable
print(svmT4)
plot(svmT4, trainDF)

svmpred <- predict(svmT1, testDF, type="class") #to make it return class values
confusionMatrix3 <- table(testDF$V3, svmpred) #confusion matrix
confusionMatrix3
accTest <- sum(diag(confusionMatrix3)) / sum(confusionMatrix3) #get accuracy
print(paste('Accuracy on Test data', accTest)) 

# What is the best SVM model for our data? Let's compare all the kernels on SVM for our data.
svmpred1 <- predict(svmT1, testDF, type="class") #prediction - class values for each model
svmpred2 <- predict(svmT2, testDF, type="class") 
svmpred3 <- predict(svmT3, testDF, type="class") 
svmpred4 <- predict(svmT4, testDF, type="class") 

cf1 <- table(testDF$V3, svmpred1) #confusion matrix for each model
cf2 <- table(testDF$V3, svmpred2)
cf3 <- table(testDF$V3, svmpred3)
cf4 <- table(testDF$V3, svmpred4)

accTest1 <- sum(diag(cf1)) / sum(cf1) #getting accuracy for each model
accTest2 <- sum(diag(cf2)) / sum(cf2) 
accTest3 <- sum(diag(cf3)) / sum(cf3) 
accTest4 <- sum(diag(cf4)) / sum(cf4) 

print(paste('Linear', accTest1)) #plotting the accuracy results
print(paste('Radial', accTest2))
print(paste('Polynomial', accTest3))
print(paste('Sigmoid', accTest4))

# Which one is the best one? Accuracy is interpreted as the higher, the better the model.
