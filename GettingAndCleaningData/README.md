# Getting and Cleaning Data Course Project

## README for run\_analysis.R

### Purpose

Process the data sources of "Human Activity Recognition Using Smartphones Dataset" to create an independent tidy data set with the average of each variable for each activity and each subject.

The file generated meets the principles of tidy data:

- Each variable measured should be in on column
- Each different observation of a variable should be in a different row

A specific description of the tidy data file contents is available in the CodeBook.md file.

### Packages required
 
- dplyr
- reshape2

### Instructions

1. Download and extract the [Samsung data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) to the working directory.
2. Check the required packages are installed (user install.packages() otherwise).
3. Run the run\_analysis.R script.

The resulting tidy data will be output to file "tidyAverages.txt" in the working directory, which can be read into and displayed in R with:

data <- read.table("file_path",header=TRUE)  
View(data)

### Script Walkthrough

The script performs the following steps:

- Reads the training & test sets
- Reads the feature names and labels the column/variable names accordingly 
- Merges the train & test set rows into a unified data set
- Extract the measurements on the mean and standard deviation for each measurement (any column name which includes "mean" or "std" in its name is interpreted as to be included)
- Appends subject data
- Appends activity data
- Replaces activity codes by descriptive names using the class labels
- Melts the data set
- Creates a tidy data set with the average of each variable for each activity and each subject (wide format)
- Makes variable names more readable by
    + replacing consecutive periods with single period
    + removing periods at the end of the name
- Writes the resulting tidy data to file "tidyAverages.txt"