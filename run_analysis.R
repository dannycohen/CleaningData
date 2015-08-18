## Clear environment
## rm(list = ls())

###################################################################
## 1. Merges the training and the test sets to create one data set.
###################################################################


## Load test & train data

test <- read.table("UCI HAR Dataset/test/X_test.txt")
testLabels <- read.table("UCI HAR Dataset/test/y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

training <- read.table("UCI HAR Dataset/train/X_train.txt")
trainingLabels <- read.table("UCI HAR Dataset/train/y_train.txt")
trainingSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")


## add relevant columns

test <- cbind(test,testLabels,testSubjects)
training <- cbind(training,trainingLabels,trainingSubjects)


## merge test and train sets

allData <-rbind(test,training)


## add header names 

headers <- read.table("UCI HAR Dataset/features.txt") ## load header names from features_info.txt 
headers <- as.vector(headers[,2])
headers <- append(headers,"Activity")
headers <- append(headers,"Subjects")
names(allData) = headers


###################################################################
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
###################################################################

## measurement are columns 1:561; columns 562:563 are added activity and subjects columns
apply(allData[1:561], 2, mean)  
apply(allData[1:561], 2, sd)


###################################################################
## 3. Uses descriptive activity names to name the activities in the data set
###################################################################

activities <- read.table("UCI HAR Dataset/activity_labels.txt") 
names(activities) <- c("Activity", "ActivityName")

library(dplyr)
activities$Activity <- as.numeric(activities$Activity)
allData$Activity <- as.numeric(allData$Activity)
allData <- inner_join(allData,activities)


###################################################################
## 4. Appropriately labels the data set with descriptive variable names. 
###################################################################

## Already done. See "add header names" section above.


###################################################################
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
###################################################################

library(dplyr)
meanByActivityAndSubject <- aggregate(allData[, 1:561], list(ActivityName=allData$ActivityName,Subject=allData$Subject), mean)

## sort by ActivityName and then by Subject
meanByActivityAndSubject <- meanByActivityAndSubject[order(meanByActivityAndSubject$ActivityName ,meanByActivityAndSubject$Subject),] 

write.table(meanByActivityAndSubject, "meanByActivityAndSubject.txt", sep="\t", row.name=FALSE)


