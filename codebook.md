# Data Dictionary - Getting and Cleaning Course Project


=================

## Raw data

### Raw Data Collection
The raw data set of the project was downloaded from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The raw data set includes the following files:

* 'README.txt'
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

### Raw Data Features

The raw data was collected from the experiments that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

The signals were sampled in fixed-width sliding windows of 2.56 sec and 50% 
overlap (128 readings/window at 50 Hz).
From each window, a vector of features was obtained by calculating variables
from the time and frequency domain.

The set of variables that were estimated from these signals are: 

*  mean(): Mean value
*  std(): Standard deviation
*  mad(): Median absolute deviation 
*  max(): Largest value in array
*  min(): Smallest value in array
*  sma(): Signal magnitude area
*  energy(): Energy measure. Sum of the squares divided by the number of values. 
*  iqr(): Interquartile range 
*  entropy(): Signal entropy
*  arCoeff(): Autoregression coefficients with Burg order equal to 4
*  correlation(): Correlation coefficient between two signals
*  maxInds(): Index of the frequency component with largest magnitude
*  meanFreq(): Weighted average of the frequency components to obtain a mean frequency
*  skewness(): Skewness of the frequency domain signal 
*  kurtosis(): Kurtosis of the frequency domain signal 
*  bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT
   of each window.
*  angle(): Angle between some vectors.

No unit of measures is reported as all features were normalized and bounded
within [-1,1].

## Transformations for getting the final data Set

The raw data set are transformed in order to create the desired final data. The transformations include

* Merges the training and the test sets to create one data set.

    + download and unzip raw data set;
    + load useful infomration from raw data set (including the data from "X_train.txt","y_train.txt", "X_test.txt","y_test.txt","features.txt", "activity_labels.txt", "subject_train.txt" and "subject_test.txt");
    + merge data set (called "merge_data") to combine training/test sets, labels and subject data. 
    
* Extracts only the measurements on the mean and standard deviation for each measurement. 

    + find all measurements with "mean()" presented in the variable names;
    + find all measurements with "std()" presented in the variable names;
    + extract sub-data frame (called "new_data") from "merge_data" with all measurements with eirther "mean()" or "std()" presented in the variable names.
    
* Uses descriptive activity names to name the activities in the data set
    + find matching rows in "merge_data" activity variable, and replacing those variable values by the decriptive activity names (defined in "activity_labels.txt"). 
    
* Appropriately labels the data set with descriptive variable names. 
    + obtain the column names of "new_data" as variable "orig_name"
    + split each character string based on capital letters
    + replace 't' at the beginning of each character string with the 'time info of'
    + replace 'f' at the beginning of each character string wit the 'frequency info of'
    + replace '-X' (or '-Y', '-Z') with 'on the X (or Y, Z) axis'
    
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    + reshape "new_data" to "ds_mlt", by keeping variable "activities" and "subjects" and transforming others into measured variables
    + convert "ds_mlt" to "result" by calculating mean of measured variables based on both "activities" and "subjects" variables.
    + write the "result" into "my_output.txt" by ignoring row names. 


## Final data Set


The raw data sets are processed with run_analisys.R script to create a tidy data
set, which include the averaged mean() and std() related measurements for each activity and each subject. 

The tidy data set contains 180 observations with 68 variables. The variables are described as the following:

*  an activity label (__activities__): WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
*  an identifier of the subject who carried out the experiment (__subjects__):
   1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, 30
*  a 66-feature vector (3rd~68th variables) with time and frequency domain signal variables (numeric)


The 3rd ~ 42th varialbles are averaged time domain data for each activity and each subject, with range of [-1 1]. Their names are explained as the following table.


