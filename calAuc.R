#calculate AUC
calAuc <- function(results, test,i){
  results<-as.numeric(results)                #factor -> numeric
  test$label <- as.numeric(test$label)
  pred <- ROCR::prediction(results, test$label)
  auc <- ROCR::performance(pred, measure = "auc")
  #cat("AUC of dat= ", unlist(auc@y.values),"\n")
  return(auc)
}