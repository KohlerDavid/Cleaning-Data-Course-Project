# Import of data (setwd to folder UCi...)

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

df_test<-cbind(x_test,y_test,subject_test)
df_train<-cbind(x_train,y_train,subject_train)
# merge it to one data set

final_data<-rbind(df_train,df_test)

str(final_data)


# Extraction of all the data which contains mean or std in columnname 
library(dplyr)
selceted_data<- final_data%>%
        select(contains("mean"),contains("std"))
head(selceted_data)      
# add descriptive activity names
final_data_names_activity<-merge(final_data, activities, by= c("code"))
names(final_data_names_activity)

# add appropriate names
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

# caluclate the group mean sorted accroding to activity an subject
mean_group<- final_data_names_activity %>%
        group_by(subject,activity)%>%
        summarise_all(mean)
  
write.table(mean_group, file="solution.txt", row.names = FALSE )         


