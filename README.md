Coursera - Cleaning - Wk4

This is the readme file for the final assignment of the Getting and Cleansing Course on Coursera

This repository contains:

    run_analysis.R --> performes all the necessary tasks (described below in more detail)
    the Codebook describes what kind of data table were used and who the procedured was done in detail
    Solution.txt the result -->  group means of subject and activity
    

The actual data files are not included; they can be found over here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


# Cleaning-Data-Course-Project
#Description to the performed exercise

#Merges the training and the test sets to create one data set:

#In a first step all the date was loaded for the directory.
#The respective column names were specified in the read.table function.
#The column names for the x_test and x_train where taken form the text file "feature"

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")



#Then the data was from test and also training were put in on respetive data frame. 
df_test<-cbind(x_test,y_test,subject_test)
df_train<-cbind(x_train,y_train,subject_train)
#Subsequently these data frames where merged.
final_data<-rbind(df_train,df_test)

#Extracts only the measurements on the mean and standard deviation for each measurement:

#the select function from the library dplyr was used to extract all the columns which contain the word "mean"
#and "std"

selceted_data<- final_data%>%
        select(contains("mean"),contains("std"))
head(selceted_data)

#Uses descriptive activity names to name the activities in the data set:

#The merge function was used to attribute to the desiription of each activity to the respective code which was already
#in the data frame. that this worked was check with the fuction names

final_data_names_activity<-merge(final_data, activities, by= c("code"))
names(final_data_names_activity)



#Appropriately labels the data set with descriptive variable names:

#To do that all teh abrrivations where exchange with the full name. therefore the function gsub was used to 
#search for a specific letlter /letters at a certain postion of the column names. --> Tidy data

names(final_data_names_activity)<-gsub("Acc", "Accelerometer", names(final_data_names_activity))
names(final_data_names_activity)<-gsub("angle", "Angle", names(final_data_names_activity))
names(final_data_names_activity)<-gsub("BodyBody", "Body", names(final_data_names_activity))
names(final_data_names_activity)<-gsub("Gyro", "Gyroscope", names(final_data_names_activity))
names(final_data_names_activity)<-gsub("gravity", "Gravity", names(final_data_names_activity))
names(final_data_names_activity)<-gsub("Mag", "Magnitude", names(final_data_names_activity))

names(final_data_names_activity)<-gsub("^t", "Time", names(final_data_names_activity))
names(final_data_names_activity)<-gsub("^f", "Frequency", names(final_data_names_activity))
names(final_data_names_activity)<-gsub("tBody", "TimeBody", names(final_data_names_activity))
names(final_data_names_activity)<-gsub("-mean()", "Mean", names(final_data_names_activity), ignore.case = TRUE)
names(final_data_names_activity)<-gsub("-std()", "STD", names(final_data_names_activity), ignore.case = TRUE)
names(final_data_names_activity)<-gsub("-freq()", "Frequency", names(final_data_names_activity), ignore.case = TRUE)

#check the new names
str(final_data_names_activity)

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity #and each subject.

#First the tidy data was group according to the subject and activity then the summarise_function was used to determine the #column mean.

mean_group<- final_data_names_activity %>%
        group_by(subject,activity)%>%
        summarise_all(mean)
  
write.table(mean_group, file="solution.txt", row.names = FALSE )  

