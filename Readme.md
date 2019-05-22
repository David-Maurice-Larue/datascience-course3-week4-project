---
title: "Readme"
author: "David M Larue"
date: "May 21, 2019"
output: html_document
---
<em>File:</em>  
  Readme.R  
  
<em>Purpose:</em>  

* Programming Course Project  
* Getting and Cleaning Data  
* Data Science Series  
* Johns Hopkins University  
* Coursera  
* <https://www.coursera.org/learn/data-cleaning/home/welcome>  
   
<em>auxiliary files:<em>  

* run_analysis.R (script to clean and summarize data)  
* getfiles.R (optional file to automate retrieval and placement of data files)  
* notes.txt (optional various notes from discussion forums)  
* CodeBook.md (required codebook/description of variables)  

 We acknowledge the source and use of this data via this citation:  
 
> Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
> Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.
> International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

 Run by executing in R in this directory: > source ("run_analysis.R")  
 Note that dplyr is a required library.

 We assume we are already in the working directory with the downloaded data and info files  
 
 * activity_labels.txt
 * features.txt
 * features_info.txt
 * README.txt
 * subject_test.txt
 * subject_train.txt
 * X_test.txt
 * X_train.txt
 * y_test.txt
 * y_train.txt
 as well as the R file run_analysis already present, and that we have started R with this as the working directory. (If not, the file getfiles.R can fetch and place them.)

After the file dfcsags.txt is created,it may be later read in and viewed by  

* dfcsags <- read.table("dfcsags.txt", header = TRUE)  
* View(dfcsags)

The raw data was obtained via the auxilliary getfiles.R file on this date:  
"date downloaded:"  
"2019-05-21 14:42:05 MDT"  

The run_analysis.R file does the following:

* Adds the library "dplyr"  
* Optionally obtains and places the above text files (by running getfiles.R).  
* Uses read.table to read in the the test and train data (from X,y,subject files).  
* rbinds the test data after the train data to produce the initial data frame df.  
* rbinds the test y and sub after the train data to produce the initial y and sub..  
* reads in the activity_labels file and replaces the numberic designators in y by the appropriate human readable values.  
* reads in the original data column names from the features file.  
* selects from those original names those that include mean() or std().  
* creates dfc from df containing only those 66 columns in features list.  
* modifies the names to expand t and f to time and frequency, remove parentheses (), and replacedashes - by dots . This is stored in features.  
* adds the column names to the main data table, dfc. 
* uses cbind on y, sub and dfc to prepend the Subject and Activity to the data frame dfc to make dfcsa. 
* group by Subject and Activity the data dfcsa to make dfcsag.  
* summarize using mean all the data where Subect and Activity are equal, to make dfcsags  
* use write.table to make a text-file version of dfcsags.

At this point we hav the fie dfcsags.txt, which is a tidy file (unique identifier combo of Subject & Activity; 66 variable columns that are distinct data collected around the same time and represent means of the given data for those Subject and Activity value) meeting the requirements of the project.