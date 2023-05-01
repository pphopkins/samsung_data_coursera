# **GETTING AND CLEANING DATA - COURSERA ASSIGNEMENT**

The dataset used for this project represent data collected from the
accelerometers from the Samsung Galaxy S smartphone. The full
description can be found here:
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>
and the dataset can be found here:
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

The purpose of this assignment was to create R script called
"run_analysis.R" that does the following:

1.  Merges the training and the test sets to create one data set.

2.  Extracts only the measurements on the mean and standard deviation
    for each measurement.

3.  Uses descriptive activity names to name the activities in the data
    set

4.  Appropriately labels the data set with descriptive variable names.

5.  From the data set in step 4, creates a second, independent tidy data
    set with the average of each variable for each activity and each
    subject.

## Content of this repository

This repository contains the following files:

1.  ***run_analysis.R***

This is the main script which processes the data. Place the script in a
folder of your choice (ideally, an empty one) and run it. The required
Samsung phone dataset will be downloaded automatically.

Requirements: rshape2 package is required. If you don't have it
installed on your machine, the script will try to install it
automatically.

Description:

-   Samsung phone accelerometers datasets (including metadata) is
    downloaded and unzipped into the directory where the script is
    present
-   relevant datasets are loaded into R (see the comments in the script)
-   training and test sets are assigned column names from *features*
    object
-   only the features that represent mean measurements or their standard
    deviations are kept for both the training and test sets
-   two id columns are added to both training and test sets
    -   "subject" represents the subject id
    -   "activity" represents the type of activity (6 different types)
-   training and test sets are merged
-   "activity" column is converted to a factor with meaningful activity
    labels
-   for each combination of id variable mean values of each feature are
    calculated
-   column names are cleaned
-   the tidy dataset is saved into a text file

2.  ***README.md***

The file you are reading. It contains a brief description of the project
and the files descriptions

3.  ***code_book.md***

Describes transformations of the features, units and columns names

4.  ***tidy.txt***

The output of the analysis

