#cluster majority in training set
majorCluster <- function(train,n, col){      #clusters major and combines back into training set
  set.seed(seed)
  cluster <-kmeans(train[,1:(col-1)], n)
  majorout <- data.frame(cluster$centers)
  majorout <- cbind(majorout, label = 'negative')
  #trainbind <- rbind(majorout, trainminor)
  return(majorout)
} 