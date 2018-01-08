# `colname_zen`: the colname_zen() function zenifies a data frame's column names by lower and caterpillar casing

## Description


 the colname_zen() function zenifies a data frame's column names by lower and caterpillar casing
 
 the colname_zen() function zenifies a data frame's column names by lower and caterpillar casing


## Usage

```r
colname_zen(df, suffix = NULL, ind_suffix = NULL)
colname_zen(df, suffix = NULL, ind_suffix = NULL)
```


## Arguments

Argument      |Description
------------- |----------------
```df```     |     a data.frame
```suffix```     |     a single character string to attach as a suffix to column names
```ind_suffix```     |     an integer vector (optional) that picks the specific columns to attach the suffix (default NULL)
```df```     |     a data.frame
```suffix```     |     a single character string (optional) to attach as a suffix to column names (default NULL)

## Value


 a data.frame whose column names have been lower and caterpillar cased
 
 a modified character vector of names that have been lower and caterpillar cased with an optional suffix


## Examples

```r 
 iris %>% colname_zen() %>% head
 
 iris %>% colname_zen(.,suffix="src_1") %>% head
 df_foo = iris
 
 df_foo %>% colname_zen()
 df_foo %>% colname_zen(.,suffix="src_1")
 df_foo %>% colname_zen(.,suffix="src_1",c(1,5))
 
 # assign names to original data frame
 names_new = df_foo %>% colname_zen(.,suffix="src_1",c(1,5))
 names(df_foo) = names_new
 names(df_foo)
 ``` 

