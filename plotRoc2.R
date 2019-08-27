#plotting ROC of a dataset with different algorithms on the same plot
plotRoc2 <- function(fit, test, i, fileName, j, numAlg, algor){
  
  results <- predict(fit, test, type = 'prob')[,2]
  results<-as.numeric(results)                #factor -> numeric
  test$label <- as.numeric(test$label)
  pred <- prediction(results, test$label)
  perf <- performance(pred,"tpr","fpr")
  
  col <- c('black','blue','red','green','purple','pink')
  if (j == 1){
    fName <- paste0(fileName, i,'.jpg')
    jpeg(file = fName)
    title <- paste0(fileName,i)
    plot(perf, col= col[j], main = title)
  }
  if(j != 1){
    par(new = TRUE)
    plot(perf, col = col[j])
  }
  if(j == numAlg){
      legend('bottomright', legend=algor[1:numAlg], lty=1, col = col[1:numAlg],bty='n', cex=.75)
      dev.off()
  }
}
