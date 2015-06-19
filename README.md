# How the script works
## My interpretation of the project

x_*.txt contains the actual data, no headers.

y_*.txt contains a ref. to the activity labels (6 labels) for each variable.

Features.txt contains the variables and are the "headernames" for the dataset.

subject.txt contains the ID of the subjects.

In the final tidy DS we should end up with something like:

**activity,subject,feature1,feature2,...,featureN**

*activityName1,1,number,number,number,number*

*...,...,...,...,...,...,*

*activityNameN,30,number,number,number,number*

Where:

Activity  : one of the following values {walking,walking_upstairs,walking_downstairs,sitting,standing,laying}

Subject   : a number from 1 to 30

feature_i  : a clear and meaningfull description of the feature (only the means and the stddevs), e.g. **meanBodyAccelarationX, meanGravityAccelarationY, ...**

##The algorithm, for more details see the R script:

1. create a list with headers from features.txt. This part includes cleaning and providing clear names for variables.
2. add an extra column with "activity" and fill this column with resolved activity (activity number is replaced by its name from activity_lables.txt)
4. add an extra colmun with "subject"
4. fill the other columns with the data coming from x_*.txt (the sample data)
5. Do this for both DS (DS_train, DS_test)
6. Keep only the columns with means and std deviations
6. Append the two datasets.

# How to use the script?
## Assumptions
The script assumes that it is run from the directory where the data resides including the subfolders as extracted from the zip.

UCI HAR Dataset <- script should be run from here, all other TXT files as in the ZIP must also be here.

  \\test\...
  
  \\train\...

Run the script, no parameters are needed. The results are in CleanSamsungS.txt
  
# CODEBOOK
