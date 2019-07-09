pollutantmean <- function(directory,pollutant,id = 1:332){
  ## 'direcotry' is a character vector of length 1 indicating the
  ## location of the CSV file
  
  ## 'pollutant' is a character vector of length 1 indicating the name
  ## of pollutant for which we will calculate the mean; either 
  ## 'sulfate' or 'nitrate'
  
  ## 'id' is an integer vector indicating the monito ID numbers to
  ## be used.
  
  ## Return the mean of the pollutant across all monitors list in
  ## the 'id' vector (ignoring NA values)
  
  ## NOTE: Do not round the result!
  
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
    
    print("*****************************************")
    message("Sto processando il file: ", input_file)
    print("*****************************************")
    
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
  
  # calcolo la media
  mean_o <- mean(data[,pollutant], na.rm = TRUE)
  message("La media di ", pollutant, " è: ", mean_o)

}