# 1) Download the data ----
# download the .zip folder from the internet
downloaded_file <- "Course_Project_3_Data.zip"
if (!file.exists(downloaded_file)){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", downloaded_file)
}

# unzip the data if it's not already unzipped
if (!file.exists("UCI HAR Dataset")){
  unzip(downloaded_file)
}


# 2) Load required packages (and install if not already installed) ----
if (!require(data.table)){
  install.packages("data.table")
}
if (!require(janitor)){
  install.packages("janitor")
}
if (!require(magrittr)){
  install.packages("magrittr")
}
if (!require(tidyverse)){
  install.packages("tidyverse")
}


# 3) Read in the data ----
# identifiers 
activity_labels <- fread("UCI HAR Dataset/activity_labels.txt")
features <- fread("UCI HAR Dataset/features.txt")

# training files 
train_data <- fread("UCI HAR Dataset/train/X_train.txt")
train_labels <- fread("UCI HAR Dataset/train/y_train.txt")
train_subjects <- fread("UCI HAR Dataset/train/subject_train.txt")

# test files
test_data <- fread("UCI HAR Dataset/test/X_test.txt")
test_labels <- fread("UCI HAR Dataset/test/y_test.txt")
test_subjects <- fread("UCI HAR Dataset/test/subject_test.txt")

# 4) Clean up the data ----
# training cleaning
train_data_cleaned <- train_data %>%
  # set column names to feature names
  set_colnames(features$V2) %>%
  # remove special characters from column names
  clean_names() %>%
  # attach activity label identifiers 
  cbind(train_labels) %>%
  rename(activity_label_id = V1) %>%
  # join to activity label names
  left_join(activity_labels, by = c("activity_label_id" = "V1")) %>%
  rename(activity = V2) %>%
  relocate(c(activity_label_id, activity)) %>%
  # attach subject identifiers
  cbind(train_subjects) %>%
  rename(subject_id = V1) %>%
  relocate(subject_id)

# test cleaning
test_data_cleaned <- test_data %>%
  # set column names to feature names
  set_colnames(features$V2) %>%
  # remove special characters from column names
  clean_names() %>%
  # attach activity label identifiers 
  cbind(test_labels) %>%
  rename(activity_label_id = V1) %>%
  # join to activity label names
  left_join(activity_labels, by = c("activity_label_id" = "V1")) %>%
  rename(activity = V2) %>%
  relocate(c(activity_label_id, activity)) %>%
  # attach subject identifiers
  cbind(test_subjects) %>%
  rename(subject_id = V1) %>%
  relocate(subject_id)

# 5) Merge the training and test data into a single dataset ----
all_data <- rbind(train_data_cleaned, test_data_cleaned) 

# 6) Extract only the measurements on the mean and standard devitation for each measurement ----
all_data_mean_std <- all_data %>%
  select(subject_id, activity, contains("mean") | contains("std"))

fwrite(all_data_mean_std, "Final Data/combined_data.txt")

# 7) Find average of each variable for each activity and subject ----
var_avgs <- all_data_mean_std %>%
  group_by(subject_id, activity) %>%
  summarise_all(mean) %>%
  ungroup()

fwrite(var_avgs, "Final Data/avgs_by_activity_and_subject.txt")
