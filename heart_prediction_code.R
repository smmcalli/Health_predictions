set.seed(214)
library(readr)
#heart_attack_prediction_dataset <- read_csv("heart_attack_prediction_dataset.csv")
#View(heart_attack_prediction_dataset)

#INITIAL DATA CLEANING_____________________________________________________________________________
Heart=heart_attack_prediction_dataset 
bp <- do.call(rbind, strsplit(as.character(Heart$`Blood Pressure`), "/"))   #split blood pressure
Heart$SystolicBP <- as.numeric(bp[,1])
Heart$DiastolicBP <- as.numeric(bp[,2])
Heart$`Blood Pressure` <- NULL
Heart$`Patient ID` <- NULL
Heart$ratio <- Heart$SystolicBP/Heart$DiastolicBP
Heart[] <- lapply(Heart, function(x) {
  if (is.character(x)) as.factor(x) else x
})
Heart=na.omit(Heart)     #remove nulls
names(Heart) <- make.names(names(Heart))


#DECISION TREE___________________________________________________________________________________
library(rpart)

#Converting to factors
dats=Heart
dats$Diabetes <- as.factor(dats$Diabetes)
dats$Family.History <- as.factor(dats$Family.History)
dats$Smoking <- as.factor(dats$Smoking)
dats$Obesity <- as.factor(dats$Obesity)
dats$Alcohol.Consumption <- as.factor(dats$Alcohol.Consumption)
dats$Previous.Heart.Problems <- as.factor(dats$Previous.Heart.Problems)
dats$Heart.Attack.Risk <- as.factor(dats$Heart.Attack.Risk)
dats$Medication.Use <- as.factor(dats$Medication.Use)
dats$Stress.Level <- as.factor(dats$Stress.Level)
dats$Physical.Activity.Days.Per.Week <- as.factor(dats$Physical.Activity.Days.Per.Week)
dats$Sleep.Hours.Per.Day <- as.factor(dats$Sleep.Hours.Per.Day)
str(dats)

#test and training
grab<-sample(1:nrow(dats),nrow(dats)/4,replace=FALSE) 
test_heart=dats[grab,]  
train_heart=dats[-grab,]

y_test=test_heart$Heart.Attack.Risk
x_test=test_heart
x_test$Heart.Attack.Risk <- NULL

y_train=train_heart$Heart.Attack.Risk
x_train=train_heart
x_train$Heart.Attack.Risk <- NULL

model.control <- rpart.control(minsplit = 200, xval = 10, cp = 0) 
fit.train_heart <- rpart(Heart.Attack.Risk~., data=train_heart, method = 'class',control=model.control ) 

#prediction
pred.dt <- predict(fit.train_heart,newdata=test_heart, type='class') 
#confusion matrix
table(Predicted = pred.dt, Actual = y_test)
#error & accuracy
test_err_dt <- mean(pred.dt != y_test)
dt_accuracy=1-test_err_dt
dt_accuracy   #=.847

#plot
x11()                     
plot(fit.train_heart, uniform=T, compress=T) 
text(fit.train_heart, cex=1) 
title("Decision Tree for Heart Attack Risk Prediction")

#RANDOM FOREST______________________________________________________________________________________
library(randomForest)  
Heart_traindf <- as.data.frame(train_heart)
rf.fit <- randomForest(`Heart.Attack.Risk` ~ .,data = Heart_traindf, ntree = 500)

#prediction
pred.rf <- predict(rf.fit, x_test)
#confusion matrix
table(Predicted = pred.rf, Actual = y_test)
#error & accuracy
test_err_rf <- mean(pred.rf != y_test)
df_accuracy=1-test_err_rf
df_accuracy   #=.910

#plot
x11()  
varImpPlot(rf.fit) 
title("Variable Importance          ")


importance(rf.fit) 
#rf top 5 important attributes:
  #Cholesterol
  #Age 
  #SystolicBP
  #Country
  #Exercise.Hours.Per.Week


#PRINCIPAL COMPONENT ANALYSIS_______________________________________________________________________
dats=Heart
library(ggplot2)
#obtain and scale numeric attributes
Heart_num <- dats[, c("Age",
                     "Cholesterol",
                     "Heart.Rate",
                     "Exercise.Hours.Per.Week",
                     "Stress.Level",
                     "BMI",
                     "Triglycerides",
                     "Physical.Activity.Days.Per.Week",
                     "Sleep.Hours.Per.Day",
                     "SystolicBP",
                     "DiastolicBP",
                     "ratio")]
#Heart_num <- scale(Heart_num)
#PCA model
fit <- prcomp(Heart_num, center = TRUE, scale = TRUE)
summary(fit) 
#PC1-5 account for >50% of variance
fit$rotation
#Attributes in PC1-5 with magnitude >.3
  #PC1: strong positive associations for SystolicBP and ratio, strong negative association for DiastolicBP
  #PC2: strong positive associations for Cholesterol and Exercise, strong negative association for Stress.Level
  #PC3: strong positive associations for Sleep.Hours.Per.Day, strong negative association for Exercise.Hours.Per.Week and Triglycerides
  #PC4: strong positive associations for BMI, SystolicBP, and DiastolicBP
  #PC5: strong negative association for Cholesterol, Exercise.Hours.Per.Week, Stress.Level, and Physical.Activity.Days.Per.Week



x11()
plot(fit)

PC_dats <- as.data.frame(fit$x[,1:5])
x11()
ggplot(data=PC_dats[ , c(1:5)])+
  geom_point(mapping=aes(x=PC1,y=PC2))+ 
  ggtitle("PC1 vs PC2")


#K-MEANS____________________________________________________________________________________________
library(cluster)

grab<-sample(1:nrow(dats),nrow(dats)/4,replace=FALSE) 
test_heart=dats[grab,]  
train_heart=dats[-grab,]

km <- kmeans(PC_dats, centers = 2, nstart = 100)
rand.index(km$cluster, as.numeric(dats$Heart.Attack.Risk))        #.528  
adj.rand.index(km$cluster, as.numeric(as.character(dats$Heart.Attack.Risk)))    #.665


x11()
plot(PC_dats[,1:5], col = km$cluster, main = "K-means Clusters")
sil <- silhouette(km$cluster, dist(PC_dats))
summary(sil)
x11()
plot(sil, main = "Silhouette Plot")

gap_kmeans <- clusGap(PC_dats, kmeans, nstart = 10, K.max = 5, B = 150)
x11()
plot(gap_kmeans, main = "Gap Statistic: kmeans")


