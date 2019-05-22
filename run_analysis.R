# file: run_analysis.R
# author: David M Larue
# date: May 21, 2019
# purpose:
#   Programming Course Project
#   Getting and Cleaning Data
#   Data Science Series
#   Johns Hopkins University
#   Coursera
#   https://www.coursera.org/learn/data-cleaning/home/welcome
# auxiliary files:
#   getfiles.R (optional file to automate retrieval and placement of data files)
#   notes.txt (optional various notes from discussion forums)
#   README.md (required readme)
#   CodeBook.md (required codebook)
#
# We acknowledge the source and use of this data via this citation:
#   Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
#
#[1] "date downloaded:"
#[1] "2019-05-21 14:42:05 MDT"
#
# Run by executing in R in this directory: > source ("run_analysis.R")
# required libraries. 
# install.packages("dplyr")
library(dplyr)
#  
# We assume we are already in the working directory with the files
#   activity_labels.txt
#   features.txt
#   features_info.txt
#   README.txt
#   subject_test.txt
#   subject_train.txt
#   X_test.txt
#   X_train.txt
#   y_test.txt
#   y_train.txt
# as well as this R file already present, and that we have started R with this as the working directory.
#
# If we are not, uncomment the following line to retrieve and position the files and set the working directory.
#
###
# source("getfiles.R")


#-----------------

# Read in and bind together the main test and train files X. Store in df.

testdf<-read.table("X_test.txt",header=FALSE,blank.lines.skip=TRUE,stringsAsFactors=FALSE)
dim(testdf)
#[1] 2947  561

traindf<-read.table("X_train.txt",header=FALSE,blank.lines.skip=TRUE,stringsAsFactors=FALSE)
dim(traindf)
#[1] 7352  561

df<-rbind(traindf,testdf)
dim(df)
#[1] 10299   561

#2947 rows each
#value range
#y_test 1:6
#subject_test 1:30

# Read in and bind together the test and train Activity files, y. Store in y.

trainy<-read.table("y_train.txt",header=FALSE,blank.lines.skip=TRUE,stringsAsFactors=FALSE)
testy<-read.table("y_test.txt",header=FALSE,blank.lines.skip=TRUE,stringsAsFactors=FALSE)
y<-rbind(trainy,testy)

# Read in and bind together the test and train Subject files, y. Store in sub.

trainsub<-read.table("subject_train.txt",header=FALSE,blank.lines.skip=TRUE,stringsAsFactors=FALSE)
testsub<-read.table("subject_test.txt",header=FALSE,blank.lines.skip=TRUE,stringsAsFactors=FALSE)
sub<-rbind(trainsub,testsub)

# Read in and store the Activity Labels file, activity_labels. Store in activity_labels.

activity_labels<-read.table("activity_labels.txt",header=FALSE,blank.lines.skip=TRUE,stringsAsFactors=FALSE)

# Convert the Activity file y from numbers to labels. 

y$V1<-with(activity_labels, V2[match(y$V1,V1)])

# Remove the original tables.

rm("testdf","traindf","testsub","trainsub","testy","trainy","activity_labels")

#left with tables df, sub, y

# Read in the original column/variable/measurement names from features. Store in features.

features<-read.table("features.txt",header=FALSE,blank.lines.skip=TRUE,stringsAsFactors=FALSE)
features<-as.tbl(features)

# Keep in featuresselect only those features that have the desired mean(),std() in them.

colnameindex<-features[grep("mean\\(|std\\(",features$V2),1]
featuresselect<-features[unlist(colnameindex),]

# Keep in main data table df only those variables kept in featuresselect. Store in dfc.

df<-as.tbl(df)
dfc<-select(df,colnameindex$V1)
#10299x66

# Clean up the features names: remove () and -; replace initial t and f by time and freq (domains), replace dashes - by dots .

features<-sub("\\()","",featuresselect$V2)
features<-sub("^t","time",features)
features<-sub("^f","freq",features)
features<-gsub("-",".",features)
#66

# Change the default names of the main data set dfc to be those cleaned up names.

names(dfc)<-features

# Give descriptive names to the Activity and Subject tables y and sub.

names(y)<-c("Activity")
names(sub)<-c("Subject")

# Column bind the Subject and Activity columns to the front of the main data table dfc, store in dfcsa.

sub<-as.tbl(sub)
y<-as.tbl(y)
dfcsa<-as.tbl(cbind(sub,y,dfc))

#now we have 10299 of 68, first two columns are Subject number and Activity name.
#Other variable names had mean(),std(), now less the (), in them, and other cleanings.

# Produce the final tidy data table by appropriately grouping and summarizing dfcsa, store in dfcsag.

dfcsag<-group_by(dfcsa,Subject,Activity)
dfcsags<-summarize_at(dfcsag,vars(-group_cols()), mean)

# Remove the source data files from the working directory.

f1=c("activity_labels.txt","features.txt","features_info.txt","README.txt")
 file.remove(f1)
f2=c("subject_test.txt","X_test.txt","y_test.txt")
 file.remove(f2)
f3=c("subject_train.txt","X_train.txt","y_train.txt")
 file.remove(f3)

# Save off the desired final table as the file dfcsags.txt.

write.table(dfcsags,"dfcsags.txt",row.name=FALSE)
View(dfcsags)

# This table is tidy as it has the key Subject and Activity columns, uniquely defining a mean measurement, and the remaining 66 data columns associated with the Subject and Activity choices.

#__END__