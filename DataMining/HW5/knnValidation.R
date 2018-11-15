library(class)
# Q 2.1
#carData
car1tr = read.table("car1tr.txt",sep = ',')
car1te = read.table("car1te.txt",sep = ',')
car2tr = read.table("car2tr.txt",sep = ',')
car2te = read.table("car2te.txt",sep = ',')
car3tr = read.table("car3tr.txt",sep = ',')
car3te = read.table("car3te.txt",sep = ',')
car4tr = read.table("car4tr.txt",sep = ',')
car4te = read.table("car4te.txt",sep = ',')
car5tr = read.table("car5tr.txt",sep = ',')
car5te = read.table("car5te.txt",sep = ',')
#credit Data
cre1tr = read.table("cre1tr.txt",sep = ',')
cre1te = read.table("cre1te.txt",sep = ',')
cre2tr = read.table("cre2tr.txt",sep = ',')
cre2te = read.table("cre2te.txt",sep = ',')
cre3tr = read.table("cre3tr.txt",sep = ',')
cre3te = read.table("cre3te.txt",sep = ',')
cre4tr = read.table("cre4tr.txt",sep = ',')
cre4te = read.table("cre4te.txt",sep = ',')
cre5tr = read.table("cre5tr.txt",sep = ',')
cre5te = read.table("cre5te.txt",sep = ',')
#distance function
euDist <- function(a, b){
  ret = 0
  for(i in c(1:(length(a)-1)))
  {
    ret = ret + (as.numeric(a[i])-as.numeric(b[i]))^2
  }
  ret = sqrt(ret)
  return(ret)
}

mDist <- function(a, b){
  ret = 0
  for(i in c(1:(length(a)-1) ))
  {
    ret = ret + abs(as.numeric(a[i])-as.numeric(b[i]))
  }
  ret <- sum(ret)
  return(ret)
}

