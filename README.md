## README.md
### Author: Mark D. Dixon
### Date: 22 June 2014

## Description of How the Script Works

The file "run_analysis.R" contains an R script to process data collected from the accelerometers of a Samsung Galaxy S smartphone.  The data set proccessed can be found at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The script creates a tidy data set with the average of each variable for each activity and each subject. Steps to create the tidy data set are:

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

The input files must be located in the current working directory. The script creates as output a file titled "tidy_data_set.txt" containing the tidy data. This file is in comma separated variable (csv) format and is created in the working directory.

The first block of code loads required packages and gets the working directory for use in later function calls to read the data files.


```r
  # Load required packages
library(data.table)
library(doBy)
  # Get the working directory containing the input files
work_dir <- getwd()
```

The next three blocks of code performs step 1.  Two data frames are formed, one of test data and one of train data.  Then the test and the train data frames are combined to form the one data set.

In the following code block a test data frame is formed by first reading the subject, activity and features data files each into a separate data frame.  Since these data are aligned by row, the three data frames are then combined using the cbind() function.


```r
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
```

In the following code block a data frame of the train data is formed in the same steps as the test data frame described above.


```r
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
```

The following code block completes step 1 by combining the test and the train data frames into one data frame.  Since these data are aligned by column, the two are combined into a new data frame using the rbind() function.


```r
  # Combine the test and train dataframes by row
one_data_set <- rbind(data_set_test, data_set_train)
```

The following block of code performs step 2.  The measurements on the mean and stardard deviation for each measurement are extracted by using the grep() function.  The substrings "mean" or "std" are searched for over the feature names vector.  Column numbers for feature names that match are returned and used to subset the desired columns into a new data frame, data_set.


```r
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
```

The following block of code performs step 3.  The activity labels are read in from the activity_labels.text file to a vector.  The vector is used as the "labels=" argument in a factor() function call on the data set activity column.  This replaces numerical values with corresponding character labels. 


```r
  # Read the file containing names of each activity
activity_names <- read.table(paste(work_dir,"/activity_labels.txt",sep=""), 
                             header=FALSE)
activity_names <- as.vector(tolower(activity_names[,2]))
  # Convert activity column to factors with labels
data_set$activity <- factor(data_set$activity, labels=activity_names)
```

The following block of code performs step 4. Variable labels are extracted from the feature_names vector by subsetting the vector with the cols_to_extract vector determined above.  Problematic characters in the variable names are removed or replaced and the variable names are combined with "subject" and "activity" labels to be assigned by names() function to the data set.


```r
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
```

Task 4 is performed by the following code.  The summaryBy() function in the doby package is called to calculate groupwise summary statistics.  In this case the mean() function is specified by the "FUN=" argument. The grouping is specified by "subject + activity" in the formula argument and the "." indicates the mean is to be calculated over all other data set variables for each grouping.  The summaryBy() function adds ".mean" to the column labels.  The below script replaces the periods with underscores retaining the "mean" addition. 


```r
data_set_of_means <- summaryBy( . ~ subject + activity, data=data_set, 
                               FUN=mean)
  # Tidy up the resulting variable names by replacing periods
names(data_set_of_means) <- gsub("\\.", "_", names(data_set_of_means))
```

The resulting tidy data set is written to a file in the working directory using the write.table() function.  The file is written in comma separated variable form as specified by the sep="," argument.  However the file extention is specified as "txt" so the file can be uploaded to Coursera.


```r
  # Write the data set as a text file (csv format) to the working directory 
write.table(data_set_of_means, file="tidy_data_set.txt", sep=",", 
            row.names=FALSE)
```
