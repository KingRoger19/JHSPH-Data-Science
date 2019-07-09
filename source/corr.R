corr <- function(directory,threshold=0){
  ## 'directory' is a character vector of length 1 indicating the
  ## location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the 
  ## number of completely observed observations (on all variables)
  ## required to compute the correlation between nitrate and sulfate:
  ## the default is 0
  
  ## Rturn a numeric vectr if correlations
  ## NOTE: Do not round the results!
  
  root <- "C:/Users/Gabriele/Documents/Git/JHSPH-Data-Science/data/"
  
  # estraggo numero file presenti
  files<- list.files(path=paste(root, directory, sep = ""))
  num_files = length(files)
  
  for (i in 1:num_files) {
    if (i <= 9) {
      input_file <- paste(root, directory, "/00", i, ".csv", sep = "")
    }
    else if (10 <= i & i <= 99){
      input_file <- paste(root, directory, "/0", i, ".csv", sep = "")
    }
    else {
      input_file <- paste(root, directory, "/", i, ".csv", sep = "")
    }
    
    # alla prima iterazione non ho la struttura di data. 
    # Non mi funziona la funzione get0
    if (i == 1){
      data <- read.csv(input_file,header = TRUE)
    }
    else {
      tmp_data <- read.csv(input_file,header = TRUE)
      data <- rbind(data,tmp_data)
    }
  }

  value <- complete("specdata")
  list_of_ids <- value[which(value$nobs >= threshold),]$ID
  
  data_filtered <- subset(data, ID %in% list_of_ids)
  data_filtered_clean <- data_filtered[complete.cases(data_filtered),]
  cor <- vector()
  
  for (i in list_of_ids) {
    data_filtered_clean_u <- data_filtered_clean[which(data_filtered_clean$ID == i),]
    name <- paste("cor_",i,sep = "")
    cor <- c(cor,assign(name, cor(data_filtered_clean_u$sulfate, data_filtered_clean_u$nitrate)))
  }
  return(cor)
}