# Q 2.2
# data preprocessing
# car data preprocessing function
procar <- function(carData){
  carData <- as.matrix(carData)
  for (i in 1:nrow(carData)) {
    for (j in 1:2) {
      if(carData[i,j] == "vhigh")
        carData[i,j] <- 4
      if(carData[i,j] == "high")
        carData[i,j] <- 3
      if(carData[i,j] == "med")
        carData[i,j] <-2
      if(carData[i,j] == "low")
        carData[i,j] <-1
    }
    for (j in 3:4) {
      if(carData[i,j] == "5more")
        carData[i,j] <- 6
      if(carData[i,j] == "more")
        carData[i,j] <-5
      if(carData[i,j] == "4")
        carData[i,j] <-4
      if(carData[i,j] == "3")
        carData[i,j] <-3
      if(carData[i,j] == "2")
        carData[i,j] <-2
    }
    if(carData[i,5] == "big")
      carData[i,5] <- 3
    if(carData[i,5] == "med")
      carData[i,5] <- 2
    if(carData[i,5] == "small")
      carData[i,5] <-1
    if(carData[i,6] == "high")
      carData[i,6] <- 3
    if(carData[i,6] == "med")
      carData[i,6]<-2
    if(carData[i,6]=="low")
      carData[i,6] <-1
  }
  return(carData)
}
# credit data preprocessing function
procre <- function(creditData){
  creditData <- as.matrix(creditData)
  for (i in 1:nrow(creditData)){
    if(creditData[i,1] == "?")
      creditData[i,1] <-0
    if(creditData[i,1] == "a" )
      creditData[i,1] <- 2
    if(creditData[i,1] == "b")
      creditData[i,1] <- 1
    if(creditData[i,2] == "?") 
      creditData[i,2] <- 0
    else
      creditData[i,2] <- as.numeric(creditData[i,2])
    if(creditData[i,4] == "?")
      creditData[i,4] <- 0
    if(creditData[i,4] == "l")
      creditData[i,4] <- 1
    if(creditData[i,4] == "u")
      creditData[i,4] <- 2
    if(creditData[i,4] == "y")
      creditData[i,4] <- 3
    if(creditData[i,5] == "?")
      creditData[i,5] <-0
    if(creditData[i,5] == "gg")
      creditData[i,5] <-1
    if(creditData[i,5] == "g")
      creditData[i,5] <-2
    if(creditData[i,5] == "p")
      creditData[i,5] <- 3
    if(creditData[i,6] == "?")
      creditData[i,6] <- 0
    if(creditData[i,6] == "ff")
      creditData[i,6] <-1
    if(creditData[i,6] == "c")
      creditData[i,6] <-2
    if(creditData[i,6] == "cc")
      creditData[i,6] <- 3
    if(creditData[i,6] == "d")
      creditData[i,6]<-4
    if(creditData[i,6] == "i")
      creditData[i,6]<-5
    if(creditData[i,6] == "j")
      creditData[i,6]<-6
    if(creditData[i,6] == "k")
      creditData[i,6]<-7
    if(creditData[i,6] == "m")
      creditData[i,6]<-8
    if(creditData[i,6] == "r")
      creditData[i,6]<-9
    if(creditData[i,6] == "q")
      creditData[i,6]<-10
    if(creditData[i,6] == "w")
      creditData[i,6]<-11
    if(creditData[i,6] == "x")
      creditData[i,6]<-12
    if(creditData[i,6] == "e")
      creditData[i,6]<-13
    if(creditData[i,6] == "aa")
      creditData[i,6]<-14
    if(creditData[i,7] == "?")
      creditData[i,7]<-0
    if(creditData[i,7] == "ff")
      creditData[i,7]<-1
    if(creditData[i,7] == "v")
      creditData[i,7]<-2
    if(creditData[i,7] == "h")
      creditData[i,7]<-3
    if(creditData[i,7] == "bb")
      creditData[i,7]<-4
    if(creditData[i,7] == "n")
      creditData[i,7]<-5
    if(creditData[i,7] == "j")
      creditData[i,7]<-6
    if(creditData[i,7] == "z")
      creditData[i,7]<-7
    if(creditData[i,7] == "dd")
      creditData[i,7]<-8
    if(creditData[i,7] == "o")
      creditData[i,7]<-9
    for (j in 9:12) {
      if(creditData[i,j] == "f")
        creditData[i,j]<-0
      if(creditData[i,j] == "t")
        creditData[i,j]<-1
    }
    if(creditData[i,13] == "g")
      creditData[i,13]<-1
    if(creditData[i,13] == "d")
      creditData[i,13]<-2
    if(creditData[i,13] == "p")
      creditData[i,13]<-3
    if(creditData[i,13] == "s")
      creditData[i,13]<-4
    if(creditData[i,14] == "?")
      creditData[i,14] <- 0 
    else
      creditData[i,14] <- as.numeric(creditData[i,14])
  }
  return(creditData)
}
car1te <- procar(car1te)
car2te <- procar(car2te)
car3te <- procar(car3te)
car4te <- procar(car4te)
car5te <- procar(car5te)
car1tr <- procar(car1tr)
car2tr <- procar(car2tr)
car3tr <- procar(car3tr)
car4tr <- procar(car4tr)
car5tr <- procar(car5tr)
#processed credit data
cre1te <- procre(cre1te)
cre2te <- procre(cre2te)
cre3te <- procre(cre3te)
cre4te <- procre(cre4te)
cre5te <- procre(cre5te)
cre1tr <- procre(cre1tr)
cre2tr <- procre(cre2tr)
cre3tr <- procre(cre3tr)
cre4tr <- procre(cre4tr)
cre5tr <- procre(cre5tr)
# knn function
knn_predict <- function(test, train, k,type,dist){
  pred <- c()
  nc <- ncol(train)
  for(i in c(1:nrow(test))){   
    mydist =c()         
    eu_char = c()
    good = 0
    acc = 0
    unacc = 0
    vgood = 0
    add = 0 
    sub = 0
    for(j in c(1:nrow(train))){
      mydist <- c(mydist, dist(test[i,], train[j,]))
      eu_char <- c(eu_char, as.character(train[j,][[nc]]))
    }
    eu <- data.frame(eu_char, mydist)
    eu <- eu[order(eu$mydist),]     
    eu <- eu[1:k,]
    if(type == "car"){
      for(k in c(1:nrow(eu))){
        if(as.character(eu[k,"eu_char"]) == "good")
          good = good + 1
        if(as.character(eu[k,"eu_char"]) == "acc") 
          acc = acc + 1
        if(as.character(eu[k,"eu_char"]) == "unacc")
          unacc = unacc + 1
        if(as.character(eu[k,"eu_char"]) == "vgood")
          vgood = vgood + 1
        }
      }
    else{
      for (k in c(1:nrow(eu))) {
        if(as.character(eu[k,"eu_char"]) == "+")
          add = add +1
        if(as.character(eu[k,"eu_char"]) == "-")
          sub = sub +1
      }}
    if (type == "car"){
      if(good == max(good,vgood,acc,unacc) ){         
        pred <- c(pred, "good")
      }
      else if(vgood == max(good,vgood,acc,unacc) ){        
        pred <- c(pred, "vgood")
      }
      else if(acc == max(good,vgood,acc,unacc) ){         
        pred <- c(pred, "acc")
      }
      else if(unacc == max(good,vgood,acc,unacc) ){          
        pred <- c(pred, "unacc")
      }}
    else{
      if(add == max(add,sub) ){         
        pred <- c(pred, "+")
      }
      else if(sub == max(add,sub) ){         
        pred <- c(pred, "-")
      }
    }
    }
  
  return(pred) #return pred vector
}
# error rate function
errorate <- function(test,predi){
  count = 0
  nc <- ncol(test)
  for(i in c(1:nrow(test))){
    if(test[i,nc] == predi[i]){ 
      count = count + 1
    }
  }
  error = 1 - (count/nrow(test)) 
  return(error)
}


