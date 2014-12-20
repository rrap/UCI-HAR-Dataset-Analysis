##
## This R script reads the UCI HAR Dataset, and creates new tidy datasets from the original one
##


##
## Read the activity labels
##
activity_lables<-read.table("UCI HAR Dataset/activity_labels.txt")

##
## Read the training sets and replace the activity labels with meaningful names
##
train_subjects<-read.table("UCI HAR Dataset/train/subject_train.txt")
train_Xdata<-read.table("UCI HAR Dataset/train/X_train.txt")
train_Ydata<-read.table("UCI HAR Dataset/train/y_train.txt")
sapply(train_Ydata, function(x) {activity_lables[x,2]})

train_total <- cbind(train_Xdata, train_subjects, train_Ydata)

##
## Read the test sets and replace the activity labels with meaningful names
##
test_subjects<-read.table("UCI HAR Dataset/test/subject_test.txt")
test_Xdata<-read.table("UCI HAR Dataset/test/X_test.txt")
test_Ydata<-read.table("UCI HAR Dataset/test/y_test.txt")
sapply(test_Ydata, function(x) {activity_lables[x,2]})

test_total <- cbind(test_Xdata, test_subjects, test_Ydata)

##
## Merge the training and test sets
##
combined_set <- rbind(train_total, test_total)

##
## Read the feature labels and prepare columns to extract for mean and std
##
features<-read.table("UCI HAR Dataset/features.txt")
meanCols <- features[grep("mean\\(\\)", features[,2]), 1]
stdCols <- features[grep("std\\(\\)", features[,2]), 1]
colsToExtract <- c(meanCols, stdCols, 562, 563)

##
## Extract the mean and std columns
##
miniDF <- combined_set[colsToExtract]

##
## Create descriptive column names 
## (first remove the subjectID and Activity columns which do not appear in the features table)
##
cols<-colsToExtract[1:(length(colsToExtract)-2)]
colnames(miniDF) <- c(as.character(features[cols,2]), "SubjectID", "Activity")

##
    ## Create a new tidy dataset with the average of each variable for each activity and each subject
##
tidy_df <- aggregate(. ~ SubjectID + Activity, data = miniDF, FUN = "mean")
write.table(tidy_df, "tidy.txt", row.names=FALSE)
