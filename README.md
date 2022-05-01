# Getting-and-Cleaning-Data-Course-Project

## Directory Overview 
This directory contains the following folders/files: 

  1. **Code:** The **Code** folder contains this project's only script, **run_analysis.R.**
  2. **Final Data:** The **Final Data** folder contains two text files -- **combined_data.txt,** which is the cleaned and combined training and test data, and **avgs_by_activity_and_subject.txt,** which is the second tidy dataset created according to Step 5 in this project's instructions.
  3. **.gitignore:** The **.gitignore** file allows us to exclude the project's data files from being added to this Git repo. 
  4. **CodeBook.md:** The **CodeBook.md** file describes the variables, the data, and any transformations and/or work that was performed to clean up the data. 
  5. **README.md**
  
## Explanation of Analysis Script(s)
The only script used in this project is **run_analysis.R,** which as described above can be found in the **Code** folder. It does the following: 

  1. Downloads the data from the internet and unzips it into a folder called **UCI HAR Dataset.**
  2. Loads required packages. Packages used are as follows: 
    - **data.table:** Used to read in the unzipped data
    - **janitor:** Used to clean up descriptive column names
    - **magrittr:** Used to set column names in bulk 
    - **tidyverse:** Used for misc. Tidyverse functions
  3. Reads data into the local R environment.
  4. Cleans up the data, first training then test. Cleaning steps are as follows: 
    - Set column names to the feature labels found in **features.txt**
    - Remove special characters (dashes, parentheses, commas, etc.) from column names 
    - Attach activity names to data (and subsequently move to the front)
    - Attach subject ID numbers to data (and subsequently move to the front)
  5. Merges the cleaned training and test data into a single dataset.
  6. Extracts only the measurements on the mean and standard deviation for each measurement, then writes the resulting data to **combined_data.txt** in the **Final Data** folder.
  7. Finds the average of each variable for each activity and subject, then writes the resulting data to **avgs_by_activity_and_subject.txt** in the **Final Data** folder. 