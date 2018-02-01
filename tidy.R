subject_test <- read.table("~/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
y_test <- read.table("~/UCI HAR Dataset/test/y_test.txt", col.names = "activity")
X_test <- read.table("~/UCI HAR Dataset/X_test.txt")
## read the test files
test_data <- cbind(subject_test, y_test, X_test)
## merge the test files
subject_train <- read.table("~/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
y_train <- read.table("~/UCI HAR Dataset/train/y_train.txt", col.names = "activity")
X_train <- read.table("~/UCI HAR Dataset/train/X_train.txt")
## read the train files
train_data <- cbind(subject_train, y_train,X_train)
## merge the train files
total_data <- rbind(test_data, train_data)
## merge the test file and train file
library(dplyr)
total_file <- select(total_data, 1:8)
## Extract the measurements on the mean and standard deviation
names <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
## create a vector use activity names.
total_file$activity <- names[total_file$activity]
## use the above activity names to name the activities
vol_names <- c("subject", "activity", "time.body.accleration.mean.X", "time.body.accleration.mean.Y", 
               "time.body.accleration.mean.Z", "time.body.accleration.std.X", "time.body.accleration.std.Y",
               "time.body.accleration.std.Z")
colnames(total_file) <- vol_names
## name the columns
total_group <- group_by(total_file, subject, activity)
## group the data by subject and activity
tidy_data <- summarize(total_group, time.body.accleration.mean.X = mean(time.body.accleration.mean.X), 
                       time.body.accleration.mean.Y = mean(time.body.accleration.mean.Y), 
                       time.body.accleration.mean.Z = mean(time.body.accleration.mean.Z), 
                       time.body.accleration.std.X = mean(time.body.accleration.std.X), 
                       time.body.accleration.std.Y = mean(time.body.accleration.std.Y), 
                       time.body.accleration.std.Z = mean(time.body.accleration.std.Z))
## caculate the mean of the grouped data
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)
## output the tidy data