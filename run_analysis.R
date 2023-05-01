### Final assignment for Getting and Cleaning Data Coursera course (JHU)
# load required libraries
# reshape2 will be used to melt and cast data to obtain tidy dataset
if (!require(reshape2)) install.packages("reshape2", dependencies=TRUE)
# DOWNLOAD THE DATA
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zip_path <- file.path(getwd(), "data.zip")
download.file(url, zip_path)
unzip(zip_path)

# GET TRAINING and TEST SETS and also their col names, activity labels and subjects
# training and test sets
train <- read.table(file.path(
        getwd(), "UCI HAR Dataset", "train", "X_train.txt"
))
test <- read.table(file.path(
        getwd(), "UCI HAR Dataset", "test", "X_test.txt"
))
# features
features <- read.table(file.path(
        getwd(), "UCI HAR Dataset", "features.txt"
))
# training and test set labels
train_labels <- read.table(file.path(
        getwd(), "UCI HAR Dataset", "train","y_train.txt"
))
# test set labels
test_labels <- read.table(file.path(
        getwd(), "UCI HAR Dataset", "test", "y_test.txt"
))

# training and test set subjects
subjects_train <- read.table(file.path(
        getwd(), "UCI HAR Dataset", "train","subject_train.txt"
))
subjects_test <- read.table(file.path(
        getwd(), "UCI HAR Dataset", "test", "subject_test.txt"
))
# activity labels
activity_label <- read.table(file.path(
        getwd(), "UCI HAR Dataset", "activity_labels.txt"
))

# ADD colnames activity LABELS
# add colnames to both training and test sets
colnames(train) <- features[ ,2]
colnames(test) <- features[ ,2]
# reduce the columns dimensions (mean and sd cols only)
# to extract only means and standard deviations I need 
# to grep columns containing "mean()" and "std()"
required_cols <- grep(
       "(mean|std)\\(\\)", features[ ,2], value=TRUE 
)
train <- train[ ,required_cols]
test <- test[ , required_cols]
# add subjects and activity columns to training and test sets
train <- cbind(subjects_train, train_labels, train)
names(train)[1:2] <- c("subject", "activity")
test <- cbind(subjects_test, test_labels, test)
names(test)[1:2] <- c("subject", "activity")

# 4. MERGE TRAINING and TEST sets
train_test <- rbind(train, test)
# change activity labels
train_test$activity <- factor(
        train_test$activity,
        levels = activity_label[[1]],
        labels = activity_label[[2]]
)

####################
# CREATE SUMMARY DATASET
# we can melt ALL df to have a "thin" dataset that we can easily summarise

train_test_melt <- melt(train_test, id.vars = c("subject", "activity") ,variable.name="variable")
# obtaining summary table with mean measurements
# for each combination of id variables calculate the mean value
summary_table <- dcast(train_test_melt, subject + activity ~ variable, mean)
names(summary_table) <- gsub("\\(\\)", "", names(summary_table))
names(summary_table) <- gsub("^t", "time", names(summary_table))
names(summary_table) <- gsub("^f", "freq", names(summary_table))
names(summary_table) <- gsub("-mean", "Mean", names(summary_table))
names(summary_table) <- gsub("-std", "Std", names(summary_table))
names(summary_table) <- gsub("-", "", names(summary_table))
# write tidy dataset to a text file
write.table(summary_table, "tidy.txt", row.names=FALSE)
###############################################################################
