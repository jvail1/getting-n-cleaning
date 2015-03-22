# Data cleaning script for course project

# First load useful packages:
library(dplyr)

# Load all three parts of the test data into data frames:
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# Combine these into one thing:
All_test <- cbind(X_test, subject_test, y_test)

# Load all three parts of the training data into data frames:
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

# Combine these into one thing:
All_train <- cbind(X_train, subject_train, y_train)

# Load the features list and extract the right rows from it:
features <- read.table("features.txt", stringsAsFactors = FALSE)
colnames(features) <- c("vecnum", "vecfeature")
rows <- filter(features, grepl("std", vecfeature)|grepl("mean", vecfeature))
rows <- filter(rows, !grepl("Freq", vecfeature))

# Add extra rows for the subject and activity IDs:
extra_rows <- data.frame(c(562, 563), c("subject_id", "activity_id"))
colnames(extra_rows) <- c("vecnum", "vecfeature")
finalrows <- rbind(rows, extra_rows)

# Next to filter the test and train data tables:
colnames(All_test) <- c(1:563)
test_selection <- select(All_test, finalrows$vecnum)

colnames(All_train) <- c(1:563)
train_selection <- select(All_train, finalrows$vecnum)

# Combine the filtering results:
TestnTrain <- rbind(test_selection, train_selection)

# Clean names from finalrows and name TestnTrain:
valid_names <- make.names(finalrows$vecfeature, unique = TRUE, allow_ = TRUE )
colnames(TestnTrain) <- valid_names

# Use descriptive activity names to name the activities in the data set
activity_names <- read.table("activity_labels.txt", stringsAsFactors = FALSE)
colnames(activity_names) <- c("activity_id", "activity_name")
TestnTrain <- merge(TestnTrain, activity_names, by.x = "activity_id", by.y = "activity_id", all.x = TRUE)

# Create a new table of a second data set, with the average of each variable for each activity and subject
# Make a character vector of columns to take means of:
mean_cols <- valid_names[1:66]

# Use summarise_each_ and group_by to get the final table:
niftable <- TestnTrain %>% group_by(activity_name, subject_id)
finaltable <- niftable %>% summarise_each_(funs(mean), mean_cols)
write.table(finaltable, file = "secondtidydata.txt", row.names = FALSE)
