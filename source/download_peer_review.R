#download Peer review data
setwd("C:/Users/Gabriele/Documents/Git/JHSPH-Data-Science/source/")
if(!file.exists("../data/miscellaneous")){dir.create("../data/miscellaneous")}
#fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
#fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
#download.file(fileUrl1, destfile = "../data/miscellaneous/reviews.csv")
#download.file(fileUrl2, destfile = "../data/miscellaneous/solutions.csv")
reviews = read.csv("../data/miscellaneous/reviews.csv"); solutions <- read.csv("../data/miscellaneous/solutions.csv")