# My interpretation of the project
There are several files containing data, here is how interprete them:

> x_*.txt contains the actual data, no headers.

> y_*.txt contains a reference to the activity labels (6 labels) for each variable.

> features.txt contains the variables and are the "headernames" for the dataset.

> subject.txt contains the ID of the subjects.

In the final tidy DS we should end up with something like:

**activity,subject,feature1,feature2,...,featureN**

*activityName1,1,number,number,number,number*

*...,...,...,...,...,...,*

*activityNameN,30,number,number,number,number*

Where:

> Activity  : one of the following values {walking,walking_upstairs,walking_downstairs,sitting,standing,laying}

> Subject   : a number from 1 to 30

> feature_i : a clear and meaningfull description of the feature (only the means and the stddevs), e.g. **meanBodyAccelarationX, meanGravityAccelarationY, ...**

#The algorithm

1. Create a dataset with the data coming from x_*.txt (the sample data).
2. Add an extra column with "activity" and fill this column with resolved activity.
3. Add an extra colmun with "subject" coming from the subject files.
4. Do this for both datasets (DS_train, DS_test).
6. Keep only the columns with means and std deviations in their description.
7. Append the two datasets.
8. Aggregate over the activty and means.
9. Save to a file.

#Code
For more details on the different functions see the R script.
There are several functions in the code. The idea is to create generic functions that can be used for any dataset.
In the main part of the script we do the folloing:

1. initialize the global variables: mostly paths but also 2 datasets for features and labels that are the used across the script.
2. A generic function `Create_Full_Dataset` generates a complete dataset including the extra colmuns subject and activity. These columns are added through generic functions. In case of the activity (`Get_Activity_Names`) there  is some logic built-in to replace the actvity number into full text.
3. The 2 datasets (TEST and TRAIN) are bound together into a single dataset (`ds_full`).
4. Using GREP we only keep the columns we need. We store it in ds_clean.
5. This dataset (`ds_clean`) is then aggregated over actvity and subject into a tidy dataset called `ds_aggregated`.
6. The dataset `ds_aggregated` is then written to a file.
 

 

