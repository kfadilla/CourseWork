#problem1
mydata <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/ionosphere/ionosphere.data", sep = ",")
entries <- nrow(mydata)
symData <- plot(c(mydata$V2,mydata$V1),c(mydata$V20,mydata$V22))
barplot(table(mydata$V1), xlab = "True or False", ylab = "Count")
barplot(table(mydata$V2), xlab = "Value", ylab = "Count")
barplot(table(mydata$V35), xlab = "Good or Bad", ylab = "Count")

#Problem2
plot(mydata$V22,mydata$V20,col= ifelse(mydata$V35 == 'g', 'red', ifelse(mydata$V35 =='b', 'blue', 'black')))
plot(mydata$V1,mydata$V2,col= ifelse(mydata$V35 == 'g', 'red', ifelse(mydata$V35 =='b', 'blue', 'black')))
