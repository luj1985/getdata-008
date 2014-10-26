#Course Project for Getting and Cleaning Data

Data for Human Activity Recognition analysis.

##File descriptions
- 'README.md'

- 'data': Folder contains raw data, the data was collect by http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

- 'run_anlysis.R': R script to generate a tidy dataset from raw data


##How to use

Open command prompt, navigate to current folder and start R.

Then run following R script to create a file with analysis result.

```r
source("run_analysis.R")
results <- run_analysis()
write.table(results, file="results.txt", row.names=FALSE)
```

The detail code explaination can be found in "Codebook.md"