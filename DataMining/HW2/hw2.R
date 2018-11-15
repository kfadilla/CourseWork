mydata <- fread("https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/breast-cancer-wisconsin.data")
head(mydata)
mydata$v7 <- as.numeric(mydata$V7) #convert to numeric value

nrow(mydata) #number of row in the data
nrow(mydata) * 11 #total entries in the data

table(is.na(mydata)) #number of missing value

id <- mydata$V1
hist(id)

clumpThinkness <- mydata$V2
hist(clumpThinkness)

uniformityOfCellSize <- mydata$V3
hist(uniformityOfCellSize)

uniformityOfCellShape <- mydata$V4
hist(uniformityOfCellShape)

marginalAdhesion <- mydata$V5
hist(marginalAdhesion)

SingleEpithelialCellSize <- mydata$V6
hist(SingleEpithelialCellSize)

bareNuclei <- mydata$V7
hist(bareNuclei)

blandChromatin <- mydata$V8
hist(blandChromatin)

normalNucleoli <- mydata$V9
hist(normalNucleoli)

mitoses <- mydata$V10
hist(mitoses)

dataClass <- mydata$V11
hist(dataClass)

benign <- nrow(mydata[mydata$V11 == 2,])

malignant <- nrow(mydata[mydata$V11 == 4,])