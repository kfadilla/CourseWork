mydata <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/ionosphere/ionosphere.data", sep = ",")
workingdata <- subset(mydata, select = -c(35))

EuDistance <- function(center, newPoint) {
  temp = 0;
  for (i in 1:length(newPoint)) {
    temp = temp + (center - newPoint[i])^2;
  }
  return(sqrt(temp))
}

findmin <- function(data){
  pt = min(data);
  ret = 0;
  for (i in 1:length(data)){
    if (pt == data[i]){
      ret = i;
    }
  }
  return(ret)
}
calavg <- function(data){
  n = 0;
  for (i in 1:length(data)){
    if (data[i] != 0){
      n = n + 1;
    }
  }
  if (n == 0){
    return(0)
  }
  return(sum(data)/n)
}
calDif <- function(a,b, k){
  1/k * sum(abs(a - b))
}

Ck <- function(data, eudist = EuDistance, k, r){
  center = matrix(nrow = k);
  for (i in 1:k) {
    center[i] = runif(n=1, min=1e-12, max=.9999999999);
  }
  centerp = matrix(,,35)
  lst = list(center, centerp);
  dif <- r - 1;
  i <- 0;
  while (dif < r){
  centerp = matrix(0,nrow = k, ncol = ncol(data));
  i <- i + 1
  for (n in 1:k){
    mindist = Inf;
    minIndex = 0;
    for (j in 1:ncol(data)){
      curdist = eudist(center[n], data[,j]);
      if (curdist < mindist){
        mindist = curdist;
        minIndex = j;
      }
    }
  }
  for (a in 1:k){
    for (b in 1:ncol(data)){
      cp = findmin(distm[,b]); #find closest center index
      centerp[cp,b] = centerp[cp,b] + min(distm[,b]);
    }
  }
  print(distm)
  newcenter = center;
  for (x in 1:k){
    center[x] = calavg(centerp[x,]);
  }
  singleVar = 0;
  diffVec = 0;
  for (o in 1:k) {
    diffVec = center[o,] - newcenter[o,];
    singleVar = singleVar + sqrt(dot(diffVec, diffVec));
  }
  dif = singleVar / k;
  }
  return(center)
}


countbad <- function(kdata, dataset){
  count = 0;
  for (i in 1:length(kdata)){
    if (kdata[i] != 0){
      if (dataset[i,35] == 'b'){
        count = count + 1;
      }
    }
  }
  return(count)
}
errorRate <- function(kdata, dataset){
  b = countbad(kdata, dataset);
  g = countgood(kdata, dataset);
  rate = b;
  return(rate)
}
totalerrorRate <- function(kdata, dataset){
  rate = 0;
  for (i in 1:ncol(kdata)){
    rate = rate + countbad(kdata[,i], dataset);
  }
  total = rate/nrow(dataset)
  return(total)
}
test1 = Ck(workingdata,EuDistance,2,20)
test1
test2 = Ck(workingdata,EuDistance,3,10)
test3 = Ck(workingdata,EuDistance,4,10)
test4 = Ck(workingdata,EuDistance,5,10)
g1 = totalerrorRate(test1, mydata)
g1
g2 = totalerrorRate(test2, mydata)
g2
g3 = totalerrorRate(test3, mydata)
g4 = totalerrorRate(test4, mydata)
g4
boxplot(c(g1,g2,g3,g4))

