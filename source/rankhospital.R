rankhospital <- function(state, outcome, num = "best") {
  
  # do common part
  best(state, outcome)
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  data_out$rank <- 1:nrow(data_out)
  if (num == "best") {
    data_out[1,2]
  }
  else if (num == "worst") {
    data_out[nrow(data_out),2]
  }
  else {
    if (num > nrow(data_out)) {return(NA)}
    else {data_out[which(data_out$rank == num),2]}
  } 
}