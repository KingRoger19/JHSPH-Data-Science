# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average 
#    of each variable for each activity and each subject.

# I can define a vector of packages to load them in just one step
Packages <- c("dplyr", "reshape2")
lapply(Packages, library, character.only = TRUE)

# Download and unzip of files
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")

# Activity_labels.txt: Links the class labels with their activity name.
ActivityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "", dec = ".", col.names = c("ClassLabels", "ActivityName"))
# Features.txt: List of all features.
Features <- read.table("UCI HAR Dataset/features.txt", header = FALSE, sep = "", dec = ".", col.names = c("ID", "FeatureName"))
# Subsetting all the ID satisfying condition 2.
FeaturesFiltered <- grep("(mean|std)\\(\\)", Features[, "FeatureName"])
# selecting the only rows satisfying condition 2.
ValidMeasures <- Features[FeaturesFiltered, "FeatureName"]
# Clean up the vector.
ValidMeasures <- gsub('[()]', '', ValidMeasures)

### X TRAIN ###
# Loading training input file eand renaming columns.
ds_train_X <- setNames(read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "", dec = "."), 1:561)
# Selecting the only columns by filtered features.
ds_train_X <- ds_train_X %>% select(FeaturesFiltered)
# Renaming columns.
ds_train_X <- setNames(ds_train_X, ValidMeasures)

### Y TRAIN ###
# Loading train activities input file and renaming columns.
TrainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt", header = FALSE, sep = "", dec = ".", col.names = c("Activity"))
# Loading subject input file who performed activities.
TrainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "", dec = ".", col.names = c("IDSubject"))
# Putting all these datasets togheter.
ds_Train <- cbind(TrainSubjects, TrainActivities, ds_train_X)


### X TEST ###
# Loading testing input file eand renaming columns.
ds_test_X <- setNames(read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "", dec = "."), 1:561)
# Selecting the only columns by filtered features.
ds_test_X <- ds_test_X %>% select(FeaturesFiltered)
# Renaming columns.
ds_test_X <- setNames(ds_test_X, ValidMeasures)

### Y TEST ###
TestActivities <- read.table("UCI HAR Dataset/test/Y_test.txt", header = FALSE, sep = "", dec = ".", col.names = c("Activity"))
TestSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "", dec = ".", col.names = c("IDSubject"))
ds_Test <- cbind(TestSubjects, TestActivities, ds_test_X)

# Appending all datasets.
ds_Driver <- rbind(ds_Train, ds_Test)

# I can use factor function (function to format levels-labels)
ds_Driver[["Activity"]] <- factor(ds_Driver[, "Activity"], 
                                  levels = ActivityLabels[["ClassLabels"]], 
                                  labels = ActivityLabels[["ActivityName"]])
# To perform aggregate function, I have to convert numeric IDSubject to a factor variable
ds_Driver[["IDSubject"]] <- as.factor(ds_Driver[, "IDSubject"])
# calling MELT function to transpose measures. I will have 2 more columns: variable and value
ds_Driver <- melt(ds_Driver, id = c("IDSubject", "Activity"))
# now I can use DCAST function to perform computations for all the way IDSubject + Activity
ds_Driver <- dcast(ds_Driver, IDSubject + Activity ~ variable, fun.aggregate = mean)

# Write mi tidy dataset to the outfile
write.table(ds_Driver, file = "tidyData.txt", sep = ",", row.names = FALSE)
