## CodeBook.md
### Author: Mark D. Dixon
### Date: 22 June 2014

## Study Design - Getting and Cleaning Data Course Project

The purpose of this project is to prepare a tidy data set that can be used for subsequent data analysis.  The data set selected for preparation is the "Human Activity Recognition Using Smartphone Dataset Version 1.0".  A complete description of the data set can be found at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

A detailed description of both the original study and the data set are provide in appendix A and B.

The actual data set processed in this project was downloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

After download, the "getdata-projectfiles-UCI_HAR_Dataset.zip" file was unzipped using the Windows Explorer embedded extraction function.  The following files from the data set were moved to a common working directory for processing.

* activity_labels.txt  
* features.txt  
* subject_test.txt  
* subject_train.txt  
* X_test.txt  
* X_train.txt  
* y_test.txt  
* y_train.txt   

The files were processed by an R script contained in the file "run_analysis.R".  This script performs the following steps.

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set.
4. Appropriately label the data set with descriptive variable names.
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

The requirements for the tidy data set are as follows:

1. Each variable you measure should be in one column
2. Each different observation of that variable should be in a different row
3. There should be one table for each kind of variable
4. If you have are multiple tables, each should include a column in the table that allows them to be linked.

Some other important tips
* Include a row at the top of each file with variable names.
* Make variable names human readable (AgeAtDiagnosis instead of AgeDx)
* In general data should be saved in one file per table

Reference: Lecture slide 4/7 "The components of tidy data", Coursera course "Getting and Cleaning Data"
           Jeffrey Leek

A detailed description of the "run_analysis.R" script is provided in README.md.  The following notes provide assumptions and rationale with regards to performing each step listed above.

#### Step 1  

1. Inertial signals data were not included in step 1 because this data was not included in the final tidy data set. In step 2 all variables are filtered out except than the measurements on the mean and standard deviation for each measurement.
2. The observations (rows) in the test features data file (X_test.txt), test subject file (subject_test.txt) and test activity file (x_test.txt) are aligned and can be combined by column.
3. The observations (rows) in the train features data file (X_train.txt), train subject file (subject_train.txt) and train activity file (x_train.txt) are aligned and can be combined by column.
4. Variables (columns) in the test features data (X_test.txt) and train features data (Y_train.txt) are both aligned according to the features labels (features.txt) and therefore can be combined by row.

#### Step 2  

1. Extraction of "the measurements on the mean and standard deviation for each measurement" was interpreted to include only "mean()", "std()" and "meanFreq()" estimated variables as described in appendix B.  Other estimated variables, specifically "angle()" was explicitly excluded since these are understood to be an estimated angle between two variables which may, one or both be a mean value. 

#### Step 4  

1. Feature names containing the substring "BodyBody" were assumed to be typos because there is no reference to a measurment/variable containing "BodyBody" in the original study features information file (features_info.txt).  The "BodyBody" substring was replace with "Body" in the decriptive variable names for the tidy data set. 


## Code Book

The following is a complete list and description of the variables in the data set.

**subject** - The experiment volunteer numbered 1 to 30. No units.  
**activity** - The activity performed by the volunteer during the experiment. Values are walking, walking_upstairs, walking_downstairs, sitting, standing, laying.

Notes:  
The "mean" on the end of the variable name indicates that it is a mean value calculated for each activity and each subject.  This is denoted by "mean FEAES" in the descriptions below.

The original features were normalized and bounded within [-1, 1]. See notes in appendix A.  Therefore all of the following variables are unitless and bounded within [-1, 1].

A prefix "t" on the variable name indicates a time domain measurement.  A prefix "f" indicates that a Fast Fourier Transform (FFT) was applied and therefore it is a frequency domain variable

