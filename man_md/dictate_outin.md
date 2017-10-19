# `dictate_outin`: The dictate_outin() function

## Description


 An extremely simple function that creates a named vector.
 A useful helper to create key-value dictionaries to use in [`str_replace_all`](str_replace_all.html) 


## Usage

```r
dictate_outin(swap_out, swap_in)
```


## Arguments

Argument      |Description
------------- |----------------
```swap_out```     |     vector whose elements will be used as the names of the resulting character vector
```swap_in```     |     vector whose elements will be used as the values of the resulting character vector

## Value


 a character vector with values from swap_in and names from swap_out


## Seealso


 [`str_replace_all`](str_replace_all.html) 


## Examples

```r 
 dictate_outin('compton','bompton')
 
 ``` 

