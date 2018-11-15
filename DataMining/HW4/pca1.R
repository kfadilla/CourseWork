install.packages("FactoMineR")
library(FactoMineR)
adata <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/ionosphere/ionosphere.data", sep = ",")
inputdata <- subset(adata, select = -c(35))
randomRows = function(df,n){
  return(df[sample(nrow(df),n),])
}

#question1a
pca1 = PCA(inputdata, graph = FALSE)
pca2 = prcomp(inputdata)
plot(pca2$rotation)
plot(pca2$rotation[order(pca2$rotation[,1]),1],pca2$rotation[order(pca2$rotation[,2]),2], xlab = "PC1", ylab = "PC2")

#question1b
pca2$rotation[order(pca2$rotation[,1]),1][pca2$rotation[order(pca2$rotation[,1]),1] >= -0.2 & pca2$rotation[order(pca2$rotation[,1]),1] <= 0]
pca1$eig[,3][pca1$eig[,3] <= 80]#keep variance at least 75
pca2$sdev[pca2$sdev^2 >= 1] #variance >= 1

#question1c
pca2$rotation #loadings
#question1d
len = length(pca1$eig[,3][pca1$eig[,3] <= 90]) + 1
k1 = kmeans(pca1$eig[c(1:len),], 2, iter.max = 20, algorithm = "Lloyd", trace=FALSE)$tot.withinss
k2 = kmeans(pca1$eig[c(1:len),], 3, iter.max = 20, algorithm = "Lloyd", trace=FALSE)$tot.withinss
k3 = kmeans(pca1$eig[c(1:len),], 4, iter.max = 20, algorithm = "Lloyd", trace=FALSE)$tot.withinss
k4 = kmeans(pca1$eig[c(1:len),], 5, iter.max = 20, algorithm = "Lloyd", trace=FALSE)$tot.withinss
boxplot(k1,k2,k3,k4)

