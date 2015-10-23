
#Load downloader package
library(downloader)

#Download and put zip file into data folder (Get_Clean_Data) (under working directory to be set by user)

if(!file.exists("./Get_Clean_Data")){dir.create("./Get_Clean_Data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./Get_Clean_Data/Dataset.zip",method="libcurl")

#Unzip file to directory/Get_Clean_Data. 
unzip(zipfile="./Get_Clean_Data/Dataset.zip",exdir="./Get_Clean_Data")

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

#############################################################################################################################
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
#############################################################################################################################

#############################################################################################################################
#Extracts only the measurements on the mean and standard deviation for each measurement.

##Filter columns under Features via wildcard entries of measurements for the mean and standard  deviation
## i.e. grep to get index (vector)
##Based on "mean", "std"
Mean_SD<- grep(".*mean.*|.*std.*", names(Features_Subj_Act))
##OR
## Mean_SD<- grep(".*mean.*|.*std.*", FeaturesNames[,2])

##Extracting useful columns
Selected_Features<-Features_Subj_Act[,Mean_SD]

##Binding columns to form eventual dataframe / datatable
Table_Mean_SD<-cbind(Selected_Features, Sub_Act)

#Convert all column names to lowercase to conform to conventions 
tolower(names(Table_Mean_SD))
#############################################################################################################################

#############################################################################################################################
#Uses descriptive activity names to name the activities in the data set

##Extracting activity name from activity_labels file
Activity_Labels <- read.table(file.path(dataset_path, "activity_labels.txt"),head=FALSE)


##Factor Table_Mean_SD$activity using labels in activity_labels
Table_Mean_SD$activity <- factor(Table_Mean_SD$activity, levels = Activity_Labels[ ,1], labels  = Activity_Labels[ ,2])
#######################################################################################

#######################################################################################
#Appropriately labels the data set with descriptive variable names.

##leading t is replaced with time
##leading f is replaced with frequency.
##Body = related to body movement. i.e, BodyBody is cleaned up with body
##Gravity is used for acceleration of gravity
##Acc is used accelerometer measurement, and thus replaced by accelerometer
##Gyro is used for gyroscopic measurements, and thus replaced by gyroscope
##Jerk = sudden movement acceleration
##Mag is used for magnitude of movement, and thus replaced by magnitude
#mean and SD are calculated for each subject for each activity 
#for each mean and SD  measurements. 
#The units given are g’s for the accelerometer and rad/sec 
#for the gyro and g/sec  and rad/sec/sec for the corresponding jerks.

names(Table_Mean_SD)<-gsub("std()", "sd", names(Table_Mean_SD))
names(Table_Mean_SD)<-gsub("mean()", "mean", names(Table_Mean_SD))
names(Table_Mean_SD)<-gsub("^t", "time", names(Table_Mean_SD))
names(Table_Mean_SD)<-gsub("^f", "frequency", names(Table_Mean_SD))
names(Table_Mean_SD)<-gsub("Acc", "accelerometer", names(Table_Mean_SD))
names(Table_Mean_SD)<-gsub("Gyro", "gyroscope", names(Table_Mean_SD))
names(Table_Mean_SD)<-gsub("Mag", "magnitude", names(Table_Mean_SD))
names(Table_Mean_SD)<-gsub("BodyBody", "body", names(Table_Mean_SD))

#Convert all column names to lowercase to conform to conventions 
tolower(names(Table_Mean_SD))
#############################################################################################################################


#############################################################################################################################
#From the data set in step 4, creates a second, 
#independent tidy data set with the average of each variable for #each activity and each  subject

##Arrange data frame with respect to subject and then activity
Table_Mean_SD <-Table_Mean_SD[order(Table_Mean_SD$subject,Table_Mean_SD$activity),]

##Load plyr package
library(plyr)

##Aggregate with respect to subject and activity
tidy_data <- ddply(Table_Mean_SD,.(subject,activity),colwise(mean))
##OR
## tidy_data <- ddply(Table_Mean_SD, .(subject, activity), .fun=function(x){ colMeans(x[,-c (87:88)]) })


##Write tidy_data into a table 
##write.table(tidy_data, file = "tidy_data.txt",row.name=FALSE)
write.table(tidy_data,file.path("./Get_Clean_Data" , "tidy_data.txt"),row.name=FALSE)

#############################################################################################################################
