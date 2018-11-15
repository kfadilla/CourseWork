dist.euclidean.R <- function(x,y){
  return(sqrt((x[1] - y[1])^2 + (x[2] - y[2])^2))
}

sample.variance.R <- function(x){
  return(sum((x-mean(x))^2/(length(x)-1)))
}

sample.mean.R <- function(x){
  return(sum(x)/length(x))
}
