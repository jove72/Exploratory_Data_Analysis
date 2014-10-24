
##download and unzip files
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="temp0.zip",mode="wb")
unzip("temp0.zip")


# load useful information
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"")
features <- read.table("UCI HAR Dataset/features.txt", quote="\"")
label<-read.table("UCI HAR Dataset/activity_labels.txt", quote="\"")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"")


# task 1: merge data sets
allx<-rbind(X_train,X_test) ## merge training and test sets
ally<-rbind(y_train,y_test) # all labels
colnames(ally)<-"labels" # rename variable name
allsub<-rbind(subject_train,subject_test) # all subjects
colnames(allsub)[1]<-"subjects" ## rename column name
merge_data <- cbind(ally,allsub,allx)


# task 2: extract sub data frame
idxm<-grepl("mean()",features$V2,fixed=TRUE) # measurements with mean()
idxs<-grepl("std()",features$V2,fixed=TRUE) # measurements with std()
meanandstd<-features[which(idxm|idxs==TRUE),] #measurements with mean() or std()
new_data <- merge_data[,c(1:2,2+meanandstd[,1])]


# task 3: descriptive activity names
new_data$labels <-as.character(label[match(new_data$labels,label$V1),"V2"]) ##replacing labels with activity names
   

#task 4: rename variable names
orig_name <- colnames(new_data)
target_name <-as.character(features[match(orig_name,paste("V",features$V1,sep="")),"V2"]) #replace variable names based on feature info
#further describe those variable names
new_target_name<-gsub('([[:upper:]])', ' \\1', target_name) ## add one space before capital letter
new_target_name <-gsub('^t', 'time info of', new_target_name) ## replace 't' by 'time info of'
new_target_name <-gsub('^f', 'frequency info of', new_target_name) ## replace 'f' by 'frequency info of'
new_target_name <-gsub('- X$', ' on the X axis ', new_target_name) ## replace '-X|Y|Z' at the end by 'on the X|Y|Z axis'
new_target_name <-gsub('- Y$', ' on the Y axis ', new_target_name)
new_target_name <-gsub('- Z$', ' on the Z axis ', new_target_name)
new_target_name <-gsub('\\()', ' value', new_target_name) ## replace '()" by "value"
colnames(new_data)<-c("activities","subjects",new_target_name[3:length(new_target_name)])


#task 5: create tidy data set
library(reshape2)
ds_mlt<-melt(new_data,id=c("activities","subjects")) ##melt data frame
result<-dcast(ds_mlt,activities+subjects~variable,mean) ##create required tidy data set
write.table(result,"myoutput.txt",sep="\t",row.names=FALSE) ##no row names written along with data
