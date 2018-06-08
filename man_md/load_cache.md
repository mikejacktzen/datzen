# `load_cache`: The load_cache() function to load .rdata files from a knitr cache

## Description


 The load_cache() function to load .rdata files from a knitr cache


## Usage

```r
load_cache(dir_cache)
```


## Arguments

Argument      |Description
------------- |----------------
```dir_cache```     |     a single character string for the directory containing the .rdata files

## Value


 NULL, but the .rdata files are loaded into the global environment


## Examples

```r 
 dir_cache = here::here("/writeup/article_tech_doc_cache/html/")
 load_cache(dir_cache)
 ``` 

