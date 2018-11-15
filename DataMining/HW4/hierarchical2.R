install.packages("FactoMineR")
library(FactoMineR)
adata <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/ionosphere/ionosphere.data", sep = ",")
inputdata <- subset(adata, select = -c(35))
countbad <- function(kdata, dataset){
  b1 = 0;
  b2 = 0;
  for (i in 1:length(kdata)){
    temp = which(I50[i,4] == dataset, arr.ind = TRUE);
    if (dataset[temp[1],35] == 'b'){
      if (kdata[i] == 1){
        b1 = b1 + 1;
      }
      if (kdata[i] == 2){
        b2 = b2 + 1;
      }
    }
  }
  return(c(b1,b2))
}
error <- function(num,dataset){
  return(num/length(dataset[,1]))
}

countgood <- function(kdata, dataset){
  g1 = 0;
  g2 = 0;
  for (i in 1:length(kdata)){
    temp = which(I50[i,4] == dataset, arr.ind = TRUE);
    if (dataset[temp[1],35] == 'g'){
      if (kdata[i] == 1){
        g1 = g1 + 1;
      }
      if (kdata[i] == 2){
        g2 = g2 + 1;
      }
    }
  }
  return(c(g1,g2))
}
errorRate <- function(kdata, dataset){
  rate = 0
  b = countbad(kdata, dataset);
  g = countgood(kdata, dataset);
  for (i in 1:length(table(kdata))){
    rate = rate + (b[i]/(g[i]+b[i]));
  }
  return(rate)
}

#question2a
randomRows = function(df,n){
  return(df[sample(nrow(df),n),])
}
I50 = randomRows(inputdata, 50)
test = hclust(dist(I50))
plot(test)
#question2b
cut1 = cutree(test, 2)
rate = errorRate(cut1,adata)
#question2c
pca3 = PCA(I50, graph = FALSE)
reduced = pca3$eig[,3][pca3$eig[,3] <= 90]
test3 = hclust(dist(reduced))
plot(test3)
#question2d
cut2 = cutree(test3, 2)
rate2 = errorRate(cut2,adata)
