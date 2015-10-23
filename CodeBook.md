#Raw Data Description
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix ‘t’ to denote time) were captured at a constant rate of 50 Hz. and the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) – both using a low pass Butterworth filter.

The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

A Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the ‘f’ to indicate frequency domain signals).

##Description of measurement abbreviations

1. leading t or f is based on time or frequency measurements.
2. Body = related to body movement.
3. Gravity = acceleration of gravity
4. Acc = accelerometer measurement
5. Gyro = gyroscopic measurements
6. Jerk = sudden movement acceleration
7. Mag = magnitude of movement

__mean__ and __SD (standard deviation)__ are calculated for each subject. For each activity, the mean and SD measurements, the units given are:
1. g’s for the accelerometer 
2. rad/sec for the gyro and g/sec 
3. rad/sec/sec for the corresponding jerks.

These signals were used to estimate variables of the feature vector for each pattern:
‘-XYZ’ is used to denote 3-axial signals in the X, Y and Z directions. 

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are:

* __mean(): Mean value__
* __std(): Standard deviation__

#Data Set Collection Source:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

#Data Downloading

```r
#Load downloader package
library(downloader)

#Download and put zip file into data folder (Get_Clean_Data) (under working directory to be set by user)

if(!file.exists("./Get_Clean_Data")){dir.create("./Get_Clean_Data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./Get_Clean_Data/Dataset.zip",method="libcurl")

#Unzip file to directory/Get_Clean_Data. 
unzip(zipfile="./Get_Clean_Data/Dataset.zip",exdir="./Get_Clean_Data")
```
##‘UCI HAR Dataset’ files used:

* Subject
** test/subject_test.txt
** train/subject_train.txt

* Activity
** test/X_test.txt
** train/X_train.txt

* Data
** test/y_test.txt
** train/y_train.txt

* features.txt - Column variables for dataframe /datatable to be created

* activity_labels.txt - For matching class labels with respective activity

##Create data tables after reading in above files:

```r
#Read unzipped datafiles
dataset_path <- file.path("./Get_Clean_Data" , "UCI HAR Dataset")
files<-list.files(dataset_path, recursive=TRUE)
files

#Read data from the files into the variables

#Activity Data
ActivityTest  <- read.table(file.path(dataset_path, "test" , "Y_test.txt" ),header = FALSE)
ActivityTrain <- read.table(file.path(dataset_path, "train", "Y_train.txt"),header = FALSE)

#Subject Data
SubjectTrain <- read.table(file.path(dataset_path, "train", "subject_train.txt"),header =  FALSE)
SubjectTest  <- read.table(file.path(dataset_path, "test" , "subject_test.txt"),header =  FALSE)

#Features Data
FeaturesTest  <- read.table(file.path(dataset_path, "test" , "X_test.txt" ),header = FALSE)
FeaturesTrain <- read.table(file.path(dataset_path, "train", "X_train.txt"),header = FALSE)
```
#1. Merges the training and the test sets to create one data set.
```r
#Merges the training and the test sets to create one data set.

##Concatenate by rows
#Merge all training and the test sets by row binding 
Subject <- rbind(SubjectTrain, SubjectTest)
Activity<- rbind(ActivityTrain, ActivityTest)
Features<- rbind(FeaturesTrain, FeaturesTest)

##Set column names for each feature, subject and activity
names(Subject)<-c("subject")
names(Activity)<- c("activity")
FeaturesNames <- read.table(file.path(dataset_path, "features.txt"),head=FALSE)
names(Features)<- FeaturesNames$V2

##Merge columns to get final data frame, Features_Subj_Act
Sub_Act <- cbind(Subject, Activity)
Features_Subj_Act <- cbind(Features, Sub_Act)
```
