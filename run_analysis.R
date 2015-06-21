# Merges the training and the test sets to create one data set.
# All Paths are for Windows 
# Read all tabe files after setting working directory
setwd("C:\\Users\\Home\\Downloads\\getdata-projectfiles-UCI HAR Dataset")
train_data <- read.table(".\\data\\train\\X_train.txt")
train_label <- read.table(".\\data\\train\\y_train.txt")
train_subject <- read.table(".\\data\\train\\subject_train.txt")
test_data <- read.table(".\\data\\test\\X_test.txt")
test_label <- read.table(".\\data\\test\\y_test.txt") 
test_subject <- read.table(".\\data\\test\\subject_test.txt")
# Join tables
join_data <- rbind(train_data, test_data)
join_label <- rbind(train_label, test_label)
join_subject <- rbind(train_subject, test_subject)

# Extracts only the measurements on the mean and standard deviation. 
features <- read.table(".\\data\\features.txt")
meanStd <- grep("mean\\(\\)|std\\(\\)", features[, 2])
join_data <- join_data[, meanStd]
# Set names
names(join_data) <- gsub("\\(\\)", "", features[meanStd, 2]) 
names(join_data) <- gsub("mean", "Mean", names(join_data)) 
names(join_data) <- gsub("std", "Std", names(join_data)) 
names(join_data) <- gsub("-", "", names(join_data))  

# Name the data set by labels
activity <- read.table(".\\data\\activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activity_label <- activity[join_label[, 1], 2]
join_label[, 1] <- activity_label
names(join_label) <- "activity"
names(join_subject) <- "subject"
# bind data with labels and take avg of each var in each activity for each subject
cleaned_data <- cbind(join_subject, join_label, join_data)
subject_len <- length(table(join_subject))
activity_len <- dim(activity)[1]
column_len <- dim(cleaned_data)[2]
result <- as.data.frame(matrix(NA, nrow=subject_len*activity_len, ncol=column_len)) 
colnames(result) <- colnames(cleaned_data)
row <- 1
for(i in 1:subject_len) {
  for(j in 1:activity_len) {
    result[row, 1] <- sort(unique(join_subject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    bool1 <- i == cleaned_data$subject
    bool2 <- activity[j, 2] == cleaned_data$activity
    result[row, 3:column_len] <- colMeans(cleaned_data[bool1&bool2, 3:columnLen])
    row <- row + 1
  }
}
# write table and end
write.table(result, "tidy_data.txt")
