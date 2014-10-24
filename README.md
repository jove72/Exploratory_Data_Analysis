# Getting and Cleaning Data Course Project


## Overview of the Repo
This repo constains my work for the course project for the Couresa course "Getting and Cleaning Data Course".

This repo contains the following files. 

**1) run_analysis.R** The r script processes the data and generated the required tidy dataset. 

**2) myoutput.txt** The text file contains my submission of required tidy dataset. 

**3) CodeBook.md** A code book that describes the variables, the data, and any transformations or work that I performed to clean up the data

**4) README.md** The README file for this repo. 

## Instructions for running the 'run_analysis.R' script
* download the raw data package from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip; unzip the package to generate raw data set "UCI HAR Dataset"

* load useful infomration "UCI HAR Dataset"
    + variable "X_train" from "X_train.txt";
    + variable "y_train" from "y_train.txt";
    + variable "X_test" from "X_test.txt";
    + variable "y_test" from "y_test.txt";
    + variable "features" from "features.txt";
    + variable "label" from "activity_labels.txt";
    + variable "subject_train" from "subject_train.txt";
    + variable "subject_test" from "subject_test.txt"    
    
        
* merge above data sets into "merge_data" 
    + combine "X_train" and "X_test" into "allx";
    + combine "y_train" and "y_test" into "ally";
    + rename column names of "ally"as "labels";
    + combine "subject_train" and "subject_test" into "allsub";
    + rename column names of "allsub" as "subjects";
    + combine "ally", "allsub" and "allx" into "merge_data"    
    
    
* extract only mean or standard deviation related measurement from "merge_data"
    + find all variable names with "mean()" presented, logically describe the result as "idxm";
    + find all variable names with "std()" presented, logically describe the result as "idxs";
    + get according feature information "meanandstd" where either "idxm" or "idxs" is true;    
    + extract "new_data" from "merge_data" by keep varialbes those names are presented in "meanandstd"  
    
    
* uses descriptive activity names to name the activities in the "new_data"
    + check variable "labels" in "new_data"
    + comparing the variable values with the "V1" variable in "labels", replacing those values by the according "V2" values in "labels"   
    
    
* appropriately labels the "new_data" with descriptive variable names. 
    + obtain the column names of "new_data" as variable "orig_name"
    + split each character string based on capital letters
    + replace 't' at the beginning of each character string with the 'time info of'
    + replace 'f' at the beginning of each character string wit the 'frequency info of'
    + replace '-X' (or '-Y', '-Z') with 'on the X (or Y, Z) axis'    
    
    
* creates a tidy data set "result" with the average of each variable for each activity and each subject;
    + reshape "new_data" to "ds_mlt", by keeping variable "activities" and "subjects" and transforming others into measured variables;
    + convert "ds_mlt" back to "result" by calculating mean of measured variables based on both "activities" and "subjects" variables    
    
    
* write the "result" into "my_output.txt" by ignoring row names   
