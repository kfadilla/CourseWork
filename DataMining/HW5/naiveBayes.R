install.packages("e1071")
library(e1071)
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
#Import car data
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
#import credit Data
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


#car label prediction and calculate error rate
car1nb = naiveBayes(car1tr$V7~ ., data = car1tr)
ca1 = errorate(car1te,predict(car1nb,car1te))
car2nb = naiveBayes(car2tr$V7~ ., data = car2tr)
ca2 =errorate(car2te,predict(car2nb,car2te))
car3nb = naiveBayes(car3tr$V7~ ., data = car3tr)
ca3 = errorate(car3te,predict(car3nb,car3te))
car4nb = naiveBayes(car4tr$V7~ ., data = car4tr)
ca4 = errorate(car4te,predict(car4nb,car4te))
car5nb = naiveBayes(car5tr$V7~ ., data = car5tr)
ca5 = errorate(car5te,predict(car5nb,car5te))
#car error rate plot
plot(c(ca1,ca2,ca3,ca4,ca5),xlab = "test data",ylab = "error rate")

#credit label prediction, calculate error rate
cre1nb = naiveBayes(cre1tr$V16~ ., data = cre1tr)
cr1 = errorate(cre1te,predict(cre1nb,cre1te))
cre2nb = naiveBayes(cre2tr$V16~ ., data = cre2tr)
cr2 = errorate(cre2te,predict(cre2nb,cre2te))
cre3nb = naiveBayes(cre3tr$V16~ ., data = cre3tr)
cr3 = errorate(cre3te,predict(cre3nb,cre3te))
cre4nb = naiveBayes(cre4tr$V16~ ., data = cre4tr)
cr4 = errorate(cre4te,predict(cre4nb,cre4te))
cre5nb = naiveBayes(cre5tr$V16~ ., data = cre5tr)
cr5 = errorate(cre5te,predict(cre5nb,cre5te))

#credit data error rate plot
plot(c(cr1,cr2,cr3,cr4,cr5),xlab = "test data", ylab = "error rate")