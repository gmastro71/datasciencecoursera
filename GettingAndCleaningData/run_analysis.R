# Samsung data must be in working directory

# Read the data and label the features
features <- read.table("features.txt", col.names=c("col","name"), stringsAsFactors=FALSE)
train <- read.table("./train/X_train.txt", col.names=features$name)
test <- read.table("./test/X_test.txt", col.names=features$name)

# Merge train and test into one data set
all <- rbind(train, test)

# Extract the measurements on the mean and standard deviation for each measurement
# Any column which includes "mean" or "std" in its name is interpreted as to be included
library(dplyr)
meanAndStd <- select(all, matches("mean|std", ignore.case=TRUE))

# Append subject data
strain <- read.table("./train/subject_train.txt", col.names="subject")
stest <- read.table("./test/subject_test.txt", col.names="subject")
s <- rbind(strain, stest)
meanAndStd <- cbind(meanAndStd, s)

# Append activity data
ytrain <- read.table("./train/y_train.txt", col.names="activity")
ytest <- read.table("./test/y_test.txt", col.names="activity")
y <- rbind(ytrain, ytest)
meanAndStd <- cbind(meanAndStd, y)
# Replace activity codes by descriptive names
activityLabels <- read.table("./activity_labels.txt", col.names=c("class", "label"))
meanAndStd$activity <- activityLabels$label[meanAndStd$activity]

# Create a tidy data set with the average of each variable for each activity and each subject (wide format)
library(reshape2)
dataMelt <- melt(meanAndStd, id=c("activity","subject"), measure.vars=names(meanAndStd)[1:86])
tidyAverages <- dcast(dataMelt, activity+subject ~ variable, mean)

# Make variable names more readable by
# replacing consecutive periods with single period
names(tidyAverages) <- gsub(pattern="[.]+", replacement=".", names(tidyAverages))
# removing periods at the end of the name
names(tidyAverages) <- gsub(pattern="[.]$", replacement="", names(tidyAverages))

# Write resulting tidy data to file
write.table(tidyAverages, file="tidyAverages.txt", row.name=FALSE)
