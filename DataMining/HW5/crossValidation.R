creditData <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/credit-screening/crx.data", sep = ',')
carData <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/car/car.data", sep = ',')
#implementation
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

creditData = as.matrix(creditData)
carData = as.matrix(carData)
cre1 = mykfold(creditData,5)
cre2 = mykfold(creditData,5)
cre3 = mykfold(creditData,5)
cre4 = mykfold(creditData,5)
cre5 = mykfold(creditData,5)

car1 = mykfold(carData,5)
car2 = mykfold(carData,5)
car3 = mykfold(carData,5)
car4 = mykfold(carData,5)
car5 = mykfold(carData,5)
#output data
write.table(cre1[[1]], file = "cre1tr.txt",sep = ',', row.names = FALSE, col.names = FALSE)
write.table(cre2[[1]], file = "cre2tr.txt", sep = ',', row.names = FALSE, col.names = FALSE)
write.table(cre3[[1]], file = "cre3tr.txt", sep = ',', row.names = FALSE, col.names = FALSE)
write.table(cre4[[1]], file = "cre4tr.txt", sep = ',', row.names = FALSE, col.names = FALSE)
write.table(cre5[[1]], file = "cre5tr.txt", sep = ',', row.names = FALSE, col.names = FALSE)
write.table(cre1[[2]], file = "cre1te.txt",sep = ',', row.names = FALSE, col.names = FALSE)
write.table(cre2[[2]], file = "cre2te.txt", sep = ',', row.names = FALSE, col.names = FALSE)
write.table(cre3[[2]], file = "cre3te.txt", sep = ',', row.names = FALSE, col.names = FALSE)
write.table(cre4[[2]], file = "cre4te.txt", sep = ',', row.names = FALSE, col.names = FALSE)
write.table(cre5[[2]], file = "cre5te.txt", sep = ',', row.names = FALSE, col.names = FALSE)

write.table(car1[[1]], file = "car1tr.txt",sep = ',', row.names = FALSE, col.names = FALSE)
write.table(car1[[2]], file = "car1te.txt",sep = ',', row.names = FALSE, col.names = FALSE)
write.table(car2[[1]], file = "car2tr.txt",sep = ',', row.names = FALSE, col.names = FALSE)
write.table(car2[[2]], file = "car2te.txt",sep = ',', row.names = FALSE, col.names = FALSE)
write.table(car3[[1]], file = "car3tr.txt",sep = ',', row.names = FALSE, col.names = FALSE)
write.table(car3[[2]], file = "car3te.txt",sep = ',', row.names = FALSE, col.names = FALSE)
write.table(car4[[1]], file = "car4tr.txt",sep = ',', row.names = FALSE, col.names = FALSE)
write.table(car4[[2]], file = "car4te.txt",sep = ',', row.names = FALSE, col.names = FALSE)
write.table(car5[[1]], file = "car5tr.txt",sep = ',', row.names = FALSE, col.names = FALSE)
write.table(car5[[2]], file = "car5te.txt",sep = ',', row.names = FALSE, col.names = FALSE)
