# Read Me - Overview of Project and Files
This is my submission for the final project for JHU's Getting and Cleaning Data Course Project on Coursera. The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

The data for this project comes from UCI's archives: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. It represents accelerometer data from smartphones intended to be used for wearable computing.

In this repo you will find:

1. A CodeBook.md file that describes the dataset and transformations applied to it.
2. A run_analysis.r script that performs said transformations (see below for further details).
3. The output tidy dataset, tidydataset.csv.

In this project, the original dataset is tidied and processed according to the course instructor's instructions. The script, run_analysis.r accomplishes the following:

1. Merges the training and the test sets (measurements, activities, and subjects) to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set according to the provided labels.
4. Cleans up the variable labels, particularly removing parenthesis and other symbols that obscure the text.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Script Description

The script reads the data from UCI's original file arrangement, pulling from the appropriate sub-folders using read.delim() and a custom function fixMergeData() that reads the files using readLines(). The latter is done to fix spacing issues present in the original data set. In particular, there are extraneous spaces present throughout, preventing read.delim() or similar functions from properly reading the files.  

readLines is used to read each whole file and then passed to fixSpaces(), which removes the bad spaces, and then to read.table. Test and train sets are then combined using rbind().

After this, the activity labels from UCI's original set are used to replace the integer stand-ins and then formatted using tolower(). The column names are also tidied up.

Lastly, the script uses a group_by() function to group the data by subject and then activity. The rest of the data are summarized by mean().