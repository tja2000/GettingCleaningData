##############################################################################
#                 Getting and Cleaning Data - Project                        #
##############################################################################

# General remarks: 
# 	All variables use the underscore naming conventions in lower case
# 	All custom functions are camel cased with underscores
# 	No check are done to see if directories or files exist.
#   There is no feedback to the console.

##############################################################################
#                             HELPER FUNCTIONS                               #
##############################################################################
Get_Descriptive_Featurenames <- function(f_location_features) {
	# -- Get the names from the features file and cleanup a bit --
	# INPUT 	  : takes as argument the location of the file
	# OUTPUT      : a vector with the "cleaned" feature labels
	# ASSUMPTIONS : file exists.
	
	# Read the file and assign the 2nd colmun to labels_features
	features <- read.table(f_location_features,sep="",header=FALSE)[,2]

	# Clean up part 1 : to lower case ...
	clean_labels <- lapply(as.character(features),tolower)
	
	# Clean up part 2 : first get () out the names and then replaces all "," and "-" by an underscore "_"
	#                 : that should provide some more readable columns
	clean_labels <- gsub("[,-]","_",gsub("()","",clean_labels,fixed=TRUE))
	return(clean_labels)
}

Create_Dataset_From_File <- function(samples="TEST",type="SAMPLES") {
	# -- Get the datasets --
	# INPUT 	  : samples = takes as argument TEST or TRAIN,
	#			  : type = SAMPLES,ACTIVITY,SUBJECT 
	#             : determines if we need to load the sample data ("x" files), the activities (the "y" files")
	#             : or the subjects.
	# OUTPUT      : a dataset with content of the file
	# ASSUMPTIONS : file exists.
	
	# determine which set to take
	if (samples=="TRAIN") { 
		# Get the correct paths for TRAIN
		if (type=="SAMPLES") {
			f <- file_location_train_x 	} 
			else { 
				if (type=="ACTIVITY") {
					f <- file_location_train_y }
				else { f <- file_location_subject_train}
			}
		}
	else { 
		# Get the correct paths for TEST
		if (type=="SAMPLES") {
			f <- file_location_test_x 	} 
			else { 
				if (type=="ACTIVITY") {
					f <- file_location_test_y }
				else { f <- file_location_subject_test}
			}
		}
		
	return (read.table(f,sep="",header=FALSE))
}

Get_Activity_Names <- function(f_location_activity_names) {
	# -- Get the activity labels --
	# INPUT 	  : takes as argument the location of the file
	# OUTPUT      : a vector with the "cleaned" activity labels
	# ASSUMPTIONS : file exists.
	
	# Read the file and only keep the second column
	activity_names <- read.table(f_location_activity_names,sep="",header=FALSE)
	activity_names$V1 <- NULL
	return(activity_names)
}
Add_Replace_Activity <- function(ds_data,ds_activities, ds_labels_activities) {
	# -- Add an extraGet the activty labels --
	# INPUT 	  : ds_data = the dataset with the full samples, 
	#			  : ds_activities = the dataset with the activity samples
	#			  : ds_labels_activities = a dataset with the labels
	# OUTPUT      : The dataset with the replaced activity labels
	# ASSUMPTIONS : File exists.
	
	#Add the activities and replace the numbers with the labels
	#a <- data.frame(matrix(labels_activities[ds_activities[,1]],,byrow=TRUE))
	ds_activities$V1 <- replace(ds_activities$V1,TRUE,as.character(ds_labels_activities[as.numeric(ds_activities$V1),1]))
	
	ds_activity <- ds_activities
	#Give it a meaningful name
	names(ds_activity) <- c("activity")
	
	# Add to the ds_train_test dataset...
	return(data.frame(ds_data,ds_activity))
}

Add_Subjects <- function(ds_data,ds_subjects) {
	# -- Add the subjects to the dataset --
	# INPUT 	  : ds_data = the dataset with the samples, 
	#			  : ds_subjects = the dataset with the subjects
	# OUTPUT      : The dataset with the added subjects and column title.
	# ASSUMPTIONS : file exists.
	
	#Give it a meaningful name, no further action required.
	names(ds_subjects) <- c("subject")
	
	# Add to the ds_train_test dataset...
	return(data.frame(ds_data,ds_subjects))
}

Create_Full_Dataset <- function(samples="TEST") {
	# -- Create a full dataset with all columns needed --
	# INPUT 	  : samples, which dataset to generate: TEST or TRAIN
	#			  : 
	# OUTPUT      : the dataset with all colmuns
	# ASSUMPTIONS : none

# First get the sample data set	
ds_train_test <- Create_Dataset_From_File(samples,"SAMPLES")
# Get the corresponding activities and correct the names
ds_train_test_activities <- Create_Dataset_From_File(samples,"ACTIVITY")

# Get the corresponding subject data set
ds_subjects <- Create_Dataset_From_File(samples,"SUBJECT")

#Set the names for the dataset using the the cleaned up Features
names(ds_train_test) <- c(labels_features)

#Add the activities and replace the numbers with the labels
ds_train_test <- Add_Replace_Activity(ds_train_test,ds_train_test_activities, labels_activities) 

# Add the subjects
ds_train_test <- Add_Subjects(ds_train_test,ds_subjects)

return(ds_train_test)
}

##############################################################################
#                                     MAIN                                   #
##############################################################################
# Define global variables
file_location_features <- "features.txt"
file_location_activity_labels <-"activity_labels.txt"
file_location_subject_test <- "test//subject_test.txt"
file_location_test_x <- "test//X_test.txt"
file_location_test_y <- "test//y_test.txt"
file_location_subject_train <- "train//subject_train.txt"
file_location_train_x <- "train//X_train.txt"
file_location_train_y <- "train//y_train.txt"

# Get the "clean" feature names... and the activities as "global variables"
labels_features <- Get_Descriptive_Featurenames(file_location_features)
labels_activities <- Get_Activity_Names(file_location_activity_labels)

# Create the dataset from both TEST and TRAIN.
ds_full <- rbind(Create_Full_Dataset("TEST"),Create_Full_Dataset("TRAIN"))

#Create a new one with only columns that contain mean,std,activity,subject in their name
ds_clean <- ds_full[,grep("mean|std|activity|subject",names(ds_full))]

# Aggreagate on activity and subject
ds_aggregated <- aggregate(ds_clean,by=list(ds_clean$activity,ds_clean$subject),FUN=mean,na.action=na.omit)

# free some memory ;-)
ds_full <- NULL
ds_clean <- NULL

#Write in a file as comma separated
write.table(ds_aggregated,file="tidy_dataset.txt",row.name=FALSE,sep=",")

return ()