**tBodyAcc_mean_X_mean** - The mean FEAES of the mean of x axis body acceleration.  
**tBodyAcc_mean_Y_mean** - The mean FEAES of the mean of y axis body acceleration.  
**tBodyAcc_mean_Z_mean** - The mean FEAES of the mean of z axis body acceleration.  
**tBodyAcc_std_X_mean** - The mean FEAES of the standard deviation of x axis body acceleration.  
**tBodyAcc_std_Y_mean** - The mean FEAES of the standard deviation of y axis body acceleration.  
**tBodyAcc_std_Z_mean** - The mean FEAES of the standard deviation of z axis body acceleration.  
**tGravityAcc_mean_X_mean** - The mean FEAES of the mean of x axis gravity acceleration.   
**tGravityAcc_mean_Y_mean** - The mean FEAES of the mean of y axis gravity acceleration.  
**tGravityAcc_mean_Z_mean** - The mean FEAES of the mean of z axis gravity acceleration.  
**tGravityAcc_std_X_mean** - The mean FEAES of the standard deviation of x axis gravity acceleration.  
**tGravityAcc_std_Y_mean** - The mean FEAES of the standard deviation of y axis gravity acceleration.  
**tGravityAcc_std_Z_mean** - The mean FEAES of the standard deviation of z axis gravity acceleration.  
**tBodyAccJerk_mean_X_mean** - The mean FEAES of the mean of x axis body linear jerk.  
**tBodyAccJerk_mean_Y_mean** - The mean FEAES of the mean of y axis body linear jerk.  
**tBodyAccJerk_mean_Z_mean** - The mean FEAES of the mean of z axis body linear jerk.  
**tBodyAccJerk_std_X_mean** - The mean FEAES of the standard deviation of z axis body linear jerk.  
**tBodyAccJerk_std_Y_mean** - The mean FEAES of the standard deviation of z axis body linear jerk.  
**tBodyAccJerk_std_Z_mean** - The mean FEAES of the standard deviation of z axis body linear jerk.  
**tBodyGyro_mean_X_mean** - The mean FEAES of the mean of x axis body angular velocity.  
**tBodyGyro_mean_Y_mean** - The mean FEAES of the mean of y axis body angular velocity.  
**tBodyGyro_mean_Z_mean** - The mean FEAES of the mean of z axis body angular velocity.  
**tBodyGyro_std_X_mean** - The mean FEAES of the standard deviation of x axis body angular velocity.  
**tBodyGyro_std_Y_mean** - The mean FEAES of the standard deviation of y axis body angular velocity.  
**tBodyGyro_std_Z_mean** - The mean FEAES of the standard deviation of z axis body angular velocity.  
**tBodyGyroJerk_mean_X_mean** - The mean FEAES of the mean of x axis body angular jerk.  
**tBodyGyroJerk_mean_Y_mean** - The mean FEAES of the mean of y axis body angular jerk.  
**tBodyGyroJerk_mean_Z_mean** - The mean FEAES of the mean of z axis body angular jerk.  
**tBodyGyroJerk_std_X_mean** - The mean FEAES of the standard deviation of x axis body angular jerk.  
**tBodyGyroJerk_std_Y_mean** - The mean FEAES of the standard deviation of y axis body angular jerk.  
**tBodyGyroJerk_std_Z_mean** - The mean FEAES of the standard deviation of z axis body angular jerk.  
**tBodyAccMag_mean_mean** - The mean FEAES of the mean of body acceleration magnitude.  
**tBodyAccMag_std_mean** - The mean FEAES of the standard deviation of body acceleration magnitude.  
**tGravityAccMag_mean_mean** - The mean FEAES of the mean of gravity acceleration magnitude.  
**tGravityAccMag_std_mean** - The mean FEAES of the standard deviation of gravity acceleration magnitude.  
**tBodyAccJerkMag_mean_mean** - The mean FEAES of the mean of body linear jerk magnitude.  
**tBodyAccJerkMag_std_mean** - The mean FEAES of the standard deviation of body linear jerk magnitude.  
**tBodyGyroMag_mean_mean** - The mean FEAES of the mean of body angular velocity magnitude.  
**tBodyGyroMag_std_mean** - The mean FEAES of the standard deviation of body angular velocity magnitude.  
**tBodyGyroJerkMag_mean_mean** - The mean FEAES of the mean of body angular jerk magnitude.  
**tBodyGyroJerkMag_std_mean** - The mean FEAES of the standard deviation of body angular jerk magnitude.  
**fBodyAcc_mean_X_mean** - The mean FEAES of the mean of the FFT of x axis body acceleration.  
**fBodyAcc_mean_Y_mean** - The mean FEAES of the mean of the FFT of y axis body acceleration.  
**fBodyAcc_mean_Z_mean** - The mean FEAES of the mean of the FFT of z axis body acceleration.  
**fBodyAcc_std_X_mean** - The mean FEAES of the standard deviation of the FFT of x axis body acceleration.  
**fBodyAcc_std_Y_mean** - The mean FEAES of the standard deviation of the FFT of y axis body acceleration.  
**fBodyAcc_std_Z_mean** - The mean FEAES of the standard deviation of the FFT of z axis body acceleration.  
**fBodyAcc_meanFreq_X_mean** - The mean FEAES of the mean frequency of x axis body acceleration.  
**fBodyAcc_meanFreq_Y_mean** - The mean FEAES of the mean frequency of y axis body acceleration.  
**fBodyAcc_meanFreq_Z_mean** - The mean FEAES of the mean frequency of z axis body acceleration.  
**fBodyAccJerk_mean_X_mean** - The mean FEAES of the mean of the FFT of x axis body linear jerk.   
**fBodyAccJerk_mean_Y_mean** - The mean FEAES of the mean of the FFT of y axis body linear jerk.  
**fBodyAccJerk_mean_Z_mean** - The mean FEAES of the mean of the FFT of z axis body linear jerk.  
**fBodyAccJerk_std_X_mean** - The mean FEAES of the standard deviation of the FFT of x axis body linear jerk.  
**fBodyAccJerk_std_Y_mean** - The mean FEAES of the standard deviation of the FFT of y axis body linear jerk.  
**fBodyAccJerk_std_Z_mean** - The mean FEAES of the standard deviation of the FFT of z axis body linear jerk.  
**fBodyAccJerk_meanFreq_X_mean** - The mean FEAES of the mean frequency of the FFT of x axis body linear jerk.  
**fBodyAccJerk_meanFreq_Y_mean** - The mean FEAES of the mean frequency of the FFT of y axis body linear jerk.  
**fBodyAccJerk_meanFreq_Z_mean** - The mean FEAES of the mean frequency of the FFT of z axis body linear jerk.  
**fBodyGyro_mean_X_mean** - The mean FEAES of the mean of the FFT of x axis body angular veclocity.  
**fBodyGyro_mean_Y_mean** - The mean FEAES of the mean of the FFT of y axis body angular veclocity.  
**fBodyGyro_mean_Z_mean** - The mean FEAES of the mean of the FFT of z axis body angular veclocity.  
**fBodyGyro_std_X_mean** - The mean FEAES of the standard deviation of the FFT of x axis body angular veclocity.  
**fBodyGyro_std_Y_mean** - The mean FEAES of the standard deviation of the FFT of y axis body angular veclocity.  
**fBodyGyro_std_Z_mean** - The mean FEAES of the standard deviation of the FFT of z axis body angular veclocity.  
**fBodyGyro_meanFreq_X_mean** - The mean FEAES of the mean frequency of the FFT of x axis body angular velocity.  
**fBodyGyro_meanFreq_Y_mean** - The mean FEAES of the mean frequency of the FFT of y axis body angular velocity.  
**fBodyGyro_meanFreq_Z_mean** - The mean FEAES of the mean frequency of the FFT of z axis body angular velocity.  
**fBodyAccMag_mean_mean** - The mean FEAES of the mean of the FFT of body acceleration magnitude.  
**fBodyAccMag_std_mean** - The mean FEAES of the standard deviation of the FFT of body acceleration magnitude.  
**fBodyAccMag_meanFreq_mean** - The mean FEAES of the mean frequency of the FFT of the body acceleration magnitude.  
**fBodyAccJerkMag_mean_mean** - The mean FEAES of the mean of the FFT of the body linear jerk magnitude.  
**fBodyAccJerkMag_std_mean** - The mean FEAES of the standard deviation of the FFT of the body linear jerk magnitude.  
**fBodyAccJerkMag_meanFreq_mean** - The mean FEAES of the mean frequency of the FFT of the body linear jerk magnitude.  
**fBodyGyroMag_mean_mean** - The mean FEAES of the mean of the FFT of the body angular velocity magnitude.  
**fBodyGyroMag_std_mean** - The mean FEAES of the standard deviation of the FFT of the body angular velocity magnitude.  
**fBodyGyroMag_meanFreq_mean** - The mean FEAES of the mean frequency of the FFT of the body angular jerk magnitude.  
**fBodyGyroJerkMag_mean_mean** - The mean FEAES of the mean of the FFT of the body angular jerk magnitude.  
**fBodyGyroJerkMag_std_mean** - The mean FEAES of the standard deviation of the FFT of the body angular jerk magnitude.  
**fBodyGyroJerkMag_meanFreq_mean** - The mean FEAES of the mean frequency of the FFT of the body angular jerk magnitude.  




### Appendix A
### README.txt from UCI HAR Dataset
```
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
```

### Appendix B
### features_info.txt from UCI HAR Dataset
```
Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'
```



