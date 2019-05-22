---
title: "CodeBook"
author: "David Larue"
date: "May 21, 2019"
output: html_document
---


<em>File:</em>  
  CodeBook.R  
  
<em>Purpose:</em>  

* Programming Course Project  
* Getting and Cleaning Data  
* Data Science Series  
* Johns Hopkins University  
* Coursera  
* <https://www.coursera.org/learn/data-cleaning/home/welcome>  

## Selection of variable columns

In this file we detail the meanings of the columns, rows,and values, in the final, submitted table, dtcsag.txt.

The original data came with the following description in the file features_info.txt:

Of the 561 original measurements recorded for combinations of the Subject and the Activity, we have retained the 66 that included "mean()" or "std()" in the name. These measurements come from combinations of the  

* domain of time or frequency [t,f]  
* where the measurement came from, Body or Gravity [Body, Gravity]  
* whether this was a measurement of Acceleration or Gyroscope Angles [Acc,Gyro]  
* whether it was Jerk or not [missing or Jerk]  
* relation of data to raw measurements, as a mean or standard deviation [std])  
* whether it was a spatial direction measurement (X-,Y- and Z-axes), or an overall magnitude (Mag)  

On the face of it this is 128 possible combinations of features of the measured variables (2^5x4). However,  
* gravity has no angular component (Gyro) or jerk, so only the X, Y, Z and magnitude is noted, and only in a time not frequency domain. Hence it contributes only 8 entries (mean or std, and X, Y,Z, or Mag), for a loss of 64-8=56.  
* Additionally, the Body Gyo Jerk combination was, in the frequency domain, only measured in Mag and not in the X,Y,Z directions, for a loss of 6.  
These removals bring us down to the recorded 66 (128-56-6=66).  

As part of the cleaning, the parentheses () were removed from these labels,and the dash was replaced by a dot.

Here are the resulting 66 variable column names:

names(dfcsa)  
 [1] "Subject"                      "Activity"                     "timeBodyAcc.mean.X"           "timeBodyAcc.mean.Y"          
 [5] "timeBodyAcc.mean.Z"           "timeBodyAcc.std.X"            "timeBodyAcc.std.Y"            "timeBodyAcc.std.Z"           
 [9] "timeGravityAcc.mean.X"        "timeGravityAcc.mean.Y"        "timeGravityAcc.mean.Z"        "timeGravityAcc.std.X"        
[13] "timeGravityAcc.std.Y"         "timeGravityAcc.std.Z"         "timeBodyAccJerk.mean.X"       "timeBodyAccJerk.mean.Y"      
[17] "timeBodyAccJerk.mean.Z"       "timeBodyAccJerk.std.X"        "timeBodyAccJerk.std.Y"        "timeBodyAccJerk.std.Z"       
[21] "timeBodyGyro.mean.X"          "timeBodyGyro.mean.Y"          "timeBodyGyro.mean.Z"          "timeBodyGyro.std.X"          
[25] "timeBodyGyro.std.Y"           "timeBodyGyro.std.Z"           "timeBodyGyroJerk.mean.X"      "timeBodyGyroJerk.mean.Y"     
[29] "timeBodyGyroJerk.mean.Z"      "timeBodyGyroJerk.std.X"       "timeBodyGyroJerk.std.Y"       "timeBodyGyroJerk.std.Z"      
[33] "timeBodyAccMag.mean"          "timeBodyAccMag.std"           "timeGravityAccMag.mean"       "timeGravityAccMag.std"       
[37] "timeBodyAccJerkMag.mean"      "timeBodyAccJerkMag.std"       "timeBodyGyroMag.mean"         "timeBodyGyroMag.std"         
[41] "timeBodyGyroJerkMag.mean"     "timeBodyGyroJerkMag.std"      "freqBodyAcc.mean.X"           "freqBodyAcc.mean.Y"          
[45] "freqBodyAcc.mean.Z"           "freqBodyAcc.std.X"            "freqBodyAcc.std.Y"            "freqBodyAcc.std.Z"           
[49] "freqBodyAccJerk.mean.X"       "freqBodyAccJerk.mean.Y"       "freqBodyAccJerk.mean.Z"       "freqBodyAccJerk.std.X"       
[53] "freqBodyAccJerk.std.Y"        "freqBodyAccJerk.std.Z"        "freqBodyGyro.mean.X"          "freqBodyGyro.mean.Y"         
[57] "freqBodyGyro.mean.Z"          "freqBodyGyro.std.X"           "freqBodyGyro.std.Y"           "freqBodyGyro.std.Z"          
[61] "freqBodyAccMag.mean"          "freqBodyAccMag.std"           "freqBodyBodyAccJerkMag.mean"  "freqBodyBodyAccJerkMag.std"  
[65] "freqBodyBodyGyroMag.mean"     "freqBodyBodyGyroMag.std"      "freqBodyBodyGyroJerkMag.mean" "freqBodyBodyGyroJerkMag.std" 

A typical row looks like:

1 STANDING            0.289          -0.0203           -0.133           -0.995           -0.983           -0.914            0.963  ...  


## Addition of Subject and Activity columns

Two more columns were added based on the data's position in the original data set,namely Subject (an opaque identifier from 1 to 30) and an Activity (a human readable choice of 6 activities such as "Walking"). This then made for 68 columns.

Each row represents a selection of both a Subject and an Activity, hence there are 30*6 or 180 rows.

## Averaging of multiple values or rows associated with each Subject/Activity combination

Each combination of a Subject and an Activity may have had associated with it in the original data more than one measurement of each of the 66 variables. There were 10,299 rows in the combined train/test data sets. These were averaged to give a single value in each column of the 66 variables for each of the Subject/Activity combinations. All the original data had been normalized, so there are no units associated with them.

## Noting that the table is "Tidy"

We note that there are two columns that together give a unqiue measurement, Subject and Activity. And that for each combination of Subject and Activity, there are 66 variables representing the averages of 66 original data variables, which themselves were averages or standard deviations of raw measured data (some derived, such as magnitude in the presence of x, y, and z components). The column labels are human readable, as are the values in the table (numbers and Activity names), save for the opaque Subject values which are numbers from 1 to 30.