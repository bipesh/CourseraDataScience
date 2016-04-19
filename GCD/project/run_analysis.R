## Requirements

## This r program does following
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Design

## Steps required to accomplish this
## 1. Read subject data from 'subject_train.txt' dataset and create a vector 
## 2. Read 'y_train.txt' dataset and create a vector by replacing activity number codes by activity labels 
## 3. Read 'X_train.txt' dataset and calculate mean and standard deviation for data on each column. Store as separate vectors 
## 4. Merge above three to create data frame with four columns "Subject", "Activity", "Mean", "SD" 
## 5. Repeat steps 1-3 for test data set.
## 6. Merge and sort train and test result data frames
## 7. Export merged data frame as tidy data file

## Implementation

## 1 Training Data
## 1.1 Process Features
features_file = "./data/features.txt"
features <- read.table(features_file, stringsAsFactor=FALSE)
names(features) <- c("rownum","feature")
mean_features <- features[grep("mean()", features$feature, fixed = TRUE),]
std_features <- features[grep("std()", features$feature, fixed = TRUE),]
features <- rbind(mean_features,std_features)
features <- features[order(features$rownum),]

## 1.2 Process Subjects
subject_train_file = "./data/train/subject_train.txt"
subject_train <-  read.table(subject_train_file, stringsAsFactor=FALSE)
names(subject_train) <- c("Subject")

## 1.3 Process Activity data
y_train_file = "./data/train/y_train.txt"
## convert activity by respective labels
y_train <-  read.table(y_train_file, stringsAsFactor=FALSE)
ysize <- length(y_train[,1])
for (i in 1:ysize) {
  y_train[i,1] <- switch(y_train[i,1], 
                         "1"="WALKING",
                         "2"="WALKING_UPSTAIRS",
                         "3"="WALKING_DOWNSTAIRS",
                         "4"="SITTING",
                         "5"="STANDING",
                         "6"="LAYING")
}
names(y_train) <- c("Activity")

## 1.4 Process activity results
x_train_file = "./data/train/X_train.txt"
x_train <-  read.table(x_train_file, stringsAsFactor=FALSE, sep = "")
x_train_avg <- x_train[,features$rownum]
names(x_train_avg) <- features$feature

## 1.5 Merge columns to get tidy training data
train_dataset <- cbind(subject_train, y_train, x_train_avg)


## 2 testing Data
## 2.1 Process Features
features_file = "./data/features.txt"
features <- read.table(features_file, stringsAsFactor=FALSE)
names(features) <- c("rownum","feature")
mean_features <- features[grep("mean()", features$feature, fixed = TRUE),]
std_features <- features[grep("std()", features$feature, fixed = TRUE),]
features <- rbind(mean_features,std_features)
features <- features[order(features$rownum),]

## 2.2 Process Subjects
subject_test_file = "./data/test/subject_test.txt"
subject_test <-  read.table(subject_test_file, stringsAsFactor=FALSE)
names(subject_test) <- c("Subject")

## 2.3 Process Activity data
y_test_file = "./data/test/y_test.txt"
## convert activity by respective labels
y_test <-  read.table(y_test_file, stringsAsFactor=FALSE)
ysize <- length(y_test[,1])
for (i in 1:ysize) {
  y_test[i,1] <- switch(y_test[i,1], 
                        "1"="WALKING",
                        "2"="WALKING_UPSTAIRS",
                        "3"="WALKING_DOWNSTAIRS",
                        "4"="SITTING",
                        "5"="STANDING",
                        "6"="LAYING")
}
names(y_test) <- c("Activity")

## 2.4 Process activity results
x_test_file = "./data/test/X_test.txt"
x_test <-  read.table(x_test_file, stringsAsFactor=FALSE, sep = "")
x_test_avg <- x_test[,features$rownum]
names(x_test_avg) <- features$feature

## 2.5 Merge columns to get tidy testing data
test_dataset <- cbind(subject_test, y_test, x_test_avg)

## merge and sort train and test results
final_result <- rbind(train_dataset,test_dataset)
final_result <- final_result[order(final_result$Subject),]
write.table(final_result,file="tidy_data.txt",row.names=FALSE)
