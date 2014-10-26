library(dplyr)

readData <- function(type) {
  subjects <- read.table(paste("./data/", type, "/subject_", type, ".txt", sep = ""))
  measures <- read.table(paste("./data/", type, "/X_", type, ".txt", sep = ""))
  labels <- read.table(paste("./data/", type, "/Y_", type, ".txt", sep = ""))
  
  features <- read.table("./data/features.txt")
  names(subjects) <- c("subject")
  names(labels) <- c("activity")
  names(measures) <- features[,2]
  cbind(subjects, labels, measures)
}

run <- function() {
  # 1. Merges the training and the test sets to create one data set.
  train <- readData("train")
  test <- readData("test")
  raw <- rbind(train, test)
  
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  n1 <- names(raw)
  meanAndStd <- n1[grep("(mean|std)\\(\\)$", n1)]
  data <- raw[, c("subject", "activity", unlist(meanAndStd))]
  
  # 3. Uses descriptive activity names to name the activities in the data set
  labels <- read.table("./data/activity_labels.txt")
  data$activity = factor(data$activity, levels=labels[,1], labels=labels[,2])
  data$subject = as.factor(data$subject)
  
  # 4. Appropriately labels the data set with descriptive variable names. 
  n2 <- names(data)
  n2 <- gsub("\\(\\)", "", n2)
  n2 <- gsub("-", ".", n2)
  names(data) <- n2
  
  # 5. From the data set in step 4, creates a second, independent tidy data set 
  # with the average of each variable for each activity and each subject.
  tidy_df <- tbl_df(data)
  tidy_df %>%
    group_by(activity, subject) %>%
    summarise_each(funs(mean))
}

results <- run()
write.table(results, file="results.txt", row.names=FALSE)