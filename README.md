##Project Motivation

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

##Background

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Project Requirements

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

Good luck!  

##How to run to reproduce project results

1. Open the R script ```run_analysis.r``` using a text editor. (The script executes to fulfil all 5 requirements described in __Project Requirements__, additional details are found in __CodeBook.md__.
2. Change parameter of the ```setwd()``` function call to the working directory/folder, where these the R script is saved).
3. Run the R script ```run_analysis.r```. Results generated are saved in ```tidy_data.txt```under location mentioned in step 2.
 

##Project Output

```tidy_data.txt`` (tab-delimited text)
