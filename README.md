=================================================================
Getting and Cleaning Data Course Project README
=================================================================
Kathryn Thompson
=================================================================

The original data was collected from a group of 30 volunteers carrying out six activities, wearing a smartphone on the waist - the original details of the projects are available here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

And the original data files were downloaded from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The new data set produced from this contains the average of each mean and standard deviation variable, from both the training and the test data combined, for each activity and each subject in the experiment. The result is a 180 x 68 table, with decriptive names for the activities and for each variable. 

To create this data set, the original data files were run through the attached script, run_analysis.R. This processes the data in the following steps:

- For the testing data set, loads and combines the original feature vectors with the subject ID information and the activity information into one data frame, All_test, using cbind

- Does the same for the training data set, into one data frame, All_train

- Loads the file containing the names of all the fields in the feature vector, and uses filter and grepl to extract the names and row numbers of the features which are standards or means. Features which were frequency means were excluded, as not being the main mean() or std() values of the signals that were requested.

- Appends (with names) two extra rows to include the subject and activity IDs that were added to the data earlier

- Selects the columns from each of the training and test data sets that match the desired features, matching row numbers of the features table to column numbers of the data sets

- Combines the two data sets into one

- Forces the feature names to be unique and valid, and then uses the list of valid names to descriptively name the columns of the merged test and train data

- Reads the file of activity names, and uses merge with the activity IDs to add descriptive names to each activity type

- Uses summarise_each_ and group_by to get the new data set, and writes it to a file in the working directory named secondtidydata.txt
