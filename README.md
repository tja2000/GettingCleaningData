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

# CODEBOOK
