CodeBook for Tidy UCI HAR Dataset
=================================

This CodeBook describes the filtering of data resulting in the output of the `run_analysis.R` script. 
The output is created in a file tidy.txt which can be read using the following command.

```R
tidy_data <- read.table("tidy.txt")
```

The script reads and processes the University of California Irvine's (UCI's) dataset for Human Activity Recognition (HAR) using smartphones that can be used for further research and analysis. The original UCI HAR Dataset is a public domain dataset built from the recordings of subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensor (see http://archive.ics.uci.edumldatasetsHuman+Activity+Recognition+Using+Smartphones).

The script performs the following actions:
### Read and combine training and test data sets
* Reads the activity labels contained in the file activity_labels.txt (data frame 6x2 containing the integer value and correstponding name of each activity)
* Reads the training sets: subject_train (7352 subject IDs), X_train (7352 samples x 561 features), y_train (7352 activity IDs)
* Replaces the activity IDs column with meaning activity lables
* Adds the subject IDs and activity IDs to the features dataset as columns 562 and 563
* Performs previous steps for the test set which contains 2947 samples of subject IDs, features and activity IDs.
* Combines the training and test sets into one set (called combined_set)

### Extract the mean and std columns only
* The feature table is read
* The combined set is reduced by extracting only the measurements on the mean and standard deviation for each measurement. The relevant columns are extracted in the following way:
```R
meanCols <- features[grep("mean\\(\\)", features[,2]), 1]
stdCols <- features[grep("std\\(\\)", features[,2]), 1]
```
* The column names are made meaningful feature names, as read from the feature table, combined with the two column names of "SubjectID", "Activity"
The result of this step is a 10299 x 68 table (miniDF) that contains both the training and test samples for the mean and std features (66) + the activity and subject columns

### Create a new tidy dataset with the average of each variable for each activity and each subject
* An average is calculated per subject ID (30) and activity ID (6) on all features (561) in the previous table, miniDF.
```R
tidy_df <- aggregate(. ~ SubjectID + Activity, data = miniDF, FUN = "mean")
```
* The result table is written to a file called "tidy.txt" (dims - 180x68)