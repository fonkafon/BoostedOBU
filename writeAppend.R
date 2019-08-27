#add results to the existing file 

writeAppend <- function(results,i){
  results <- t(results)
  fname <- paste0('resultsAppend',i,'.csv')
  if(file.exists(fname)){write.table(results, fname, row.names = FALSE, 
                                     col.names = FALSE, append = TRUE, sep =',')}
  if(!file.exists(fname)){write.csv(results, fname, row.names = FALSE)}
  }  
   
