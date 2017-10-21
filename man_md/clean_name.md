# `clean_name`: The clean_name() function scrubs out common artifacts in a character string of names

## Usage

```r
clean_name(name_unique)
```


## Arguments

Argument      |Description
------------- |----------------
```name_unique```     |     a character vector containing a set of names to be parsed

## Value


 a character vector that has symbols removed from the supplied input 'name_unique'


## Examples

```r 
 # not run
 # library(dplyr)
 # name_all = c('joseph','joe','jo ',' joesephine','joseph','jo')
 # name_all %>% clean_name()
 #
 # name_all_unique = name_all %>% clean_name() %>% unique %>% sort
 #
 # name_all_unique %>%
 #   # other spot check manual gsubs
 #   gsub(.,pattern='n/a',replace='') %>%
 #   gsub(.,pattern='N/A',replace='') %>%
 #   gsub(.,pattern="can't answer.*",replace='') %>%
 #   gsub(.,pattern='dk',replace='') %>%
 #   gsub(.,pattern='^x$',replace='')
 ``` 

