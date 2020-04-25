# Cleaning-Data-Course-Project
Description to the performed exercise

Merges the training and the test sets to create one data set:

In a first step all the date was loaded for the directory.
The respective column names were specified in the read.table function.
The column names for the x_test and x_train where taken form the text file "feature"

Then the data was from test and also training were put in on respetive data frame. 
Subsequently these data frames where merged.


Extracts only the measurements on the mean and standard deviation for each measurement:

the select function from the library dplyr was used to extract all the columns which contain the word "mean"
and "std"

Uses descriptive activity names to name the activities in the data set:

The merge function was used to attribute to the desiription of each activity to the respective code which was already
in the data frame. that this worked was check with the fuction names

Appropriately labels the data set with descriptive variable names:

To do that all teh abrrivations where exchange with the full name. therefore the function gsub was used to 
search for a specific letlter /letters at a certain postion of the column names. --> Tidy data

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

First the tidy data was group according to the subject and activity then the summarise_function was used to determine the column mean.



