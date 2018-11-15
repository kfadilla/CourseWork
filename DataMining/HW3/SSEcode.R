# below install packages and datasets.
install.packages("data.table")
library(data.table)
install.packages("curl")

mydata <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/ionosphere/ionosphere.data", sep = ",")
workingdata <- subset(mydata, select = -c(35))

k = c()

for (i in 2:15) {
  k[i-1] = kmeans(workingdata, i, iter.max = 40, nstart = i, 
                  algorithm = "Lloyd")$ tot.withinss
}
k
barplot(k)