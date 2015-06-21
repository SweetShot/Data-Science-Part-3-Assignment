CodeBook
=================================================
This file describes the variables, the data, and any transformations .
Data obtaned from
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones      
The data for the project:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* The run_analysis.R script performs the following steps to clean the data:   
 1. Read X_train.txt, y_train.txt and subject_train.txt from the ".\\data\\train" folder and store them in *train_data*, *train_label* and *train_subject*.       
 2. Read X_test.txt, y_test.txt and subject_test.txt from the ".\\data\\test" folder and store them in *test_data*, *test_label* and *test_subject*.  
 3. Joins *test_data* to *train_data* and saves in data frame *join_data*; Join *test_label* to *train_label* and saves in data frame, *join_label*; joins *test_subject* to *train_subject* and saves in *join_subject*.  
 4. Read the features.txt file and store the data in *features*. only copy the mean and standard deviation. also get a subset of *join_data* with corresponding columns.  
 5. Clean clm names and capitalize first letter.   
 6. Read the activity_labels.txt file in *activity*.  
 7. Clean the activity names in the second column of *activity*.first make all names to lower cases. and change first_second to format firstSecond.  
 8. Transform the values of *join_label* as above.  
 9. Combine the *join_subject*, *join_label* and *join_data* by column save to data frame, *cleaned_data*. name the first two columns, "subject" and "activity". The "subject" colomn contains subject number [1,30]; the "activity" column contains activity names; next columns contains measurements.  
 10. Create a tidy data set with the average of each measurement for each *activity* and each *subject*. Then calculate the mean of each measurement with the corresponding combination. and save that data to *result* using nested for loop.
 11. Write the *result* out to "tidy_data.txt" file in current working directory using row_names = FALSE.
