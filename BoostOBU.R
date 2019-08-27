source("setup_edit.R")    #setwd, load all files into dfAll

#setup()
source("loadfile_edit.R")      
source("datPartition.R")
#source("trainmodel2_noCV.R")
source("trainmodel2.R")
source("majorCluster2.R")
source("plotRoc2.R")
source("calAuc.R")
source("perfResults2.R")
#source('export.R') 
source("selectNRun.R")
#source('barPlot2.R')
source('writeAppend.R')
source('multiPlot.R')

source('makeData_imb2_10042019.R')
#source('famCurve_imb_facet.R')
library(ggplot2)
 
seed <- 1987

#vary imb ratio
endJ <- 9
imbalance <- c(1.5,3,12,30,60,120,200,400) 
algor <- c('rf','svmRadial') #'mlp', , 'svmLinear'
#algor <- c('J48', 'rf', 'mlp', 'svmRadial', 'svmLinear')
j<-2
#threshold <- 45

for (l in 1:endJ){
  #imb <- 0.1*j
  imb <- imbalance[l]
  #run over 0-100% overlap (101 runs)
  endI <- 11 #11
  for (i in 1:endI){
    ovPercent <- (i-1)*10
    df <- makeData(ovPercent, imb, endI)
    k <- length(df)
    
    df[,-k] <- scale(as.numeric(unlist(df[,-k])))
     
    #partition - testing/training
    set.seed(seed)
    dPart <- datPartition(df, 0.8)
    train <- dPart[[1]]
    test <- dPart[[2]]
    
    library(bimba)
    set.seed(seed)
    #train <-  bimba::SMOTE(train, perc_min = 70, k = 3)
    train <-  bimba::BDLSMOTE(train, perc_min = 50, k = 5, borderline = 1)
    
    trainminor <- train[train$label == 'positive',]
    
    set.seed(1987)
    cm <-cmeans(train[,-ncol(train)],2,100,verbose= TRUE,method="cmeans")
    traincm <- cbind(train, pred = cm$cluster, percent = cm$membership)
    trainmajor <- traincm[traincm$label == 'negative',]
    
    mean1 <- mean(trainmajor$percent.1)
    mean2 <- mean(trainmajor$percent.2)
    threshold <- min(mean1,mean2)
    
    cond1 <- abs(trainmajor$pred - 1) # 1=wrong, 0=correct
    #cond2 <- trainmajor$percent.1 > threshold #prob belong to class1(negative)
    #cond3 <- trainmajor$percent.2 > threshold #prob belong to class1(negative)
    cond2 <- trainmajor$percent.1 > mean1 #prob belong to class1(negative)
    cond3 <- trainmajor$percent.2 > mean2 #prob belong to class1(negative)
    
    select1 <- trainmajor[(cond1 == 0) | (cond1 == 1 & cond2),]
    #for wrong cluster number
    select2 <- trainmajor[(cond1 == 1) | (cond1 == 0 & cond3),]
    
    #i<-0
    result1 <- selectNRun(select1, trainminor, algor[j], test,i)
    result2 <- selectNRun(select2, trainminor, algor[j], test,i)
    
    #Compare sens+BA
    sens1 <- as.numeric(result1[4,])
    sens2 <- as.numeric(result2[4,])
    ba1 <- as.numeric(result1[7,])
    ba2 <- as.numeric(result2[7,])
    if(sens1 != sens2){ifelse(sens1 > sens2, best <- result1, best <- result2)}
    if(sens1 == sens2){ifelse(ba1 > ba2, best <- result1, best <- result2)}
    
    best <- rbind(best, threshold)
    
    filenum <- 090820192  
    writeAppend(best, filenum)
    #technique <- ('clusteringUS')
    #export(algor[j],cfAll,cfAll2, technique)
    cat(paste0(i,' finished','\n'))
  }
  cat(paste0(l,' finished','\n'))
}
