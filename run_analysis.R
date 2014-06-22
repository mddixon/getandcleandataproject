# File: run_analysis.R
# Author: Mark D. Dixon
# Date: June 2014
# R script to process data collected from the accelerometers of a
# Samsung Galaxy S smartphone.  Data set can be found at:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles
#   %2FUCI%20HAR%20Dataset.zip
# This script creates a tidy data set with the average of each 
# variable for each activity and each subject.
# Input files: activity_labels.txt, features.txt, subject_test.txt,
#              subject_train.txt, X_test.txt, X_train.txt,
#              y_test.txt, y_train.txt# 
# Output file: tidy_data_set.txt 
# 
  # Load required packages
library(data.table)
library(doBy)
  # Get the working directory containing the input files
work_dir <- getwd()

## Merge the training and the test sets to create one data set.

  # Form a dataframe of the test data
  # Read the file containing the subject number for each observation
subject_test <- read.table(paste(work_dir,"/Subject_test.txt",sep=""),
                           header=FALSE, col.names="subject")
  # Read the file containing the activity number for each observation 
activity_number_test <- read.table(paste(work_dir,"/y_test.txt",sep=""),
                                   header=FALSE, col.names="activity")
  # Read the file containing feature value for each observation
feature_values_test <- read.table(paste(work_dir,"/X_test.txt",sep=""),
                                  header=FALSE)
  # Combine the above dataframes by column
data_set_test <- cbind(subject_test, activity_number_test, 
                       feature_values_test)

  # Form a dataframe of the train data
  # Read the file containing the subject number for each observation
subject_train <- read.table(paste(work_dir,"/Subject_train.txt",sep=""),
                            header=FALSE, col.names="subject")
  # Read the file containing the activity number for each observation 
activity_number_train <- read.table(paste(work_dir,"/y_train.txt",sep=""),
                                    header=FALSE, col.names="activity")
  # Read the file containing feature value for each observation
feature_values_train <- read.table(paste(work_dir,"/X_train.txt",sep=""),
                                   header=FALSE)
  # Combine the above dataframes by column
data_set_train <- cbind(subject_train, activity_number_train, 
                        feature_values_train)

  # Combine the test and train dataframes by row
one_data_set <- rbind(data_set_test, data_set_train)

## Extract only the measurements on the mean and stardard deviation 
##   for each measurement

  # Read the file containing names of each feature
feature_names <- read.table(paste(work_dir,"/features.txt",sep=""), 
                            header=FALSE)
feature_names <- as.vector(feature_names[,2])
  # Get the indices of the feature names containing "mean" or "std"
  #   excluding capitals
cols_to_extract <- grep("mean|std", feature_names, ignore.case=FALSE, 
                        value=FALSE)
  # Insert index numbers for the subject and activity columns and extract
  #   the desired columns into a new data set by subsetting
data_set <- one_data_set[, c(1, 2, (cols_to_extract + 2))]

## Use descriptive activity names to name the activities in the data set

  # Read the file containing names of each activity
activity_names <- read.table(paste(work_dir,"/activity_labels.txt",sep=""), 
                             header=FALSE)
activity_names <- as.vector(tolower(activity_names[,2]))
  # Convert activity column to factors with labels
data_set$activity <- factor(data_set$activity, labels=activity_names)

## Appropriately label the data set with descriptive variable names

  # Extract the subset of variable names from feature names
variable_names <- feature_names[cols_to_extract]
  # Remove/replace special characters from variable names
  # Define a function to find and replace substrings 
replace <- function(pattern, replacement, x, ...) {
    for(i in 1:length(pattern)) x <- gsub(pattern[i], replacement[i], x, ...)
    return(x)}
  # Define replacement substrings
from <- c("-", "\\(", "\\)")
to <- c("_", "", "")
  # Call replace() to clean up variable names
variable_names <- replace(from, to, variable_names)
  # Assign the descriptive variable names to the data set
names(data_set) <- c("subject", "activity", variable_names)

## Create a second, independent tidy data set with the average of 
##   each variable for each activity and each subject.

data_set_of_means <- summaryBy( . ~ subject + activity, data=data_set, 
                               FUN=mean)
  # Tidy up the resulting variable names by replacing periods
names(data_set_of_means) <- gsub("\\.", "_", names(data_set_of_means))

  # Write the data set as a text file (csv format) to the working directory 
write.table(data_set_of_means, file="tidy_data_set.txt", sep=",",
            row.names=FALSE)
