CrossValidation.R:
	mykfold: implementation of kfold

KnnValidation.R:
	eudist: euclidean distance implementation
	mdist: mannhattan distance implementation
	procar: car data preprocessing
	procre: credit data preprocessing
	knn_predict: KNN implementation
	errorrate: output error rate between prediction and actual label
	my_knn: activate function of knn_predict, and calculate error rate
The following template output the error rate of built-in knn function.
for (i in 1:5){
  cat("k =", loop[i], "error=",errorate( ... ,knn( ... , ... , ... , k = loop[i])), "\n")
}
naiveBayes.R:
	errorrate: output error rate between prediction and actual label

car"1-5"tr.txt : car training set after kfold validation
car"1-5"te.txt : car test set after kfold validation
cre"1-5"tr.txt : credit training set after kfold validation
cre"1-5"te.txt : credit test set after kfold validation