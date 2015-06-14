#### 1. Merges the training and the test sets to create one data set.
#read data
sub_test<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")
sub_train<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")
x_test<-read.table("./data/UCI HAR Dataset/test/X_test.txt")
x_train<-read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_test<-read.table("./data/UCI HAR Dataset/test/Y_test.txt")
y_train<-read.table("./data/UCI HAR Dataset/train/Y_train.txt")
#Merge train adn test sets
sub<-rbind(sub_train,sub_test)
x<-rbind(x_train,x_test)
y<-rbind(y_train,y_test)
#names variables
names(sub)<-"subject"
names(y)<-"activity_num"
data<-cbind(sub,y,x)
View(data)

#### 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#Read features
features<-read.table("./data/UCI HAR Dataset/features.txt")
#Set names features
setnames(features, names(features), c("featureNum", "featureName"))
index_features<-grep("mean\\(\\)|std\\(\\)",features[,2])
x<-x[,index_features]
names(x)<-features[index_features,2]
#check x
View(x)

#### 3.Uses descriptive activity names to name the activities in the data set
#Read activity
activi <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
activi[, 2] = gsub("_", "", tolower(as.character(activi[, 2])))
y[,1] = activi[y[,1], 2]
# Set Name
names(y) <- "activity"
#check y
View(y)

#### 4. Appropriately labels the data set with descriptive variable names.
data<-cbind(sub,y,x)
View(data)
write.table(data,"merged_data.txt")

#### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
numCOL<-dim(data)[2]
averages<-aggregate(data[,3:numCOL],list(data$subject,data$activity),mean)
names(averages)[1]<-"subject"
names(averages)[2]<-"activity"
write.table(averages,"tidy_data.txt",row.name=FALSE)






