# `freadss`: The freadss() function reads in a csv and perhaps subsets the rows (optionally sampled)

## Description


 The input file is read in-memory via [`fread`](fread.html) .
 If rows are subset, there is a slow down. Hence, subsetting rows costs a one-time slow down
 but affords ability to bean count the read-in memory footprint


## Usage

```r
freadss(input, ss = NULL, ind_choose = NULL)
```


## Arguments

Argument      |Description
------------- |----------------
```input```     |     character for file path of csv passed to [`fread`](fread.html)
```ss```     |     integer for desired row sample size. Default of ss is NULL, meaning no subsampling.
```ind_choose```     |     optional integer vector of specific rows to read in (instead of sampling)

## Details


 NOTE: if both ss and ind_choose are NULL, no subsetting is done. Entire csv is read in.


## Value


 a 'data.frame' with optionally subsetted rows (perhaps from sampling)


## Seealso


 [`fread`](fread.html) 


## Examples

```r 
 
 set.seed(1); m = matrix(rnorm(10*100),ncol=100,nrow=100)
 
 csv = data.frame(m)
 names(csv) = paste0('x',seq_along(csv))
 names(csv)
 
 tf = tempfile()
 write.csv(csv,tf,row.names=FALSE)
 dir_test=tf
 
 # if ss=NULL and ind_choose=NULL
 # no sub sampling, basically fread() but no flexible optional args.
 # just demo, might as well use fread() directly
 
 identical(freadss(input=dir_test),fread(dir_test))
 
 # user wants to sample 5 random rows
 freadss(input=dir_test,ss=5)
 
 # user picks 5 specific rows
 ind_pick = c(1,7,23,69,100)
 
 df_subset_before = freadss(input=dir_test,ind_choose = ind_pick)
 df_subset_after = freadss(input=dir_test)[ind_pick,]
 identical(df_subset_before,df_subset_after)
 
 ``` 