Variable Name                                   | Descripition (averaged time domain data)                        
------------------------------------------------| ---------------------------------------------------------------|
time of Body Acc-mean value on the X axis       | averaged Boby acceleration mean values (X-axis)                | 
time of Body Acc-mean value on the Y axis       | averaged Boby acceleration mean values (Y-axis)                |          
time of Body Acc-mean value on the Z axis       | averaged Boby acceleration mean values (Z-axis)                |  
time of Body Acc-std value on the X axis        | averaged Boby acceleration standard deviation (X-axis)         |  
time of Body Acc-std value on the Y axis        | averaged Boby acceleration standard deviation (Y-axis)         | 
time of Body Acc-std value on the Z axis        | averaged Boby acceleration standard deviation (Z-axis)         | 
time of Gravity Acc-mean value on the X axis    | averaged Gravity acceleration mean values (X-axis)             | 
time of Gravity Acc-mean value on the Y axis    | averaged Gravity acceleration mean values (Y-axis)             |   
time of Gravity Acc-mean value on the Z axis    | averaged Gravity acceleration mean values (Z-axis)             | 
time of Gravity Acc-std value on the X axis     | averaged Gravity acceleration standard deviation (X-axis)      | 
time of Gravity Acc-std value on the Y axis     | averaged Gravity acceleration standard deviation (Y-axis)      | 
time of Gravity Acc-std value on the Z axis     | averaged Gravity acceleration standard deviation (Z-axis)      |       
time of Body Acc Jerk-mean value on the X axis  | averaged Jerk of Boby acceleration mean values (X-axis)        | 
time of Body Acc Jerk-mean value on the Y axis  | averaged Jerk of Boby acceleration mean values(Y-axis)         |     
time of Body Acc Jerk-mean value on the Z axis  | averaged Jerk of Boby acceleration mean values (Z-axis)        | 
time of Body Acc Jerk-std value on the X axis   | averaged Jerk of Boby acceleration standard deviation (X-axis) |   
time of Body Acc Jerk-std value on the Y axis   | averaged Jerk of Boby acceleration standard deviation (Y-axis) | 
time of Body Acc Jerk-std value on the Z axis   | averaged Jerk of Boby acceleration standard deviation (Z-axis) |   
time of Body Gyro-mean value on the X axis      | averaged Gyro of Boby acceleration mean values (X-axis)        | 
time of Body Gyro-mean value on the Y axis      | averaged Gyro of Boby acceleration mean values (Y-axis)        |         
time of Body Gyro-mean value on the Z axis      | averaged Gyro of Boby acceleration mean values (Z-axis)        | 
time of Body Gyro-std value on the X axis       | averaged Gyro of Boby acceleration standard deviation (X-axis) | 
time of Body Gyro-std value on the Y axis       | averaged Gyro of Boby acceleration standard deviation (Y-axis) |         
time of Body Gyro-std value on the Z axis       | averaged Gyro of Boby acceleration standard deviation (Z-axis) |         
time of Body Gyro Jerk-mean value on the X axis | averaged Gyro of Boby acceleration mean values (X-axis)        | 
time of Body Gyro Jerk-mean value on the Y axis | averaged Gyro of Boby acceleration mean values (Y-axis)        | 
time of Body Gyro Jerk-mean value on the Z axis | averaged Gyro of Boby acceleration mean values (Z-axis)        | 
time of Body Gyro Jerk-std value on the X axis  | averaged Gyro of Boby acceleration standard deviation (X-axis) |    
time of Body Gyro Jerk-std value on the Y axis  | averaged Gyro of Boby acceleration standard deviation (Y-axis) | 
time of Body Gyro Jerk-std value on the Z axis  | averaged Gyro of Boby acceleration standard deviation (Z-axis) |     
time of Body Acc Mag-mean value                 | averaged Boby acceleration magnitude mean values               | 
time of Body Acc Mag-std value                  | averaged Boby acceleration magnitude standard deviation        |                   
time of Gravity Acc Mag-mean value              | averaged Gravity acceleration magnitude mean values            | 
time of Gravity Acc Mag-std value               | averaged Gravity acceleration magnitude standard deviation     |               
time of Body Acc Jerk Mag-mean value            | averaged Jerk of Boby acceleration magnitude mean values       | 
time of Body Acc Jerk Mag-std value             | averaged Jerk of Boby acceleration magnitude standard deviation|                
time of Body Gyro Mag-mean value                | averaged Boby acceleration magnitude mean values               | 
time of Body Gyro Mag-std value                 | averaged Boby acceleration magnitude standard deviation        |                  
time of Body Gyro Jerk Mag-mean value           | averaged Boby acceleration magnitude mean values               | 
time of Body Gyro Jerk Mag-std value            | averaged Boby acceleration magnitude standard deviation        | 



