# How the script works
## Approach
x_*.txt contains the actual data, no headers.
y_*.txt contains a ref. to the activity labels (6 labels) for each variable. These are the "rownames" for the dataset
Features.txt contains the variables and are the "headernames" for the dataset.
In the final tidy DS we also need the activity and the code for the subject, so we should end up with something like:

|   activity    | subject  |  feature1  | feature2   |   ...  | featureN |

| activityName1 |     1    |   number   |   number   | number |   number |

|     ...       |   ...    |    ...     |   ...      |  ...   |   ...    |

Where:

Activity  : one of the following values {walking,walking_upstairs,walking_downstairs,sitting,standing, laying}

Subject   : a number from 1 to 30

feature_i  : a description of the feature (only the means and the stddevs), e.g. meanBodyAccelarationX, meanGravityAccelarationY, ...

##The algorithm:

1. create a DS with headers from features.txt
2. add an extra column with "activity"
3. 3. fill this column with resolved activity (activity number is replaced by its name from activit_lables.txt
4. add an extra colmun with "subject"
4. Fill the other columns with the data coming from x_*.txt
5. Do this for both DS (DS_train, DS_test)
6. Create a new DS with sames number of colmuns as the previous ones
7. Add an extra colmun called Datatype (TEST=0 or TRAIN=1)

# How to use the script?
## Assumptions
The script assume that it is run from the directory where the data resides including the subfolders as extracted from the zip.

UCI HAR Dataset <- script should be run from here, all other TXT files as in the ZIP must also be here.

  \\test\...
  
  \\train\...

Run the script, no parameters are needed. The results are in CleanSamsungS.txt
  
# CODEBOOK
