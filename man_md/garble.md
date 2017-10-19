# `garble`: the garble function to spit out random gibberish

## Description


 the garble function to spit out random gibberish


## Usage

```r
garble(size_out, pattern_bank = "~!@#$%^&*()-+")
```


## Arguments

Argument      |Description
------------- |----------------
```size_out```     |     an integer for length of output, must be 3 or larger
```pattern_bank```     |     a single string of patterns (no space)

## Value


 a character vector of random characters


## Examples

```r 
 
 garble(1)
 garble(10)
 garble(10,'!&@')
 garble(3)
 ``` 

