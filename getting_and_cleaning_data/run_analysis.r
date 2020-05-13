library(data.table)
library(plyr)
library(dplyr)

#import data
x_train = 'project/UCI HAR Dataset/train/X_train.txt'
x_test = 'project/UCI HAR Dataset/test/X_test.txt'

y_train = read.delim('project/UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = " ")
y_test = read.delim('project/UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = " ")

subject_train = read.delim('project/UCI HAR Dataset/train/subject_train.txt', header = FALSE, sep = " ")
subject_test = read.delim('project/UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = " ")


column_names = as.vector(read.delim('project/UCI HAR Dataset/features.txt', header = FALSE, sep=" ")[,2])
activity_labels = read.delim('project/UCI HAR Dataset/activity_labels.txt', header = FALSE, sep=" ")

mean_std_columns = grep('mean|std', column_names) 

# function to fix spaces and merge training and test data; called in fixMergeData()
fixSpaces <- function(line){
  line_fixed = gsub('  ', ' ',line)
  return(gsub('^ ', '', line_fixed))
}

# function to merge x test and train data
fixMergeData <- function(test,train){
  
  lines_test = readLines(test, n=-1,)
  test = read.table(text=fixSpaces(lines_test), header=FALSE, sep=" ",col.names = column_names)
  
  lines_train = readLines(train, n=-1)
  train = read.table(text=fixSpaces(lines_train), header=FALSE, sep=" ",col.names = column_names)
  
  rbind(test,train)[,mean_std_columns]
}

#merge test and train data
x <- fixMergeData(x_test, x_train)
y <- rbind(y_test,y_train)
subjects <- rbind(subject_test, subject_train)

#transform Ys to descriptive activity name
y <- tolower(mapvalues(y$V1, from=as.numeric(activity_labels$V1), to=as.character(activity_labels$V2)))

#clean up data set labels
names(x)[1]
column_names[1]
new_cols = column_names[mean_std_columns]
new_cols = tolower(gsub(pattern = '\\()|-', replacement = '',x=new_cols))
names(x) <- new_cols

#combine y and x; and then fix their labels
df <- cbind(subjects,x,y)
names(df)[names(df) == 'y'] <- 'activity'
names(df)[names(df) == 'V1'] <- 'subject'

##
# 5. Independent Tidy Dataset - Avg of Each Variable for Each Activity & Subject
##
df %>% group_by(subject, activity) %>% summarise_all(mean) -> tidy_dataset
write.csv(tidy_dataset, 'tidy_dataset.csv')
