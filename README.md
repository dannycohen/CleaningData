# Course Project: Getting and Cleaning Data 

## Introduction

The [run_analysis.R](run_analysis.R) script contains the script that performs steps 1-5 of the course project.

The script itself is structured so that it includes a section for each step, with comments within the code explaining its purpose and actions.


## Directory structure

In the [run_analysis.R](run_analysis.R) script I assume the script is located in the parent directory of ```UCI HAR Dataset``` directory (the directory that contains the ```test``` and ```train``` sub-directories as well as related files.

The expected directory structure is as follows:     

```
\run_analysis.R
\UCI HAR Dataset\*.*
\UCI HAR Dataset\test\*.*
\UCI HAR Dataset\train\*.*
```

## Library dependencies

* ```dplyr```


## Step-by-step Description of Script

#### Step 1: Merges the training and the test sets to create one data set

1. Load the ```train``` and ```test``` data into data tables
* 3 files are loaded for each: 
   * The data itself (train / test)
   * The Labels (i.e. the Activity codes, numeric range 1:6)
   * The Subjects (i.e. test subject identifiers, as numeric with range 1:30)
* Bind the Labels and Subject columns as new columns of the ```train``` and ```test``` sets (accordingly)
* Bind the rows of test and train data sets into a single data set, appropriately named ```allData```
* Loaded the descriptive header names and assign them to the ```allData``` data set 
   * (this was required in step 4, but I decided to do this in this step since it feels more aesthetic to have proper column names on a data set)

#### Step 2: Extracts only the measurements on the mean and standard deviation for each measurement

I used the ```apply``` function to calculate the ```mean``` and ```sd``` of all measurements columns:

```
> apply(allData[1:561], 2, mean)  
> apply(allData[1:561], 2, sd)
```

I restricted the column range to 1:561 since I added (in step 1) two columns (562:563 for Activity and Subject info).

The result of this step is that the mean and standard deviation of every measurement column is printed to the console. 

#### Step 3: Uses descriptive activity names to name the activities in the data set

In this step I add the proper values for activities (i.e. mapping the activity codes 1:6 to an activity name like "WALKING", "SITTING" etc.)

This is done using the ```dplyr``` library's ```inner_join``` function. 

The inner join is performed based on identical column names ("Activity") and a identical row counts in the two joined sets. 


#### Step 4: Appropriately labels the data set with descriptive variable names

This was done in step 1, as described above. 


#### Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

Using the ```dplyr``` library's ```aggregate``` function, I calculate the average (mean) of every measurement, grouped by Activity and Subject.

This means that for 6 activities, and 30 subjects, there will be 180 rows (6x30) in the resulting data set, each containing the average measurements for a specific activity performed by a specific subject.

The resulting data set was saved using ```write.table``` function as a tab separated text file named "meanByActivityAndSubject.txt", and uploaded to using the Coursera web site's user interface.


     
         