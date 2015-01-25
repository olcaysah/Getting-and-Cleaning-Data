  #In this R script, interested data downloaded and saved into the folder. We directly read from 
  #local drive to the worksapce and we apply requested analysis. At the end of the script new 
  #tidy set will be generated to the work folder.

setwd("~/Documents/")

#INPUT DATA TO WORKSPACE
#Load Training Data
trainData = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
trainData[,562] = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
trainData[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

#Load Test Data
testData = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
testData[,562] = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
testData[,563] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

#Load Activity Names
activityNames = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

# Read features files and and make the feature names better suited for R with some substitutions
features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
features[,2] = gsub('-mean', 'Mean', features[,2])  #Replace -mean to Mean
features[,2] = gsub('-std', 'Std', features[,2])  #Replace -std to Std
features[,2] = gsub('[-()]', '', features[,2])  #Removes last letter and hypen

# Merge training and test sets together
allData = rbind(trainData, testData)

# Get only the data on mean and std. dev.
cols <- grep(".*Mean.*|.*Std.*", features[,2])

# First reduce the features table to what we want
features <- features[cols,]

# Now add the last two columns (subject and activity)
cols <- c(cols, 562, 563)

# And remove the unwanted columns from allData
allData <- allData[,cols]

# Add the column names (features) to allData
colnames(allData) <- c(features$V2, "Activity", "Subject")
colnames(allData) <- tolower(colnames(allData))
currentActivity = 1

for (currentActivityLabel in activityNames$V2) {
  allData$activity <- gsub(currentActivity, currentActivityLabel, allData$activity)
  currentActivity <- currentActivity + 1
}
allData$activity <- as.factor(allData$activity)
allData$subject <- as.factor(allData$subject)
tidy = aggregate(allData, by=list(activity = allData$activity, subject=allData$subject), mean)

# Remove the subject and activity column, since a mean of those has no use
tidy[,90] = NULL
tidy[,89] = NULL
write.table(tidy, "tidy.txt", sep="\t", row.name=FALSE)
