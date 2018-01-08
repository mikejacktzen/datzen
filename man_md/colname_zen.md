# `colname_zen`: The colname_zen() function zenifies a data frame's column names by lower and caterpillar casing

## Description


 The colname_zen() function zenifies a data frame's column names by lower and caterpillar casing


## Usage

```r
colname_zen(df, suffix = NULL, ind_suffix = NULL)
```


## Arguments

Argument      |Description
------------- |----------------
```df```     |     a data.frame
```suffix```     |     a single character string (optional) to attach as a suffix to column names (default NULL)
```ind_suffix```     |     an integer vector (optional) that picks the specific columns to attach the suffix (default NULL)

## Value


 a modified character vector of names that have been lower and caterpillar cased,
 perhaps with an optional suffix attached


## Examples

```r 
 df_foo = iris
 
 df_foo %>% colname_zen()
 df_foo %>% colname_zen(.,suffix="src_1")
 df_foo %>% colname_zen(.,suffix="src_1",c(1,5))
 
 # assign names to original data frame
 names_new = df_foo %>% colname_zen(.,suffix="src_1",c(1,5))
 names(df_foo) = names_new
 names(df_foo)
 
 # use ?grepl() to pick col indices
 names(df_foo)
 ind_grep = which(grepl(names(df_foo),pattern=".Width"))
 names_new_grep = df_foo %>% colname_zen(.,suffix="src_1",ind_grep)
 names(df_foo) = names_new_grep
 names(df_foo)
 
 ``` 

