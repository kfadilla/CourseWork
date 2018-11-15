library(neuralnet)
library(class)

train = read.csv("train.csv")
test = read.csv("test.csv")
train = as.matrix(train)
test = as.matrix(test)
train = train[,-1]
test = test[,-1]

replaceMissing <- function(data){
  data[data == -1] <- mean(data)
  return(data)
}
for (i in 1:length(train[1,])){
  train[,i] = replaceMissing(train[,i]);
}
for (i in 1:length(test[1,])){
  test[,i] = replaceMissing(test[,i])
}
mykfold <- function(data,k){
  repv = rep_len(1:k, nrow(data))
  folds = sample(repv, nrow(data))
  for (i in 1:k){
    ind = which(folds == i)
    train = data[-ind,]
    test = data[ind,]
  }
  return(list(train,test))
}
#list of folds
mytrain1 = mykfold(train,5)
mytrain2 = mykfold(train,5)
mytrain3 = mykfold(train,5)
mytrain4 = mykfold(train,5)
mytrain5 = mykfold(train,5)

tr1 = mytrain1[[1]];
tr2 = mytrain2[[1]];
tr3 = mytrain3[[1]];
tr4 = mytrain4[[1]];
tr5 = mytrain5[[1]];
n = names(as.data.frame(tr1));
f <- as.formula(paste("target ~", paste(n[!n %in% "target"], collapse = " + ")))

nn1 = neuralnet(f,as.matrix(tr1), hidden = 1000,learningrate = 0.3)
nn2 = neuralnet(f,as.matrix(tr2), hidden = 1000,learningrate = 0.3)
nn3 = neuralnet(f,as.matrix(tr3), hidden = 1000,learningrate = 0.3)
nn4 = neuralnet(f,as.matrix(tr4), hidden = 1000,learningrate = 0.3)
nn5 = neuralnet(f,as.matrix(tr5), hidden = 1000,learningrate = 0.3)
testrecord = compute(nn,test)
write.csv(testrecord, file = "/u/kfadilla/365project/result.csv")