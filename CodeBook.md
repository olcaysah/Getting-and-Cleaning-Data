In this R script, interested data downloaded and saved into the folder. We directly read from 
local drive to the worksapce and we apply requested analysis. At the end of the script new 
tidy set will be generated to the work folder.

First of all, I load the to the workspace. The script reads the column names for the data set and use this columns to identify data.

Second, I edit the features file content to suitable format for the R.

Third, Merge the training and testing data together.

Fourth, get only the data on mean and std. dev.

Fifth, Remove the unnecessary content from the file

Lastly, add interested content to new file which name is tidy.txt
