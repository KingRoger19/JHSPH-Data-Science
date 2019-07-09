if(!file.exists("../data/miscellaneous")){dir.create("../data/miscellaneous")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile = "../data/miscellaneous/restaurants.csv")
restData <- read.csv("../data/miscellaneous/restaurants.csv")