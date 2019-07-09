rankall <- function(outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # check that outcome is valid
  valid_outcome <- c("heart attack", "heart failure", "pneumonia")
  if (outcome %in% valid_outcome == FALSE) {
    message("invalid outcome")
    stop()
  }
  
  if (outcome == "heart attack") {col_2_take = 11}
  else if (outcome == "heart failure") {col_2_take = 17}
  else if (outcome == "pneumonia") {col_2_take = 23}
  
  # create empty structure
  data_final <- data.frame(Hospital.Name = as.character(),State = as.character())
  
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  unique_states <- sort(unique(data$State))
  for (i in unique_states) {
    data[,col_2_take] <- as.numeric(data[,col_2_take])
    data_extract <- data[which(data$State == i & !is.na(data[,col_2_take])),]
    data_sorted <- data_extract[order(data_extract[,col_2_take], data_extract[,2]),]
    data_sorted$rank <- 1:nrow(data_sorted)
    data_rank <- data_sorted
    
    if (num == "best") {
      data_out <- subset(data_rank[1,], select = c('Hospital.Name','State'))
    }
    else if (num == "worst") {
      data_out <- subset(data_rank[nrow(data_rank),], select = c('Hospital.Name','State'))
    }
    else {
      if (num > nrow(data_rank)) {
        data_out <- data.frame('NA',i)
        names(data_out) <- c('Hospital.Name','State')
        }
      else {
        data_out <- subset(data_rank[which(data_rank$rank == num),],select = c('Hospital.Name','State'))
        }
    }
    
    data_final <- rbind(data_final,data_out)
  } # end for loop 
  data_final
  data_final <<- data_final
}