####################
#
# This file needs the directory UCI HAR Dataset in the working directory
# run the R script by source("run_analysis.R")
# Inputs are in UCI HAR Dataset/train and CI HAR Dataset/test/ directories
# Output data frame is written to the text file average_subject_activity.txt
#
####################
#First try to merge two data set
#For one data set : train
c1 <- read.table("UCI HAR Dataset/train/subject_train.txt")
c2 <- read.table("UCI HAR Dataset/train/y_train.txt")
cn <- read.table("UCI HAR Dataset/train/X_train.txt")
#Get a data frame with all the columns from three files
df <- cbind(c1,c2,cn)
#For one data set : test
cc1 <- read.table("UCI HAR Dataset/test/subject_test.txt")
cc2 <- read.table("UCI HAR Dataset/test/y_test.txt")
ccn <- read.table("UCI HAR Dataset/test/X_test.txt")
ddf <- cbind(cc1,cc2,ccn)
#Merge two data frames from two data sets
complete_df <- rbind(df,ddf)
#Get list of lables for columns
rb <- read.table("UCI HAR Dataset/features.txt")
column_labels <- rb[,"V2"]
#converts to character array
column_labels <- as.character(column_labels)
#build the label array
first_column_labels = c("subject","activity")
#array with all the labels
all_column_labels <- append(first_column_labels,column_labels)
#Get discriptive names for activity list
activity_table <- read.table("UCI HAR Dataset/activity_labels.txt")
activity_names <- activity_table[,"V2"]
activity_names <- as.character(activity_names)
#Add meaningful names to data frame columns
names(complete_df) <- all_column_labels
#Get a subset of columns only for mean and std values
subset_complete_df <- complete_df[,grep("subject|activity|std|mean",names(complete_df))]
#Replace intiger "activity" number with descriptive names
subset_complete_df[,"activity"] <- activity_names[subset_complete_df[,"activity"]]
#creating set of ids to access the main data set
subject_id = 1:30
activity_id = 1:6
column_id = 3:81
#create empty data frame to save average values
average_df <- data.frame(ncol(81))
rowcount <- 1
#nested for loops to compute the average values for each subject for each activity
for(sbj in subject_id){
  for(acty in activity_id){
    average_df[rowcount,1] <- sbj
    average_df[rowcount,2] <- activity_names[activity_id[acty]]
    for(c in column_id){
      average_df[rowcount,c] <- mean(subset_complete_df[subset_complete_df[,"subject"]==sbj & subset_complete_df[,"activity"]==activity_names[activity_id[acty]],c])
    }
    rowcount <- rowcount + 1
  }
}
#update data frame column names
names(average_df) <- names(subset_complete_df)
write.table(average_df,file="average_subject_activity.txt",row.name=F)

