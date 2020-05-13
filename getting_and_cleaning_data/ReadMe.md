#Read Me - Overview of Project and Files
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
