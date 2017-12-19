# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names.
# 5) From the data set in step 4, creates a second, independent tidy data set with the average
#    of each variable for each activity and each subject.

# Merge the Training & test sets to create one data set.
# Download the data
workingdirectory <- "S:/Documents/R/UCI HAR Dataset"
setwd(workingdirectory)
if(!file.exists("./data")){dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dstFile <- "./data/UCIHARDataset.zip"
download.file(fileURL, dstFile, method = "libcurl")
unzip(zipfile="./data/UCIHARDataset.zip",exdir="./data")
setwd("data")

# Load in tidy data packages
library(dplyr)
library(data.table)
library(tidyr)

# Read train and test data & create variables
# Train
setwd("train")
subject_train <- read.table("subject_train.txt")
x_train <- read.table("x_train.txt")
y_train <- read.table("y_train.txt")

# Test
setwd("../test")
subject_test <- read.table("subject_test.txt")
x_test <- read.table("x_test.txt")
y_test <- read.table("y_test.txt")

# Merges the training and the test sets to create one data set.
mergedSubject <- rbind(subject_test, subject_train)
mergedSubject <- tbl_df(mergedSubject)
mergedX <- rbind(x_test, x_train)
mergedX <- tbl_df(mergedX)
mergedY <- rbind(y_test, y_train)
mergedY <- tbl_df(mergedY)

# Creates clear names for all fields
allSubjectData <- mergedSubject
colnames(allSubjectData) <- "subject"
allActivityData <- mergedY
colnames(allActivityData) <- "activity_number"
DataTable <- mergedX

# import and name feature variables
setwd("../")
featureData <- tbl_df(read.table("features.txt"))
colnames(featureData) <- c("feature_number", "feature_name")

# import and name activity label variables
activityLabels <- tbl_df(read.table("activity_labels.txt"))
colnames(activityLabels) <- c("activity_number", "activity_name")

# merge columns
allActivity_Subject <- cbind(allActivityData, mergedSubject)
dataTable <- cbind(alldataSubjAct, dataTable)
