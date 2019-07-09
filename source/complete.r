complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating the location
  ## of the CSV files
  
  ## 'id' is an integer vector indicating the moniotr ID numbers to be used
  
  ## Reurn a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the moniotr ID number and 'nobs' is the number of
  ## complete cases
  
  root <- "C:/Users/Gabriele/Documents/Git/JHSPH-Data-Science/data/"
  
  for (i in id) {
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
    if (i == id[1]){
      data <- read.csv(input_file,header = TRUE)
    }
    else {
      tmp_data <- read.csv(input_file,header = TRUE)
      data <- rbind(data,tmp_data)
    }
  }
  data_save <<- data
  for (i in id) {
    subset <- data[which(data$ID == i),]
    data_frame <- subset[complete.cases(subset),]
    if (i == id[1]) {
      output <- data.frame("ID"=i,"nobs"=nrow(data_frame))
    }
    else {
      output <- rbind(output,data.frame("ID"=i,"nobs"=nrow(data_frame)))
    }
  }
  return(output)
}
  
  
  
  
  