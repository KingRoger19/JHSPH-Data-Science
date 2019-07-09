## makeVector creates a special "vector", which is really a list containing a function to:
## 1. set the value of the vector
## 2. get the value of the vector
## 3. set the value of the mean
## 4. get the value of the mean

makeVector <- function(x = numeric()) {
  m <- NULL

  # set the value of the vector
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  # get the value of the vector 
  get <- function() x
  # set the mean 
  setmean <- function(mean) m <<- mean
  # get the mean
  getmean <- function() m
  # build the list
  list(set = set, get = get, setmean = setmean, getmean = getmean)
}
