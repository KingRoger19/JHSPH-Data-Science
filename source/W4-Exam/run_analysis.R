# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average 
#    of each variable for each activity and each subject.

# i can define a vector of packages to load them in one step
Packages <- c("dplyr", "reshape2")
lapply(Packages, library, character.only = TRUE)

setwd("C:/Users/Gabriele/Documents/Git/JHSPH-Data-Science/data/W4-Exam/UCI HAR Dataset")

#activity_labels.txt: Links the class labels with their activity name.
ActivityLabels <- read.table("activity_labels.txt", header = FALSE, sep = "", dec = ".", col.names = c("ClassLabels", "ActivityName"))
# features.txt: List of all features.
Features <- read.table("features.txt", header = FALSE, sep = "", dec = ".", col.names = c("ID", "FeatureName"))
# subset of all the ID satisfying condition 2.
FeaturesFiltered <- grep("(mean|std)\\(\\)", Features[, "FeatureName"])
# select only rows satisfying condition 2.
ValidMeasures <- Features[FeaturesFiltered, "FeatureName"]
# clean up the vector
ValidMeasures <- gsub('[()]', '', ValidMeasures)

### X TRAIN ###
# util call columns
ds_train_X <- setNames(read.table("train/X_train.txt", header = FALSE, sep = "", dec = "."), 1:561)
# select only columns for filtered features
ds_train_X <- ds_train_X %>% select(FeaturesFiltered)
# renaming columns
ds_train_X <- setNames(ds_train_X, ValidMeasures)

### Y TRAIN ###
TrainActivities <- read.table("train/Y_train.txt", header = FALSE, sep = "", dec = ".", col.names = c("Activity"))
# Subject who performed the activity 
TrainSubjects <- read.table("train/subject_train.txt", header = FALSE, sep = "", dec = ".", col.names = c("IDSubject"))
# put all these datasets togheter
ds_Train <- cbind(TrainSubjects, TrainActivities, ds_train_X)


### X TEST ###
# util call columns
ds_test_X <- setNames(read.table("test/X_test.txt", header = FALSE, sep = "", dec = "."), 1:561)
# select only columns for filtered features
ds_test_X <- ds_test_X %>% select(FeaturesFiltered)
# renaming columns
ds_test_X <- setNames(ds_test_X, ValidMeasures)

### Y TRAIN ###
TestActivities <- read.table("test/Y_test.txt", header = FALSE, sep = "", dec = ".", col.names = c("Activity"))
TestSubjects <- read.table("test/subject_test.txt", header = FALSE, sep = "", dec = ".", col.names = c("IDSubject"))
ds_Test <- cbind(TestSubjects, TestActivities, ds_test_X)

# now that i have tidy dataset, i can append them
ds_Driver <- rbind(ds_Train, ds_Test)

# I can use factor function (function to format code-labels)
ds_Driver[["Activity"]] <- factor(ds_Driver[, "Activity"], 
                                levels = ActivityLabels[["ClassLabels"]], 
                                labels = ActivityLabels[["ActivityName"]])
# to perform aggregate function,i have to convert numeric IDSubject to a factor variable
ds_Driver[["IDSubject"]] <- as.factor(ds_Driver[, "IDSubject"])
# calling melt function to transpose measures. I will have 2 more columns: variable and value
ds_Driver <- melt(ds_Driver, id = c("IDSubject", "Activity"))
# now i can use dcast function to perform computations for all the way IDSubject + Activity
ds_Driver <- dcast(ds_Driver, IDSubject + Activity ~ variable, fun.aggregate = mean)

# write output on the outfile
write.table(ds_Driver, file = "tidyData.txt", sep = ",", row.names = FALSE)
