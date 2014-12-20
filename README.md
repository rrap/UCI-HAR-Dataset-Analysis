
This repo contains:
* run_analysis.R - an R script that can be used to analysis the UCI HAR Dataset (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
The script converts it to a tidy data set.
* CodeBook.md - describes the transformations that are done and the clean up that was performed on the data.

## The script

The run_analysis.R script does the following
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Running the script
```R
source("run_analysis.R")
```

The script expects the HAR dataset to be present in the working directory under the "UCI HAR Dataset" directory

The script saves the output in a file called "tidy.txt". It can be loaded back into R using the following command

```R
tidy_data <- read.table("tidy.txt")
```
