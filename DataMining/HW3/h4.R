install.packages("FactoMineR")
install.packages("pracma")
library(FactoMineR)
library(pracma)
adata <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/ionosphere/ionosphere.data", sep = ",")
inputdata <- subset(adata, select = -c(35))
# below reset matrix max bound.
options(max.print=1000000)
# below install list append built-in function.


# below convert mydata dataframe to a matrix.
mydata = data.matrix(inputdata)

# below are some universal constants.
entries = nrow(inputdata)
dimensions = ncol(inputdata)

# below is the L2 distance formulae. (input are in list form.)
L2Distance <- function(centroidPoint, inputPoint) {
  tempDistance = 0;
  # dimensions = ncol(inputPoint)
  for (i in 1:dimensions) {
    tempDistance = tempDistance + (centroidPoint[i] - inputPoint[i])^2;
  }
  return(sqrt(tempDistance))
}

# below is the helper for generating a new vector of index for some specific
# centorid. arr is indexData, x is the number of centorid.
genArrCoord <- function(arr, g) {
  newArr = c();
  for (z in 1:length(arr)) {
    if (g == arr[z]) {
      newArr = append(newArr, z)
    }
  }
  return(newArr)
}

# replace helper
replaceVec <- function(arr, input) {
  if (length(input) == 0) {
    return(arr)
  }
  for (t in 1:length(input)) {
    arr[t] = input[t];
  }
  for (u in (length(input) + 1):length(arr)) {
    arr[u] = 0;
  }
  return (arr)
}

# below generate the helper for generating a matrix containing all index of
# entries for each centorid it belongs to.
genMatArr <- function(arr, numCen) {
  matArr = matrix(0, nrow = numCen, ncol = entries);
  for (r in 1: numCen) {
    matArr[r,] = replaceVec(matArr[r,], genArrCoord(arr, r));
  }
  return(matArr)
}

# below length of not zero helper.
notZero <- function(inArr) {
  output = 0;
  for (w in 1:length(inArr)) {
    if (inArr[w] != 0) {
      output = output + 1;
    }
  }
  return(output)
}

# below renew helper function.
renewHelper <- function(inputArr) {
  dimArr = matrix(0, nrow = 1, ncol = dimensions);
  for (e in 1:entries) {
    if (inputArr[e] != 0) {
      dimArr = dimArr + mydata[inputArr[e],];
    }
  }
  output = matrix(0, nrow = 1, ncol = dimensions);
  output = dimArr / notZero(dimArr);
  return(output)
}

# below renew each centorids with newer inputs.
renewArr <- function(matInput, k) {
  newcArr = matrix(0, nrow = k, ncol = dimensions);
  for (p in 1:k) {
    newcArr[p,] = renewHelper(matInput[p,]);
  }
  return(newcArr)
}

# below is the main k-means algorithm.
kMeans <- function(dataSet, distance = L2Distance, k, tau) {
  repeat {
    # below is the number of interations.
    i = 0;
    # below is the array of centriods.
    cArr = matrix(nrow = k, ncol = dimensions);
    # below generate two coord for centriods.
    for (j in 1:k) {
      for (h in 1:dimensions) {
        cArr[j,h] = runif(n=1, min=1e-12, max=.9999999999);
      }
    }
    # below iterate the i value.
    i = i + 1;
    
    # below going through the dataset "mydata" to generate distance.
    dArr = matrix(nrow = k, ncol = 1);
    indexData = matrix(nrow = entries, ncol = 1);
    
    # below generate a centorid field cB.
    for (m in 1:entries) {
      for (n in 1:k) {
        dArr[n,] = distance(cArr[n,], mydata[m,]);
      }
      flatdArr = unlist(dArr, recursive = TRUE);
      indexMin = which.min(flatdArr);
      indexData[m,] = indexMin;
      dArr = matrix(nrow = k, ncol = 1);
    }
    # below create number of coords in each centorids.
    cNArr = matrix(nrow = k, ncol = 1);
    for (hj in 1:entries) {
      cNArr[indexData[hj,],] = cNArr[indexData[hj,],] + 1;
    }
    # below update each centorids.
    resultArr1 = genMatArr(indexData, k);
    updatedcArr = matrix(nrow = k, ncol = dimensions);
    updatedcArr = renewArr(resultArr1, k);
    
    # below deriving scalar product.
    singleVar = 0;
    for (o in 1:k) {
      diffVec = cArr[o,] - updatedcArr[o,];
      singleVar = singleVar + sqrt(dot(diffVec, diffVec));
    }
    testingTau = singleVar / 2;
    if (testingTau <= tau) {
      break;
    }
    dArr = matrix(nrow = k, ncol = 1);
    cArr = updatedcArr;
  }
  
  return(updatedcArr)
}

# tests:
afk1 = kMeans(mydata, L2Distance, 3, 20)
afk1
pca1 = PCA(inputdata, graph = FALSE)
pca1
pca1$eig
pca2 = prcomp(inputdata)
plot(pca2$rotation[,1],pca2$rotation[,2])
cov(pca2$rotation[1], pca2$rotation[2])
