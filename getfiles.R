# file: getfiles.R
# author: David M Larue
# date: May 21, 2019
# purpose:
#   Programming Course Project
#   Getting and Cleaning Data
#   Data Science Series
#   Johns Hopkins University
#   Coursera
#   https://www.coursera.org/learn/data-cleaning/home/welcome
#

# This is an optional auxilliary file to the main run_analysis.R which, if uncommented there or run stand-alone, obtains the remotely sourced data files as a .zip file, creates the appropriate directory structure and places the files where run_analysis.R can see them.

# Set the main working directory as desired. Assume we are there, uncomment and modify as needed.
### mainDir <- "C:/Users/david/Documents/R/datasciencecoursera/datascience-course3-week4-project"
mainDir<-"."
# Create if needed, and change to the data subdirectory.
subDir <- "data"

setwd(mainDir)
if (file.exists(subDir)){
    setwd(file.path(mainDir, subDir))
 } else {
    dir.create(file.path(mainDir, subDir))
    setwd(file.path(mainDir, subDir))
}

print(paste(c("data working directory: ",getwd())))

# Grab the remote data zip file,unpack it into its own directory. Note the date retrieved.
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile<-"UCI-HAR-Dataset.zip"
download.file(url,destfile)
print("date downloaded:"); print (Sys.time())
#[1] "date downloaded:"
#[1] "2019-05-21 14:42:05 MDT"
zipF<-destfile
outDir<-"."
unzip(zipF,exdir=outDir)

# Copy the need text files into the main working directory,and change to it.
setwd("UCI HAR Dataset")
f1=c("activity_labels.txt","features.txt","features_info.txt","README.txt")
file.copy(f1,"../..")
setwd("test")
f2=c("subject_test.txt","X_test.txt","y_test.txt")
file.copy(f2,"../../..")
setwd("../train")
f3=c("subject_train.txt","X_train.txt","y_train.txt")
file.copy(f3,"../../..")
setwd("../../..")

# Verify where we are:
print(getwd())
