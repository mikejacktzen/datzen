# `colname_zen`: the colname_zen() function zenifies a data frame's column names by lower and caterpillar casing

## Description


 the colname_zen() function zenifies a data frame's column names by lower and caterpillar casing


## Usage

```r
colname_zen(df, suffix = NULL)
```


## Arguments

Argument      |Description
------------- |----------------
```df```     |     a data.frame
```suffix```     |     a single character string to attach as a suffix to column names

## Value


 a data.frame whose column names have been lower and caterpillar cased


## Examples

```r 
 iris %>% colname_zen() %>% head
 
 iris %>% colname_zen(.,suffix="src_1") %>% head
 ``` 

