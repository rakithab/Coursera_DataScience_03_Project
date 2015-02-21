# Coursera_DataScience_03_Project
course03_Project repository contains following files
* README.md
* run_analysis.R
* code_book.txt

The main script is run_analysis.R and this file needs the directory UCI HAR Dataset in the working directory. The zip file containing this directory can be downloaded from,

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Inputs to the main script are in UCI HAR Dataset/train and CI HAR Dataset/test/ directories

To generate the output,

1. Extract the zip file into working directory
2. Run the R script - source("run_analysis.R")
3. Output will be saved to a text file - average_subject_activity.txt
4. Output can also be accessed via data frame - average_df
