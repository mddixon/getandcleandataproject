# README.md

## Description of How the Script Works

The file "run_analysis.R" contains an R script to process data collected from the accelerometers of a Samsung Galaxy S smartphone.  The data set proccessed can be found at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The script creates a tidy data set with the average of each variable for each activity and each subject. Tasks to create the tidy data set are:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set.
4. Appropriately label the data set with descriptive variable names.
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
 
The files from the UCI data set which are required as input are:

activity_labels.txt  
features.txt  
subject_test.txt  
subject_train.txt  
X_test.txt  
X_train.txt  
y_test.txt  
y_train.txt   

The input files must be located in the working directory. The script creates as output a file titled "tidy_data_set.txt" containing the tidy data. This file is in comma separated variable (csv) format and is created in the working directory.

The first block of code loads required packages and gets the working directory for use in later function calls to read the data files.


```r
  # Load required packages
library(data.table)
library(plyr)
  # Get the working directory containing the input files
work_dir <- getwd()
```

The next three blocks of code performs task 1.  Two data frames are formed, one of test data and one of train data.  Then the test data frame and the train data frame are combined to form the one data set.

In the following code block a test data frame is formed by first reading the subject, activity and features data files each into a separate data frame.  Since these data are aligned by column, the three data frames are then combined using the cbind() function.


```r
  # Form a dataframe of the test data
  #   Read the file containing the subject number for each observation
Subject_test <- read.table(paste(work_dir,"/Subject_test.txt",sep=""),
                           header=FALSE, col.names="Subject")
  #   Read the file containing the activity number for each observation 
Activity_number_test <- read.table(paste(work_dir,"/y_test.txt",sep=""),
                                   header=FALSE, col.names="Activity")
  #   Read the file containing feature value for each observation
Feature_values_test <- read.table(paste(work_dir,"/X_test.txt",sep=""),
                                  header=FALSE)
  #   Combine the above dataframes by column
data_set_test <- cbind(Subject_test, Activity_number_test, Feature_values_test)
```
In the following code block a data frame of the train data is formed in the same way as the test data frame above.


```r
  # Form a dataframe of the train data
  #   Read the file containing the subject number for each observation
Subject_train <- read.table(paste(work_dir,"/Subject_train.txt",sep=""),
                            header=FALSE, col.names="Subject")
  #   Read the file containing the activity number for each observation 
Activity_number_train <- read.table(paste(work_dir,"/y_train.txt",sep=""),
                                    header=FALSE, col.names="Activity")
  #   Read the file containing feature value for each observation
Feature_values_train <- read.table(paste(work_dir,"/X_train.txt",sep=""),
                                   header=FALSE)
  #   Combine the above dataframes by column
data_set_train <- cbind(Subject_train, Activity_number_train, Feature_values_train)
```



