selectNRun <- function(select, trainminor, algor, test,i){
  nMajLeft1 <- nrow(select)
  majorselect1 <- select[,1:ncol(trainminor)]
  train1 <- rbind(majorselect1, trainminor)

  #train w/o undersampling
  set.seed(seed)
  fit1 <- trainmodel(train1, algor)
  
  #fit <- trainmodel(train, algor[j])
  result1 <- perfResults2(fit1, test,i)
  
  perf <- rbind(Data = i, Alg = algor,nMajLeft1,result1)
  return(perf)
}