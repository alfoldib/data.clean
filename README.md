## The code - README

### Summary

The run_analysis.R cleans the initial dataset, which can be found at: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 


The code consist of 8 parts, each clearly labeled. The parts are:
* Preparation
* Getting column names and activity labels 
* Getting train data
* Getting test data
* Merging datasets
* Adding descriptive activity names
* Adding descriptive activity variable names
* Aggregation

### Preparation
This part loads the required packages for the analysis, and sets the working directory to the path i downloaded the dataset.

### Getting column names and activity labels 
This part loads the activity and column names, and stores them in objects.

### Getting train data
Loads the train dataset and combines the IDs. Then removes every not used columns, and adds a variable identifying that it is the train part of the dataset.

### Getting test data
Does the same, as previous, but with the test data.

### Merging datasets
Merges the train and the test data, and creating a factor variable from the ID which indicates the type of the data (train or test) 

### Adding descriptive activity names
Adding the activity labels, which where stored in the second part of the code.

### Adding descriptive variable names
Changing the variable names. (Removed the unnecessary brackets, changed the "-" to dot. And changed the initial lett of each variable, which indicates the the type of measurement.

### Aggregation
Calculates the mean for each subject on each activity for the required variables.