The 43rd ~ 68th varialbles are averaged frequency domain data for each activity and each subject, with range of [-1 1]. Their names are explained as the following table.

Variable Name                                        | Description (averaged frequency domain data)                     |
-----------------------------------------------------| -----------------------------------------------------------------|
frequency of Body Acc-mean value on the X axis       | averaged Boby acceleration mean values (X-axis)                  |
frequency of Body Acc-mean value on the Y axis       | averaged Boby acceleration mean values (Y-axis)                  |    
frequency of Body Acc-mean value on the Z axis       | averaged Boby acceleration mean values (Z-axis)                  |
frequency of Body Acc-std value on the X axis        | averaged Boby acceleration standard deviation (X-axis)           |
frequency of Body Acc-std value on the Y axis        | averaged Boby acceleration standard deviation (Y-axis)           |
frequency of Body Acc-std value on the Z axis        | averaged Boby acceleration standard deviation (Z-axis)           |
frequency of Body Acc Jerk-mean value on the X axis  | averaged Jerk of Boby acceleration mean values (X-axis)          | 
frequency of Body Acc Jerk-mean value on the Y axis  | averaged Jerk of Boby acceleration mean values (Y-axis)          | 
frequency of Body Acc Jerk-mean value on the Z axis  | averaged Jerk of Boby acceleration mean values (Z-axis)          | 
frequency of Body Acc Jerk-std value on the X axis   | averaged Jerk of Boby acceleration standard deviation (X-axis)   | 
frequency of Body Acc Jerk-std value on the Y axis   | averaged Jerk of Boby acceleration standard deviation (Y-axis)   | 
frequency of Body Acc Jerk-std value on the Z axis   | averaged Jerk of Boby acceleration standard deviation (Z-axis)   | 
frequency of Body Gyro-mean value on the X axis      | averaged Gyro of Boby acceleration mean values (X-axis)          |
frequency of Body Gyro-mean value on the Y axis      | averaged Gyro of Boby acceleration mean values (Y-axis)          |
frequency of Body Gyro-mean value on the Z axis      | averaged Gyro of Boby acceleration mean values (Z-axis)          |
frequency of Body Gyro-std value on the X axis       | averaged Gyro of Boby acceleration standard deviation (X-axis)   |
frequency of Body Gyro-std value on the Y axis       | averaged Gyro of Boby acceleration standard deviation (Y-axis)   |
frequency of Body Gyro-std value on the Z axis       | averaged Gyro of Boby acceleration standard deviation (Z-axis)   |
frequency of Body Acc Mag-mean value                 | averaged Boby acceleration magnitude mean values                 | 
frequency of Body Acc Mag-std value                  | averaged Boby acceleration magnitude standard deviation          | 
frequency of Body Body Acc Jerk Mag-mean value       | averaged Jerk of Boby acceleration magnitude mean values         | 
frequency of Body Body Acc Jerk Mag-std value        | averaged Jerk of Boby acceleration magnitude standard deviation  | 
frequency of Body Body Gyro Mag-mean value           | averaged Gyro of Boby magnitude mean values                      | 
frequency of Body Body Gyro Mag-std value            | averaged Gyro of Boby magnitude standard deviation               | 
frequency of Body Body Gyro Jerk Mag-mean value      | averaged Jerk of Gyro of Boby magnitude mean values              | 
frequency of Body Body Gyro Jerk Mag-std value       | averaged Jerk of Gyro of Boby magnitude standard deviation       | 

The tidy data set is written to the file myoutput.txt.