myknn <- function(test,train,ty,dist){
  k <- c(2,20,50,100,150)
  for (i in 1:5) {
    predictions <- knn_predict(test, train, k[i],ty,dist)
    cat("k = ",k[i])
    print(errorate(test,predictions))
  }
}
myknn(car1te,car1tr,"car",euDist)
myknn(car1te,car1tr,"car",mDist)
myknn(car2te,car2tr,"car",euDist)
myknn(car2te,car2tr,"car",mDist)
myknn(car3te,car3tr,"car",euDist)
myknn(car3te,car3tr,"car",mDist)
myknn(car4te,car4tr,"car",euDist)
myknn(car4te,car4tr,"car",mDist)
myknn(car5te,car5tr,"car",euDist)
myknn(car5te,car5tr,"car",mDist)
myknn(cre1te,cre1tr,"credit",euDist)
myknn(cre1te,cre1tr,"credit",mDist)
myknn(cre2te,cre2tr,"credit",euDist)
myknn(cre2te,cre2tr,"credit",mDist)
myknn(cre3te,cre3tr,"credit",euDist)
myknn(cre3te,cre3tr,"credit",mDist)
myknn(cre4te,cre4tr,"credit",euDist)
myknn(cre4te,cre4tr,"credit",mDist)
myknn(cre5te,cre5tr,"credit",euDist)
myknn(cre5te,cre5tr,"credit",mDist)
#2.3 cardata 
loop <- c(2,20,50,100,150)
for (i in 1:5){
  cat("k =", loop[i], "error=",errorate(car1te,knn(car1tr[,1:6],car1te[,1:6],car1tr[,7], k = loop[i])), "\n")
}
print("end")
for (i in 1:5){
  cat("k =", loop[i], "error=",errorate(car2te,knn(car2tr[,1:6],car2te[,1:6],car2tr[,7], k = loop[i])), "\n")
}
print("end")
for (i in 1:5){
  cat("k =", loop[i], "error=",errorate(car3te,knn(car3tr[,1:6],car3te[,1:6],car3tr[,7], k = loop[i])), "\n")
}
print("end")
for (i in 1:5){
  cat("k =", loop[i], "error=",errorate(car4te,knn(car4tr[,1:6],car4te[,1:6],car4tr[,7], k = loop[i])), "\n")
}
print("end")
for (i in 1:5){
  cat("k =", loop[i], "error=",errorate(car5te,knn(car5tr[,1:6],car5te[,1:6],car5tr[,7], k = loop[i])), "\n")
}
print("end")

#2.3 credit data
for (i in 1:5){
  cat("k =", loop[i], "error=",errorate(cre1te,knn(cre1tr[,1:15],cre1te[,1:15],cre1tr[,16], k = loop[i])), "\n")
}

for (i in 1:5){
  cat("k =", loop[i], "error=",errorate(cre2te,knn(cre2tr[,1:15],cre2te[,1:15],cre2tr[,16], k = loop[i])), "\n")
}
for (i in 1:5){
  cat("k =", loop[i], "error=",errorate(cre3te,knn(cre3tr[,1:15],cre3te[,1:15],cre3tr[,16], k = loop[i])), "\n")
}

for (i in 1:5){
  cat("k =", loop[i], "error=",errorate(cre4te,knn(cre4tr[,1:15],cre4te[,1:15],cre4tr[,16], k = loop[i])), "\n")
}

for (i in 1:5){
  cat("k =", loop[i], "error=",errorate(cre5te,knn(cre5tr[,1:15],cre5te[,1:15],cre5tr[,16], k = loop[i])), "\n")
}
print("end")
