# `yankovise`: The yankovise() function to Weird Al Yankovise a string

## Description


 The function helps the user revise a lyric by substituting original words for thematic keywords.
 NOTE: the input string will immediately be lowercased via tolower(snip)


## Usage

```r
yankovise(snip, brev = TRUE, dict_outin = NULL, suffix = NULL)
```


## Arguments

Argument      |Description
------------- |----------------
```snip```     |     a character string of lyrics
```brev```     |     a logical (default TRUE) determining whether to pass 'snip' into brevitweet(snip) which abbreviates 'snip' for twitter brevity
```dict_outin```     |     a named character vector (default NULL) where an element's name will later be swapped out for its associated value. See [`str_replace_all`](str_replace_all.html)
```suffix```     |     a character string used as a suffix, say for a signed name.

## Value


 a character string that has been Weird Al yankovised() using elements
 in 'dict_outin' swapping value 4 name.


## Seealso


 [`str_replace_all`](str_replace_all.html)  [`dictate_outin`](dictate_outin.html) 


## Examples

```r 
 
 snip = "Suede sun roof, hanging out the big top We leave the dealership, head to the rim shop"
 
 # yankovise(snip)  # expect error
 
 # user supplied dictionary
 dict_outin = c(datzen::dictate_outin('dealership','SERVER ROOM'),
 datzen::dictate_outin('big','LAP'),
 datzen::dictate_outin('rim','RAM'))
 
 yankovise(snip,brev=FALSE,dict_outin)
 yankovise(snip,brev=TRUE,suffix="- @2chainz",dict_outin = dict_outin)
 ``` 

