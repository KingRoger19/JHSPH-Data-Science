best <- function(state, outcome){
  # read outcome data 
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # check that state and outcome are valid
  # list of unique states
  unique_states <- unique(data$State)
  valid_outcome <- c("heart attack", "heart failure", "pneumonia")
  if (state %in% unique_states == FALSE) {
    message("invalid state")
    stop()
  }
  if (outcome %in% valid_outcome == FALSE) {
    message("invalid outcome")
    stop()
  }
  
  # setting variable
  if (outcome == "heart attack") {col_2_take = 11}
  else if (outcome == "heart failure") {col_2_take = 17}
  else if (outcome == "pneumonia") {col_2_take = 23}
  
  #return hospital name in that state with lowest 30-day death rate
  data[,col_2_take] <- as.numeric(data[,col_2_take])
  data_extract <- data[which(data$State == state & !is.na(data[,col_2_take])),]
  data_sorted <- data_extract[order(data_extract[,col_2_take], data_extract[,2]),]
  data_out <<- data_sorted
  data_sorted[1,2]
}