# My interpretation of the project

x_*.txt contains the actual data, no headers.

y_*.txt contains a reference to the activity labels (6 labels) for each variable.

features.txt contains the variables and are the "headernames" for the dataset.

subject.txt contains the ID of the subjects.

In the final tidy DS we should end up with something like:

**activity,subject,feature1,feature2,...,featureN**

*activityName1,1,number,number,number,number*

*...,...,...,...,...,...,*

*activityNameN,30,number,number,number,number*

Where:

Activity  : one of the following values {walking,walking_upstairs,walking_downstairs,sitting,standing,laying}

Subject   : a number from 1 to 30

feature_i : a clear and meaningfull description of the feature (only the means and the stddevs), e.g. **meanBodyAccelarationX, meanGravityAccelarationY, ...**

##The algorithm, for more details see the R script:

1. Create a dataset with headers from features.txt. This part includes cleaning and providing clear names for variables. For the exercise we just removed some characters, no real logic was used to get clean and meaningful names.
2. Add an extra column with "activity" and fill this column with resolved activity (activity number is replaced by its name from activity_lables.txt).
3. Add an extra colmun with "subject" oming from the subject files.
4. Fill the other columns with the data coming from x_*.txt (the sample data).
5. Do this for both datasets (DS_train, DS_test).
6. Keep only the columns with means and std deviations in their description.
7. Append the two datasets.
8. Aggregate over the activty and means
9. Save to a file.
