# How the script works
## Approach
x_*.txt contains the actual data, no headers.
y_*.txt contains a ref. to the activity labels (6 labels) for each variable. These are the "rownames" for the dataset
Features.txt contains the variables and are the "headernames" for the dataset.

### 1. Merge algorithm and approach
1. create a DS with headers from features.txt
2. add an extra column with "activity"
3. fill this column with resolved activity (activity number is replaced by its name from activit_lables.txt
4. Fill the other columns with the data coming from x_*.txt
5. Do this for both DS (DS_train, DS_test)
6. Create a new DS with sames number of colmuns as the previous ones
7. Add an extra colmun called Datatype (TEST=0 or TRAIN=1)

# How to use the script?
## Assumptions
The script assume that it is run from the directory where the data resides including the subfolders as extracted from the zip:
Thus: 
UCI HAR Dataset <- script should be run from here, all other TXT files as in the ZIP must also be here.
  \test\...
  \train\...

Run the script, no parameters are needed. The results are in CleanSamsungS.txt
  
# CODEBOOK
